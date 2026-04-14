package com.snaptheslop.snaptheslop.issue.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "municipalityIssueListServlet", value = "/municipality/issue-list")
public class MunicipalityIssueListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("activePage", "issue-reports");
        request.getRequestDispatcher("/WEB-INF/views/municipality/issue-list.jsp")
               .forward(request, response);
    }
}
