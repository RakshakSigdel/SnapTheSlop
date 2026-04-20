package com.snaptheslop.snaptheslop.admin.controller;

import com.snaptheslop.snaptheslop.user.model.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "adminCitizensServlet", value = "/admin/users")
public class AdminCitizensServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("users", userDAO.getAllUsers());
        request.setAttribute("activePage", "citizens");
        request.getRequestDispatcher("/WEB-INF/views/admin/citizens.jsp").forward(request, response);
    }
}
