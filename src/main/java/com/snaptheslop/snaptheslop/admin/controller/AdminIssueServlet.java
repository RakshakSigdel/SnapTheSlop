package com.snaptheslop.snaptheslop.admin.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(name="adminIssueServlet",value="/admin/issue-management")
public class AdminIssueServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setAttribute("activePage", "issue-management");
        request.getRequestDispatcher("/WEB-INF/views/admin/issue-management.jsp").forward(request,response);
    }
}
