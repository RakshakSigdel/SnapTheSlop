package com.snaptheslop.snaptheslop.upvote.model.dao;

import com.snaptheslop.snaptheslop.config.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UpvoteDAO {

	private static final Logger LOGGER = Logger.getLogger(UpvoteDAO.class.getName());

	public boolean hasUserUpvoted(int issueId, int userId) {
		String sql = "SELECT 1 FROM upvotes WHERE issueId = ? AND userId = ? LIMIT 1";
		try (Connection conn = DBConnection.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, issueId);
			ps.setInt(2, userId);
			try (ResultSet rs = ps.executeQuery()) {
				return rs.next();
			}
		} catch (SQLException | ClassNotFoundException e) {
			LOGGER.log(Level.SEVERE, "Error checking upvote state", e);
			return false;
		}
	}

	public boolean toggleUpvote(int issueId, int userId) {
		String deleteSql = "DELETE FROM upvotes WHERE issueId = ? AND userId = ?";
		String insertSql = "INSERT INTO upvotes (issueId, userId, createdAt) VALUES (?, ?, NOW())";

		try (Connection conn = DBConnection.getConnection()) {
			conn.setAutoCommit(false);
			try {
				if (hasUserUpvoted(conn, issueId, userId)) {
					try (PreparedStatement ps = conn.prepareStatement(deleteSql)) {
						ps.setInt(1, issueId);
						ps.setInt(2, userId);
						ps.executeUpdate();
					}
				} else {
					try (PreparedStatement ps = conn.prepareStatement(insertSql)) {
						ps.setInt(1, issueId);
						ps.setInt(2, userId);
						ps.executeUpdate();
					}
				}
				conn.commit();
				return true;
			} catch (SQLException e) {
				conn.rollback();
				LOGGER.log(Level.SEVERE, "Error toggling upvote", e);
				return false;
			} finally {
				conn.setAutoCommit(true);
			}
		} catch (SQLException | ClassNotFoundException e) {
			LOGGER.log(Level.SEVERE, "Error opening connection for upvote toggle", e);
			return false;
		}
	}

	public Set<Integer> findUserUpvotedIssueIds(int userId, List<Integer> issueIds) {
		if (issueIds == null || issueIds.isEmpty()) {
			return Collections.emptySet();
		}

		String placeholders = String.join(",", java.util.Collections.nCopies(issueIds.size(), "?"));
		String sql = "SELECT issueId FROM upvotes WHERE userId = ? AND issueId IN (" + placeholders + ")";

		Set<Integer> result = new HashSet<>();
		try (Connection conn = DBConnection.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			int idx = 1;
			ps.setInt(idx++, userId);
			for (Integer issueId : issueIds) {
				ps.setInt(idx++, issueId);
			}

			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					result.add(rs.getInt("issueId"));
				}
			}
		} catch (SQLException | ClassNotFoundException e) {
			LOGGER.log(Level.SEVERE, "Error loading user upvoted issue ids", e);
			return Collections.emptySet();
		}

		return result;
	}

	/**
	 * Return a list of upvoters for an issue. Each entry is a Map with keys: name, email.
	 * This is used by municipality/admin views to see who supported a report.
	 */
	public java.util.List<java.util.Map<String,String>> findUpvotersByIssueId(int issueId) {
		String sql = "SELECT u.id, CONCAT(u.firstName, ' ', u.lastName) AS name, u.email "
				+ "FROM upvotes up JOIN users u ON up.userId = u.id "
				+ "WHERE up.issueId = ? ORDER BY up.createdAt DESC";

		java.util.List<java.util.Map<String,String>> result = new java.util.ArrayList<>();
		try (Connection conn = DBConnection.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, issueId);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					java.util.Map<String,String> m = new java.util.HashMap<>();
					m.put("name", rs.getString("name") != null ? rs.getString("name") : "Citizen");
					m.put("email", rs.getString("email") != null ? rs.getString("email") : "");
					result.add(m);
				}
			}
		} catch (SQLException | ClassNotFoundException e) {
			LOGGER.log(Level.SEVERE, "Error fetching upvoters for issueId=" + issueId, e);
			return java.util.Collections.emptyList();
		}

		return result;
	}

	private boolean hasUserUpvoted(Connection conn, int issueId, int userId) throws SQLException {
		String sql = "SELECT 1 FROM upvotes WHERE issueId = ? AND userId = ? LIMIT 1";
		try (PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, issueId);
			ps.setInt(2, userId);
			try (ResultSet rs = ps.executeQuery()) {
				return rs.next();
			}
		}
	}
}
