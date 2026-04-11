package com.snaptheslop.snaptheslop.admin.controller;

import java.io.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "adminDashboardServlet", value = "/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setAttribute("activePage", "dashboard");
        request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
    }
}
