package com.snaptheslop.snaptheslop.admin.controller;

import com.snaptheslop.snaptheslop.issue.model.Issue;
import com.snaptheslop.snaptheslop.issue.model.dao.IssueDAO;
import com.snaptheslop.snaptheslop.municipality.MunicipalityDAO;
import com.snaptheslop.snaptheslop.municipality.model.Municipality;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

@WebServlet(name = "adminIssueServlet", urlPatterns = {"/admin/issue-management", "/admin/manage-issues"})
public class AdminIssueServlet extends HttpServlet {

    private static final int PAGE_SIZE = 15;
    private final IssueDAO issueDAO = new IssueDAO();
    private final MunicipalityDAO municipalityDAO = new MunicipalityDAO();

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String categoryFilter = trim(request.getParameter("category"));
        String municipalityFilter = trim(request.getParameter("municipalityId"));
        String wardFilter = trim(request.getParameter("ward"));
        String statusFilter = trim(request.getParameter("status"));
        String keywordFilter = trim(request.getParameter("keyword"));

        int page = 1;
        try {
            page = Math.max(1, Integer.parseInt(request.getParameter("page")));
        } catch (NumberFormatException ignored) {
        }

        List<Issue> issues = issueDAO.findAll(categoryFilter, municipalityFilter, wardFilter, statusFilter, keywordFilter, page, PAGE_SIZE);
        if (issues == null) {
            issues = Collections.emptyList();
        }

        int totalCount = issueDAO.countAllIssues(null);
        int openCount = issueDAO.countAllIssues("Open");
        int inProgressCount = issueDAO.countAllIssues("In Progress");
        int resolvedCount = issueDAO.countAllIssues("Resolved");

        int filteredCount = issueDAO.countAllFiltered(categoryFilter, municipalityFilter, wardFilter, statusFilter, keywordFilter);
        int totalPages = (int) Math.ceil((double) filteredCount / PAGE_SIZE);
        if (totalPages < 1) {
            totalPages = 1;
        }

        List<Municipality> municipalities;
        try {
            municipalities = municipalityDAO.getAllMunicipalities();
        } catch (Exception e) {
            municipalities = Collections.emptyList();
        }

        request.setAttribute("issues", issues);
        request.setAttribute("municipalities", municipalities);
        request.setAttribute("categoryFilter", categoryFilter);
        request.setAttribute("municipalityFilter", municipalityFilter);
        request.setAttribute("wardFilter", wardFilter);
        request.setAttribute("statusFilter", statusFilter);
        request.setAttribute("keywordFilter", keywordFilter);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalCount", totalCount);
        request.setAttribute("filteredCount", filteredCount);
        request.setAttribute("openCount", openCount);
        request.setAttribute("inProgressCount", inProgressCount);
        request.setAttribute("resolvedCount", resolvedCount);

        request.setAttribute("activePage", "issue-management");
        request.getRequestDispatcher("/WEB-INF/views/admin/issue-management.jsp").forward(request, response);
    }

    private String trim(String value) {
        if (value == null) {
            return null;
        }
        String trimmed = value.trim();
        return trimmed.isEmpty() ? null : trimmed;
    }
}
