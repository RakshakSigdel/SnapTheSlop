package com.snaptheslop.snaptheslop.issue.model.dao;

import com.snaptheslop.snaptheslop.config.DBConnection;
import com.snaptheslop.snaptheslop.issue.model.Issue;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * IssueDAO — all database operations for Issue entity.
 * Sprint 5: Core Issue Lifecycle
 */
public class IssueDAO {

    private static final Logger LOGGER = Logger.getLogger(IssueDAO.class.getName());

    // ── CREATE ─────────────────────────────────────────────────────────────

    /**
     * Insert a new issue. Returns the generated numeric id, or -1 on failure.
     */
    public int createIssue(Issue issue) {
        String sql = "INSERT INTO issues (issueId, title, description, category, status, priority, " +
                     "imagePath, location, userId, municipality_id, ward_no, createdAt, updatedAt) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW())";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, issue.getIssueId());
            ps.setString(2, issue.getTitle());
            ps.setString(3, issue.getDescription());
            ps.setString(4, issue.getCategory());
            ps.setString(5, issue.getStatus() != null ? issue.getStatus() : "Open");
            ps.setString(6, issue.getPriority() != null ? issue.getPriority() : "Medium");
            ps.setString(7, issue.getImagePath());
            ps.setString(8, issue.getLocation());
            ps.setInt(9, issue.getUserId());
            ps.setInt(10, issue.getMunicipalityId());
            ps.setInt(11, issue.getWardNo());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                try (ResultSet keys = ps.getGeneratedKeys()) {
                    if (keys.next()) return keys.getInt(1);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error creating issue", e);
        }
        return -1;
    }

    // ── READ ───────────────────────────────────────────────────────────────

    /**
     * Find a single issue by its string issueId (e.g. "ISS-8821").
     * Joins with users and municipalities for display fields.
     */
    public Issue findByIssueId(String issueId) {
        String sql = buildBaseQuery() + " WHERE i.issueId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, issueId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error finding issue by issueId: " + issueId, e);
        }
        return null;
    }

    /**
     * Find a single issue by its numeric DB id.
     */
    public Issue findById(int id) {
        String sql = buildBaseQuery() + " WHERE i.id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error finding issue by id: " + id, e);
        }
        return null;
    }

    /**
     * Find a single issue by numeric id and owner id.
     * Used by citizen edit/delete flows to enforce ownership at the DAO layer.
     */
    public Issue findByIdAndUserId(int id, int userId) {
        String sql = buildBaseQuery() + " WHERE i.id = ? AND i.userId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.setInt(2, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error finding issue by id and owner: " + id + "/" + userId, e);
        }
        return null;
    }

    /**
     * Get all issues submitted by a specific user (by users.id).
     * Optional filter: statusFilter (null = all).
     * Supports pagination.
     */
    public List<Issue> findByUserId(int userId, String statusFilter, int page, int pageSize) {
        return findByUserId(userId, statusFilter, null, page, pageSize);
    }

    public List<Issue> findByUserId(int userId, String statusFilter, String keywordFilter, int page, int pageSize) {
        StringBuilder sql = new StringBuilder(buildBaseQuery());
        sql.append(" WHERE i.userId = ?");
        if (statusFilter != null && !statusFilter.isBlank()) {
            sql.append(" AND LOWER(i.status) = LOWER(?)");
        }
        if (keywordFilter != null && !keywordFilter.isBlank()) {
            appendKeywordClause(sql);
        }
        sql.append(" ORDER BY i.createdAt DESC");
        sql.append(" LIMIT ? OFFSET ?");

        List<Issue> issues = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            int idx = 1;
            ps.setInt(idx++, userId);
            if (statusFilter != null && !statusFilter.isBlank()) {
                ps.setString(idx++, statusFilter);
            }
            if (keywordFilter != null && !keywordFilter.isBlank()) {
                bindKeyword(ps, idx, keywordFilter);
                idx += 2;
            }
            ps.setInt(idx++, pageSize);
            ps.setInt(idx, (page - 1) * pageSize);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) issues.add(mapRow(rs));
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error fetching issues for userId: " + userId, e);
        }
        return issues;
    }

    /**
     * Count issues for a user, with optional status filter (for pagination UI).
     */
    public int countByUserId(int userId, String statusFilter) {
        return countByUserId(userId, statusFilter, null);
    }

    public int countByUserId(int userId, String statusFilter, String keywordFilter) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM issues i WHERE i.userId = ?");
        if (statusFilter != null && !statusFilter.isBlank()) {
            sql.append(" AND LOWER(i.status) = LOWER(?)");
        }
        if (keywordFilter != null && !keywordFilter.isBlank()) {
            appendKeywordClause(sql);
        }
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            ps.setInt(1, userId);
            if (statusFilter != null && !statusFilter.isBlank()) {
                ps.setString(2, statusFilter);
            }
            if (keywordFilter != null && !keywordFilter.isBlank()) {
                bindKeyword(ps, statusFilter != null && !statusFilter.isBlank() ? 3 : 2, keywordFilter);
            }
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error counting issues for userId: " + userId, e);
        }
        return 0;
    }

    /**
     * Get all issues for a municipality (issue queue), with optional filters.
     * Supports pagination.
     */
    public List<Issue> findByMunicipalityId(int municipalityId,
                                            String statusFilter,
                                            String categoryFilter,
                                            String wardFilter,
                                            int page,
                                            int pageSize) {
        return findByMunicipalityId(municipalityId, statusFilter, categoryFilter, wardFilter, null, page, pageSize);
    }

    public List<Issue> findByMunicipalityId(int municipalityId,
                                            String statusFilter,
                                            String categoryFilter,
                                            String wardFilter,
                                            String keywordFilter,
                                            int page,
                                            int pageSize) {
        StringBuilder sql = new StringBuilder(buildBaseQuery());
        sql.append(" WHERE i.municipality_id = ?");
        if (statusFilter != null && !statusFilter.isBlank()) {
            sql.append(" AND LOWER(i.status) = LOWER(?)");
        }
        if (categoryFilter != null && !categoryFilter.isBlank()) {
            sql.append(" AND LOWER(i.category) = LOWER(?)");
        }
        if (wardFilter != null && !wardFilter.isBlank()) {
            sql.append(" AND i.ward_no = ?");
        }
        if (keywordFilter != null && !keywordFilter.isBlank()) {
            appendKeywordClause(sql);
        }
        sql.append(" ORDER BY i.createdAt DESC LIMIT ? OFFSET ?");

        List<Issue> issues = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            int idx = 1;
            ps.setInt(idx++, municipalityId);
            if (statusFilter != null && !statusFilter.isBlank())   ps.setString(idx++, statusFilter);
            if (categoryFilter != null && !categoryFilter.isBlank()) ps.setString(idx++, categoryFilter);
            if (wardFilter != null && !wardFilter.isBlank()) {
                try { ps.setInt(idx++, Integer.parseInt(wardFilter)); }
                catch (NumberFormatException ex) { ps.setString(idx++, wardFilter); }
            }
            if (keywordFilter != null && !keywordFilter.isBlank()) {
                bindKeyword(ps, idx, keywordFilter);
                idx += 2;
            }
            ps.setInt(idx++, pageSize);
            ps.setInt(idx, (page - 1) * pageSize);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) issues.add(mapRow(rs));
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error fetching issues for municipalityId: " + municipalityId, e);
        }
        return issues;
    }

    /**
     * Count issues for a municipality (for pagination and stats).
     */
    public int countByMunicipalityId(int municipalityId, String statusFilter) {
        return countByMunicipalityId(municipalityId, statusFilter, null);
    }

    public int countByMunicipalityId(int municipalityId, String statusFilter, String keywordFilter) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM issues i WHERE i.municipality_id = ?");
        if (statusFilter != null && !statusFilter.isBlank()) {
            sql.append(" AND LOWER(i.status) = LOWER(?)");
        }
        if (keywordFilter != null && !keywordFilter.isBlank()) {
            appendKeywordClause(sql);
        }
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            ps.setInt(1, municipalityId);
            if (statusFilter != null && !statusFilter.isBlank()) ps.setString(2, statusFilter);
            if (keywordFilter != null && !keywordFilter.isBlank()) {
                bindKeyword(ps, statusFilter != null && !statusFilter.isBlank() ? 3 : 2, keywordFilter);
            }
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error counting issues for municipalityId: " + municipalityId, e);
        }
        return 0;
    }

    /**
     * Find open issues older than the provided age (in hours) for SLA alerts.
     */
    public List<Issue> findOpenIssuesOlderThanHoursByMunicipality(int municipalityId, int minHoursOpen) {
        String sql = buildBaseQuery()
                + " WHERE i.municipality_id = ?"
                + " AND i.status IN ('Open', 'In Progress')"
                + " AND i.createdAt <= (NOW() - INTERVAL ? HOUR)"
                + " ORDER BY i.createdAt ASC";

        List<Issue> issues = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, municipalityId);
            ps.setInt(2, minHoursOpen);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    issues.add(mapRow(rs));
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error finding SLA-aged issues for municipalityId: " + municipalityId, e);
        }
        return issues;
    }

    /**
     * Count all issues globally with optional status filter.
     */
    public int countAllIssues(String statusFilter) {
        return countAllIssues(statusFilter, null);
    }

    public int countAllIssues(String statusFilter, String keywordFilter) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM issues i WHERE 1=1");
        if (statusFilter != null && !statusFilter.isBlank()) {
            sql.append(" AND LOWER(i.status) = LOWER(?)");
        }
        if (keywordFilter != null && !keywordFilter.isBlank()) {
            appendKeywordClause(sql);
        }
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            if (statusFilter != null && !statusFilter.isBlank()) {
                ps.setString(1, statusFilter);
            }
            if (keywordFilter != null && !keywordFilter.isBlank()) {
                bindKeyword(ps, statusFilter != null && !statusFilter.isBlank() ? 2 : 1, keywordFilter);
            }
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error counting all issues", e);
        }
        return 0;
    }

    /**
     * Browse all public issues (for citizen browse page), with optional filters.
     */
    public List<Issue> findAll(String categoryFilter,
                               String municipalityIdFilter,
                               String wardFilter,
                               String statusFilter,
                               int page,
                               int pageSize) {
        return findAll(categoryFilter, municipalityIdFilter, wardFilter, statusFilter, null, page, pageSize);
    }

    public List<Issue> findAll(String categoryFilter,
                               String municipalityIdFilter,
                               String wardFilter,
                               String statusFilter,
                               String keywordFilter,
                               int page,
                               int pageSize) {
        StringBuilder sql = new StringBuilder(buildBaseQuery() + " WHERE 1=1");
        if (categoryFilter != null && !categoryFilter.isBlank())        sql.append(" AND LOWER(i.category) = LOWER(?)");
        if (municipalityIdFilter != null && !municipalityIdFilter.isBlank()) sql.append(" AND i.municipality_id = ?");
        if (wardFilter != null && !wardFilter.isBlank())                sql.append(" AND i.ward_no = ?");
        if (statusFilter != null && !statusFilter.isBlank())            sql.append(" AND LOWER(i.status) = LOWER(?)");
        if (keywordFilter != null && !keywordFilter.isBlank())          appendKeywordClause(sql);
        sql.append(" ORDER BY i.createdAt DESC LIMIT ? OFFSET ?");

        List<Issue> issues = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            int idx = 1;
            if (categoryFilter != null && !categoryFilter.isBlank())        ps.setString(idx++, categoryFilter);
            if (municipalityIdFilter != null && !municipalityIdFilter.isBlank()) {
                try { ps.setInt(idx++, Integer.parseInt(municipalityIdFilter)); }
                catch (NumberFormatException ex) { ps.setString(idx++, municipalityIdFilter); }
            }
            if (wardFilter != null && !wardFilter.isBlank()) {
                try { ps.setInt(idx++, Integer.parseInt(wardFilter)); }
                catch (NumberFormatException ex) { ps.setString(idx++, wardFilter); }
            }
            if (statusFilter != null && !statusFilter.isBlank())            ps.setString(idx++, statusFilter);
            if (keywordFilter != null && !keywordFilter.isBlank()) {
                bindKeyword(ps, idx, keywordFilter);
                idx += 2;
            }
            ps.setInt(idx++, pageSize);
            ps.setInt(idx, (page - 1) * pageSize);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) issues.add(mapRow(rs));
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error fetching all issues", e);
        }
        return issues;
    }

    /**
     * Count all public issues with optional filters.
     */
    public int countAllFiltered(String categoryFilter,
                                String municipalityIdFilter,
                                String wardFilter,
                                String statusFilter) {
        return countAllFiltered(categoryFilter, municipalityIdFilter, wardFilter, statusFilter, null);
    }

    public int countAllFiltered(String categoryFilter,
                                String municipalityIdFilter,
                                String wardFilter,
                                String statusFilter,
                                String keywordFilter) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM issues i WHERE 1=1");
        if (categoryFilter != null && !categoryFilter.isBlank())        sql.append(" AND LOWER(i.category) = LOWER(?)");
        if (municipalityIdFilter != null && !municipalityIdFilter.isBlank()) sql.append(" AND i.municipality_id = ?");
        if (wardFilter != null && !wardFilter.isBlank())                sql.append(" AND i.ward_no = ?");
        if (statusFilter != null && !statusFilter.isBlank())            sql.append(" AND LOWER(i.status) = LOWER(?)");
        if (keywordFilter != null && !keywordFilter.isBlank())          appendKeywordClause(sql);

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            int idx = 1;
            if (categoryFilter != null && !categoryFilter.isBlank())        ps.setString(idx++, categoryFilter);
            if (municipalityIdFilter != null && !municipalityIdFilter.isBlank()) {
                try { ps.setInt(idx++, Integer.parseInt(municipalityIdFilter)); }
                catch (NumberFormatException ex) { ps.setString(idx++, municipalityIdFilter); }
            }
            if (wardFilter != null && !wardFilter.isBlank()) {
                try { ps.setInt(idx++, Integer.parseInt(wardFilter)); }
                catch (NumberFormatException ex) { ps.setString(idx++, wardFilter); }
            }
            if (statusFilter != null && !statusFilter.isBlank())            ps.setString(idx, statusFilter);
            if (keywordFilter != null && !keywordFilter.isBlank()) {
                bindKeyword(ps, idx, keywordFilter);
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error counting filtered issues", e);
        }
        return 0;
    }

    // ── UPDATE ─────────────────────────────────────────────────────────────

    /**
     * Update the status of an issue (enforces valid transition rules).
     * Returns true on success, false if the transition is invalid or DB error.
     * Sprint 5 flow: Open → In Progress → Resolved | Rejected
     */
    public boolean updateStatus(String issueId, String newStatus) {
        Issue current = findByIssueId(issueId);
        if (current == null) {
            LOGGER.warning("updateStatus: issue not found: " + issueId);
            return false;
        }
        if (!current.isValidTransition(newStatus)) {
            LOGGER.warning("updateStatus: invalid transition " + current.getStatus() + " → " + newStatus);
            return false;
        }
        return doUpdateStatus(current.getId(), newStatus);
    }

    /**
     * Force-update status (used by municipality manage page — bypasses transition validation).
     * The servlet layer is responsible for validation; use updateStatus() for enforcement.
     */
    public boolean forceUpdateStatus(int issueDbId, String newStatus, String priority) {
        String sql = "UPDATE issues SET status = ?, priority = ?, updatedAt = NOW() WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setString(2, priority);
            ps.setInt(3, issueDbId);
            return ps.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error force-updating status for issue id: " + issueDbId, e);
        }
        return false;
    }

    /**
     * Update the editable fields of an issue, restricted to the owning citizen.
     */
    public boolean updateIssueByOwner(Issue issue, int ownerUserId) {
        if (issue == null || issue.getId() <= 0 || ownerUserId <= 0) {
            return false;
        }

        String sql = "UPDATE issues SET title = ?, description = ?, category = ?, location = ?, ward_no = ?, imagePath = ?, updatedAt = NOW() WHERE id = ? AND userId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, issue.getTitle());
            ps.setString(2, issue.getDescription());
            ps.setString(3, issue.getCategory());
            ps.setString(4, issue.getLocation());
            ps.setInt(5, issue.getWardNo());
            ps.setString(6, issue.getImagePath());
            ps.setInt(7, issue.getId());
            ps.setInt(8, ownerUserId);
            return ps.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error updating issue for owner: " + issue.getId() + "/" + ownerUserId, e);
        }
        return false;
    }

    /**
     * Delete an issue, restricted to the owning citizen.
     */
    public boolean deleteIssueByOwner(int issueDbId, int ownerUserId) {
        if (issueDbId <= 0 || ownerUserId <= 0) {
            return false;
        }

        String sql = "DELETE FROM issues WHERE id = ? AND userId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, issueDbId);
            ps.setInt(2, ownerUserId);
            return ps.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error deleting issue for owner: " + issueDbId + "/" + ownerUserId, e);
        }
        return false;
    }

    // ── HELPERS ────────────────────────────────────────────────────────────

    private boolean doUpdateStatus(int issueDbId, String newStatus) {
        String sql = "UPDATE issues SET status = ?, updatedAt = NOW() WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setInt(2, issueDbId);
            return ps.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error updating status for issue id: " + issueDbId, e);
        }
        return false;
    }

    /**
     * Shared SELECT with LEFT JOINs to users + municipalities.
     * Upvote count is computed via a correlated subquery to avoid GROUP BY issues
     * with MySQL ONLY_FULL_GROUP_BY mode.
     */
    private String buildBaseQuery() {
        return "SELECT i.*, " +
               "  CONCAT(u.firstName, ' ', u.lastName) AS citizenName, " +
               "  u.email AS citizenEmail, " +
               "  m.name AS municipalityName, " +
               "  (SELECT COUNT(*) FROM upvotes uv WHERE uv.issueId = i.id) AS upvoteCount " +
               "FROM issues i " +
               "LEFT JOIN users u ON i.userId = u.id " +
               "LEFT JOIN municipalities m ON i.municipality_id = m.id";
    }

    private void appendKeywordClause(StringBuilder sql) {
        sql.append(" AND (LOWER(i.title) LIKE ? ESCAPE '\\' OR LOWER(i.category) LIKE ? ESCAPE '\\')");
    }

    private void bindKeyword(PreparedStatement ps, int startIndex, String keywordFilter) throws SQLException {
        String pattern = toLikePattern(keywordFilter);
        ps.setString(startIndex, pattern);
        ps.setString(startIndex + 1, pattern);
    }

    private String toLikePattern(String value) {
        String normalized = value == null ? "" : value.trim().toLowerCase();
        String escaped = normalized
                .replace("\\", "\\\\")
                .replace("%", "\\%")
                .replace("_", "\\_");
        return "%" + escaped + "%";
    }

    private Issue mapRow(ResultSet rs) throws SQLException {
        Issue issue = new Issue();
        issue.setId(rs.getInt("id"));
        issue.setIssueId(rs.getString("issueId"));
        issue.setTitle(rs.getString("title"));
        issue.setDescription(rs.getString("description"));
        issue.setCategory(rs.getString("category"));
        issue.setStatus(rs.getString("status"));
        issue.setPriority(rs.getString("priority"));
        issue.setImagePath(rs.getString("imagePath"));
        issue.setLocation(rs.getString("location"));
        issue.setUserId(rs.getInt("userId"));
        issue.setMunicipalityId(rs.getInt("municipality_id"));
        issue.setWardNo(rs.getInt("ward_no"));
        issue.setCreatedAt(rs.getTimestamp("createdAt"));
        issue.setUpdatedAt(rs.getTimestamp("updatedAt"));
        issue.setCitizenName(rs.getString("citizenName"));
        issue.setCitizenEmail(rs.getString("citizenEmail"));
        issue.setMunicipalityName(rs.getString("municipalityName"));
        issue.setUpvoteCount(rs.getInt("upvoteCount"));
        return issue;
    }
}
