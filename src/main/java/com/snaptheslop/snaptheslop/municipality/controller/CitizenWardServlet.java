package com.snaptheslop.snaptheslop.municipality.controller;

import com.snaptheslop.snaptheslop.municipality.model.dao.MunicipalityDAO;
import com.snaptheslop.snaptheslop.municipality.model.dao.WardDAO;
import com.snaptheslop.snaptheslop.municipality.model.Ward;
import com.snaptheslop.snaptheslop.user.model.User;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "citizenWardServlet", urlPatterns = "/wards")
public class CitizenWardServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(CitizenWardServlet.class.getName());
    private final WardDAO wardDAO = new WardDAO();
    private final MunicipalityDAO municipalityDAO = new MunicipalityDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            HttpSession session = request.getSession(false);
            User user = null;
            if (session != null) {
                Object currentUser = session.getAttribute("loggedInUser");
                if (currentUser instanceof User) {
                    user = (User) currentUser;
                } else {
                    Object legacyUser = session.getAttribute("user");
                    if (legacyUser instanceof User) {
                        user = (User) legacyUser;
                    }
                }
            }

            if (user == null) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                out.print("{\"success\":false,\"message\":\"Session expired. Please login again.\"}");
                return;
            }

            if (!isCitizen(user)) {
                response.setStatus(HttpServletResponse.SC_FORBIDDEN);
                out.print("{\"success\":false,\"message\":\"Only citizens can access wards here.\"}");
                return;
            }

            if (user.getMunicipalityId() <= 0 && session != null) {
                Object sessionMunicipalityId = session.getAttribute("municipalityId");
                if (sessionMunicipalityId instanceof Integer) {
                    user.setMunicipalityId((Integer) sessionMunicipalityId);
                }
            }

            int municipalityId = resolveMunicipalityIdFromUser(user);
            if (municipalityId <= 0) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"success\":false,\"message\":\"Your municipality is not configured.\"}");
                return;
            }

            List<Ward> wards = wardDAO.getWardsByMunicipalityId(municipalityId);

            StringBuilder json = new StringBuilder("[");
            for (int i = 0; i < wards.size(); i++) {
                Ward ward = wards.get(i);
                if (i > 0) {
                    json.append(",");
                }
                json.append("{\"id\":")
                        .append(ward.getId())
                        .append(",\"wardNumber\":")
                        .append(ward.getWardNumber())
                        .append("}");
            }
            json.append("]");

            response.setStatus(HttpServletResponse.SC_OK);
            out.print(json);

        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error fetching citizen wards", e);
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"success\":false,\"message\":\"Unable to load wards right now.\"}");
        }
    }

    private int resolveMunicipalityIdFromUser(User user) throws SQLException, ClassNotFoundException {
        if (user == null) {
            return -1;
        }

        if (user.getMunicipalityId() > 0) {
            if (municipalityDAO.findById(user.getMunicipalityId()) != null) {
                return user.getMunicipalityId();
            }
        }

        if (user.getMunicipality() == null || user.getMunicipality().trim().isEmpty()) {
            return -1;
        }

        Integer municipalityId = municipalityDAO.findMunicipalityIdByName(user.getMunicipality().trim());
        if (municipalityId != null && municipalityId > 0) {
            user.setMunicipalityId(municipalityId);
            return municipalityId;
        }
        return -1;
    }

    private boolean isCitizen(User user) {
        if (user == null || user.getRole() == null) {
            return false;
        }

        String role = user.getRole().trim().toUpperCase();
        return "REGISTERED CITIZEN".equals(role) || "CITIZEN".equals(role);
    }
}

