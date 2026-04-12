package com.snaptheslop.snaptheslop.issue.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "citizenMyIssuesServlet", value = "/citizen/my-issues")
public class CitizenMyIssuesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("activePage", "my-issues");
        request.getRequestDispatcher("/WEB-INF/views/citizen/my-issues.jsp")
               .forward(request, response);
    }
}
