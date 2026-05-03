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

@WebServlet(name = "commentDeleteServlet", value = "/citizen/comment-delete")
public class CommentDeleteServlet extends HttpServlet {

    private final CommentDAO commentDAO = new CommentDAO();

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
        String returnUrl = resolveReturnUrl(request, "/citizen/my-issues");

        if (commentId <= 0) {
            flashError(request, "Missing comment identifier.");
            response.sendRedirect(returnUrl);
            return;
        }

        Comment comment = commentDAO.findByIdAndUserId(commentId, userDbId);
        if (comment == null) {
            flashError(request, "You can only delete your own comment.");
            response.sendRedirect(returnUrl);
            return;
        }

        if (!commentDAO.deleteCommentByOwner(commentId, userDbId)) {
            flashError(request, "Failed to delete your comment. Please try again.");
            response.sendRedirect(returnUrl);
            return;
        }

        request.getSession().setAttribute("successMessage", "Your comment was deleted successfully.");
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
}
