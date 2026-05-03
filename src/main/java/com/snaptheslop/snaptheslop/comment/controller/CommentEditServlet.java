package com.snaptheslop.snaptheslop.comment.controller;

import com.snaptheslop.snaptheslop.comment.model.Comment;
import com.snaptheslop.snaptheslop.comment.model.dao.CommentDAO;
import com.snaptheslop.snaptheslop.config.DBConnection;
import com.snaptheslop.snaptheslop.issue.model.Issue;
import com.snaptheslop.snaptheslop.issue.model.dao.IssueDAO;
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

@WebServlet(name = "commentEditServlet", value = "/citizen/comment-edit")
public class CommentEditServlet extends HttpServlet {

    private final CommentDAO commentDAO = new CommentDAO();
    private final IssueDAO issueDAO = new IssueDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserDTO user = SessionUtil.getLoggedInUser(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int userDbId = resolveUserDbId(request, user);
        int commentId = parseCommentId(request.getParameter("id"));
        if (commentId <= 0) {
            flashError(request, "Missing comment identifier.");
            response.sendRedirect(resolveReturnUrl(request, "/citizen/my-issues"));
            return;
        }

        Comment comment = commentDAO.findByIdAndUserId(commentId, userDbId);
        if (comment == null) {
            flashError(request, "You can only edit your own comment.");
            response.sendRedirect(resolveReturnUrl(request, "/citizen/my-issues"));
            return;
        }

        Issue issue = issueDAO.findById(comment.getIssueId());
        request.setAttribute("comment", comment);
        request.setAttribute("issue", issue);
        request.setAttribute("returnUrl", resolveReturnUrl(request, "/citizen/issue-detail?id=" + comment.getIssueId()));
        request.setAttribute("activePage", "my-issues");
        request.getRequestDispatcher("/WEB-INF/views/citizen/comment-edit.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserDTO user = SessionUtil.getLoggedInUser(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int userDbId = resolveUserDbId(request, user);
        int commentId = parseCommentId(request.getParameter("commentId"));
        String content = trim(request.getParameter("content"));
        String returnUrl = resolveReturnUrl(request, "/citizen/my-issues");

        if (commentId <= 0 || content == null || content.isBlank()) {
            flashError(request, "Comment text is required.");
            response.sendRedirect(returnUrl);
            return;
        }

        if (!commentDAO.updateCommentByOwner(commentId, userDbId, content)) {
            flashError(request, "You can only edit your own comment.");
            response.sendRedirect(returnUrl);
            return;
        }

        request.getSession().setAttribute("successMessage", "Your comment was updated successfully.");
        response.sendRedirect(returnUrl);
    }

    private int resolveUserDbId(HttpServletRequest request, UserDTO user) {
        int userDbId = SessionUtil.getLoggedInUserDbId(request);
        if (userDbId > 0) {
            return userDbId;
        }

        if (user == null || user.getUserId() == null) {
            return -1;
        }

        String sql = "SELECT id FROM users WHERE userId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getUserId());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    userDbId = rs.getInt(1);
                    SessionUtil.setLoggedInUserDbId(request, userDbId);
                    return userDbId;
                }
            }
        } catch (Exception ignored) {
        }
        return -1;
    }

    private int parseCommentId(String value) {
        try {
            return value == null ? -1 : Integer.parseInt(value.trim());
        } catch (NumberFormatException e) {
            return -1;
        }
    }

    private String resolveReturnUrl(HttpServletRequest request, String fallback) {
        String returnUrl = request.getParameter("returnUrl");
        if (returnUrl == null || returnUrl.isBlank()) {
            return request.getContextPath() + fallback;
        }
        if (!returnUrl.startsWith("/")) {
            return request.getContextPath() + fallback;
        }
        return request.getContextPath() + returnUrl;
    }

    private void flashError(HttpServletRequest request, String message) {
        request.getSession().setAttribute("errorMessage", message);
    }

    private String trim(String value) {
        return value == null ? null : value.trim();
    }
}
