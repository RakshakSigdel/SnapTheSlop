package com.snaptheslop.snaptheslop.issue.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "municipalityManageIssueServlet", value = "/municipality/manage-issue")
public class MunicipalityManageIssueServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("activePage", "issue-reports");
        request.getRequestDispatcher("/WEB-INF/views/municipality/manageIssue.jsp")
                .forward(request, response);
    }
}
