package com.snaptheslop.snaptheslop.user.controller;

import com.snaptheslop.snaptheslop.user.model.User;
import com.snaptheslop.snaptheslop.user.model.dao.UserDAO;
import com.snaptheslop.snaptheslop.util.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.UUID;

@WebServlet(name = "registerServlet", value = "/register")
public class RegisterServlet extends HttpServlet {

  private static final String REGISTER_VIEW =
    "/WEB-INF/views/user/register.jsp";
  private UserDAO userDAO = new UserDAO();

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    request.getRequestDispatcher(REGISTER_VIEW).forward(request, response);
  }

  @Override
  protected void doPost(
    HttpServletRequest request,
    HttpServletResponse response
  ) throws ServletException, IOException {
    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String password = request.getParameter("password");
    String confirmPassword = request.getParameter("confirmPassword");

    // Validation
    StringBuilder errors = new StringBuilder();

    if (firstName == null || firstName.trim().isEmpty()) {
      errors.append("First name is required. ");
    }

    if (lastName == null || lastName.trim().isEmpty()) {
      errors.append("Last name is required. ");
    }

    if (!ValidationUtil.isValidEmail(email)) {
      errors.append("Invalid email address. ");
    }

    if (email != null && userDAO.findUserByEmail(email) != null) {
      errors.append("Email already registered. ");
    }

    if (password == null || password.length() < 8) {
      errors.append("Password must be at least 8 characters. ");
    }

    if (!password.equals(confirmPassword)) {
      errors.append("Passwords do not match. ");
    }

    if (errors.length() > 0) {
      request.setAttribute("error", errors.toString().trim());
      request.setAttribute("firstName", firstName);
      request.setAttribute("lastName", lastName);
      request.setAttribute("email", email);
      request.setAttribute("phone", phone);
      request.getRequestDispatcher(REGISTER_VIEW).forward(request, response);
      return;
    }

    // Create UserDTO
    User newUser = new User();
    newUser.setUserId(
      "NS-" +
        System.currentTimeMillis() +
        "-" +
        UUID.randomUUID().toString().substring(0, 5).toUpperCase()
    );
    newUser.setFirstName(firstName.trim());
    newUser.setLastName(lastName.trim());
    newUser.setEmail(email.trim());
    newUser.setPhoneNumber(phone);
    newUser.setMunicipality("Itahari Sub-metropolitan City");
    newUser.setWardNo("Ward No. 1");
    newUser.setProvince("Madhesh Province");
    newUser.setRole("Registered Citizen");
    newUser.setAccountStatus("Verified Account");
    newUser.setMemberSince(java.time.LocalDate.now().toString());

    // Register user in database
    if (userDAO.registerUser(newUser, password)) {
      // Store user in session
      HttpSession session = request.getSession();
      session.setAttribute("loggedInUser", newUser);
      session.setAttribute(
        "userName",
        firstName.trim() + " " + lastName.trim()
      );
      session.setAttribute(
        "userInitials",
        (
          firstName.trim().charAt(0) +
          "" +
          lastName.trim().charAt(0)
        ).toUpperCase()
      );

      // Redirect to citizen dashboard
      response.sendRedirect(request.getContextPath() + "/citizen/dashboard");
    } else {
      request.setAttribute("error", "Registration failed. Please try again.");
      request.setAttribute("firstName", firstName);
      request.setAttribute("lastName", lastName);
      request.setAttribute("email", email);
      request.setAttribute("phone", phone);
      request.getRequestDispatcher(REGISTER_VIEW).forward(request, response);
    }
  }
}
