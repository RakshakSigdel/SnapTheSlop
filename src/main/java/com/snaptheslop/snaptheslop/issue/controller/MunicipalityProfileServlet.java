package com.snaptheslop.snaptheslop.issue.controller;

import com.snaptheslop.snaptheslop.municipality.MunicipalityDAO;
import com.snaptheslop.snaptheslop.municipality.model.Municipality;
import com.snaptheslop.snaptheslop.user.model.UserDTO;
import com.snaptheslop.snaptheslop.user.model.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "municipalityProfileServlet", value = "/municipality/profile")
public class MunicipalityProfileServlet extends HttpServlet {

    private final MunicipalityDAO municipalityDAO = new MunicipalityDAO();
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("activePage", "profile");
        request.getRequestDispatcher("/WEB-INF/views/municipality/profile.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Object userObj = session != null ? session.getAttribute("loggedInUser") : null;
        if (userObj == null) {
            userObj = session != null ? session.getAttribute("user") : null;
        }

        if (userObj == null) {
            // Not authenticated
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Read form fields
        String headFirstName = request.getParameter("headFirstName");
        String headLastName = request.getParameter("headLastName");
        String officialEmail = request.getParameter("officialEmail");
        String officePhone = request.getParameter("officePhone");
        // emergencyLine is currently not stored in Municipality table; ignored
        String municipalityName = request.getParameter("municipalityName");
        String officeAddress = request.getParameter("officeAddress");
        String province = request.getParameter("province");

        // Determine municipality id: prefer user's municipalityId if available
        int municipalityId = -1;
        try {
            if (userObj instanceof UserDTO) {
                UserDTO u = (UserDTO) userObj;
                if (u.getMunicipalityId() > 0) {
                    municipalityId = u.getMunicipalityId();
                }
            } else {
                // try reflection to read getMunicipalityId
                try {
                    java.lang.reflect.Method m = userObj.getClass().getMethod("getMunicipalityId");
                    Object v = m.invoke(userObj);
                    if (v instanceof Integer && ((Integer) v) > 0) municipalityId = (Integer) v;
                } catch (Exception ignored) {}
            }

            if (municipalityId <= 0) {
                Integer found = municipalityDAO.findMunicipalityIdByName(municipalityName != null ? municipalityName : "");
                municipalityId = found != null ? found : -1;
            }
        } catch (SQLException | ClassNotFoundException e) {
            // ignore and proceed with -1
        }

        if (municipalityId <= 0) {
            request.setAttribute("error", "Unable to resolve municipality to update.");
            request.setAttribute("activePage", "profile");
            request.getRequestDispatcher("/WEB-INF/views/municipality/profile.jsp").forward(request, response);
            return;
        }

        Municipality municipality = new Municipality();
        municipality.setId(municipalityId);
        municipality.setName(municipalityName != null ? municipalityName.trim() : null);
        municipality.setProvince(province != null ? province.trim() : null);
        municipality.setContactNumber(officePhone != null ? officePhone.trim() : null);
        municipality.setEmail(officialEmail != null ? officialEmail.trim() : null);
        municipality.setOfficeAddress(officeAddress != null ? officeAddress.trim() : null);

        try {
            boolean ok = municipalityDAO.updateMunicipality(municipality);

            // update user name if possible
            if (userObj instanceof UserDTO) {
                UserDTO u = (UserDTO) userObj;
                if (headFirstName != null) u.setFirstName(headFirstName.trim());
                if (headLastName != null) u.setLastName(headLastName.trim());
                userDAO.updateUserProfile(u);
                UserDTO refreshed = userDAO.findUserById(u.getUserId());
                if (refreshed != null && session != null) session.setAttribute("loggedInUser", refreshed);
            } else {
                // try to set via reflection on session 'user' object
                try {
                    java.lang.reflect.Method sf = userObj.getClass().getMethod("setFirstName", String.class);
                    java.lang.reflect.Method sl = userObj.getClass().getMethod("setLastName", String.class);
                    if (sf != null) sf.invoke(userObj, headFirstName != null ? headFirstName.trim() : null);
                    if (sl != null) sl.invoke(userObj, headLastName != null ? headLastName.trim() : null);
                    if (session != null) session.setAttribute("user", userObj);
                } catch (Exception ignored) {}
            }

            if (ok) {
                // set flash message in session and redirect to avoid double POST
                if (session != null) session.setAttribute("profileSuccess", "Profile updated successfully!");
                response.sendRedirect(request.getContextPath() + "/municipality/profile");
                return;
            } else {
                request.setAttribute("error", "Failed to save municipality data.");
            }
        } catch (SQLException | ClassNotFoundException e) {
            request.setAttribute("error", "Database error while saving municipality profile.");
        }

        request.setAttribute("activePage", "profile");
        request.getRequestDispatcher("/WEB-INF/views/municipality/profile.jsp").forward(request, response);
    }
}
