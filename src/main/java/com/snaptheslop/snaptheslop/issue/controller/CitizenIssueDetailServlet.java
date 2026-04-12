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
        request.setAttribute("activePage", "my-issues");
        request.getRequestDispatcher("/WEB-INF/views/citizen/issue-detail.jsp")
               .forward(request, response);
    }
}
