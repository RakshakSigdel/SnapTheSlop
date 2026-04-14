package com.snaptheslop.snaptheslop.issue.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "citizenBrowseIssuesServlet", value = "/citizen/browse-issues")
public class CitizenBrowseIssuesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("activePage", "browse-issues");
        request.getRequestDispatcher("/WEB-INF/views/citizen/browse-issues.jsp").forward(request, response);
    }
}
