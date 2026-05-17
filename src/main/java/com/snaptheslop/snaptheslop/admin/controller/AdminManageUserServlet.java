package com.snaptheslop.snaptheslop.admin.controller;

import com.snaptheslop.snaptheslop.user.model.User;
import com.snaptheslop.snaptheslop.user.model.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "adminManageUserServlet", value = "/admin/manage-user")
public class AdminManageUserServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User loggedInUser = (User) (session != null ? session.getAttribute("loggedInUser") : null);
        if (!isAdmin(loggedInUser)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Only admins can manage user status.");
            return;
        }

        String userId = request.getParameter("id");
        if (userId != null && !userId.trim().isEmpty()) {
            User targetUser = userDAO.findUserById(userId.trim());
            request.setAttribute("targetUser", targetUser);
        }

        request.setAttribute("activePage", "citizens");
        request.getRequestDispatcher("/WEB-INF/views/admin/manageCitizens.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User loggedInUser = (User) (session != null ? session.getAttribute("loggedInUser") : null);
        if (!isAdmin(loggedInUser)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Only admins can update user status.");
            return;
        }

        String userId = request.getParameter("userId");
        String accountStatus = request.getParameter("accountStatus");

        if (userId == null || userId.trim().isEmpty() || accountStatus == null || accountStatus.trim().isEmpty()) {
            request.setAttribute("error", "User ID and account status are required.");
            if (userId != null && !userId.trim().isEmpty()) {
                request.setAttribute("targetUser", userDAO.findUserById(userId.trim()));
            }
            request.setAttribute("activePage", "citizens");
            request.getRequestDispatcher("/WEB-INF/views/admin/manageCitizens.jsp").forward(request, response);
            return;
        }

        User targetUser = userDAO.findUserById(userId.trim());
        if (targetUser != null && targetUser.getRole() != null
                && "SUPER ADMIN".equalsIgnoreCase(targetUser.getRole().trim())) {
            request.setAttribute("error", "Super Admin status cannot be modified.");
            request.setAttribute("targetUser", targetUser);
            request.setAttribute("activePage", "citizens");
            request.getRequestDispatcher("/WEB-INF/views/admin/manageCitizens.jsp").forward(request, response);
            return;
        }

        boolean updated = userDAO.updateUserAccountStatus(userId.trim(), accountStatus.trim());
        if (updated) {
            request.setAttribute("success", "User status updated successfully.");
        } else {
            request.setAttribute("error", "Failed to update user status.");
        }

        request.setAttribute("targetUser", userDAO.findUserById(userId.trim()));
        request.setAttribute("activePage", "citizens");
        request.getRequestDispatcher("/WEB-INF/views/admin/manageCitizens.jsp").forward(request, response);
    }

    private boolean isAdmin(User user) {
        if (user == null || user.getRole() == null) {
            return false;
        }
        String role = user.getRole().trim().toUpperCase();
        return "SUPER ADMIN".equals(role) || "ADMIN".equals(role);
    }
}
