package com.snaptheslop.snaptheslop.notification.model.dao;

import com.snaptheslop.snaptheslop.config.DBConnection;
import com.snaptheslop.snaptheslop.notification.model.NotificationItem;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class NotificationDAO {

    private static final Logger LOGGER = Logger.getLogger(NotificationDAO.class.getName());

    public boolean create(NotificationItem item) {
        String sql = "INSERT INTO notifications (audience, user_id, municipality_id, issue_id, type, title, message, event_key) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            bindForInsert(ps, item);
            return ps.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Unable to create notification", e);
            return false;
        }
    }

    public boolean createIfAbsent(NotificationItem item) {
        String sql = "INSERT INTO notifications (audience, user_id, municipality_id, issue_id, type, title, message, event_key) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?) "
                + "ON DUPLICATE KEY UPDATE id = id";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            bindForInsert(ps, item);
            ps.executeUpdate();
            return true;
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Unable to create deduplicated notification", e);
            return false;
        }
    }

    public List<NotificationItem> findForCitizen(int userDbId, int limit) {
        String sql = "SELECT id, audience, user_id, municipality_id, issue_id, type, title, message, is_read, event_key, created_at "
                + "FROM notifications WHERE audience = 'CITIZEN' AND user_id = ? "
                + "ORDER BY created_at DESC LIMIT ?";
        return queryList(sql, ps -> {
            ps.setInt(1, userDbId);
            ps.setInt(2, limit);
        });
    }

    public List<NotificationItem> findForMunicipality(int municipalityId, int limit) {
        String sql = "SELECT id, audience, user_id, municipality_id, issue_id, type, title, message, is_read, event_key, created_at "
                + "FROM notifications WHERE audience = 'MUNICIPALITY' AND municipality_id = ? "
                + "ORDER BY created_at DESC LIMIT ?";
        return queryList(sql, ps -> {
            ps.setInt(1, municipalityId);
            ps.setInt(2, limit);
        });
    }

    public int countUnreadForCitizen(int userDbId) {
        String sql = "SELECT COUNT(*) FROM notifications WHERE audience = 'CITIZEN' AND user_id = ? AND is_read = 0";
        return queryCount(sql, userDbId);
    }

    public int countUnreadForMunicipality(int municipalityId) {
        String sql = "SELECT COUNT(*) FROM notifications WHERE audience = 'MUNICIPALITY' AND municipality_id = ? AND is_read = 0";
        return queryCount(sql, municipalityId);
    }

    public boolean markAllReadForCitizen(int userDbId) {
        String sql = "UPDATE notifications SET is_read = 1 WHERE audience = 'CITIZEN' AND user_id = ? AND is_read = 0";
        return executeUpdate(sql, userDbId);
    }

    public boolean markAllReadForMunicipality(int municipalityId) {
        String sql = "UPDATE notifications SET is_read = 1 WHERE audience = 'MUNICIPALITY' AND municipality_id = ? AND is_read = 0";
        return executeUpdate(sql, municipalityId);
    }

    private List<NotificationItem> queryList(String sql, SqlConsumer<PreparedStatement> binder) {
        List<NotificationItem> notifications = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            binder.accept(ps);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    NotificationItem n = new NotificationItem();
                    n.setId(rs.getInt("id"));
                    n.setAudience(rs.getString("audience"));
                    n.setUserId((Integer) rs.getObject("user_id"));
                    n.setMunicipalityId((Integer) rs.getObject("municipality_id"));
                    n.setIssueId((Integer) rs.getObject("issue_id"));
                    n.setType(rs.getString("type"));
                    n.setTitle(rs.getString("title"));
                    n.setMessage(rs.getString("message"));
                    n.setRead(rs.getBoolean("is_read"));
                    n.setEventKey(rs.getString("event_key"));
                    if (rs.getTimestamp("created_at") != null) {
                        n.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                    }
                    notifications.add(n);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Unable to fetch notifications", e);
        }
        return notifications;
    }

    private int queryCount(String sql, int id) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Unable to count notifications", e);
        }
        return 0;
    }

    private boolean executeUpdate(String sql, int id) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
            return true;
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Unable to update notifications", e);
            return false;
        }
    }

    private void bindForInsert(PreparedStatement ps, NotificationItem item) throws SQLException {
        ps.setString(1, item.getAudience());
        if (item.getUserId() == null) {
            ps.setNull(2, java.sql.Types.INTEGER);
        } else {
            ps.setInt(2, item.getUserId());
        }
        if (item.getMunicipalityId() == null) {
            ps.setNull(3, java.sql.Types.INTEGER);
        } else {
            ps.setInt(3, item.getMunicipalityId());
        }
        if (item.getIssueId() == null) {
            ps.setNull(4, java.sql.Types.INTEGER);
        } else {
            ps.setInt(4, item.getIssueId());
        }
        ps.setString(5, item.getType());
        ps.setString(6, item.getTitle());
        ps.setString(7, item.getMessage());
        if (item.getEventKey() == null || item.getEventKey().isBlank()) {
            ps.setNull(8, java.sql.Types.VARCHAR);
        } else {
            ps.setString(8, item.getEventKey());
        }
    }

    @FunctionalInterface
    private interface SqlConsumer<T> {
        void accept(T t) throws SQLException;
    }
}
