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

@WebServlet(name = "loginServlet", value = "/login")
public class LoginServlet extends HttpServlet {

  private static final String LOGIN_VIEW = "/WEB-INF/views/user/login.jsp";
  private UserDAO userDAO = new UserDAO();

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    request.getRequestDispatcher(LOGIN_VIEW).forward(request, response);
  }

  @Override
  protected void doPost(
    HttpServletRequest request,
    HttpServletResponse response
  ) throws ServletException, IOException {
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String rememberMe = request.getParameter("remember");

    // Validate inputs
    if (
      email == null ||
      email.trim().isEmpty() ||
      password == null ||
      password.trim().isEmpty()
    ) {
      request.setAttribute("error", "Email and password are required.");
      request.setAttribute("email", email);
      request.getRequestDispatcher(LOGIN_VIEW).forward(request, response);
      return;
    }

    // Authenticate user
    UserDTO user = userDAO.authenticateUser(email.trim(), password);

    if (user != null) {
      // Create session
      HttpSession session = request.getSession();
      session.setAttribute("loggedInUser", user);
      session.setAttribute(
        "userName",
        user.getFirstName() + " " + user.getLastName()
      );
      session.setAttribute(
        "userInitials",
        (
          user.getFirstName().charAt(0) +
          "" +
          user.getLastName().charAt(0)
        ).toUpperCase()
      );
      session.setMaxInactiveInterval(30 * 60); // 30 minutes

      // Store remember-me preference if checked
      if ("on".equals(rememberMe)) {
        session.setAttribute("rememberDevice", true);
      }

      // Redirect based on user role
      String userRole = user.getRole();
      String redirectPath;

      if (userRole != null) {
        userRole = userRole.trim();
      }

      System.out.println("DEBUG: User logged in - Email: " + user.getEmail());
      System.out.println("DEBUG: User Role: '" + userRole + "'");
      System.out.println(
        "DEBUG: Role bytes: " +
          (userRole != null
            ? java.util.Arrays.toString(userRole.getBytes())
            : "null")
      );

      if ("Super Admin".equalsIgnoreCase(userRole)) {
        redirectPath = request.getContextPath() + "/admin/dashboard";
        System.out.println(
          "DEBUG: Matched SUPER ADMIN - Redirecting to ADMIN dashboard"
        );
      } else if ("Municipal Head".equalsIgnoreCase(userRole)) {
        redirectPath = request.getContextPath() + "/municipality/dashboard";
        System.out.println(
          "DEBUG: Matched MUNICIPAL HEAD - Redirecting to MUNICIPAL dashboard"
        );
      } else {
        redirectPath = request.getContextPath() + "/citizen/dashboard";
        System.out.println(
          "DEBUG: No role match - Redirecting to CITIZEN dashboard (role was: '" +
            userRole +
            "')"
        );
      }

      System.out.println("DEBUG: Final redirect path: " + redirectPath);
      response.sendRedirect(redirectPath);
    } else {
      // Login failed
      request.setAttribute("error", "Invalid email or password.");
      request.setAttribute("email", email);
      request.getRequestDispatcher(LOGIN_VIEW).forward(request, response);
    }
  }
}
