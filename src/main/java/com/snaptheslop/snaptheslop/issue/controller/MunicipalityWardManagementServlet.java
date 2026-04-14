package com.snaptheslop.snaptheslop.issue.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "municipalityWardManagementServlet", value = "/municipality/ward-management")
public class MunicipalityWardManagementServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("activePage", "ward-management");
        request.getRequestDispatcher("/WEB-INF/views/municipality/wardManagement.jsp")
                .forward(request, response);
    }
}
