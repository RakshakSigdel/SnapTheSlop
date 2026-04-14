package com.snaptheslop.snaptheslop.issue.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "municipalityDashboardServlet", value = "/municipality/dashboard")
public class MunicipalityDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("activePage", "dashboard");
        request.getRequestDispatcher("/WEB-INF/views/municipality/dashboard.jsp")
               .forward(request, response);
    }
}
