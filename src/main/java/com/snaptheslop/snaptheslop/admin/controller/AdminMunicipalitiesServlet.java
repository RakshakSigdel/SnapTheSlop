package com.snaptheslop.snaptheslop.admin.controller;

import com.snaptheslop.snaptheslop.municipality.model.Municipality;
import com.snaptheslop.snaptheslop.admin.model.dao.AdminDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(
  name = "adminMunicipalitiesServlet",
  value = "/admin/municipalities"
)
public class AdminMunicipalitiesServlet extends HttpServlet {

  private AdminDAO adminDAO = new AdminDAO();

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    forwardMunicipalitiesPage(request, response);
  }

  @Override
  protected void doPost(
    HttpServletRequest request,
    HttpServletResponse response
  ) throws ServletException, IOException {
    // Get form parameters
    String municipalityName = request.getParameter("municipalityName");
    String municipalityCode = request.getParameter("municipalityCode");
    String municipalityPhone = request.getParameter("municipalityPhone");
    String officeAddress = request.getParameter("officeAddress");
    String adminFirstName = request.getParameter("adminFirstName");
    String adminLastName = request.getParameter("adminLastName");
    String adminEmail = request.getParameter("adminEmail");
    String adminPhone = request.getParameter("adminPhone");
    String adminPassword = request.getParameter("adminPassword");

    // Validation
    StringBuilder errors = new StringBuilder();

    if (municipalityName == null || municipalityName.trim().isEmpty()) {
      errors.append("Municipality name is required. ");
    }

    if (municipalityCode == null || municipalityCode.trim().isEmpty()) {
      errors.append("Municipality code is required. ");
    }

    if (adminFirstName == null || adminFirstName.trim().isEmpty()) {
      errors.append("Admin first name is required. ");
    }

    if (adminLastName == null || adminLastName.trim().isEmpty()) {
      errors.append("Admin last name is required. ");
    }

    if (adminEmail == null || !adminEmail.contains("@")) {
      errors.append("Valid admin email is required. ");
    }

    if (municipalityPhone == null || municipalityPhone.trim().isEmpty()) {
      errors.append("Municipality phone number is required. ");
    }

    if (officeAddress == null || officeAddress.trim().isEmpty()) {
      errors.append("Office address is required. ");
    }

    if (adminPassword == null || adminPassword.length() < 8) {
      errors.append("Admin password must be at least 8 characters. ");
    }

    // Check if municipality already exists
    if (
      municipalityName != null &&
      adminDAO.getMunicipalityByName(municipalityName.trim()) != null
    ) {
      errors.append("Municipality already exists. ");
    }

    // Check if admin email already exists
    if (
      adminEmail != null && adminDAO.municipalityEmailExists(adminEmail.trim())
    ) {
      errors.append("Email already in use. ");
    }

    if (errors.length() > 0) {
      request.setAttribute("error", errors.toString().trim());
      request.setAttribute("municipalityName", municipalityName);
      request.setAttribute("municipalityCode", municipalityCode);
      request.setAttribute("municipalityPhone", municipalityPhone);
      request.setAttribute("officeAddress", officeAddress);
      request.setAttribute("adminFirstName", adminFirstName);
      request.setAttribute("adminLastName", adminLastName);
      request.setAttribute("adminEmail", adminEmail);
      request.setAttribute("adminPhone", adminPhone);
      forwardMunicipalitiesPage(request, response);
      return;
    }

    // Create municipality object
    Municipality municipality = new Municipality();
    municipality.setName(municipalityName.trim());
    municipality.setCode(municipalityCode.trim());
    municipality.setContactNumber(municipalityPhone.trim());
    municipality.setOfficeAddress(officeAddress.trim());
    municipality.setAdminFirstName(adminFirstName.trim());
    municipality.setAdminLastName(adminLastName.trim());
    municipality.setAdminEmail(adminEmail.trim());
    municipality.setAdminPhone(
      adminPhone != null && !adminPhone.trim().isEmpty()
        ? adminPhone.trim()
        : municipalityPhone.trim()
    );
    municipality.setAdminPassword(adminPassword);
    municipality.setProvince("Madhesh Province");
    municipality.setDistrict("Itahari");
    municipality.setStatus("active");

    // Register municipality
    if (adminDAO.registerMunicipality(municipality)) {
      request.setAttribute(
        "success",
        "Municipality registered successfully! Admin account created."
      );
      forwardMunicipalitiesPage(request, response);
    } else {
      request.setAttribute(
        "error",
        "Failed to register municipality. Please try again."
      );
      request.setAttribute("municipalityName", municipalityName);
      request.setAttribute("municipalityCode", municipalityCode);
      request.setAttribute("municipalityPhone", municipalityPhone);
      request.setAttribute("officeAddress", officeAddress);
      request.setAttribute("adminFirstName", adminFirstName);
      request.setAttribute("adminLastName", adminLastName);
      request.setAttribute("adminEmail", adminEmail);
      request.setAttribute("adminPhone", adminPhone);
      forwardMunicipalitiesPage(request, response);
    }
  }

  private void forwardMunicipalitiesPage(
    HttpServletRequest request,
    HttpServletResponse response
  ) throws ServletException, IOException {
    request.setAttribute("municipalities", adminDAO.getAllMunicipalities());
    request.setAttribute("activePage", "municipalities");
    request
      .getRequestDispatcher("/WEB-INF/views/admin/municipalities.jsp")
      .forward(request, response);
  }
}
