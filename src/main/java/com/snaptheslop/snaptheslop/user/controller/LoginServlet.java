package com.snaptheslop.snaptheslop.user.controller;

import com.snaptheslop.snaptheslop.user.model.UserDTO;
import com.snaptheslop.snaptheslop.user.model.dao.UserDAO;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "loginServlet", value = "/login")
public class LoginServlet extends HttpServlet {

    private static final String LOGIN_VIEW = "/WEB-INF/views/user/login.jsp";
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher(LOGIN_VIEW).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String rememberDevice = request.getParameter("remember-device");

        // Authenticate user
        UserDTO user = userDAO.authenticateUser(email, password);

        if (user != null) {
            // Create session
            HttpSession session = request.getSession();
            session.setAttribute("loggedInUser", user);
            session.setMaxInactiveInterval(30 * 60); // 30 minutes

            // Store remember-device preference if needed
            if ("on".equals(rememberDevice)) {
                session.setAttribute("rememberDevice", true);
            }

            // Redirect to profile
            response.sendRedirect(request.getContextPath() + "/profile");
        } else {
            // Login failed
            request.setAttribute("error", "Invalid email or password.");
            request.setAttribute("email", email);
            request.getRequestDispatcher(LOGIN_VIEW).forward(request, response);
        }
    }
}
