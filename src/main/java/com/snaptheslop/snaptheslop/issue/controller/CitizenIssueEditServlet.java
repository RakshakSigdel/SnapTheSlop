package com.snaptheslop.snaptheslop.issue.controller;

import com.snaptheslop.snaptheslop.config.DBConnection;
import com.snaptheslop.snaptheslop.issue.model.Issue;
import com.snaptheslop.snaptheslop.issue.model.dao.IssueDAO;
import com.snaptheslop.snaptheslop.municipality.model.dao.WardDAO;
import com.snaptheslop.snaptheslop.user.model.User;
import com.snaptheslop.snaptheslop.util.ImageUploadUtil;
import com.snaptheslop.snaptheslop.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "citizenIssueEditServlet", value = "/citizen/issue-edit")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 5 * 1024 * 1024L,
        maxRequestSize = 10 * 1024 * 1024L
)
public class CitizenIssueEditServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(CitizenIssueEditServlet.class.getName());

    private final IssueDAO issueDAO = new IssueDAO();
    private final WardDAO wardDAO = new WardDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User citizen = SessionUtil.getLoggedInUser(request);
        if (citizen == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int userDbId = resolveLoggedInUserDbId(request, citizen);
        String issueIdParam = request.getParameter("id");
        if (issueIdParam == null || issueIdParam.isBlank()) {
            flashError(request, "Please select a report to edit.");
            response.sendRedirect(request.getContextPath() + "/citizen/my-issues");
            return;
        }

        Issue issue = resolveOwnedIssue(issueIdParam, userDbId);
        if (issue == null) {
            flashError(request, "You can only edit your own report.");
            response.sendRedirect(request.getContextPath() + "/citizen/my-issues");
            return;
        }

        request.setAttribute("editMode", true);
        request.setAttribute("issue", issue);
        request.setAttribute("issueId", issue.getId());
        request.setAttribute("reportMunicipalityId", issue.getMunicipalityId());
        request.setAttribute("reportMunicipalityName", issue.getMunicipalityName());
        request.setAttribute("prevTitle", issue.getTitle());
        request.setAttribute("prevCategory", issue.getCategory());
        request.setAttribute("prevLocation", issue.getLocation());
        request.setAttribute("prevDescription", issue.getDescription());
        request.setAttribute("selectedWardNo", issue.getWardNo());
        request.setAttribute("existingImagePath", issue.getImagePath());
        request.setAttribute("activePage", "report-issue");
        request.getRequestDispatcher("/WEB-INF/views/citizen/report-issue.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User citizen = SessionUtil.getLoggedInUser(request);
        if (citizen == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int userDbId = resolveLoggedInUserDbId(request, citizen);
        String issueIdParam = trim(request.getParameter("issueId"));
        if (issueIdParam == null) {
            flashError(request, "Missing report identifier.");
            response.sendRedirect(request.getContextPath() + "/citizen/my-issues");
            return;
        }

        Issue existing = resolveOwnedIssue(issueIdParam, userDbId);
        if (existing == null) {
            flashError(request, "You can only edit your own report.");
            response.sendRedirect(request.getContextPath() + "/citizen/my-issues");
            return;
        }

        String title = trim(request.getParameter("title"));
        String category = trim(request.getParameter("category"));
        String wardParam = trim(request.getParameter("ward"));
        String location = trim(request.getParameter("location"));
        String description = trim(request.getParameter("description"));

        String validationError = validate(title, category, wardParam, location, description);
        if (validationError != null) {
            reloadForm(request, response, existing, validationError);
            return;
        }

        int wardNo;
        try {
            wardNo = Integer.parseInt(wardParam);
        } catch (NumberFormatException e) {
            reloadForm(request, response, existing, "Invalid ward selected.");
            return;
        }

        try {
            if (!wardDAO.existsWard(existing.getMunicipalityId(), wardNo)) {
                reloadForm(request, response, existing, "Selected ward does not belong to your municipality.");
                return;
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unable to validate ward for issue edit", e);
            reloadForm(request, response, existing, "Unable to validate the selected ward right now.");
            return;
        }

        String imagePath = existing.getImagePath();
        String oldImagePath = existing.getImagePath();
        try {
            Part imagePart = request.getPart("image");
            if (ImageUploadUtil.hasFile(imagePart)) {
                String uploadRoot = getServletContext().getRealPath("/" + ImageUploadUtil.UPLOAD_DIR);
                String newPath = ImageUploadUtil.saveImage(imagePart, uploadRoot);
                if (newPath != null) {
                    imagePath = newPath;
                }
            }
        } catch (IllegalArgumentException e) {
            reloadForm(request, response, existing, e.getMessage());
            return;
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Image upload failed while editing issue", e);
            reloadForm(request, response, existing, "Image upload failed. Please try again.");
            return;
        }

        existing.setTitle(title);
        existing.setCategory(category);
        existing.setWardNo(wardNo);
        existing.setLocation(location);
        existing.setDescription(description);
        existing.setImagePath(imagePath);

        boolean updated = issueDAO.updateIssueByOwner(existing, userDbId);
        if (!updated) {
            reloadForm(request, response, existing, "Failed to update your report. Please try again.");
            return;
        }

        if (imagePath != null && !imagePath.equals(oldImagePath)) {
            deleteExistingImage(oldImagePath);
        }

        request.getSession().setAttribute("successMessage", "Your report was updated successfully.");
        response.sendRedirect(request.getContextPath() + "/citizen/issue-detail?id=" + existing.getId());
    }

    private Issue resolveOwnedIssue(String idParam, int userDbId) {
        try {
            int numericId = Integer.parseInt(idParam);
            return issueDAO.findByIdAndUserId(numericId, userDbId);
        } catch (NumberFormatException e) {
            return null;
        }
    }

    private int resolveLoggedInUserDbId(HttpServletRequest request, User citizen) {
        int userDbId = SessionUtil.getLoggedInUserDbId(request);
        if (userDbId > 0) {
            return userDbId;
        }
        if (citizen == null || citizen.getUserId() == null) {
            return -1;
        }

        String sql = "SELECT id FROM users WHERE userId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, citizen.getUserId());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    userDbId = rs.getInt(1);
                    SessionUtil.setLoggedInUserDbId(request, userDbId);
                    return userDbId;
                }
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error resolving logged in user db id", e);
        }
        return -1;
    }

    private void reloadForm(HttpServletRequest request, HttpServletResponse response, Issue issue, String error)
            throws ServletException, IOException {
        request.setAttribute("editMode", true);
        request.setAttribute("issue", issue);
        request.setAttribute("issueId", issue.getId());
        request.setAttribute("reportMunicipalityId", issue.getMunicipalityId());
        request.setAttribute("reportMunicipalityName", issue.getMunicipalityName());
        request.setAttribute("prevTitle", request.getParameter("title"));
        request.setAttribute("prevCategory", request.getParameter("category"));
        request.setAttribute("prevLocation", request.getParameter("location"));
        request.setAttribute("prevDescription", request.getParameter("description"));
        request.setAttribute("selectedWardNo", request.getParameter("ward"));
        request.setAttribute("existingImagePath", issue.getImagePath());
        request.setAttribute("errorMessage", error);
        request.setAttribute("activePage", "report-issue");
        request.getRequestDispatcher("/WEB-INF/views/citizen/report-issue.jsp").forward(request, response);
    }

    private void deleteExistingImage(String imagePath) {
        if (imagePath == null || imagePath.isBlank()) {
            return;
        }
        try {
            String realPath = getServletContext().getRealPath(imagePath);
            if (realPath != null) {
                File file = new File(realPath);
                if (file.exists() && !file.delete()) {
                    LOGGER.log(Level.WARNING, "Failed to delete old issue image: {0}", realPath);
                }
            }
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Unable to delete replaced issue image", e);
        }
    }

    private void flashError(HttpServletRequest request, String message) {
        request.getSession().setAttribute("errorMessage", message);
    }

    private String validate(String title, String category, String ward, String location, String description) {
        if (blank(title)) return "Title is required.";
        if (title.length() > 200) return "Title must be 200 characters or fewer.";
        if (blank(category)) return "Category is required.";
        if (blank(ward)) return "Ward is required.";
        if (blank(location)) return "Location is required.";
        if (blank(description)) return "Description is required.";
        return null;
    }

    private String trim(String value) {
        return value == null ? null : value.trim();
    }

    private boolean blank(String value) {
        return value == null || value.isBlank();
    }
}

