<%--
  Browse Community Issues — NagarSewa (social feed)
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.snaptheslop.snaptheslop.issue.model.Issue" %>
<%@ page import="com.snaptheslop.snaptheslop.municipality.model.Municipality" %>
<%@ page import="com.snaptheslop.snaptheslop.comment.model.Comment" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Set" %>
<jsp:include page="../common/header.jsp"/>
<%
  List<Issue> issues = (List<Issue>) request.getAttribute("issues");
  List<Municipality> municipalities = (List<Municipality>) request.getAttribute("municipalities");
  Map<Integer, List<Comment>> commentsByIssue = (Map<Integer, List<Comment>>) request.getAttribute("commentsByIssue");
  Map<Integer, Integer> commentCountByIssue = (Map<Integer, Integer>) request.getAttribute("commentCountByIssue");
  Set<Integer> upvotedIssueIds = (Set<Integer>) request.getAttribute("upvotedIssueIds");

  String categoryFilter = (String) request.getAttribute("categoryFilter");
  String municipalityFilter = (String) request.getAttribute("municipalityFilter");
  String wardFilter = (String) request.getAttribute("wardFilter");
  String statusFilter = (String) request.getAttribute("statusFilter");
  String keywordFilter = (String) request.getAttribute("keywordFilter");
  String successMessage = (String) request.getAttribute("successMessage");
  String errorMessage = (String) request.getAttribute("errorMessage");

  int currentPage = request.getAttribute("currentPage") != null ? (int) request.getAttribute("currentPage") : 1;
  int totalPages = request.getAttribute("totalPages") != null ? (int) request.getAttribute("totalPages") : 1;
  int totalCount = request.getAttribute("totalCount") != null ? (int) request.getAttribute("totalCount") : 0;

  if (issues == null) issues = new java.util.ArrayList<>();
  if (municipalities == null) municipalities = new java.util.ArrayList<>();
  if (commentsByIssue == null) commentsByIssue = new java.util.HashMap<>();
  if (commentCountByIssue == null) commentCountByIssue = new java.util.HashMap<>();
  if (upvotedIssueIds == null) upvotedIssueIds = new java.util.HashSet<>();

  String contextPath = request.getContextPath();
%>

<div class="flex min-h-screen">
  <jsp:include page="../common/citizen-sidebar.jsp"/>

  <div class="flex-1" style="margin-left:220px; background:#eef2f7; min-height:100vh;">
    <div style="padding:18px 32px; border-bottom:1px solid #dbe3ee; background:#ffffff;">
      <h1 style="font-family:'Outfit',sans-serif; font-size:22px; font-weight:800; color:#0f172a; margin:0;">Community Feed</h1>
      <p style="font-size:13px; color:#5b6b82; margin:3px 0 0;">Browse reports, upvote what matters, and discuss fixes with your neighbors.</p>
    </div>

    <div style="padding:24px 28px; max-width:1100px;">
      <% if (successMessage != null) { %>
      <div style="background:#d1fae5; border:1px solid #6ee7b7; border-radius:10px; padding:12px 14px; margin-bottom:14px; color:#065f46; font-size:13px;">
        <%= successMessage %>
      </div>
      <% } %>
      <% if (errorMessage != null) { %>
      <div style="background:#fee2e2; border:1px solid #fca5a5; border-radius:10px; padding:12px 14px; margin-bottom:14px; color:#991b1b; font-size:13px;">
        <%= errorMessage %>
      </div>
      <% } %>

      <form method="get" action="<%= contextPath %>/citizen/browse-issues" style="background:#ffffff; border:1px solid #dbe3ee; border-radius:12px; padding:12px; margin-bottom:16px; display:grid; grid-template-columns:1fr 1fr 1fr 1fr 1fr auto; gap:8px;">
        <input type="text" name="keyword" placeholder="Search title or category" value="<%= keywordFilter != null ? keywordFilter : "" %>" style="height:38px; border:1px solid #d5deea; border-radius:8px; padding:0 10px; font-size:13px; background:#fbfdff;"/>
        <select name="category" style="height:38px; border:1px solid #d5deea; border-radius:8px; padding:0 10px; font-size:13px; background:#fbfdff;">
          <option value="">All Categories</option>
          <option value="Roads Potholes" <%= "Roads Potholes".equals(categoryFilter) ? "selected" : "" %>>Roads & Potholes</option>
          <option value="Waste Management" <%= "Waste Management".equals(categoryFilter) ? "selected" : "" %>>Waste Management</option>
          <option value="Water Supply" <%= "Water Supply".equals(categoryFilter) ? "selected" : "" %>>Water Supply</option>
          <option value="Electricity" <%= "Electricity".equals(categoryFilter) ? "selected" : "" %>>Electricity</option>
          <option value="Drainage" <%= "Drainage".equals(categoryFilter) ? "selected" : "" %>>Drainage</option>
          <option value="Street Lighting" <%= "Street Lighting".equals(categoryFilter) ? "selected" : "" %>>Street Lighting</option>
          <option value="Public Safety" <%= "Public Safety".equals(categoryFilter) ? "selected" : "" %>>Public Safety</option>
          <option value="Sanitation" <%= "Sanitation".equals(categoryFilter) ? "selected" : "" %>>Sanitation</option>
          <option value="Other" <%= "Other".equals(categoryFilter) ? "selected" : "" %>>Other</option>
        </select>

        <select name="municipalityId" style="height:38px; border:1px solid #d5deea; border-radius:8px; padding:0 10px; font-size:13px; background:#fbfdff;">
          <option value="">All Municipalities</option>
          <% for (Municipality municipality : municipalities) { %>
          <option value="<%= municipality.getId() %>" <%= String.valueOf(municipality.getId()).equals(municipalityFilter) ? "selected" : "" %>><%= municipality.getName() %></option>
          <% } %>
        </select>

        <input type="number" min="1" name="ward" placeholder="Ward" value="<%= wardFilter != null ? wardFilter : "" %>" style="height:38px; border:1px solid #d5deea; border-radius:8px; padding:0 10px; font-size:13px; background:#fbfdff;"/>

        <select name="status" style="height:38px; border:1px solid #d5deea; border-radius:8px; padding:0 10px; font-size:13px; background:#fbfdff;">
          <option value="">All Statuses</option>
          <option value="Open" <%= "Open".equals(statusFilter) ? "selected" : "" %>>Open</option>
          <option value="In Progress" <%= "In Progress".equals(statusFilter) ? "selected" : "" %>>In Progress</option>
          <option value="Resolved" <%= "Resolved".equals(statusFilter) ? "selected" : "" %>>Resolved</option>
          <option value="Rejected" <%= "Rejected".equals(statusFilter) ? "selected" : "" %>>Rejected</option>
        </select>

        <button type="submit" style="height:38px; padding:0 14px; border:none; border-radius:8px; background:#1d4ed8; color:#fff; font-size:13px; font-weight:700; cursor:pointer;">Filter</button>
      </form>

      <p style="font-size:12px; color:#66758d; margin:0 0 12px;">Showing <%= issues.size() %> of <%= totalCount %> issues</p>

      <% if (issues.isEmpty()) { %>
      <div style="background:#ffffff; border:1px solid #dbe3ee; border-radius:12px; padding:34px; text-align:center; color:#8c98ab; font-size:14px;">
        No issues found for your current filters.
      </div>
      <% } else { %>
        <% for (Issue issue : issues) {
             String st = issue.getStatus();
             String statusBg = "#e2e8f0";
             String statusFg = "#334155";
             if ("Open".equals(st)) { statusBg = "#fee2e2"; statusFg = "#991b1b"; }
             else if ("In Progress".equals(st)) { statusBg = "#fef3c7"; statusFg = "#92400e"; }
             else if ("Resolved".equals(st)) { statusBg = "#dcfce7"; statusFg = "#166534"; }
             else if ("Rejected".equals(st)) { statusBg = "#f1f5f9"; statusFg = "#64748b"; }

             boolean upvoted = upvotedIssueIds.contains(issue.getId());
             List<Comment> comments = commentsByIssue.get(issue.getId());
             if (comments == null) comments = new java.util.ArrayList<>();
             Integer commentCountObj = commentCountByIssue.get(issue.getId());
             int commentCount = commentCountObj != null ? commentCountObj : 0;
             String returnUrl = "/citizen/browse-issues?page=" + currentPage;
             if (categoryFilter != null) returnUrl += "&category=" + java.net.URLEncoder.encode(categoryFilter, "UTF-8");
             if (municipalityFilter != null) returnUrl += "&municipalityId=" + java.net.URLEncoder.encode(municipalityFilter, "UTF-8");
             if (wardFilter != null) returnUrl += "&ward=" + java.net.URLEncoder.encode(wardFilter, "UTF-8");
             if (statusFilter != null) returnUrl += "&status=" + java.net.URLEncoder.encode(statusFilter, "UTF-8");
              if (keywordFilter != null) returnUrl += "&keyword=" + java.net.URLEncoder.encode(keywordFilter, "UTF-8");
             returnUrl += "#issue-" + issue.getId();
        %>
        <article id="issue-<%= issue.getId() %>" style="display:grid; grid-template-columns:64px 1fr; background:#ffffff; border:1px solid #dbe3ee; border-radius:12px; overflow:hidden; margin-bottom:12px;">
          <div style="background:#f8fafc; border-right:1px solid #e4ebf4; display:flex; flex-direction:column; align-items:center; padding:10px 0; gap:8px;">
            <form action="<%= contextPath %>/citizen/upvote" method="post" style="margin:0;">
              <input type="hidden" name="issueId" value="<%= issue.getId() %>"/>
              <input type="hidden" name="returnUrl" value="<%= returnUrl %>"/>
              <button type="submit" style="width:34px; height:34px; border-radius:9px; border:<%= upvoted ? "1px solid #f97316" : "1px solid #d5deea" %>; background:<%= upvoted ? "#fff7ed" : "#ffffff" %>; color:<%= upvoted ? "#ea580c" : "#64748b" %>; font-size:16px; font-weight:800; cursor:pointer;">▲</button>
            </form>
            <p style="font-size:14px; font-weight:800; color:#0f172a; margin:0;"><%= issue.getUpvoteCount() %></p>
            <p style="font-size:10px; color:#64748b; margin:0;">votes</p>
          </div>

          <div style="padding:12px 14px 10px;">
            <div style="display:flex; align-items:center; gap:8px; flex-wrap:wrap; margin-bottom:6px;">
              <span style="padding:2px 8px; border-radius:999px; font-size:10px; font-weight:700; background:<%= statusBg %>; color:<%= statusFg %>;"><%= st %></span>
              <span style="font-size:11px; color:#6b7b91;"><%= issue.getMunicipalityName() != null ? issue.getMunicipalityName() : "Municipality" %> · Ward <%= issue.getWardNo() %></span>
              <span style="font-size:11px; color:#94a3b8;">•</span>
              <span style="font-size:11px; color:#6b7b91;">posted by <strong><%= issue.getCitizenName() != null ? issue.getCitizenName() : "Citizen" %></strong> · <%= issue.getCreatedAtShort() %></span>
            </div>

            <a href="<%= contextPath %>/citizen/issue-detail?id=<%= issue.getId() %>" style="text-decoration:none; color:#0f172a;">
              <h2 style="font-family:'Outfit',sans-serif; font-size:21px; font-weight:800; margin:0 0 8px;"><%= issue.getTitle() %></h2>
            </a>
            <p style="font-size:13px; color:#334155; line-height:1.6; margin:0 0 10px; max-width:95%;"><%= issue.getDescription() != null ? issue.getDescription() : "" %></p>

            <div style="display:flex; align-items:center; gap:10px; margin-bottom:10px;">
              <span style="font-size:11px; color:#64748b; background:#f1f5f9; border-radius:6px; padding:3px 8px;"><%= issue.getCategory() != null ? issue.getCategory() : "General" %></span>
              <span style="font-size:11px; color:#64748b; background:#f1f5f9; border-radius:6px; padding:3px 8px;"><%= commentCount %> comments</span>
              <a href="<%= contextPath %>/citizen/issue-detail?id=<%= issue.getId() %>" style="font-size:12px; font-weight:700; color:#1d4ed8; text-decoration:none;">Open Thread →</a>
            </div>

            <div style="background:#f8fafc; border:1px solid #e2e8f0; border-radius:10px; padding:10px; margin-bottom:8px;">
              <p style="font-size:11px; font-weight:700; color:#475569; margin:0 0 8px;">Recent comments</p>
              <% if (comments.isEmpty()) { %>
              <p style="font-size:12px; color:#94a3b8; margin:0;">No comments yet. Be the first to add context.</p>
              <% } else { %>
                <% for (Comment comment : comments) { %>
                <div style="padding:7px 0; border-bottom:1px solid #e9eef5;">
                  <p style="font-size:11px; color:#64748b; margin:0 0 2px;"><strong><%= comment.getCommenterName() != null ? comment.getCommenterName() : "Citizen" %></strong> · <%= comment.getCreatedAtShort() %></p>
                  <p style="font-size:13px; color:#1f2937; margin:0;"><%= comment.getContent() %></p>
                </div>
                <% } %>
              <% } %>
            </div>

            <form action="<%= contextPath %>/citizen/comment" method="post" style="display:flex; gap:8px; align-items:flex-start;">
              <input type="hidden" name="issueId" value="<%= issue.getId() %>"/>
              <input type="hidden" name="returnUrl" value="<%= returnUrl %>"/>
              <textarea name="commentText" rows="2" maxlength="1000" required placeholder="Add a public comment..."
                        style="flex:1; border:1px solid #d5deea; border-radius:8px; padding:8px 10px; font-size:13px; background:#ffffff; resize:vertical; min-height:40px; max-height:120px;"></textarea>
              <button type="submit" style="height:40px; border:none; border-radius:8px; padding:0 14px; background:#0f172a; color:#fff; font-size:12px; font-weight:700; cursor:pointer;">Comment</button>
            </form>
          </div>
        </article>
        <% } %>
      <% } %>

      <% if (totalPages > 1) { %>
      <div style="display:flex; gap:6px; justify-content:center; margin-top:14px;">
        <% for (int p = Math.max(1, currentPage - 2); p <= Math.min(totalPages, currentPage + 2); p++) { %>
          <a href="<%= contextPath %>/citizen/browse-issues?page=<%= p %><%= categoryFilter != null ? "&category=" + java.net.URLEncoder.encode(categoryFilter, "UTF-8") : "" %><%= municipalityFilter != null ? "&municipalityId=" + java.net.URLEncoder.encode(municipalityFilter, "UTF-8") : "" %><%= wardFilter != null ? "&ward=" + java.net.URLEncoder.encode(wardFilter, "UTF-8") : "" %><%= statusFilter != null ? "&status=" + java.net.URLEncoder.encode(statusFilter, "UTF-8") : "" %><%= keywordFilter != null ? "&keyword=" + java.net.URLEncoder.encode(keywordFilter, "UTF-8") : "" %>"
             style="min-width:34px; height:34px; border-radius:8px; display:flex; align-items:center; justify-content:center; text-decoration:none; font-size:12px; font-weight:700; border:<%= p == currentPage ? "none" : "1px solid #d5deea" %>; background:<%= p == currentPage ? "#0f172a" : "#ffffff" %>; color:<%= p == currentPage ? "#ffffff" : "#475569" %>;">
            <%= p %>
          </a>
        <% } %>
      </div>
      <% } %>
    </div>
  </div>
</div>
</body>
</html>
