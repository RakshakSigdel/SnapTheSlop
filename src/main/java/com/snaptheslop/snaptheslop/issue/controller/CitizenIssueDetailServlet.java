package com.snaptheslop.snaptheslop.issue.controller;

import com.snaptheslop.snaptheslop.comment.model.Comment;
import com.snaptheslop.snaptheslop.comment.model.dao.CommentDAO;
import com.snaptheslop.snaptheslop.issue.model.Issue;
import com.snaptheslop.snaptheslop.issue.model.dao.IssueDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Collections;
import java.util.List;
import java.util.logging.Logger;

/**
 * Sprint 5 Task 3 — Issue detail retrieval with complete metadata.
 * Sprint 5 Task 7 — Replace static/mock data with live DB-backed data.
 */
@WebServlet(name = "citizenIssueDetailServlet", value = "/citizen/issue-detail")
public class CitizenIssueDetailServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(CitizenIssueDetailServlet.class.getName());
    private final IssueDAO issueDAO = new IssueDAO();
    private final CommentDAO commentDAO = new CommentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String issueIdParam = request.getParameter("id");

        if (issueIdParam == null || issueIdParam.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/citizen/my-issues");
            return;
        }

        // Try to find by numeric id first, then by string issueId
        Issue issue = null;
        try {
            int numericId = Integer.parseInt(issueIdParam);
            issue = issueDAO.findById(numericId);
        } catch (NumberFormatException e) {
            // param is a string issueId (e.g. "ISS-123")
            issue = issueDAO.findByIssueId(issueIdParam);
        }

        if (issue == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Issue not found.");
            return;
        }

        List<Comment> issueComments = commentDAO.findByIssueId(issue.getId());
        if (issueComments == null) {
            issueComments = Collections.emptyList();
        }

        String successMessage = (String) request.getSession().getAttribute("successMessage");
        String errorMessage = (String) request.getSession().getAttribute("errorMessage");
        if (successMessage != null) {
            request.setAttribute("successMessage", successMessage);
            request.getSession().removeAttribute("successMessage");
        }
        if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
            request.getSession().removeAttribute("errorMessage");
        }

        request.setAttribute("issue", issue);
        request.setAttribute("issueComments", issueComments);
        request.setAttribute("activePage", "browse-issues");
        request.getRequestDispatcher("/WEB-INF/views/citizen/issue-detail.jsp").forward(request, response);
    }
}
