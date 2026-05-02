package com.snaptheslop.snaptheslop.user.controller;

import com.snaptheslop.snaptheslop.user.model.UserDTO;
import com.snaptheslop.snaptheslop.user.model.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "deleteAccountServlet", urlPatterns = {"/citizen/delete-account"})
public class DeleteAccountServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession(false);
        UserDTO user = (UserDTO) (session != null ? session.getAttribute("loggedInUser") : null);

        if (user == null || user.getUserId() == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            out.print("{\"success\":false,\"message\":\"Not authenticated\"}");
            return;
        }

        boolean deleted = userDAO.deleteUserByUserId(user.getUserId());

        if (deleted) {
            if (session != null) session.invalidate();
            out.print("{\"success\":true,\"message\":\"Account deleted successfully\"}");
        } else {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"success\":false,\"message\":\"Unable to delete account right now\"}");
        }
    }
}

