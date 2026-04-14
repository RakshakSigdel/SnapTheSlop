package com.snaptheslop.snaptheslop.issue.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "citizenIssueDetailServlet", value = "/citizen/issue-detail")
public class CitizenIssueDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String issueId = request.getParameter("id");
        if (issueId == null || issueId.isBlank()) {
            issueId = "1";
        }

        request.setAttribute("issueId", issueId);
        request.setAttribute("activePage", "my-issues");

        // Demo data for now until backend integration is added.
        switch (issueId) {
            case "2":
                request.setAttribute("issueTitle", "Streetlight out - Bagbazar chowk");
                request.setAttribute("issueCategory", "Electrical");
                request.setAttribute("issueStatus", "In Progress");
                request.setAttribute("issuePriority", "Medium Priority");
                request.setAttribute("issueLocation", "Bagbazar chowk, Ward 04");
                break;
            case "3":
                request.setAttribute("issueTitle", "Garbage pile - Thapathali bridge");
                request.setAttribute("issueCategory", "Sanitation");
                request.setAttribute("issueStatus", "Resolved");
                request.setAttribute("issuePriority", "Low Priority");
                request.setAttribute("issueLocation", "Thapathali bridge, Ward 04");
                break;
            case "4":
                request.setAttribute("issueTitle", "Broken pipe near Pashupati area");
                request.setAttribute("issueCategory", "Water");
                request.setAttribute("issueStatus", "Resolved");
                request.setAttribute("issuePriority", "Medium Priority");
                request.setAttribute("issueLocation", "Pashupati area, Ward 07");
                break;
            case "5":
                request.setAttribute("issueTitle", "Overflowing drain - Sundhara");
                request.setAttribute("issueCategory", "Drainage");
                request.setAttribute("issueStatus", "Pending");
                request.setAttribute("issuePriority", "High Priority");
                request.setAttribute("issueLocation", "Sundhara, Ward 04");
                break;
            default:
                request.setAttribute("issueTitle", "Pothole near Ratna Park");
                request.setAttribute("issueCategory", "Roads & Potholes");
                request.setAttribute("issueStatus", "Pending");
                request.setAttribute("issuePriority", "High Priority");
                request.setAttribute("issueLocation", "Near Ratna Park bus stop, Ward 04");
                break;
        }

        request.getRequestDispatcher("/WEB-INF/views/citizen/issue-detail.jsp")
               .forward(request, response);
    }
}
