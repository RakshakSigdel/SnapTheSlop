package com.snaptheslop.snaptheslop.issue.controller;

import com.snaptheslop.snaptheslop.issue.model.Issue;
import com.snaptheslop.snaptheslop.issue.model.dao.IssueDAO;
import com.snaptheslop.snaptheslop.user.model.UserDTO;
import com.snaptheslop.snaptheslop.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Collections;
import java.util.List;
import java.util.logging.Logger;

/**
 * Sprint 5 Task 4 — Municipality issue queue with filtering and pagination.
 * Sprint 5 Task 7 — Replace static data with live DB-backed data.
 */
@WebServlet(name = "municipalityIssueListServlet", value = "/municipality/issue-list")
public class MunicipalityIssueListServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(MunicipalityIssueListServlet.class.getName());
    private static final int PAGE_SIZE = 15;
    private final IssueDAO issueDAO = new IssueDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Auth
        UserDTO muniUser = SessionUtil.getLoggedInUser(request);
        if (muniUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int municipalityId = muniUser.getMunicipalityId();

        // Filters
        String statusFilter   = trim(request.getParameter("status"));
        String categoryFilter = trim(request.getParameter("category"));
        String wardFilter     = trim(request.getParameter("ward"));

        int page = 1;
        try { page = Math.max(1, Integer.parseInt(request.getParameter("page"))); }
        catch (NumberFormatException ignored) {}

        // Fetch issues belonging to this municipality
        List<Issue> issues = Collections.emptyList();
        int totalCount = 0;
        int countOpen = 0, countInProgress = 0, countResolved = 0;

        if (municipalityId > 0) {
            issues = issueDAO.findByMunicipalityId(
                    municipalityId, statusFilter, categoryFilter, wardFilter, page, PAGE_SIZE);
            totalCount    = issueDAO.countByMunicipalityId(municipalityId, null);
            countOpen       = issueDAO.countByMunicipalityId(municipalityId, "Open");
            countInProgress = issueDAO.countByMunicipalityId(municipalityId, "In Progress");
            countResolved   = issueDAO.countByMunicipalityId(municipalityId, "Resolved");
        }

        int totalPages = (int) Math.ceil((double) totalCount / PAGE_SIZE);
        if (totalPages < 1) totalPages = 1;

        // Success/error flash messages from manage-issue POST
        String successMessage = (String) request.getSession().getAttribute("successMessage");
        String errorMessage   = (String) request.getSession().getAttribute("errorMessage");
        if (successMessage != null) { request.setAttribute("successMessage", successMessage); request.getSession().removeAttribute("successMessage"); }
        if (errorMessage   != null) { request.setAttribute("errorMessage",   errorMessage);   request.getSession().removeAttribute("errorMessage");   }

        request.setAttribute("activePage",      "issue-reports");
        request.setAttribute("issues",          issues);
        request.setAttribute("statusFilter",    statusFilter);
        request.setAttribute("categoryFilter",  categoryFilter);
        request.setAttribute("wardFilter",      wardFilter);
        request.setAttribute("currentPage",     page);
        request.setAttribute("totalPages",      totalPages);
        request.setAttribute("totalCount",      totalCount);
        request.setAttribute("countOpen",       countOpen);
        request.setAttribute("countInProgress", countInProgress);
        request.setAttribute("countResolved",   countResolved);

        request.getRequestDispatcher("/WEB-INF/views/municipality/issue-list.jsp").forward(request, response);
    }

    private String trim(String s) { return (s == null || s.isBlank()) ? null : s.trim(); }
}
