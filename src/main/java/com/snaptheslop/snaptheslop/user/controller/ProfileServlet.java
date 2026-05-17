package com.snaptheslop.snaptheslop.user.controller;

import com.snaptheslop.snaptheslop.municipality.model.dao.MunicipalityDAO;
import com.snaptheslop.snaptheslop.municipality.model.Municipality;
import com.snaptheslop.snaptheslop.user.model.User;
import com.snaptheslop.snaptheslop.user.model.dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Collections;
import java.util.List;

@WebServlet(name = "profileServlet", urlPatterns = {"/citizen/profile", "/profile"})
public class ProfileServlet extends HttpServlet {

    private static final String PROFILE_VIEW = "/WEB-INF/views/citizen/profile.jsp";
    private final UserDAO userDAO = new UserDAO();
    private final MunicipalityDAO municipalityDAO = new MunicipalityDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User profileUser = (User) request.getSession().getAttribute("loggedInUser");

        // UI-only behavior: always show profile page with demo/fallback data.
        if (profileUser == null) {
            profileUser = createDemoUser();
            request.getSession().setAttribute("loggedInUser", profileUser);
        }

        // Retrieve latest user data from database only for real user ids.
        if (profileUser.getUserId() != null && profileUser.getUserId().startsWith("NS-")) {
            User updatedUser = userDAO.findUserById(profileUser.getUserId());
            if (updatedUser != null) {
                profileUser = updatedUser;
                request.getSession().setAttribute("loggedInUser", profileUser);
                request.getSession().setAttribute("municipalityId", profileUser.getMunicipalityId());
            }
        }

        request.setAttribute("municipalities", loadMunicipalities());
        request.setAttribute("profileUser", profileUser);
        request.setAttribute("profileInitials", buildInitials(profileUser.getFirstName(), profileUser.getLastName()));
        request.setAttribute("activePage", "profile");
        request.getRequestDispatcher(PROFILE_VIEW).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User profileUser = (User) request.getSession().getAttribute("loggedInUser");

        if (profileUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String municipality = trimToNull(request.getParameter("municipality"));
        if (!isValidMunicipality(municipality)) {
            request.setAttribute("error", "Please select a valid municipality from the list.");
            request.setAttribute("municipalities", loadMunicipalities());
            request.setAttribute("profileUser", profileUser);
            request.setAttribute("profileInitials", buildInitials(profileUser.getFirstName(), profileUser.getLastName()));
            request.setAttribute("activePage", "profile");
            request.getRequestDispatcher(PROFILE_VIEW).forward(request, response);
            return;
        }

        // Update profile data from request parameters
        profileUser.setFirstName(request.getParameter("firstName"));
        profileUser.setLastName(request.getParameter("lastName"));
        profileUser.setPhoneNumber(request.getParameter("phoneNumber"));
        profileUser.setMunicipality(municipality);
        profileUser.setWardNo(request.getParameter("wardNo"));
        profileUser.setProvince(request.getParameter("province"));

        try {
            Integer municipalityId = municipalityDAO.findMunicipalityIdByName(municipality);
            profileUser.setMunicipalityId(municipalityId != null ? municipalityId : -1);
            request.getSession().setAttribute("municipalityId", profileUser.getMunicipalityId());
        } catch (SQLException | ClassNotFoundException e) {
            request.setAttribute("error", "Unable to validate municipality right now. Please try again.");
            request.setAttribute("municipalities", loadMunicipalities());
            request.setAttribute("profileUser", profileUser);
            request.setAttribute("profileInitials", buildInitials(profileUser.getFirstName(), profileUser.getLastName()));
            request.setAttribute("activePage", "profile");
            request.getRequestDispatcher(PROFILE_VIEW).forward(request, response);
            return;
        }

        // Update in database
        if (userDAO.updateUserProfile(profileUser)) {
            User refreshedUser = userDAO.findUserById(profileUser.getUserId());
            if (refreshedUser != null) {
                profileUser = refreshedUser;
            }
            request.getSession().setAttribute("loggedInUser", profileUser);
            request.getSession().setAttribute("municipalityId", profileUser.getMunicipalityId());
            request.setAttribute("success", "Profile updated successfully!");
        } else {
            request.setAttribute("error", "Failed to update profile.");
        }

        request.setAttribute("municipalities", loadMunicipalities());
        request.setAttribute("profileUser", profileUser);
        request.setAttribute("profileInitials", buildInitials(profileUser.getFirstName(), profileUser.getLastName()));
        request.setAttribute("activePage", "profile");
        request.getRequestDispatcher(PROFILE_VIEW).forward(request, response);
    }

    private List<Municipality> loadMunicipalities() {
        try {
            return municipalityDAO.getAllMunicipalities();
        } catch (SQLException | ClassNotFoundException e) {
            return Collections.emptyList();
        }
    }

    private boolean isValidMunicipality(String municipalityName) {
        if (municipalityName == null || municipalityName.isBlank()) {
            return false;
        }
        try {
            return municipalityDAO.findMunicipalityIdByName(municipalityName) != null;
        } catch (SQLException | ClassNotFoundException e) {
            return false;
        }
    }

    private String trimToNull(String value) {
        if (value == null) {
            return null;
        }
        String trimmed = value.trim();
        return trimmed.isEmpty() ? null : trimmed;
    }


    private String buildInitials(String firstName, String lastName) {
        String first = (firstName == null || firstName.isBlank()) ? "R" : firstName.substring(0, 1).toUpperCase();
        String last = (lastName == null || lastName.isBlank()) ? "Y" : lastName.substring(0, 1).toUpperCase();
        return first + last;
    }

    private User createDemoUser() {
        User user = new User();
        user.setUserId("NS-UI-000001");
        user.setFirstName("Ramesh");
        user.setLastName("Yadav");
        user.setEmail("ramesh.yadav@municipality.gov.np");
        user.setPhoneNumber("+977 9841123456");
        user.setRole("Registered Citizen");
        user.setAccountStatus("Verified Account");
        user.setMunicipality("Janakpur Sub-Metropolitan City");
        user.setWardNo("Ward No. 7");
        user.setMemberSince("Jan 2023");
        user.setProvince("Madhesh Province");
        return user;
    }
}
