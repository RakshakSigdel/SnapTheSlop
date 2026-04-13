package com.snaptheslop.snaptheslop.issue.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "citizenDashboardServlet", value = "/citizen/dashboard")
public class CitizenDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("activePage", "dashboard");
        request.getRequestDispatcher("/WEB-INF/views/citizen/dashboard.jsp")
               .forward(request, response);
    }
}
