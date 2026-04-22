package com.snaptheslop.snaptheslop.issue.controller;

import com.snaptheslop.snaptheslop.issue.model.Issue;
import com.snaptheslop.snaptheslop.issue.model.dao.IssueDAO;
import com.snaptheslop.snaptheslop.municipality.MunicipalityDAO;
import com.snaptheslop.snaptheslop.municipality.model.Municipality;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Collections;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

// Sprint 5 Task 2 — Browse issues with server-side filtering

/**
 * Sprint 5 Task 2 — Browse all community issues with pagination and filtering.
 * Sprint 5 Task 7 — Replace static data with live DB-backed data.
 */
@WebServlet(name = "citizenBrowseIssuesServlet", value = "/citizen/browse-issues")
public class CitizenBrowseIssuesServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(CitizenBrowseIssuesServlet.class.getName());
    private static final int PAGE_SIZE = 15;

    private final IssueDAO issueDAO = new IssueDAO();
    private final MunicipalityDAO municipalityDAO = new MunicipalityDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Filters from query params
        String categoryFilter    = trim(request.getParameter("category"));
        String municipalityFilter= trim(request.getParameter("municipalityId"));
        String wardFilter        = trim(request.getParameter("ward"));
        String statusFilter      = trim(request.getParameter("status"));

        int page = 1;
        try { page = Math.max(1, Integer.parseInt(request.getParameter("page"))); }
        catch (NumberFormatException ignored) {}

        // Fetch live data from DB
        List<Issue> issues = issueDAO.findAll(
                categoryFilter, municipalityFilter, wardFilter, statusFilter, page, PAGE_SIZE);

        // Load municipalities for the filter dropdown
        List<Municipality> municipalities = Collections.emptyList();
        try { municipalities = municipalityDAO.getAllMunicipalities(); }
        catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.WARNING, "Could not load municipalities for filter", e);
        }

        // Pagination info
        int totalCount = 0; // approximate — count query could be added
        int totalPages = 1;

        request.setAttribute("activePage",         "browse-issues");
        request.setAttribute("issues",             issues);
        request.setAttribute("municipalities",     municipalities);
        request.setAttribute("categoryFilter",     categoryFilter);
        request.setAttribute("municipalityFilter", municipalityFilter);
        request.setAttribute("wardFilter",         wardFilter);
        request.setAttribute("statusFilter",       statusFilter);
        request.setAttribute("currentPage",        page);
        request.setAttribute("totalPages",         totalPages);

        request.getRequestDispatcher("/WEB-INF/views/citizen/browse-issues.jsp").forward(request, response);
    }

    private String trim(String s) { return (s == null || s.isBlank()) ? null : s.trim(); }
}
