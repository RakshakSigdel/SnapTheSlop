package com.snaptheslop.snaptheslop.issue.controller;

import com.snaptheslop.snaptheslop.config.DBConnection;
import com.snaptheslop.snaptheslop.issue.model.Issue;
import com.snaptheslop.snaptheslop.issue.model.dao.IssueDAO;
import com.snaptheslop.snaptheslop.municipality.MunicipalityDAO;
import com.snaptheslop.snaptheslop.municipality.model.Municipality;
import com.snaptheslop.snaptheslop.user.model.UserDTO;
import com.snaptheslop.snaptheslop.user.model.dao.UserDAO;
import com.snaptheslop.snaptheslop.util.ImageUploadUtil;
import com.snaptheslop.snaptheslop.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collections;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Sprint 5 Task 1 — Report issue backend.
 *   a. Create issue with title, description, category, ward, priority, optional image.
 *   b. Validate file type/size and store image path safely.
 */
@WebServlet(name = "citizenReportIssueServlet", value = "/citizen/report-issue")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize       = 5 * 1024 * 1024L,
        maxRequestSize    = 10 * 1024 * 1024L
)
public class CitizenReportIssueServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(CitizenReportIssueServlet.class.getName());
    private final MunicipalityDAO municipalityDAO = new MunicipalityDAO();
    private final IssueDAO issueDAO = new IssueDAO();
    private final UserDAO userDAO = new UserDAO();

    // ── GET ────────────────────────────────────────────────────────────────

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserDTO citizen = SessionUtil.getLoggedInUser(request);
        if (citizen == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        UserDTO latestUser = userDAO.findUserById(citizen.getUserId());
        if (latestUser != null) {
            citizen = latestUser;
            request.getSession().setAttribute("loggedInUser", citizen);
            request.getSession().setAttribute("municipalityId", citizen.getMunicipalityId());
        }

        String action = request.getParameter("action");
        if ("municipalities".equalsIgnoreCase(action)) {
            handleMunicipalitiesApi(response);
            return;
        }

        request.setAttribute("activePage", "report-issue");
        int municipalityId = resolveMunicipalityIdFromUser(citizen);
        String municipalityName = citizen.getMunicipality();
        if (municipalityId <= 0 || blank(municipalityName)) {
            request.setAttribute("errorMessage",
                    "Your municipality is not configured in profile. Please update your profile first.");
        }
        request.setAttribute("reportMunicipalityId", municipalityId);
        request.setAttribute("reportMunicipalityName", municipalityName);
        request.getRequestDispatcher("/WEB-INF/views/citizen/report-issue.jsp").forward(request, response);
    }

    // ── POST ───────────────────────────────────────────────────────────────

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Auth check
        UserDTO citizen = SessionUtil.getLoggedInUser(request);
        if (citizen == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 2. Read fields
        String title       = trimParam(request, "title");
        String category    = trimParam(request, "category");
        String wardParam   = trimParam(request, "ward");
        String location    = trimParam(request, "location");
        String description = trimParam(request, "description");
        String priority    = trimParam(request, "priority");
        if (priority == null || priority.isBlank()) priority = "Medium";

        // 3. Validate
        String err = validate(title, category, wardParam, location, description);
        if (err != null) { reloadForm(request, response, err); return; }

        // 4. Resolve municipality from the logged-in user's profile
        UserDTO latestUser = userDAO.findUserById(citizen.getUserId());
        if (latestUser != null) {
            citizen = latestUser;
            request.getSession().setAttribute("loggedInUser", citizen);
            request.getSession().setAttribute("municipalityId", citizen.getMunicipalityId());
        }

        int municipalityId = resolveMunicipalityIdFromUser(citizen);
        if (municipalityId <= 0) {
            reloadForm(request, response, "Your municipality is not configured. Please update it in your profile first.");
            return;
        }

        // 5. Ward number
        int wardNo;
        try { wardNo = Integer.parseInt(wardParam); }
        catch (NumberFormatException e) { reloadForm(request, response, "Invalid ward selected."); return; }

        // 6. Optional image upload
        String imagePath = null;
        try {
            Part imagePart = request.getPart("image");
            if (ImageUploadUtil.hasFile(imagePart)) {
                String uploadRoot = getServletContext().getRealPath("/" + ImageUploadUtil.UPLOAD_DIR);
                imagePath = ImageUploadUtil.saveImage(imagePart, uploadRoot);
            }
        } catch (IllegalArgumentException e) {
            reloadForm(request, response, e.getMessage()); return;
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Image upload failed", e);
            reloadForm(request, response, "Image upload failed. Please try again."); return;
        }

        // 7. Resolve users.id (int FK) from the string userId in session
        int userDbId = SessionUtil.getLoggedInUserDbId(request);
        if (userDbId == -1) {
            userDbId = lookupUserDbId(citizen.getUserId());
            if (userDbId == -1) { reloadForm(request, response, "Session error. Please log in again."); return; }
            SessionUtil.setLoggedInUserDbId(request, userDbId);
        }

        // 8. Build and persist
        Issue issue = new Issue();
        issue.setIssueId("ISS-" + System.currentTimeMillis());
        issue.setTitle(title);
        issue.setDescription(description);
        issue.setCategory(category);
        issue.setPriority(priority);
        issue.setStatus("Open");
        issue.setLocation(location);
        issue.setImagePath(imagePath);
        issue.setUserId(userDbId);
        issue.setMunicipalityId(municipalityId);
        issue.setWardNo(wardNo);

        int newId = issueDAO.createIssue(issue);
        if (newId == -1) {
            reloadForm(request, response, "Failed to submit your report. Please try again."); return;
        }

        // 9. Success
        request.getSession().setAttribute("successMessage", "Your issue has been reported successfully!");
        response.sendRedirect(request.getContextPath() + "/citizen/my-issues");
    }

    // ── Helpers ────────────────────────────────────────────────────────────

    private void handleMunicipalitiesApi(HttpServletResponse response) throws IOException {
        response.setContentType("application/json;charset=UTF-8");
        try {
            List<Municipality> municipalities = municipalityDAO.getAllMunicipalities();
            StringBuilder json = new StringBuilder("[");
            for (int i = 0; i < municipalities.size(); i++) {
                Municipality m = municipalities.get(i);
                if (i > 0) json.append(",");
                json.append("{\"id\":").append(m.getId())
                    .append(",\"name\":\"").append(escapeJson(m.getName())).append("\"}");
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

    private String validate(String title, String category, String ward,
                            String location, String description) {
        if (blank(title))       return "Title is required.";
        if (title.length() > 200) return "Title must be 200 characters or fewer.";
        if (blank(category))    return "Category is required.";
        if (blank(ward))        return "Ward is required.";
        if (blank(location))    return "Location is required.";
        if (blank(description)) return "Description is required.";
        return null;
    }

    private void reloadForm(HttpServletRequest req, HttpServletResponse res, String error)
            throws ServletException, IOException {
        req.setAttribute("activePage", "report-issue");
        req.setAttribute("errorMessage", error);
        req.setAttribute("prevTitle",       req.getParameter("title"));
        req.setAttribute("prevCategory",    req.getParameter("category"));
        req.setAttribute("prevLocation",    req.getParameter("location"));
        req.setAttribute("prevDescription", req.getParameter("description"));
        UserDTO citizen = SessionUtil.getLoggedInUser(req);
        if (citizen != null) {
            UserDTO latestUser = userDAO.findUserById(citizen.getUserId());
            if (latestUser != null) {
                citizen = latestUser;
                req.getSession().setAttribute("loggedInUser", citizen);
                req.getSession().setAttribute("municipalityId", citizen.getMunicipalityId());
            }
            req.setAttribute("reportMunicipalityName", citizen.getMunicipality());
            req.setAttribute("reportMunicipalityId", resolveMunicipalityIdFromUser(citizen));
        }
        req.getRequestDispatcher("/WEB-INF/views/citizen/report-issue.jsp").forward(req, res);
    }

    private int resolveMunicipalityId(String param) {
        if (param == null) return -1;
        try { return Integer.parseInt(param); } catch (NumberFormatException ignored) {}
        try {
            Integer id = municipalityDAO.findMunicipalityIdByName(param);
            return (id != null) ? id : -1;
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error resolving municipality id", e);
            return -1;
        }
    }

    private int resolveMunicipalityIdFromUser(UserDTO user) {
        if (user == null) {
            return -1;
        }

        if (user.getMunicipalityId() > 0) {
            return user.getMunicipalityId();
        }

        String municipalityName = user.getMunicipality();
        if (municipalityName == null || municipalityName.trim().isEmpty()) {
            return -1;
        }

        return resolveMunicipalityId(municipalityName);
    }

    private int lookupUserDbId(String userId) {
        String sql = "SELECT id FROM users WHERE userId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error resolving users.id for userId: " + userId, e);
        }
        return -1;
    }

    private String escapeJson(String v) {
        if (v == null) return "";
        return v.replace("\\", "\\\\").replace("\"", "\\\"")
                .replace("\n", "\\n").replace("\r", "\\r").replace("\t", "\\t");
    }

    private String trimParam(HttpServletRequest req, String name) {
        String v = req.getParameter(name);
        return (v == null) ? null : v.trim();
    }

    private boolean blank(String s) { return s == null || s.isBlank(); }
}
