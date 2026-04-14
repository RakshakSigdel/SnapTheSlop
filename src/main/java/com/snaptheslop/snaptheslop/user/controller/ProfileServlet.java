package com.snaptheslop.snaptheslop.user.controller;

import com.snaptheslop.snaptheslop.user.model.UserDTO;
import com.snaptheslop.snaptheslop.user.model.dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "profileServlet", urlPatterns = {"/citizen/profile", "/profile"})
public class ProfileServlet extends HttpServlet {

    private static final String PROFILE_VIEW = "/WEB-INF/views/citizen/profile.jsp";
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserDTO profileUser = (UserDTO) request.getSession().getAttribute("loggedInUser");

        // UI-only behavior: always show profile page with demo/fallback data.
        if (profileUser == null) {
            profileUser = createDemoUser();
            request.getSession().setAttribute("loggedInUser", profileUser);
        }

        // Retrieve latest user data from database only for real user ids.
        if (profileUser.getUserId() != null && profileUser.getUserId().startsWith("NS-")) {
            UserDTO updatedUser = userDAO.findUserById(profileUser.getUserId());
            if (updatedUser != null) {
                profileUser = updatedUser;
                request.getSession().setAttribute("loggedInUser", profileUser);
            }
        }

        request.setAttribute("profileUser", profileUser);
        request.setAttribute("profileInitials", buildInitials(profileUser.getFirstName(), profileUser.getLastName()));
        request.setAttribute("activePage", "profile");
        request.getRequestDispatcher(PROFILE_VIEW).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserDTO profileUser = (UserDTO) request.getSession().getAttribute("loggedInUser");

        if (profileUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Update profile data from request parameters
        profileUser.setFirstName(request.getParameter("firstName"));
        profileUser.setLastName(request.getParameter("lastName"));
        profileUser.setPhoneNumber(request.getParameter("phoneNumber"));
        profileUser.setMunicipality(request.getParameter("municipality"));
        profileUser.setWardNo(request.getParameter("wardNo"));
        profileUser.setProvince(request.getParameter("province"));

        // Update in database
        if (userDAO.updateUserProfile(profileUser)) {
            request.getSession().setAttribute("loggedInUser", profileUser);
            request.setAttribute("success", "Profile updated successfully!");
        } else {
            request.setAttribute("error", "Failed to update profile.");
        }

        request.setAttribute("profileUser", profileUser);
        request.setAttribute("profileInitials", buildInitials(profileUser.getFirstName(), profileUser.getLastName()));
        request.setAttribute("activePage", "profile");
        request.getRequestDispatcher(PROFILE_VIEW).forward(request, response);
    }


    private String buildInitials(String firstName, String lastName) {
        String first = (firstName == null || firstName.isBlank()) ? "R" : firstName.substring(0, 1).toUpperCase();
        String last = (lastName == null || lastName.isBlank()) ? "Y" : lastName.substring(0, 1).toUpperCase();
        return first + last;
    }

    private UserDTO createDemoUser() {
        UserDTO user = new UserDTO();
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
