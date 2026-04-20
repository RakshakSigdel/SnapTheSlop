package com.snaptheslop.snaptheslop.issue.controller;

import com.snaptheslop.snaptheslop.municipality.MunicipalityDAO;
import com.snaptheslop.snaptheslop.municipality.model.Municipality;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Collections;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "citizenReportIssueServlet", value = "/citizen/report-issue")
public class CitizenReportIssueServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(CitizenReportIssueServlet.class.getName());
    private final MunicipalityDAO municipalityDAO = new MunicipalityDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("municipalities".equalsIgnoreCase(action)) {
            handleMunicipalitiesApi(response);
            return;
        }

        request.setAttribute("activePage", "report-issue");

        try {
            List<Municipality> municipalities = municipalityDAO.getAllMunicipalities();
            request.setAttribute("municipalities", municipalities);
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Unable to load municipalities for report issue page", e);
            request.setAttribute("municipalities", Collections.emptyList());
            request.setAttribute("errorMessage", "Unable to load municipalities right now. Please try again.");
        }

        request.getRequestDispatcher("/WEB-INF/views/citizen/report-issue.jsp")
               .forward(request, response);
    }

    private void handleMunicipalitiesApi(HttpServletResponse response) throws IOException {
        response.setContentType("application/json;charset=UTF-8");

        try {
            List<Municipality> municipalities = municipalityDAO.getAllMunicipalities();

            StringBuilder json = new StringBuilder("[");
            for (int i = 0; i < municipalities.size(); i++) {
                Municipality municipality = municipalities.get(i);
                if (i > 0) {
                    json.append(",");
                }
                json.append("{\"id\":")
                        .append(municipality.getId())
                        .append(",\"name\":\"")
                        .append(escapeJson(municipality.getName()))
                        .append("\"}");
            }
            json.append("]");

            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().print(json);
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Unable to load municipalities API data", e);
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().print("{\"success\":false,\"message\":\"Unable to load municipalities\"}");
        }
    }

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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO: backend team — handle form submission here, then redirect
        response.sendRedirect(request.getContextPath() + "/citizen/my-issues");
    }
}
