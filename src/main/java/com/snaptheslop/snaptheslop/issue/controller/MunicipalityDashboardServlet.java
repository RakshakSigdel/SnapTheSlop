package com.snaptheslop.snaptheslop.issue.controller;

import com.snaptheslop.snaptheslop.issue.model.Issue;
import com.snaptheslop.snaptheslop.issue.model.dao.IssueDAO;
import com.snaptheslop.snaptheslop.municipality.model.dao.MunicipalityDAO;
import com.snaptheslop.snaptheslop.user.model.UserDTO;
import com.snaptheslop.snaptheslop.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Collections;
import java.util.List;

@WebServlet(name = "municipalityDashboardServlet", value = "/municipality/dashboard")
public class MunicipalityDashboardServlet extends HttpServlet {

    private final IssueDAO issueDAO = new IssueDAO();
    private final MunicipalityDAO municipalityDAO = new MunicipalityDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDTO municipalityUser = SessionUtil.getLoggedInUser(request);
        if (municipalityUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int municipalityId = resolveMunicipalityId(municipalityUser, request.getSession(false));

        List<Issue> recentIssues = Collections.emptyList();
        int totalReports = 0;
        int openReports = 0;
        int inProgressReports = 0;
        int resolvedReports = 0;

        if (municipalityId > 0) {
            recentIssues = issueDAO.findByMunicipalityId(municipalityId, null, null, null, 1, 6);
            totalReports = issueDAO.countByMunicipalityId(municipalityId, null);
            openReports = issueDAO.countByMunicipalityId(municipalityId, "Open");
            inProgressReports = issueDAO.countByMunicipalityId(municipalityId, "In Progress");
            resolvedReports = issueDAO.countByMunicipalityId(municipalityId, "Resolved");
        }

        request.setAttribute("recentIssues", recentIssues);
        request.setAttribute("totalReports", totalReports);
        request.setAttribute("openReports", openReports);
        request.setAttribute("inProgressReports", inProgressReports);
        request.setAttribute("resolvedReports", resolvedReports);
        request.setAttribute("activePage", "dashboard");
        request.getRequestDispatcher("/WEB-INF/views/municipality/dashboard.jsp")
               .forward(request, response);
    }

    private int resolveMunicipalityId(UserDTO user, HttpSession session) {
        if (user == null) {
            return -1;
        }

        if (user.getMunicipalityId() > 0) {
            return user.getMunicipalityId();
        }

        if (session != null) {
            Object sessionMunicipalityId = session.getAttribute("municipalityId");
            if (sessionMunicipalityId instanceof Integer && (Integer) sessionMunicipalityId > 0) {
                return (Integer) sessionMunicipalityId;
            }
        }

        if (user.getMunicipality() == null || user.getMunicipality().isBlank()) {
            return -1;
        }

        try {
            Integer municipalityId = municipalityDAO.findMunicipalityIdByName(user.getMunicipality());
            return municipalityId != null ? municipalityId : -1;
        } catch (SQLException | ClassNotFoundException e) {
            return -1;
        }
    }
}
