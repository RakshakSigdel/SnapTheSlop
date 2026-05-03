package com.snaptheslop.snaptheslop.issue.controller;

import com.snaptheslop.snaptheslop.issue.model.Issue;
import com.snaptheslop.snaptheslop.issue.model.dao.IssueDAO;
import com.snaptheslop.snaptheslop.comment.model.dao.CommentDAO;
import com.snaptheslop.snaptheslop.upvote.model.dao.UpvoteDAO;
import com.snaptheslop.snaptheslop.user.model.UserDTO;
import com.snaptheslop.snaptheslop.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Sprint 5 Task 4 — Municipality issue queue and status transitions.
 *   open -> in_progress -> resolved / rejected
 * Sprint 5 Task 5 — Update timestamps and audit-friendly status changes.
 * Sprint 5 Task 7 — Replace static data with live DB-backed data.
 *
 * GET  /municipality/manage-issue?id=<issueId>  — display issue management form
 * POST /municipality/manage-issue               — save status / priority update
 */
@WebServlet(name = "municipalityManageIssueServlet", value = "/municipality/manage-issue")
public class MunicipalityManageIssueServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(MunicipalityManageIssueServlet.class.getName());

    /** Valid status values accepted from the form. */
    private static final java.util.Set<String> VALID_STATUSES = new java.util.HashSet<>(
            java.util.Arrays.asList("Open", "In Progress", "Resolved", "Rejected"));

    /** Valid priority values. */
    private static final java.util.Set<String> VALID_PRIORITIES = new java.util.HashSet<>(
            java.util.Arrays.asList("Low", "Medium", "High", "Critical"));

    private final IssueDAO issueDAO = new IssueDAO();
    private final CommentDAO commentDAO = new CommentDAO();
    private final UpvoteDAO upvoteDAO = new UpvoteDAO();

    // ── GET ────────────────────────────────────────────────────────────────

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/municipality/issue-list");
            return;
        }

        Issue issue = resolveIssue(idParam);
        if (issue == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Issue not found.");
            return;
        }

        // Verify this issue belongs to the logged-in municipality
        UserDTO muniUser = SessionUtil.getLoggedInUser(request);
        if (muniUser != null && muniUser.getMunicipalityId() > 0
                && issue.getMunicipalityId() != muniUser.getMunicipalityId()) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN,
                    "You are not authorised to manage this issue.");
            return;
        }

        // Build web-accessible image URL if an image was uploaded
        String reportImageUrl = null;
        if (issue.getImagePath() != null && !issue.getImagePath().isBlank()) {
            reportImageUrl = request.getContextPath() + issue.getImagePath();
        }

        // Load comments and upvoter details so municipality can review citizen feedback
        java.util.List<com.snaptheslop.snaptheslop.comment.model.Comment> issueComments = commentDAO.findByIssueId(issue.getId());
        java.util.List<java.util.Map<String,String>> issueUpvoters = upvoteDAO.findUpvotersByIssueId(issue.getId());

        request.setAttribute("activePage", "issue-reports");
        request.setAttribute("issue", issue);
        request.setAttribute("issueComments", issueComments);
        request.setAttribute("issueUpvoters", issueUpvoters);
        request.setAttribute("reportImageUrl", reportImageUrl);
        request.getRequestDispatcher("/WEB-INF/views/municipality/manageIssue.jsp").forward(request, response);
    }

    // ── POST ───────────────────────────────────────────────────────────────

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam    = trim(request.getParameter("issueId"));
        String newStatus  = trim(request.getParameter("status"));
        String newPriority= trim(request.getParameter("priority"));

        if (idParam == null || idParam.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/municipality/issue-list");
            return;
        }

        // Validate status and priority
        if (newStatus != null && !VALID_STATUSES.contains(newStatus)) {
            flashError(request, "Invalid status value.");
            response.sendRedirect(request.getContextPath() + "/municipality/manage-issue?id=" + idParam);
            return;
        }
        if (newPriority != null && !VALID_PRIORITIES.contains(newPriority)) {
            flashError(request, "Invalid priority value.");
            response.sendRedirect(request.getContextPath() + "/municipality/manage-issue?id=" + idParam);
            return;
        }

        // Load current issue
        Issue issue = resolveIssue(idParam);
        if (issue == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Issue not found.");
            return;
        }

        // Auth — ensure municipality owns this issue
        UserDTO muniUser = SessionUtil.getLoggedInUser(request);
        if (muniUser != null && muniUser.getMunicipalityId() > 0
                && issue.getMunicipalityId() != muniUser.getMunicipalityId()) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN,
                    "You are not authorised to manage this issue.");
            return;
        }

        // Determine effective new status (default to current if not submitted)
        String effectiveStatus   = (newStatus   != null) ? newStatus   : issue.getStatus();
        String effectivePriority = (newPriority != null) ? newPriority : issue.getPriority();

        // Sprint 5 Task 4/5 — Validate status transition & persist with updatedAt timestamp
        if (!effectiveStatus.equals(issue.getStatus())) {
            if (!issue.isValidTransition(effectiveStatus)) {
                flashError(request, "Invalid status transition: "
                        + issue.getStatus() + " → " + effectiveStatus
                    + ". Allowed: Open→In Progress/Resolved/Rejected, In Progress→Resolved/Rejected.");
                response.sendRedirect(request.getContextPath() + "/municipality/manage-issue?id=" + idParam);
                return;
            }
        }

        boolean updated = issueDAO.forceUpdateStatus(issue.getId(), effectiveStatus, effectivePriority);
        if (updated) {
            // Trigger notifications
            com.snaptheslop.snaptheslop.notification.model.dao.NotificationService notificationService = new com.snaptheslop.snaptheslop.notification.model.dao.NotificationService();
            notificationService.triggerStatusChanged(issue, issue.getStatus(), effectiveStatus);
            notificationService.triggerPriorityChanged(issue, issue.getPriority(), effectivePriority);

            flashSuccess(request, "Issue #" + issue.getIssueId()
                    + " updated: status=" + effectiveStatus + ", priority=" + effectivePriority + ".");
        } else {
            flashError(request, "Failed to update the issue. Please try again.");
        }

        response.sendRedirect(request.getContextPath() + "/municipality/issue-list");
    }

    // ── Helpers ────────────────────────────────────────────────────────────

    private Issue resolveIssue(String idParam) {
        try {
            int numericId = Integer.parseInt(idParam);
            return issueDAO.findById(numericId);
        } catch (NumberFormatException e) {
            return issueDAO.findByIssueId(idParam);
        }
    }

    private void flashSuccess(HttpServletRequest req, String msg) {
        req.getSession().setAttribute("successMessage", msg);
    }

    private void flashError(HttpServletRequest req, String msg) {
        req.getSession().setAttribute("errorMessage", msg);
    }

    private String trim(String s) { return (s == null) ? null : s.trim(); }
}
