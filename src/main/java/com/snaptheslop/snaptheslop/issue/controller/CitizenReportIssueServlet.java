package com.snaptheslop.snaptheslop.issue.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "citizenReportIssueServlet", value = "/citizen/report-issue")
public class CitizenReportIssueServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("activePage", "report-issue");
        request.getRequestDispatcher("/WEB-INF/views/citizen/report-issue.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO: backend team — handle form submission here, then redirect
        response.sendRedirect(request.getContextPath() + "/citizen/my-issues");
    }
}
