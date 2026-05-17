package com.snaptheslop.snaptheslop.municipality.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLIntegrityConstraintViolationException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;

import com.snaptheslop.snaptheslop.municipality.model.dao.MunicipalityDAO;
import com.snaptheslop.snaptheslop.municipality.model.dao.WardDAO;
import com.snaptheslop.snaptheslop.municipality.model.Ward;
import com.snaptheslop.snaptheslop.user.model.UserDTO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Ward Management Servlet Handles CRUD operations for wards in municipality
 * context
 *
 * @author Sprint 4 Team
 * @version 1.0
 */
@WebServlet(name = "wardManagementServlet", urlPatterns = { "/municipality/ward-management", "/municipality/wards" })
public class WardManagementServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(WardManagementServlet.class.getName());
    private final WardDAO wardDAO = new WardDAO();
    private final MunicipalityDAO municipalityDAO = new MunicipalityDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String servletPath = request.getServletPath();

        // AJAX request to get wards as JSON
        if ("/municipality/wards".equals(servletPath) || "getWards".equals(action)) {
            handleGetWardsAPI(request, response);
            return;
        }

        // Page request - display ward management page
        try {
            handleDisplayPage(request, response);
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error displaying ward management page: " + e.getMessage(), e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Error loading ward management: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            HttpSession session = request.getSession(false);
            UserDTO user = (UserDTO) (session != null ? session.getAttribute("loggedInUser") : null);

            if (!isMunicipalHead(user)) {
                response.setStatus(HttpServletResponse.SC_FORBIDDEN);
                out.print("{\"success\":false,\"message\":\"Unauthorized access\"}");
                return;
            }

            int municipalityId = resolveMunicipalityIdFromUser(user);
            if (municipalityId <= 0) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"success\":false,\"message\":\"Unable to resolve your municipality\"}");
                return;
            }

            String wardIdStr = request.getParameter("wardId");
            String wardNumberStr = request.getParameter("wardNumber");
            String wardHead = request.getParameter("wardHead");
            String contactNumber = request.getParameter("contactNumber");
            String status = request.getParameter("status");

            // Validate inputs
            if (wardNumberStr == null || wardNumberStr.trim().isEmpty()
                    || wardHead == null || wardHead.trim().isEmpty()
                    || contactNumber == null || contactNumber.trim().isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"success\":false,\"message\":\"All fields are required\"}");
                return;
            }

            try {
                int wardNumber = Integer.parseInt(wardNumberStr);

                Ward ward = new Ward();
                ward.setWardNumber(wardNumber);
                ward.setWardHead(wardHead.trim());
                ward.setContactNumber(contactNumber.trim());
                ward.setStatus(status != null && !status.trim().isEmpty() ? status : "active");
                ward.setMunicipalityId(municipalityId);

                boolean success;
                String message;

                // Create or Update
                if (wardIdStr != null && !wardIdStr.trim().isEmpty()) {
                    // Update existing ward
                    int wardId = Integer.parseInt(wardIdStr);
                    Ward existingWard = wardDAO.findById(wardId);
                    if (existingWard == null || existingWard.getMunicipalityId() != municipalityId) {
                        response.setStatus(HttpServletResponse.SC_FORBIDDEN);
                        out.print("{\"success\":false,\"message\":\"You can only update wards from your municipality\"}");
                        return;
                    }

                    ward.setId(wardId);

                    success = wardDAO.updateWard(ward);
                    message = success ? "Ward updated successfully" : "Failed to update ward";
                } else {
                    // Check for duplicate
                    if (wardDAO.existsWard(municipalityId, wardNumber)) {
                        response.setStatus(HttpServletResponse.SC_CONFLICT);
                        out.print("{\"success\":false,\"message\":\"Ward number already exists in this municipality\"}");
                        return;
                    }

                    // Create new ward
                    success = wardDAO.createWard(ward);
                    message = success ? "Ward created successfully" : "Failed to create ward";
                }

                response.setStatus(success ? HttpServletResponse.SC_OK : HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                out.print("{\"success\":" + success + ",\"message\":\"" + message + "\"}");

            } catch (NumberFormatException e) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"success\":false,\"message\":\"Invalid input format\"}");
            } catch (SQLIntegrityConstraintViolationException e) {
                response.setStatus(HttpServletResponse.SC_CONFLICT);
                out.print("{\"success\":false,\"message\":\"Ward number already exists in this municipality\"}");
            }

        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error processing ward save: " + e.getMessage(), e);
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"success\":false,\"message\":\"Unable to save ward right now\"}");
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            HttpSession session = request.getSession(false);
            UserDTO user = (UserDTO) (session != null ? session.getAttribute("loggedInUser") : null);

            if (!isMunicipalHead(user)) {
                response.setStatus(HttpServletResponse.SC_FORBIDDEN);
                out.print("{\"success\":false,\"message\":\"Unauthorized access\"}");
                return;
            }

            int municipalityId = resolveMunicipalityIdFromUser(user);
            if (municipalityId <= 0) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"success\":false,\"message\":\"Unable to resolve your municipality\"}");
                return;
            }

            String wardIdStr = request.getParameter("wardId");
            if (wardIdStr == null || wardIdStr.trim().isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"success\":false,\"message\":\"Ward ID is required\"}");
                return;
            }

            try {
                int wardId = Integer.parseInt(wardIdStr);
                Ward ward = wardDAO.findById(wardId);

                if (ward == null) {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    out.print("{\"success\":false,\"message\":\"Ward not found\"}");
                    return;
                }

                if (ward.getMunicipalityId() != municipalityId) {
                    response.setStatus(HttpServletResponse.SC_FORBIDDEN);
                    out.print("{\"success\":false,\"message\":\"You can only delete wards from your municipality\"}");
                    return;
                }

                boolean success = wardDAO.deleteWard(wardId);

                if (success) {
                    LOGGER.log(Level.INFO, "Ward deleted successfully: " + wardId);
                    response.setStatus(HttpServletResponse.SC_OK);
                    out.print("{\"success\":true,\"message\":\"Ward deleted successfully\"}");
                } else {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    out.print("{\"success\":false,\"message\":\"Ward not found\"}");
                }

            } catch (NumberFormatException e) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"success\":false,\"message\":\"Invalid ward ID format\"}");
            }

        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error processing ward delete: " + e.getMessage(), e);
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"success\":false,\"message\":\"Unable to delete ward right now\"}");
        }
    }

    /**
     * Display ward management page with wards loaded from database
     */
    private void handleDisplayPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, ClassNotFoundException {

        HttpSession session = request.getSession(false);
        UserDTO user = (UserDTO) (session != null ? session.getAttribute("loggedInUser") : null);

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int municipalityId = resolveMunicipalityIdFromUser(user);

        if (municipalityId <= 0) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST,
                    "Municipality is not configured for this account.");
            return;
        }

        request.setAttribute("activePage", "ward-management");
        request.setAttribute("municipalityId", municipalityId);
        request.getRequestDispatcher("/WEB-INF/views/municipality/wardManagement.jsp")
                .forward(request, response);
    }

    /**
     * Return wards as JSON for AJAX requests
     */
    private void handleGetWardsAPI(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            HttpSession session = request.getSession(false);
            UserDTO user = (UserDTO) (session != null ? session.getAttribute("loggedInUser") : null);

            if (user == null) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                out.print("{\"success\":false,\"message\":\"Unauthorized\"}");
                return;
            }

            int municipalityId;
            if (isAdmin(user)) {
                municipalityId = resolveMunicipalityIdFromRequestOrUser(request, user);
            } else if (isCitizen(user)) {
                municipalityId = resolveMunicipalityIdFromUser(user);

                // Some existing citizen accounts may not have municipality mapped in session/profile.
                // In that case, allow request-based resolution to keep ward dropdown usable.
                if (municipalityId <= 0) {
                    municipalityId = resolveMunicipalityIdFromRequestOrUser(request, user);
                } else {
                    String requestedMunicipalityName = request.getParameter("municipalityName");
                    if (requestedMunicipalityName != null
                            && !requestedMunicipalityName.trim().isEmpty()
                            && user.getMunicipality() != null
                            && !requestedMunicipalityName.trim().equalsIgnoreCase(user.getMunicipality().trim())) {
                        response.setStatus(HttpServletResponse.SC_FORBIDDEN);
                        out.print("{\"success\":false,\"message\":\"You can only access wards from your municipality\"}");
                        return;
                    }

                    String requestedMunicipalityId = request.getParameter("municipalityId");
                    if (requestedMunicipalityId != null && !requestedMunicipalityId.trim().isEmpty()) {
                        try {
                            int requestedId = Integer.parseInt(requestedMunicipalityId);
                            if (requestedId != municipalityId) {
                                response.setStatus(HttpServletResponse.SC_FORBIDDEN);
                                out.print("{\"success\":false,\"message\":\"You can only access wards from your municipality\"}");
                                return;
                            }
                        } catch (NumberFormatException e) {
                            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                            out.print("{\"success\":false,\"message\":\"Invalid municipality ID\"}");
                            return;
                        }
                    }
                }
            } else {
                municipalityId = resolveMunicipalityIdFromUser(user);
            }

            if (municipalityId <= 0) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"success\":false,\"message\":\"Municipality ID required\"}");
                return;
            }

            List<Ward> wards = wardDAO.getWardsByMunicipalityId(municipalityId);

            if (isCitizen(user)) {
                wards = wards.stream()
                        .filter(ward -> "active".equalsIgnoreCase(ward.getStatus()))
                        .collect(Collectors.toList());
            }

            StringBuilder json = new StringBuilder("[");
            for (int i = 0; i < wards.size(); i++) {
                Ward ward = wards.get(i);
                if (i > 0) {
                    json.append(",");
                }
                json.append("{")
                        .append("\"id\":").append(ward.getId()).append(",")
                        .append("\"wardNumber\":").append(ward.getWardNumber()).append(",")
                        .append("\"wardHead\":\"").append(escapeJson(ward.getWardHead())).append("\",")
                        .append("\"contactNumber\":\"").append(escapeJson(ward.getContactNumber())).append("\",")
                        .append("\"status\":\"").append(escapeJson(ward.getStatus())).append("\"")
                        .append("}");
            }
            json.append("]");

            response.setStatus(HttpServletResponse.SC_OK);
            out.print(json.toString());

        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"success\":false,\"message\":\"Invalid municipality ID\"}");
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error fetching wards: " + e.getMessage(), e);
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"success\":false,\"message\":\"Database error\"}");
        }
    }

    /**
     * Escape special characters for JSON
     */
    private String escapeJson(String value) {
        if (value == null) {
            return "";
        }
        return value.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }

    private int resolveMunicipalityIdFromRequestOrUser(HttpServletRequest request, UserDTO user)
            throws SQLException, ClassNotFoundException {
        String municipalityIdStr = request.getParameter("municipalityId");
        if (municipalityIdStr != null && !municipalityIdStr.trim().isEmpty()) {
            try {
                return Integer.parseInt(municipalityIdStr);
            } catch (NumberFormatException ignored) {
                return -1;
            }
        }

        String municipalityName = request.getParameter("municipalityName");
        if (municipalityName != null && !municipalityName.trim().isEmpty()) {
            Integer municipalityId = municipalityDAO.findMunicipalityIdByName(municipalityName);
            return municipalityId != null ? municipalityId : -1;
        }

        return resolveMunicipalityIdFromUser(user);
    }

    private int resolveMunicipalityIdFromUser(UserDTO user) throws SQLException, ClassNotFoundException {
        if (user == null || user.getMunicipality() == null || user.getMunicipality().trim().isEmpty()) {
            return -1;
        }

        Integer municipalityId = municipalityDAO.findMunicipalityIdByName(user.getMunicipality());
        return municipalityId != null ? municipalityId : -1;
    }

    private boolean isMunicipalHead(UserDTO user) {
        return user != null && user.getRole() != null
                && "MUNICIPAL HEAD".equalsIgnoreCase(user.getRole().trim().replace('_', ' '));
    }

    private boolean isCitizen(UserDTO user) {
        if (user == null || user.getRole() == null) {
            return false;
        }
        String role = user.getRole().trim().toUpperCase();
        return "REGISTERED CITIZEN".equals(role) || "CITIZEN".equals(role);
    }

    private boolean isAdmin(UserDTO user) {
        if (user == null || user.getRole() == null) {
            return false;
        }
        String role = user.getRole().trim().toUpperCase();
        return "SUPER ADMIN".equals(role) || "ADMIN".equals(role);
    }
}
