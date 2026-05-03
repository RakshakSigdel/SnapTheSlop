package com.snaptheslop.snaptheslop.comment.model.dao;

import com.snaptheslop.snaptheslop.comment.model.Comment;
import com.snaptheslop.snaptheslop.config.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CommentDAO {

	private static final Logger LOGGER = Logger.getLogger(CommentDAO.class.getName());

	public boolean createComment(Comment comment) {
		String sql = "INSERT INTO comments (commentId, issueId, userId, content, createdAt, updatedAt) "
				+ "VALUES (?, ?, ?, ?, NOW(), NOW())";

		try (Connection conn = DBConnection.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, comment.getCommentId());
			ps.setInt(2, comment.getIssueId());
			ps.setInt(3, comment.getUserId());
			ps.setString(4, comment.getContent());
			return ps.executeUpdate() > 0;
		} catch (SQLException | ClassNotFoundException e) {
			LOGGER.log(Level.SEVERE, "Error creating comment", e);
			return false;
		}
	}

	public Comment findById(int id) {
		String sql = "SELECT c.id, c.commentId, c.issueId, c.userId, c.content, c.createdAt, c.updatedAt, "
				+ "CONCAT(u.firstName, ' ', u.lastName) AS commenterName "
				+ "FROM comments c "
				+ "LEFT JOIN users u ON c.userId = u.id "
				+ "WHERE c.id = ?";

		try (Connection conn = DBConnection.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, id);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					return mapRow(rs);
				}
			}
		} catch (SQLException | ClassNotFoundException e) {
			LOGGER.log(Level.SEVERE, "Error finding comment by id: " + id, e);
		}
		return null;
	}

	public Comment findByIdAndUserId(int id, int userId) {
		String sql = "SELECT c.id, c.commentId, c.issueId, c.userId, c.content, c.createdAt, c.updatedAt, "
				+ "CONCAT(u.firstName, ' ', u.lastName) AS commenterName "
				+ "FROM comments c "
				+ "LEFT JOIN users u ON c.userId = u.id "
				+ "WHERE c.id = ? AND c.userId = ?";

		try (Connection conn = DBConnection.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, id);
			ps.setInt(2, userId);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					return mapRow(rs);
				}
			}
		} catch (SQLException | ClassNotFoundException e) {
			LOGGER.log(Level.SEVERE, "Error finding comment by id and owner: " + id + "/" + userId, e);
		}
		return null;
	}

	public boolean updateCommentByOwner(int commentDbId, int ownerUserId, String content) {
		if (commentDbId <= 0 || ownerUserId <= 0 || content == null || content.trim().isEmpty()) {
			return false;
		}

		String sql = "UPDATE comments SET content = ?, updatedAt = NOW() WHERE id = ? AND userId = ?";
		try (Connection conn = DBConnection.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, content.trim());
			ps.setInt(2, commentDbId);
			ps.setInt(3, ownerUserId);
			return ps.executeUpdate() > 0;
		} catch (SQLException | ClassNotFoundException e) {
			LOGGER.log(Level.SEVERE, "Error updating comment by owner: " + commentDbId + "/" + ownerUserId, e);
		}
		return false;
	}

	public boolean deleteCommentByOwner(int commentDbId, int ownerUserId) {
		if (commentDbId <= 0 || ownerUserId <= 0) {
			return false;
		}

		String sql = "DELETE FROM comments WHERE id = ? AND userId = ?";
		try (Connection conn = DBConnection.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, commentDbId);
			ps.setInt(2, ownerUserId);
			return ps.executeUpdate() > 0;
		} catch (SQLException | ClassNotFoundException e) {
			LOGGER.log(Level.SEVERE, "Error deleting comment by owner: " + commentDbId + "/" + ownerUserId, e);
		}
		return false;
	}

	public Map<Integer, List<Comment>> findByIssueIds(List<Integer> issueIds, int maxPerIssue) {
		if (issueIds == null || issueIds.isEmpty()) {
			return Collections.emptyMap();
		}

		int safeMax = Math.max(1, maxPerIssue);
		String placeholders = String.join(",", java.util.Collections.nCopies(issueIds.size(), "?"));
		String sql = "SELECT c.id, c.commentId, c.issueId, c.userId, c.content, c.createdAt, c.updatedAt, "
				+ "CONCAT(u.firstName, ' ', u.lastName) AS commenterName "
				+ "FROM comments c "
				+ "LEFT JOIN users u ON c.userId = u.id "
				+ "WHERE c.issueId IN (" + placeholders + ") "
				+ "ORDER BY c.createdAt DESC";

		Map<Integer, List<Comment>> result = new HashMap<>();
		for (Integer issueId : issueIds) {
			result.put(issueId, new ArrayList<>());
		}

		try (Connection conn = DBConnection.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			int idx = 1;
			for (Integer issueId : issueIds) {
				ps.setInt(idx++, issueId);
			}

			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					int issueId = rs.getInt("issueId");
					List<Comment> comments = result.get(issueId);
					if (comments == null || comments.size() >= safeMax) {
						continue;
					}

					Comment comment = new Comment();
					comment.setId(rs.getInt("id"));
					comment.setCommentId(rs.getString("commentId"));
					comment.setIssueId(issueId);
					comment.setUserId(rs.getInt("userId"));
					comment.setContent(rs.getString("content"));
					comment.setCreatedAt(rs.getTimestamp("createdAt"));
					comment.setUpdatedAt(rs.getTimestamp("updatedAt"));
					comment.setCommenterName(rs.getString("commenterName"));
					comments.add(comment);
				}
			}
		} catch (SQLException | ClassNotFoundException e) {
			LOGGER.log(Level.SEVERE, "Error fetching comments by issue ids", e);
			return Collections.emptyMap();
		}

		return result;
	}

	public Map<Integer, Integer> countByIssueIds(List<Integer> issueIds) {
		if (issueIds == null || issueIds.isEmpty()) {
			return Collections.emptyMap();
		}

		String placeholders = String.join(",", java.util.Collections.nCopies(issueIds.size(), "?"));
		String sql = "SELECT issueId, COUNT(*) AS total FROM comments WHERE issueId IN (" + placeholders + ") GROUP BY issueId";

		Map<Integer, Integer> result = new HashMap<>();
		for (Integer issueId : issueIds) {
			result.put(issueId, 0);
		}

		try (Connection conn = DBConnection.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			int idx = 1;
			for (Integer issueId : issueIds) {
				ps.setInt(idx++, issueId);
			}
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					result.put(rs.getInt("issueId"), rs.getInt("total"));
				}
			}
		} catch (SQLException | ClassNotFoundException e) {
			LOGGER.log(Level.SEVERE, "Error counting comments by issue ids", e);
			return Collections.emptyMap();
		}

		return result;
	}

	public List<Comment> findByIssueId(int issueId) {
		String sql = "SELECT c.id, c.commentId, c.issueId, c.userId, c.content, c.createdAt, c.updatedAt, "
				+ "CONCAT(u.firstName, ' ', u.lastName) AS commenterName "
				+ "FROM comments c "
				+ "LEFT JOIN users u ON c.userId = u.id "
				+ "WHERE c.issueId = ? "
				+ "ORDER BY c.createdAt DESC";

		List<Comment> comments = new ArrayList<>();
		try (Connection conn = DBConnection.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, issueId);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					Comment comment = new Comment();
					comment.setId(rs.getInt("id"));
					comment.setCommentId(rs.getString("commentId"));
					comment.setIssueId(rs.getInt("issueId"));
					comment.setUserId(rs.getInt("userId"));
					comment.setContent(rs.getString("content"));
					comment.setCreatedAt(rs.getTimestamp("createdAt"));
					comment.setUpdatedAt(rs.getTimestamp("updatedAt"));
					comment.setCommenterName(rs.getString("commenterName"));
					comments.add(comment);
				}
			}
		} catch (SQLException | ClassNotFoundException e) {
			LOGGER.log(Level.SEVERE, "Error fetching comments by issueId", e);
			return Collections.emptyList();
		}

		return comments;
	}

	private Comment mapRow(ResultSet rs) throws SQLException {
		Comment comment = new Comment();
		comment.setId(rs.getInt("id"));
		comment.setCommentId(rs.getString("commentId"));
		comment.setIssueId(rs.getInt("issueId"));
		comment.setUserId(rs.getInt("userId"));
		comment.setContent(rs.getString("content"));
		comment.setCreatedAt(rs.getTimestamp("createdAt"));
		comment.setUpdatedAt(rs.getTimestamp("updatedAt"));
		comment.setCommenterName(rs.getString("commenterName"));
		return comment;
	}
}
