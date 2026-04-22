package com.snaptheslop.snaptheslop.issue.controller;

import com.snaptheslop.snaptheslop.issue.model.Issue;
import com.snaptheslop.snaptheslop.issue.model.dao.IssueDAO;
import com.snaptheslop.snaptheslop.user.model.UserDTO;
import com.snaptheslop.snaptheslop.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.logging.Logger;

/**
 * Sprint 5 Task 3 — Issue detail retrieval with complete metadata.
 * Sprint 5 Task 7 — Replace static/mock data with live DB-backed data.
 */
@WebServlet(name = "citizenIssueDetailServlet", value = "/citizen/issue-detail")
public class CitizenIssueDetailServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(CitizenIssueDetailServlet.class.getName());
    private final IssueDAO issueDAO = new IssueDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String issueIdParam = request.getParameter("id");

        if (issueIdParam == null || issueIdParam.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/citizen/my-issues");
            return;
        }

        // Try to find by numeric id first, then by string issueId
        Issue issue = null;
        try {
            int numericId = Integer.parseInt(issueIdParam);
            issue = issueDAO.findById(numericId);
        } catch (NumberFormatException e) {
            // param is a string issueId (e.g. "ISS-123")
            issue = issueDAO.findByIssueId(issueIdParam);
        }

        if (issue == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Issue not found.");
            return;
        }

        // Sprint 5 Task 6 — Citizens can only view their OWN issues via the detail page
        // (Browse page shows all; this detail is linked from "My Issues")
        UserDTO citizen = SessionUtil.getLoggedInUser(request);
        boolean isMunicipalOrAdmin = citizen != null && citizen.getRole() != null
                && (citizen.getRole().toUpperCase().contains("MUNICIPAL")
                    || citizen.getRole().toUpperCase().contains("ADMIN"));

        if (!isMunicipalOrAdmin) {
            int userDbId = SessionUtil.getLoggedInUserDbId(request);
            if (userDbId != -1 && issue.getUserId() != userDbId) {
                // Citizen trying to access someone else's issue detail — redirect to browse
                response.sendRedirect(request.getContextPath() + "/citizen/browse-issues");
                return;
            }
        }

        request.setAttribute("issue", issue);
        request.setAttribute("activePage", "my-issues");
        request.getRequestDispatcher("/WEB-INF/views/citizen/issue-detail.jsp").forward(request, response);
    }
}
