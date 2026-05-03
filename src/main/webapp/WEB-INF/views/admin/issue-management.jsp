<%--
  Admin Issue Management — NagarSewa (live DB data)
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.snaptheslop.snaptheslop.issue.model.Issue" %>
<%@ page import="com.snaptheslop.snaptheslop.municipality.model.Municipality" %>
<% request.setAttribute("activePage", "issue-management"); %>
<jsp:include page="../common/header.jsp"/>
<%
  List<Issue> issues = (List<Issue>) request.getAttribute("issues");
  List<Municipality> municipalities = (List<Municipality>) request.getAttribute("municipalities");
  if (issues == null) issues = new java.util.ArrayList<>();
  if (municipalities == null) municipalities = new java.util.ArrayList<>();

  String categoryFilter = (String) request.getAttribute("categoryFilter");
  String municipalityFilter = (String) request.getAttribute("municipalityFilter");
  String wardFilter = (String) request.getAttribute("wardFilter");
  String statusFilter = (String) request.getAttribute("statusFilter");
  String keywordFilter = (String) request.getAttribute("keywordFilter");

  int totalCount = request.getAttribute("totalCount") != null ? (int) request.getAttribute("totalCount") : 0;
  int filteredCount = request.getAttribute("filteredCount") != null ? (int) request.getAttribute("filteredCount") : 0;
  int openCount = request.getAttribute("openCount") != null ? (int) request.getAttribute("openCount") : 0;
  int inProgressCount = request.getAttribute("inProgressCount") != null ? (int) request.getAttribute("inProgressCount") : 0;
  int resolvedCount = request.getAttribute("resolvedCount") != null ? (int) request.getAttribute("resolvedCount") : 0;
  int currentPage = request.getAttribute("currentPage") != null ? (int) request.getAttribute("currentPage") : 1;
  int totalPages = request.getAttribute("totalPages") != null ? (int) request.getAttribute("totalPages") : 1;

  String contextPath = request.getContextPath();
%>

<div class="flex min-h-screen">
  <jsp:include page="../common/admin-sidebar.jsp"/>

  <div class="flex-1" style="margin-left:220px; background:#f8fafc; min-height:100vh;">

    <div style="padding:18px 32px; display:flex; align-items:center; justify-content:space-between; border-bottom:1px solid #e2e8f0; background:#fff;">
      <div>
        <h1 style="font-family:'Outfit',sans-serif; font-size:18px; font-weight:700; color:#0f172a; margin:0;">Manage Issues</h1>
        <p style="font-size:13px; color:#64748b; margin:2px 0 0;">Live issue reports across all municipalities.</p>
      </div>
      <a href="<%= contextPath %>/admin/dashboard" style="padding:9px 18px; border-radius:8px; font-size:13px; font-weight:600; border:1px solid #e2e8f0; background:#fff; color:#64748b; text-decoration:none; font-family:'Inter',sans-serif;">Back to Dashboard</a>
    </div>

    <div style="padding:28px 32px;">

      <form method="get" action="<%= contextPath %>/admin/manage-issues">
        <div style="display:grid; grid-template-columns:1fr 1fr 1fr 1fr 1fr 1fr; gap:10px; margin-bottom:14px;">
          <input type="text" name="keyword" placeholder="Search title or category" value="<%= keywordFilter != null ? keywordFilter : "" %>" style="height:40px; border:1px solid #d1d5db; border-radius:8px; padding:0 10px; font-size:13px; color:#111827; background:#fff; font-family:'Inter',sans-serif;"/>
          <select name="municipalityId" style="height:40px; border:1px solid #d1d5db; border-radius:8px; padding:0 10px; font-size:13px; color:#111827; background:#fff; font-family:'Inter',sans-serif;">
            <option value="">Municipality: All</option>
            <% for (Municipality muni : municipalities) {
                 String muniId = String.valueOf(muni.getId());
            %>
              <option value="<%= muniId %>" <%= muniId.equals(municipalityFilter) ? "selected" : "" %>><%= muni.getName() %></option>
            <% } %>
          </select>

          <select name="category" style="height:40px; border:1px solid #d1d5db; border-radius:8px; padding:0 10px; font-size:13px; color:#111827; background:#fff; font-family:'Inter',sans-serif;">
            <option value="">Category: All</option>
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

          <select name="status" style="height:40px; border:1px solid #d1d5db; border-radius:8px; padding:0 10px; font-size:13px; color:#111827; background:#fff; font-family:'Inter',sans-serif;">
            <option value="">Status: All</option>
            <option value="Open" <%= "Open".equals(statusFilter) ? "selected" : "" %>>Open</option>
            <option value="In Progress" <%= "In Progress".equals(statusFilter) ? "selected" : "" %>>In Progress</option>
            <option value="Resolved" <%= "Resolved".equals(statusFilter) ? "selected" : "" %>>Resolved</option>
            <option value="Rejected" <%= "Rejected".equals(statusFilter) ? "selected" : "" %>>Rejected</option>
          </select>

          <input type="number" name="ward" min="1" placeholder="Ward (optional)" value="<%= wardFilter != null ? wardFilter : "" %>"
                 style="height:40px; border:1px solid #d1d5db; border-radius:8px; padding:0 10px; font-size:13px; color:#111827; background:#fff; font-family:'Inter',sans-serif;"/>

          <button type="submit" style="height:40px; border:none; border-radius:8px; background:#059669; color:#fff; font-size:13px; font-weight:600; cursor:pointer; font-family:'Inter',sans-serif;">Apply Filters</button>
        </div>
      </form>

      <div style="display:flex; gap:24px; margin-bottom:20px; padding-bottom:20px; border-bottom:1px solid #f1f5f9;">
        <div><p style="font-size:11px; color:#94a3b8; font-weight:600; text-transform:uppercase; letter-spacing:0.5px;">Total</p><p style="font-size:22px; font-weight:800; color:#0f172a; font-family:'Outfit',sans-serif;"><%= totalCount %></p></div>
        <div style="border-left:1px solid #e2e8f0; padding-left:24px;"><p style="font-size:11px; color:#94a3b8; font-weight:600; text-transform:uppercase; letter-spacing:0.5px;">Open</p><p style="font-size:22px; font-weight:800; color:#dc2626; font-family:'Outfit',sans-serif;"><%= openCount %></p></div>
        <div style="border-left:1px solid #e2e8f0; padding-left:24px;"><p style="font-size:11px; color:#94a3b8; font-weight:600; text-transform:uppercase; letter-spacing:0.5px;">In Progress</p><p style="font-size:22px; font-weight:800; color:#0d9488; font-family:'Outfit',sans-serif;"><%= inProgressCount %></p></div>
        <div style="border-left:1px solid #e2e8f0; padding-left:24px;"><p style="font-size:11px; color:#94a3b8; font-weight:600; text-transform:uppercase; letter-spacing:0.5px;">Resolved</p><p style="font-size:22px; font-weight:800; color:#059669; font-family:'Outfit',sans-serif;"><%= resolvedCount %></p></div>
        <div style="border-left:1px solid #e2e8f0; padding-left:24px;"><p style="font-size:11px; color:#94a3b8; font-weight:600; text-transform:uppercase; letter-spacing:0.5px;">Filtered</p><p style="font-size:22px; font-weight:800; color:#0f172a; font-family:'Outfit',sans-serif;"><%= filteredCount %></p></div>
      </div>

      <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; overflow:hidden;">
        <table style="width:100%; border-collapse:collapse;">
          <thead>
            <tr style="border-bottom:1px solid #f1f5f9;">
              <th style="text-align:left; padding:12px 18px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">ID</th>
              <th style="text-align:left; padding:12px 18px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Issue</th>
              <th style="text-align:left; padding:12px 18px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Reporter</th>
              <th style="text-align:left; padding:12px 18px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Municipality</th>
              <th style="text-align:left; padding:12px 18px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Ward</th>
              <th style="text-align:left; padding:12px 18px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Status</th>
              <th style="text-align:left; padding:12px 18px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Priority</th>
              <th style="text-align:left; padding:12px 18px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Upvotes</th>
              <th style="text-align:left; padding:12px 18px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Date</th>
              <th style="text-align:right; padding:12px 18px;"></th>
            </tr>
          </thead>
          <tbody>
            <% if (issues.isEmpty()) { %>
              <tr>
                <td colspan="10" style="padding:36px 18px; text-align:center; font-size:13px; color:#94a3b8;">No issues found for the selected filters.</td>
              </tr>
            <% } else {
                 for (Issue issue : issues) {
                   String st = issue.getStatus();
                   String statusBg = "#f1f5f9";
                   String statusFg = "#64748b";
                   if ("Open".equals(st)) { statusBg = "#fee2e2"; statusFg = "#991b1b"; }
                   else if ("In Progress".equals(st)) { statusBg = "#d1fae5"; statusFg = "#065f46"; }
                   else if ("Resolved".equals(st)) { statusBg = "#dcfce7"; statusFg = "#166534"; }
                   else if ("Rejected".equals(st)) { statusBg = "#f1f5f9"; statusFg = "#64748b"; }

                   String pr = issue.getPriority() != null ? issue.getPriority() : "Medium";
                   String priorityColor = "#2563eb";
                   if ("Critical".equals(pr)) priorityColor = "#dc2626";
                   else if ("High".equals(pr)) priorityColor = "#d97706";
                   else if ("Low".equals(pr)) priorityColor = "#64748b";
            %>
              <tr style="border-bottom:1px solid #f8fafc;" onmouseover="this.style.background='#fafbfc'" onmouseout="this.style.background='transparent'">
                <td style="padding:14px 18px; font-size:13px; color:#94a3b8;">#<%= issue.getIssueId() %></td>
                <td style="padding:14px 18px;"><p style="font-size:13px; font-weight:600; color:#1e293b;"><%= issue.getTitle() %></p><p style="font-size:11px; color:#94a3b8;"><%= issue.getCategory() != null ? issue.getCategory() : "—" %></p></td>
                <td style="padding:14px 18px; font-size:13px; color:#64748b;"><%= issue.getCitizenName() != null ? issue.getCitizenName() : "—" %></td>
                <td style="padding:14px 18px; font-size:13px; color:#64748b;"><%= issue.getMunicipalityName() != null ? issue.getMunicipalityName() : "—" %></td>
                <td style="padding:14px 18px; font-size:13px; color:#64748b;"><%= issue.getWardNo() %></td>
                <td style="padding:14px 18px;"><span style="padding:3px 10px; border-radius:99px; font-size:11px; font-weight:600; background:<%= statusBg %>; color:<%= statusFg %>;"><%= st %></span></td>
                <td style="padding:14px 18px;"><span style="font-size:12px; font-weight:600; color:<%= priorityColor %>;">● <%= pr %></span></td>
                <td style="padding:14px 18px; font-size:12px; color:#0f172a; font-weight:700;"><%= issue.getUpvoteCount() %></td>
                <td style="padding:14px 18px; font-size:12px; color:#94a3b8;"><%= issue.getCreatedAtShort() %></td>
                <td style="padding:14px 18px; text-align:right;"><a href="<%= contextPath %>/municipality/manage-issue?id=<%= issue.getId() %>" style="background:#059669; color:#fff; border:none; padding:5px 14px; border-radius:6px; font-size:11px; font-weight:600; text-decoration:none; display:inline-block;">Manage</a></td>
              </tr>
            <%   }
               } %>
          </tbody>
        </table>

        <div style="padding:12px 18px; border-top:1px solid #f1f5f9; display:flex; align-items:center; justify-content:space-between;">
          <span style="font-size:12px; color:#94a3b8;">Showing <%= issues.size() %> of <%= filteredCount %> filtered issues</span>
          <% if (totalPages > 1) { %>
          <div style="display:flex; gap:4px;">
            <% if (currentPage > 1) { %>
              <a href="<%= contextPath %>/admin/manage-issues?page=<%= currentPage - 1 %><%= municipalityFilter != null ? "&municipalityId=" + java.net.URLEncoder.encode(municipalityFilter, java.nio.charset.StandardCharsets.UTF_8) : "" %><%= categoryFilter != null ? "&category=" + java.net.URLEncoder.encode(categoryFilter, java.nio.charset.StandardCharsets.UTF_8) : "" %><%= wardFilter != null ? "&ward=" + java.net.URLEncoder.encode(wardFilter, java.nio.charset.StandardCharsets.UTF_8) : "" %><%= statusFilter != null ? "&status=" + java.net.URLEncoder.encode(statusFilter, java.nio.charset.StandardCharsets.UTF_8) : "" %><%= keywordFilter != null ? "&keyword=" + java.net.URLEncoder.encode(keywordFilter, java.nio.charset.StandardCharsets.UTF_8) : "" %>" style="width:28px; height:28px; border-radius:6px; border:1px solid #e2e8f0; background:#fff; color:#94a3b8; cursor:pointer; font-size:11px; display:flex; align-items:center; justify-content:center; text-decoration:none;">&lsaquo;</a>
            <% } %>
            <% for (int p = Math.max(1, currentPage - 2); p <= Math.min(totalPages, currentPage + 2); p++) { %>
              <a href="<%= contextPath %>/admin/manage-issues?page=<%= p %><%= municipalityFilter != null ? "&municipalityId=" + java.net.URLEncoder.encode(municipalityFilter, java.nio.charset.StandardCharsets.UTF_8) : "" %><%= categoryFilter != null ? "&category=" + java.net.URLEncoder.encode(categoryFilter, java.nio.charset.StandardCharsets.UTF_8) : "" %><%= wardFilter != null ? "&ward=" + java.net.URLEncoder.encode(wardFilter, java.nio.charset.StandardCharsets.UTF_8) : "" %><%= statusFilter != null ? "&status=" + java.net.URLEncoder.encode(statusFilter, java.nio.charset.StandardCharsets.UTF_8) : "" %><%= keywordFilter != null ? "&keyword=" + java.net.URLEncoder.encode(keywordFilter, java.nio.charset.StandardCharsets.UTF_8) : "" %>" style="width:28px; height:28px; border-radius:6px; border:<%= p == currentPage ? "none" : "1px solid #e2e8f0" %>; background:<%= p == currentPage ? "#0f172a" : "#fff" %>; color:<%= p == currentPage ? "#fff" : "#64748b" %>; font-size:12px; font-weight:<%= p == currentPage ? "700" : "400" %>; display:flex; align-items:center; justify-content:center; text-decoration:none;"><%= p %></a>
            <% } %>
            <% if (currentPage < totalPages) { %>
              <a href="<%= contextPath %>/admin/manage-issues?page=<%= currentPage + 1 %><%= municipalityFilter != null ? "&municipalityId=" + java.net.URLEncoder.encode(municipalityFilter, java.nio.charset.StandardCharsets.UTF_8) : "" %><%= categoryFilter != null ? "&category=" + java.net.URLEncoder.encode(categoryFilter, java.nio.charset.StandardCharsets.UTF_8) : "" %><%= wardFilter != null ? "&ward=" + java.net.URLEncoder.encode(wardFilter, java.nio.charset.StandardCharsets.UTF_8) : "" %><%= statusFilter != null ? "&status=" + java.net.URLEncoder.encode(statusFilter, java.nio.charset.StandardCharsets.UTF_8) : "" %><%= keywordFilter != null ? "&keyword=" + java.net.URLEncoder.encode(keywordFilter, java.nio.charset.StandardCharsets.UTF_8) : "" %>" style="width:28px; height:28px; border-radius:6px; border:1px solid #e2e8f0; background:#fff; color:#94a3b8; cursor:pointer; font-size:11px; display:flex; align-items:center; justify-content:center; text-decoration:none;">&rsaquo;</a>
            <% } %>
          </div>
          <% } %>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>
