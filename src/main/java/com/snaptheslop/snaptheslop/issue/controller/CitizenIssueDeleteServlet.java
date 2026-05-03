package com.snaptheslop.snaptheslop.issue.controller;
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
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.logging.Level;
import java.util.logging.Logger;
@WebServlet(name = "citizenIssueDeleteServlet", value = "/citizen/issue-delete")
public class CitizenIssueDeleteServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(CitizenIssueDeleteServlet.class.getName());
    private final IssueDAO issueDAO = new IssueDAO();
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDTO citizen = SessionUtil.getLoggedInUser(request);
        if (citizen == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        int userDbId = resolveLoggedInUserDbId(request, citizen);
        String issueIdParam = trim(request.getParameter("issueId"));
        if (issueIdParam == null) {
            flashError(request, "Missing report identifier.");
            response.sendRedirect(request.getContextPath() + "/citizen/my-issues");
            return;
        }
        Issue issue = resolveOwnedIssue(issueIdParam, userDbId);
        if (issue == null) {
            flashError(request, "You can only delete your own report.");
            response.sendRedirect(request.getContextPath() + "/citizen/my-issues");
            return;
        }
        if (!issueDAO.deleteIssueByOwner(issue.getId(), userDbId)) {
            flashError(request, "Failed to delete your report. Please try again.");
            response.sendRedirect(request.getContextPath() + "/citizen/issue-detail?id=" + issue.getId());
            return;
        }
        deleteIssueImage(issue.getImagePath());
        request.getSession().setAttribute("successMessage", "Your report was deleted successfully.");
        response.sendRedirect(request.getContextPath() + "/citizen/my-issues");
    }
    private Issue resolveOwnedIssue(String idParam, int userDbId) {
        try {
            int numericId = Integer.parseInt(idParam);
            return issueDAO.findByIdAndUserId(numericId, userDbId);
        } catch (NumberFormatException e) {
            return null;
        }
    }
    private int resolveLoggedInUserDbId(HttpServletRequest request, UserDTO citizen) {
        int userDbId = SessionUtil.getLoggedInUserDbId(request);
        if (userDbId > 0) {
            return userDbId;
        }
        if (citizen == null || citizen.getUserId() == null) {
            return -1;
        }
        String sql = "SELECT id FROM users WHERE userId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, citizen.getUserId());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    userDbId = rs.getInt(1);
                    SessionUtil.setLoggedInUserDbId(request, userDbId);
                    return userDbId;
                }
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error resolving logged in user db id", e);
        }
        return -1;
    }
    private void deleteIssueImage(String imagePath) {
        if (imagePath == null || imagePath.isBlank()) {
            return;
        }
        try {
            String realPath = getServletContext().getRealPath(imagePath);
            if (realPath != null) {
                File file = new File(realPath);
                if (file.exists() && !file.delete()) {
                    LOGGER.log(Level.WARNING, "Failed to delete issue image: {0}", realPath);
                }
            }
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Unable to delete issue image", e);
        }
    }
    private void flashError(HttpServletRequest request, String message) {
        request.getSession().setAttribute("errorMessage", message);
    }
    private String trim(String value) {
        return value == null ? null : value.trim();
    }
}