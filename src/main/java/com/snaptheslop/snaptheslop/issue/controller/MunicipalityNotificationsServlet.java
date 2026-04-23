package com.snaptheslop.snaptheslop.issue.controller;

import com.snaptheslop.snaptheslop.notification.model.dao.NotificationDAO;
import com.snaptheslop.snaptheslop.user.model.UserDTO;
import com.snaptheslop.snaptheslop.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "municipalityNotificationsServlet", value = "/municipality/notifications")
public class MunicipalityNotificationsServlet extends HttpServlet {

    private final NotificationDAO notificationDAO = new NotificationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            
        UserDTO user = SessionUtil.getLoggedInUser(request);
        if (user == null || user.getMunicipalityId() <= 0) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        request.setAttribute("notifications", notificationDAO.findForMunicipality(user.getMunicipalityId(), 50));
        request.setAttribute("unreadCount", notificationDAO.countUnreadForMunicipality(user.getMunicipalityId()));

        request.setAttribute("activePage", "notifications");
        request.getRequestDispatcher("/WEB-INF/views/municipality/Notification.jsp")
                .forward(request, response);
    }
}
