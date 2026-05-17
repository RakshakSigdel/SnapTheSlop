package com.snaptheslop.snaptheslop.upvote.controller;

import com.snaptheslop.snaptheslop.config.DBConnection;
import com.snaptheslop.snaptheslop.upvote.model.dao.UpvoteDAO;
import com.snaptheslop.snaptheslop.user.model.User;
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
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "upvoteServlet", urlPatterns = {"/upvote", "/citizen/upvote"})
public class UpvoteServlet extends HttpServlet {

	private static final Logger LOGGER = Logger.getLogger(UpvoteServlet.class.getName());
	private final UpvoteDAO upvoteDAO = new UpvoteDAO();

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		User user = SessionUtil.getLoggedInUser(request);
		if (user == null) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}

		String issueIdParam = request.getParameter("issueId");
		if (issueIdParam == null || issueIdParam.isBlank()) {
			response.sendRedirect(request.getContextPath() + "/citizen/browse-issues");
			return;
		}

		int issueId;
		try {
			issueId = Integer.parseInt(issueIdParam.trim());
		} catch (NumberFormatException e) {
			response.sendRedirect(request.getContextPath() + "/citizen/browse-issues");
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

		upvoteDAO.toggleUpvote(issueId, userDbId);

		// Check milestones
		com.snaptheslop.snaptheslop.issue.model.Issue issue = new com.snaptheslop.snaptheslop.issue.model.dao.IssueDAO().findById(issueId);
		if (issue != null) {
			int upvoteCount = issue.getUpvoteCount();
			if (upvoteCount == 25 || upvoteCount == 50 || upvoteCount == 100) {
				new com.snaptheslop.snaptheslop.notification.model.dao.NotificationService()
						.triggerUpvoteMilestone(issue, upvoteCount, upvoteCount);
			}
		}

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
			LOGGER.log(Level.SEVERE, "Unable to resolve users.id for upvote action", e);
		}
		return -1;
	}
}
