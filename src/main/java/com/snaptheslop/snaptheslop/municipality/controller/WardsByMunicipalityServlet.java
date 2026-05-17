package com.snaptheslop.snaptheslop.municipality.controller;

import com.snaptheslop.snaptheslop.municipality.model.dao.WardDAO;
import com.snaptheslop.snaptheslop.municipality.model.Ward;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "wardsByMunicipalityServlet", urlPatterns = "/api/wards")
public class WardsByMunicipalityServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(WardsByMunicipalityServlet.class.getName());
    private final WardDAO wardDAO = new WardDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String midParam = request.getParameter("municipalityId");
        if (midParam == null || midParam.isBlank()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("[]");
            return;
        }

        int municipalityId;
        try {
            municipalityId = Integer.parseInt(midParam);
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("[]");
            return;
        }

        try {
            List<Ward> wards = wardDAO.getWardsByMunicipalityId(municipalityId);
            StringBuilder json = new StringBuilder("[");
            for (int i = 0; i < wards.size(); i++) {
                Ward w = wards.get(i);
                if (i > 0) json.append(',');
                json.append('{')
                        .append("\"id\":").append(w.getId()).append(',')
                        .append("\"wardNumber\":").append(w.getWardNumber())
                        .append('}');
            }
            json.append(']');
            response.setStatus(HttpServletResponse.SC_OK);
            out.print(json.toString());
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error loading wards for municipalityId=" + municipalityId, e);
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("[]");
        }
    }
}

