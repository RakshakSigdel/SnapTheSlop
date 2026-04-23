package com.snaptheslop.snaptheslop.issue.controller;

import com.snaptheslop.snaptheslop.config.DBConnection;
import com.snaptheslop.snaptheslop.issue.model.Issue;
import com.snaptheslop.snaptheslop.issue.model.dao.IssueDAO;
import com.snaptheslop.snaptheslop.user.model.UserDTO;
import com.snaptheslop.snaptheslop.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Collections;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "citizenDashboardServlet", value = "/citizen/dashboard")
public class CitizenDashboardServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(CitizenDashboardServlet.class.getName());
    private final IssueDAO issueDAO = new IssueDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDTO citizen = SessionUtil.getLoggedInUser(request);
        if (citizen == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int userDbId = SessionUtil.getLoggedInUserDbId(request);
        if (userDbId <= 0) {
            userDbId = lookupUserDbId(citizen.getUserId());
            if (userDbId > 0) {
                SessionUtil.setLoggedInUserDbId(request, userDbId);
            }
        }

        List<Issue> recentIssues = Collections.emptyList();
        int totalReports = 0;
        int inProgressReports = 0;
        int resolvedReports = 0;

        if (userDbId > 0) {
            recentIssues = issueDAO.findByUserId(userDbId, null, 1, 5);
            totalReports = issueDAO.countByUserId(userDbId, null);
            inProgressReports = issueDAO.countByUserId(userDbId, "In Progress");
            resolvedReports = issueDAO.countByUserId(userDbId, "Resolved");
        }

        request.setAttribute("recentIssues", recentIssues);
        request.setAttribute("totalReports", totalReports);
        request.setAttribute("inProgressReports", inProgressReports);
        request.setAttribute("resolvedReports", resolvedReports);
        request.setAttribute("openReports", issueDAO.countByUserId(userDbId, "Open"));
        request.setAttribute("activePage", "dashboard");
        request.getRequestDispatcher("/WEB-INF/views/citizen/dashboard.jsp")
               .forward(request, response);
    }

    private int lookupUserDbId(String userId) {
        if (userId == null) {
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
            LOGGER.log(Level.SEVERE, "Error resolving userDbId for citizen dashboard", e);
        }
        return -1;
    }
}
