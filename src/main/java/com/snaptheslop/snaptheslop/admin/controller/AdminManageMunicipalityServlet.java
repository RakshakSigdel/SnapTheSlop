package com.snaptheslop.snaptheslop.admin.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "adminManageMunicipalityServlet", value = "/admin/manage-municipality")
public class AdminManageMunicipalityServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("activePage", "municipalities");
        request.getRequestDispatcher("/WEB-INF/views/admin/manageMunicipalities.jsp").forward(request, response);
    }
}
