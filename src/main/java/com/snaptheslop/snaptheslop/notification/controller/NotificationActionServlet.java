package com.snaptheslop.snaptheslop.notification.controller;

import com.snaptheslop.snaptheslop.notification.model.dao.NotificationDAO;
import com.snaptheslop.snaptheslop.user.model.UserDTO;
import com.snaptheslop.snaptheslop.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "notificationActionServlet", urlPatterns = {
        "/citizen/notifications/mark-read",
        "/municipality/notifications/mark-read"
})
public class NotificationActionServlet extends HttpServlet {

    private final NotificationDAO notificationDAO = new NotificationDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserDTO user = SessionUtil.getLoggedInUser(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String uri = request.getRequestURI();
        if (uri.endsWith("/citizen/notifications/mark-read")) {
            int userDbId = SessionUtil.getLoggedInUserDbId(request);
            if (userDbId > 0) {
                notificationDAO.markAllReadForCitizen(userDbId);
            }
            response.sendRedirect(request.getContextPath() + "/citizen/notifications");
            return;
        }

        int municipalityId = user.getMunicipalityId();
        if (municipalityId > 0) {
            notificationDAO.markAllReadForMunicipality(municipalityId);
        }
        response.sendRedirect(request.getContextPath() + "/municipality/notifications");
    }
}
