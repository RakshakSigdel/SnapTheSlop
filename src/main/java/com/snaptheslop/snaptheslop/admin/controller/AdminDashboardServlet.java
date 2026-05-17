package com.snaptheslop.snaptheslop.admin.controller;

import com.snaptheslop.snaptheslop.issue.model.Issue;
import com.snaptheslop.snaptheslop.issue.model.dao.IssueDAO;
import com.snaptheslop.snaptheslop.municipality.model.dao.MunicipalityDAO;
import com.snaptheslop.snaptheslop.user.model.dao.UserDAO;
import java.io.*;
import java.util.Collections;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "adminDashboardServlet", value = "/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private final IssueDAO issueDAO = new IssueDAO();
    private final UserDAO userDAO = new UserDAO();
    private final MunicipalityDAO municipalityDAO = new MunicipalityDAO();

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        int totalIssues = issueDAO.countAllIssues(null);
        int openIssues = issueDAO.countAllIssues("Open");
        int inProgressIssues = issueDAO.countAllIssues("In Progress");
        int resolvedIssues = issueDAO.countAllIssues("Resolved");

        int totalCitizens = userDAO.getAllUsers().size();
        int totalMunicipalities;
        try {
            totalMunicipalities = municipalityDAO.getAllMunicipalities().size();
        } catch (Exception e) {
            totalMunicipalities = 0;
        }

        List<Issue> recentIssues = issueDAO.findAll(null, null, null, null, 1, 8);
        if (recentIssues == null) {
            recentIssues = Collections.emptyList();
        }

        int resolutionRate = totalIssues > 0 ? (int) Math.round((resolvedIssues * 100.0) / totalIssues) : 0;

        request.setAttribute("totalIssues", totalIssues);
        request.setAttribute("openIssues", openIssues);
        request.setAttribute("inProgressIssues", inProgressIssues);
        request.setAttribute("resolvedIssues", resolvedIssues);
        request.setAttribute("totalCitizens", totalCitizens);
        request.setAttribute("totalMunicipalities", totalMunicipalities);
        request.setAttribute("resolutionRate", resolutionRate);
        request.setAttribute("recentIssues", recentIssues);
        request.setAttribute("activePage", "dashboard");
        request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
    }
}
