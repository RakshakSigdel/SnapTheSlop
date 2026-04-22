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

/**
 * Sprint 5 Task 2 — Citizen "My Issues" with pagination and filtering.
 * Sprint 5 Task 6 — Citizens only access their own issues.
 */
@WebServlet(name = "citizenMyIssuesServlet", value = "/citizen/my-issues")
public class CitizenMyIssuesServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(CitizenMyIssuesServlet.class.getName());
    private static final int PAGE_SIZE = 10;
    private final IssueDAO issueDAO = new IssueDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Auth
        UserDTO citizen = SessionUtil.getLoggedInUser(request);
        if (citizen == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Resolve the numeric users.id FK
        int userDbId = SessionUtil.getLoggedInUserDbId(request);
        if (userDbId == -1) {
            userDbId = lookupUserDbId(citizen.getUserId());
            if (userDbId != -1) SessionUtil.setLoggedInUserDbId(request, userDbId);
        }

        // Filter & pagination params
        String statusFilter = request.getParameter("status");
        int page = 1;
        try { page = Math.max(1, Integer.parseInt(request.getParameter("page"))); }
        catch (NumberFormatException ignored) {}

        // Fetch issues for this citizen only (Sprint 5 Task 6 — private access)
        List<Issue> issues = Collections.emptyList();
        int totalCount = 0;
        if (userDbId != -1) {
            issues     = issueDAO.findByUserId(userDbId, statusFilter, page, PAGE_SIZE);
            totalCount = issueDAO.countByUserId(userDbId, statusFilter);
        }

        // Status counts for filter tabs
        int countAll        = issueDAO.countByUserId(userDbId, null);
        int countOpen       = issueDAO.countByUserId(userDbId, "Open");
        int countInProgress = issueDAO.countByUserId(userDbId, "In Progress");
        int countResolved   = issueDAO.countByUserId(userDbId, "Resolved");

        int totalPages = (int) Math.ceil((double) totalCount / PAGE_SIZE);
        if (totalPages < 1) totalPages = 1;

        // Success message from previous POST (report-issue redirect)
        String successMessage = (String) request.getSession().getAttribute("successMessage");
        if (successMessage != null) {
            request.setAttribute("successMessage", successMessage);
            request.getSession().removeAttribute("successMessage");
        }

        request.setAttribute("activePage",    "my-issues");
        request.setAttribute("issues",        issues);
        request.setAttribute("statusFilter",  statusFilter);
        request.setAttribute("currentPage",   page);
        request.setAttribute("totalPages",    totalPages);
        request.setAttribute("totalCount",    totalCount);
        request.setAttribute("countAll",      countAll);
        request.setAttribute("countOpen",     countOpen);
        request.setAttribute("countInProgress", countInProgress);
        request.setAttribute("countResolved", countResolved);

        request.getRequestDispatcher("/WEB-INF/views/citizen/my-issues.jsp").forward(request, response);
    }

    private int lookupUserDbId(String userId) {
        if (userId == null) return -1;
        String sql = "SELECT id FROM users WHERE userId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error resolving userDbId for: " + userId, e);
        }
        return -1;
    }
}
