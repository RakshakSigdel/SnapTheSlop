package com.snaptheslop.snaptheslop.issue.controller;

import com.snaptheslop.snaptheslop.comment.model.Comment;
import com.snaptheslop.snaptheslop.comment.model.dao.CommentDAO;
import com.snaptheslop.snaptheslop.issue.model.Issue;
import com.snaptheslop.snaptheslop.issue.model.dao.IssueDAO;
import com.snaptheslop.snaptheslop.municipality.MunicipalityDAO;
import com.snaptheslop.snaptheslop.municipality.model.Municipality;
import com.snaptheslop.snaptheslop.upvote.model.dao.UpvoteDAO;
import com.snaptheslop.snaptheslop.user.model.UserDTO;
import com.snaptheslop.snaptheslop.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.logging.Level;
import java.util.logging.Logger;

// Sprint 5 Task 2 — Browse issues with server-side filtering

/**
 * Sprint 5 Task 2 — Browse all community issues with pagination and filtering.
 * Sprint 5 Task 7 — Replace static data with live DB-backed data.
 */
@WebServlet(name = "citizenBrowseIssuesServlet", value = "/citizen/browse-issues")
public class CitizenBrowseIssuesServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(CitizenBrowseIssuesServlet.class.getName());
    private static final int PAGE_SIZE = 15;

    private final IssueDAO issueDAO = new IssueDAO();
    private final MunicipalityDAO municipalityDAO = new MunicipalityDAO();
    private final UpvoteDAO upvoteDAO = new UpvoteDAO();
    private final CommentDAO commentDAO = new CommentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Filters from query params
        String categoryFilter    = trim(request.getParameter("category"));
        String municipalityFilter= trim(request.getParameter("municipalityId"));
        String wardFilter        = trim(request.getParameter("ward"));
        String statusFilter      = trim(request.getParameter("status"));
        String keywordFilter     = trim(request.getParameter("keyword"));

        int page = 1;
        try { page = Math.max(1, Integer.parseInt(request.getParameter("page"))); }
        catch (NumberFormatException ignored) {}

        // Fetch live data from DB
        List<Issue> issues = issueDAO.findAll(
                categoryFilter, municipalityFilter, wardFilter, statusFilter, keywordFilter, page, PAGE_SIZE);

        if (issues == null) {
            issues = Collections.emptyList();
        }

        // Load municipalities for the filter dropdown
        List<Municipality> municipalities = Collections.emptyList();
        try { municipalities = municipalityDAO.getAllMunicipalities(); }
        catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.WARNING, "Could not load municipalities for filter", e);
        }

        List<Integer> issueIds = issues.stream().map(Issue::getId).collect(Collectors.toList());
        Map<Integer, List<Comment>> commentsByIssue = issueIds.isEmpty()
                ? Collections.emptyMap()
            : commentDAO.findByIssueIds(issueIds, 1);
        Map<Integer, Integer> commentCountByIssue = issueIds.isEmpty()
                ? Collections.emptyMap()
                : commentDAO.countByIssueIds(issueIds);

        Set<Integer> upvotedIssueIds = Collections.emptySet();
        UserDTO user = SessionUtil.getLoggedInUser(request);
        if (user != null && !issueIds.isEmpty()) {
            int userDbId = SessionUtil.getLoggedInUserDbId(request);
            if (userDbId > 0) {
                upvotedIssueIds = upvoteDAO.findUserUpvotedIssueIds(userDbId, issueIds);
            }
        }

        // Pagination info
        int totalCount = issueDAO.countAllFiltered(categoryFilter, municipalityFilter, wardFilter, statusFilter, keywordFilter);
        int totalPages = (int) Math.ceil((double) totalCount / PAGE_SIZE);
        if (totalPages < 1) {
            totalPages = 1;
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

        request.setAttribute("activePage",         "browse-issues");
        request.setAttribute("issues",             issues);
        request.setAttribute("municipalities",     municipalities);
        request.setAttribute("categoryFilter",     categoryFilter);
        request.setAttribute("municipalityFilter", municipalityFilter);
        request.setAttribute("wardFilter",         wardFilter);
        request.setAttribute("statusFilter",       statusFilter);
        request.setAttribute("keywordFilter",      keywordFilter);
        request.setAttribute("currentPage",        page);
        request.setAttribute("totalPages",         totalPages);
        request.setAttribute("totalCount",         totalCount);
        request.setAttribute("commentsByIssue",    commentsByIssue != null ? commentsByIssue : new HashMap<Integer, List<Comment>>());
        request.setAttribute("commentCountByIssue",commentCountByIssue != null ? commentCountByIssue : new HashMap<Integer, Integer>());
        request.setAttribute("upvotedIssueIds",    upvotedIssueIds);

        request.getRequestDispatcher("/WEB-INF/views/citizen/browse-issues.jsp").forward(request, response);
    }

    private String trim(String s) { return (s == null || s.isBlank()) ? null : s.trim(); }
}
