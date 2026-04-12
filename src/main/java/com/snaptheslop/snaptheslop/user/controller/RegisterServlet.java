package com.snaptheslop.snaptheslop.user.controller;

import com.snaptheslop.snaptheslop.user.model.UserDTO;
import com.snaptheslop.snaptheslop.user.model.dao.UserDAO;
import com.snaptheslop.snaptheslop.util.ValidationUtil;

import java.io.IOException;
import java.util.UUID;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "registerServlet", value = "/register")
public class RegisterServlet extends HttpServlet {

    private static final String REGISTER_VIEW = "/WEB-INF/views/user/register.jsp";
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher(REGISTER_VIEW).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String wardNumber = request.getParameter("wardNumber");
        String municipality = request.getParameter("municipality");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String agreeToTerms = request.getParameter("agreeToTerms");

        // Validation
        StringBuilder errors = new StringBuilder();

        if (!ValidationUtil.isValidEmail(email)) {
            errors.append("Invalid email address. ");
        }

        if (email != null && userDAO.findUserByEmail(email) != null) {
            errors.append("Email already registered. ");
        }

        if (fullName == null || fullName.trim().isEmpty()) {
            errors.append("Full name is required. ");
        }

        if (password == null || password.length() < 8) {
            errors.append("Password must be at least 8 characters. ");
        }

        if (!password.equals(confirmPassword)) {
            errors.append("Passwords do not match. ");
        }

        if (municipality == null || municipality.trim().isEmpty()) {
            errors.append("Municipality is required. ");
        }

        if (!"on".equals(agreeToTerms)) {
            errors.append("You must agree to the terms and conditions. ");
        }

        if (errors.length() > 0) {
            request.setAttribute("error", errors.toString().trim());
            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("wardNumber", wardNumber);
            request.setAttribute("municipality", municipality);
            request.getRequestDispatcher(REGISTER_VIEW).forward(request, response);
            return;
        }

        // Parse full name into first and last name
        String[] nameParts = fullName.trim().split("\\s+");
        String firstName = nameParts[0];
        String lastName = nameParts.length > 1 ? String.join(" ", java.util.Arrays.copyOfRange(nameParts, 1, nameParts.length)) : "";

        // Create UserDTO
        UserDTO newUser = new UserDTO();
        newUser.setUserId("NS-" + System.currentTimeMillis() + "-" + UUID.randomUUID().toString().substring(0, 5).toUpperCase());
        newUser.setFirstName(firstName);
        newUser.setLastName(lastName);
        newUser.setEmail(email);
        newUser.setPhoneNumber(phone);
        newUser.setMunicipality(municipality);
        newUser.setWardNo("Ward No. " + wardNumber);
        newUser.setProvince("Madhesh Province"); // Default province
        newUser.setRole("Registered Citizen");
        newUser.setAccountStatus("Verified Account");
        newUser.setMemberSince(java.time.LocalDate.now().toString());

        // Register user in database
        if (userDAO.registerUser(newUser, password)) {
            // Store user in session
            HttpSession session = request.getSession();
            session.setAttribute("loggedInUser", newUser);

            // Show success message
            request.setAttribute("success", "Account created successfully! You are now logged in.");
            request.getRequestDispatcher(REGISTER_VIEW).forward(request, response);
        } else {
            request.setAttribute("error", "Registration failed. Please try again.");
            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("wardNumber", wardNumber);
            request.setAttribute("municipality", municipality);
            request.getRequestDispatcher(REGISTER_VIEW).forward(request, response);
        }
    }
}
