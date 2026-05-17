package com.snaptheslop.snaptheslop.admin.controller;

import com.snaptheslop.snaptheslop.municipality.model.Municipality;
import com.snaptheslop.snaptheslop.admin.model.dao.AdminDAO;
import com.snaptheslop.snaptheslop.security.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "adminManageMunicipalityServlet", value = "/admin/manage-municipality")
public class AdminManageMunicipalityServlet extends HttpServlet {
    private final AdminDAO adminDAO = new AdminDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Integer municipalityId = parseMunicipalityId(request.getParameter("id"));

        if (municipalityId == null || municipalityId <= 0) {
            request.setAttribute("error", "Invalid municipality ID.");
            forwardPage(request, response, null);
            return;
        }

        Municipality municipality = adminDAO.getMunicipalityById(municipalityId);
        if (municipality == null) {
            request.setAttribute("error", "Municipality not found in database.");
        }

        forwardPage(request, response, municipality);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        Integer municipalityId = parseMunicipalityId(request.getParameter("municipalityId"));

        if (municipalityId == null || municipalityId <= 0) {
            request.setAttribute("error", "Invalid municipality ID.");
            forwardPage(request, response, null);
            return;
        }

        Municipality currentMunicipality = adminDAO.getMunicipalityById(municipalityId);
        if (currentMunicipality == null) {
            request.setAttribute("error", "Municipality not found in database.");
            forwardPage(request, response, null);
            return;
        }

        if ("save".equals(action)) {
            handleSaveAction(request, currentMunicipality);
        } else if ("reset-password".equals(action)) {
            handleResetPasswordAction(request, municipalityId);
        } else if ("disable".equals(action)) {
            handleDisableAction(request, municipalityId);
        } else {
            request.setAttribute("error", "Unsupported action.");
        }

        Municipality updatedMunicipality = adminDAO.getMunicipalityById(municipalityId);
        forwardPage(request, response, updatedMunicipality);
    }

    private void handleSaveAction(HttpServletRequest request, Municipality currentMunicipality) {
        String municipalityName = request.getParameter("municipalityName");
        String district = request.getParameter("district");
        String province = request.getParameter("province");
        String municipalityPhone = request.getParameter("municipalityPhone");
        String officeAddress = request.getParameter("officeAddress");
        String adminFirstName = request.getParameter("adminFirstName");
        String adminLastName = request.getParameter("adminLastName");
        String adminEmail = request.getParameter("adminEmail");
        String adminPhone = request.getParameter("adminPhone");
        String adminStatus = request.getParameter("adminStatus");

        StringBuilder errors = new StringBuilder();
        if (municipalityName == null || municipalityName.trim().isEmpty()) {
            errors.append("Municipality name is required. ");
        }
        if (municipalityPhone == null || municipalityPhone.trim().isEmpty()) {
            errors.append("Municipality phone is required. ");
        }
        if (officeAddress == null || officeAddress.trim().isEmpty()) {
            errors.append("Office address is required. ");
        }

        if (errors.length() > 0) {
            request.setAttribute("error", errors.toString().trim());
            return;
        }

        Municipality updateRequest = new Municipality();
        updateRequest.setId(currentMunicipality.getId());
        updateRequest.setOldName(currentMunicipality.getName());
        updateRequest.setName(municipalityName.trim());
        updateRequest.setDistrict(district != null ? district.trim() : "");
        updateRequest.setProvince(province != null ? province.trim() : "");
        updateRequest.setContactNumber(municipalityPhone.trim());
        updateRequest.setOfficeAddress(officeAddress.trim());
        updateRequest.setAdminFirstName(adminFirstName != null ? adminFirstName.trim() : "");
        updateRequest.setAdminLastName(adminLastName != null ? adminLastName.trim() : "");
        updateRequest.setAdminEmail(adminEmail != null ? adminEmail.trim() : "");
        updateRequest.setAdminPhone(
                adminPhone != null && !adminPhone.trim().isEmpty() ? adminPhone.trim() : municipalityPhone.trim());
        updateRequest.setStatus(
                adminStatus != null && !adminStatus.trim().isEmpty() ? adminStatus.trim() : "Active");

        boolean updated = adminDAO.updateMunicipalityAndAdmin(updateRequest);
        if (updated) {
            request.setAttribute("success", "Municipality details updated successfully.");
        } else {
            request.setAttribute("error", "Failed to update municipality details.");
        }
    }

    private void handleResetPasswordAction(HttpServletRequest request, int municipalityId) {
        String newPassword = request.getParameter("newPassword");
        if (newPassword == null || newPassword.trim().length() < 8) {
            request.setAttribute("error", "New password must be at least 8 characters.");
            return;
        }

        String hashedPassword = PasswordUtil.hashPassword(newPassword.trim());
        boolean reset = adminDAO.resetMunicipalityAdminPassword(municipalityId, hashedPassword);
        if (reset) {
            request.setAttribute("success", "Municipality admin password reset successfully.");
        } else {
            request.setAttribute("error", "No municipality admin found to reset password.");
        }
    }

    private void handleDisableAction(HttpServletRequest request, int municipalityId) {
        boolean disabled = adminDAO.disableMunicipalityAdmin(municipalityId);
        if (disabled) {
            request.setAttribute("success", "Municipality admin account disabled.");
        } else {
            request.setAttribute("error", "No municipality admin found to disable.");
        }
    }

    private Integer parseMunicipalityId(String municipalityIdParam) {
        if (municipalityIdParam == null || municipalityIdParam.trim().isEmpty()) {
            return null;
        }

        try {
            return Integer.parseInt(municipalityIdParam.trim());
        } catch (NumberFormatException e) {
            return null;
        }
    }

    private void forwardPage(HttpServletRequest request, HttpServletResponse response, Municipality municipality)
            throws ServletException, IOException {
        request.setAttribute("activePage", "municipalities");
        request.setAttribute("municipality", municipality);
        request.getRequestDispatcher("/WEB-INF/views/admin/manageMunicipalities.jsp").forward(request, response);
    }
}
