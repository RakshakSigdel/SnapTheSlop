package com.snaptheslop.snaptheslop.citizen.controller;

import com.snaptheslop.snaptheslop.notification.model.dao.NotificationDAO;
import com.snaptheslop.snaptheslop.user.model.User;
import com.snaptheslop.snaptheslop.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "citizenNotificationsServlet", value = "/citizen/notifications")
public class CitizenNotificationsServlet extends HttpServlet {

    private final NotificationDAO notificationDAO = new NotificationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            
        User user = SessionUtil.getLoggedInUser(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        int userDbId = SessionUtil.getLoggedInUserDbId(request);
        if (userDbId > 0) {
            request.setAttribute("notifications", notificationDAO.findForCitizen(userDbId, 50));
            request.setAttribute("unreadCount", notificationDAO.countUnreadForCitizen(userDbId));
        }
        
        request.setAttribute("activePage", "notifications");
        request.getRequestDispatcher("/WEB-INF/views/citizen/notification.jsp").forward(request, response);
    }
}
