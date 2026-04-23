package com.snaptheslop.snaptheslop.comment.controller;

import com.snaptheslop.snaptheslop.comment.model.Comment;
import com.snaptheslop.snaptheslop.comment.model.dao.CommentDAO;
import com.snaptheslop.snaptheslop.config.DBConnection;
import com.snaptheslop.snaptheslop.user.model.UserDTO;
import com.snaptheslop.snaptheslop.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "commentServlet", urlPatterns = {"/comment/add", "/citizen/comment"})
public class CommentServlet extends HttpServlet {

	private static final Logger LOGGER = Logger.getLogger(CommentServlet.class.getName());
	private final CommentDAO commentDAO = new CommentDAO();

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		UserDTO user = SessionUtil.getLoggedInUser(request);
		if (user == null) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}

		String issueIdParam = request.getParameter("issueId");
		String content = request.getParameter("commentText");

		if (issueIdParam == null || issueIdParam.isBlank() || content == null || content.trim().isEmpty()) {
			redirectBack(request, response);
			return;
		}

		int issueId;
		try {
			issueId = Integer.parseInt(issueIdParam.trim());
		} catch (NumberFormatException e) {
			redirectBack(request, response);
			return;
		}

		int userDbId = SessionUtil.getLoggedInUserDbId(request);
		if (userDbId <= 0) {
			userDbId = resolveUserDbId(user.getUserId());
			if (userDbId > 0) {
				SessionUtil.setLoggedInUserDbId(request, userDbId);
			}
		}

		if (userDbId <= 0) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}

		Comment comment = new Comment();
		comment.setCommentId("CMT-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase());
		comment.setIssueId(issueId);
		comment.setUserId(userDbId);
		comment.setContent(content.trim());
		commentDAO.createComment(comment);

		// Trigger Notification
		com.snaptheslop.snaptheslop.issue.model.Issue issue = new com.snaptheslop.snaptheslop.issue.model.dao.IssueDAO().findById(issueId);
		if (issue != null) {
			new com.snaptheslop.snaptheslop.notification.model.dao.NotificationService()
					.triggerNewComment(issue, userDbId, user.getRole());
		}

		redirectBack(request, response);
	}

	private void redirectBack(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String returnUrl = request.getParameter("returnUrl");
		if (returnUrl != null && !returnUrl.isBlank()) {
			response.sendRedirect(request.getContextPath() + returnUrl);
			return;
		}
		response.sendRedirect(request.getContextPath() + "/citizen/browse-issues");
	}

	private int resolveUserDbId(String userId) {
		if (userId == null || userId.isBlank()) {
			return -1;
		}

		String sql = "SELECT id FROM users WHERE userId = ?";
		try (Connection conn = DBConnection.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, userId);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					return rs.getInt(1);
				}
			}
		} catch (Exception e) {
			LOGGER.log(Level.SEVERE, "Unable to resolve users.id for comment action", e);
		}
		return -1;
	}
}
