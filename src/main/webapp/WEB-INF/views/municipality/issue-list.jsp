<%--
  Municipality Issue List — NagarSewa  (Sprint 5: live DB data)
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.snaptheslop.snaptheslop.issue.model.Issue, java.util.List" %>
<% request.setAttribute("activePage", "issue-reports"); %>
<jsp:include page="../common/header.jsp"/>
<%
  List<Issue> issues        = (List<Issue>) request.getAttribute("issues");
  String statusFilter       = (String)      request.getAttribute("statusFilter");
  String categoryFilter     = (String)      request.getAttribute("categoryFilter");
  String wardFilter         = (String)      request.getAttribute("wardFilter");
  int currentPage           = request.getAttribute("currentPage")    != null ? (int) request.getAttribute("currentPage")    : 1;
  int totalPages            = request.getAttribute("totalPages")     != null ? (int) request.getAttribute("totalPages")     : 1;
  int totalCount            = request.getAttribute("totalCount")     != null ? (int) request.getAttribute("totalCount")     : 0;
  int countOpen             = request.getAttribute("countOpen")      != null ? (int) request.getAttribute("countOpen")      : 0;
  int countInProgress       = request.getAttribute("countInProgress")!= null ? (int) request.getAttribute("countInProgress"): 0;
  int countResolved         = request.getAttribute("countResolved")  != null ? (int) request.getAttribute("countResolved")  : 0;
  String successMessage     = (String)      request.getAttribute("successMessage");
  String errorMessage       = (String)      request.getAttribute("errorMessage");
  String contextPath        = request.getContextPath();
  if (issues == null) issues = new java.util.ArrayList<>();
%>

<div class="flex min-h-screen">
  <jsp:include page="../common/municipality-sidebar.jsp"/>

  <div class="flex-1" style="margin-left:220px; background:#f8fafc; min-height:100vh;">

    <div style="padding:18px 32px; display:flex; align-items:center; justify-content:space-between; border-bottom:1px solid #e2e8f0; background:#fff;">
      <div>
        <h1 style="font-family:'Outfit',sans-serif; font-size:18px; font-weight:700; color:#0f172a; margin:0;">Manage Issues</h1>
        <p style="font-size:13px; color:#64748b; margin:2px 0 0;">Browse and act on reports by ward, category, status, and priority.</p>
      </div>
    </div>

    <div style="padding:28px 32px;">

      <!-- Flash messages -->
      <% if (successMessage != null) { %>
      <div style="background:#d1fae5; border:1px solid #6ee7b7; border-radius:8px; padding:12px 18px; margin-bottom:16px; font-size:13px; color:#065f46; font-weight:500;">✓ <%= successMessage %></div>
      <% } %>
      <% if (errorMessage != null) { %>
      <div style="background:#fee2e2; border:1px solid #fca5a5; border-radius:8px; padding:12px 18px; margin-bottom:16px; font-size:13px; color:#991b1b; font-weight:500;">⚠ <%= errorMessage %></div>
      <% } %>

      <!-- Filters form -->
      <form method="get" action="<%= contextPath %>/municipality/issue-list">
        <div style="display:grid; grid-template-columns:1fr 1fr 1fr auto; gap:10px; margin-bottom:14px;">
          <select name="ward" style="height:40px; border:1px solid #d1d5db; border-radius:8px; padding:0 10px; font-size:13px; color:#111827; background:#fff; font-family:'Inter',sans-serif;">
            <option value="">Ward: All</option>
            <% for (int w = 1; w <= 32; w++) { %>
            <option value="<%= w %>" <%= String.valueOf(w).equals(wardFilter) ? "selected" : "" %>>Ward <%= String.format("%02d", w) %></option>
            <% } %>
          </select>
          <select name="category" style="height:40px; border:1px solid #d1d5db; border-radius:8px; padding:0 10px; font-size:13px; color:#111827; background:#fff; font-family:'Inter',sans-serif;">
            <option value="">Category: All</option>
            <option value="Roads"      <%= "Roads".equals(categoryFilter)      ? "selected" : "" %>>Roads</option>
            <option value="Sanitation" <%= "Sanitation".equals(categoryFilter) ? "selected" : "" %>>Sanitation</option>
            <option value="Water"      <%= "Water".equals(categoryFilter)      ? "selected" : "" %>>Water</option>
            <option value="Electrical" <%= "Electrical".equals(categoryFilter) ? "selected" : "" %>>Electrical</option>
            <option value="Drainage"   <%= "Drainage".equals(categoryFilter)   ? "selected" : "" %>>Drainage</option>
          </select>
          <select name="status" style="height:40px; border:1px solid #d1d5db; border-radius:8px; padding:0 10px; font-size:13px; color:#111827; background:#fff; font-family:'Inter',sans-serif;">
            <option value="">Status: All</option>
            <option value="Open"        <%= "Open".equals(statusFilter)        ? "selected" : "" %>>Open</option>
            <option value="In Progress" <%= "In Progress".equals(statusFilter) ? "selected" : "" %>>In Progress</option>
            <option value="Resolved"    <%= "Resolved".equals(statusFilter)    ? "selected" : "" %>>Resolved</option>
            <option value="Rejected"    <%= "Rejected".equals(statusFilter)    ? "selected" : "" %>>Rejected</option>
          </select>
          <button type="submit" style="height:40px; padding:0 18px; background:#059669; color:#fff; border:none; border-radius:8px; font-size:13px; font-weight:600; cursor:pointer; font-family:'Inter',sans-serif;">Apply</button>
        </div>
      </form>

      <!-- Quick stats (live) -->
      <div style="display:flex; gap:24px; margin-bottom:24px;">
        <div><span style="font-size:12px; color:#94a3b8;">Total </span><span style="font-size:14px; font-weight:700; color:#0f172a;"><%= totalCount %></span></div>
        <div style="width:1px; background:#e2e8f0;"></div>
        <div><span style="font-size:12px; color:#94a3b8;">Open </span><span style="font-size:14px; font-weight:700; color:#dc2626;"><%= countOpen %></span></div>
        <div style="width:1px; background:#e2e8f0;"></div>
        <div><span style="font-size:12px; color:#94a3b8;">In Progress </span><span style="font-size:14px; font-weight:700; color:#2563eb;"><%= countInProgress %></span></div>
        <div style="width:1px; background:#e2e8f0;"></div>
        <div><span style="font-size:12px; color:#94a3b8;">Resolved </span><span style="font-size:14px; font-weight:700; color:#059669;"><%= countResolved %></span></div>
      </div>

      <!-- Table -->
      <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; overflow:hidden;">
        <table style="width:100%; border-collapse:collapse;">
          <thead>
            <tr style="border-bottom:1px solid #f1f5f9;">
              <th style="text-align:left; padding:12px 18px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">ID</th>
              <th style="text-align:left; padding:12px 18px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Issue</th>
              <th style="text-align:left; padding:12px 18px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Citizen</th>
              <th style="text-align:left; padding:12px 18px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Ward</th>
              <th style="text-align:left; padding:12px 18px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Status</th>
              <th style="text-align:left; padding:12px 18px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Upvotes</th>
              <th style="text-align:left; padding:12px 18px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Date</th>
              <th style="text-align:right; padding:12px 18px;"></th>
            </tr>
          </thead>
          <tbody>
            <% if (issues.isEmpty()) { %>
            <tr>
              <td colspan="8" style="padding:40px; text-align:center; color:#94a3b8; font-size:14px;">No issues found for the selected filters.</td>
            </tr>
            <% } else { for (Issue issue : issues) {
                String st = issue.getStatus();
                String bg, fg;
                if ("Open".equals(st))            { bg="#fee2e2"; fg="#991b1b"; }
                else if ("In Progress".equals(st)){ bg="#d1fae5"; fg="#065f46"; }
                else if ("Resolved".equals(st))   { bg="#dcfce7"; fg="#166534"; }
                else if ("Rejected".equals(st))   { bg="#f1f5f9"; fg="#64748b"; }
                else                              { bg="#fef3c7"; fg="#92400e"; }
                boolean isOpen = "Open".equals(st);
            %>
            <tr style="border-bottom:1px solid #f8fafc;" onmouseover="this.style.background='#fafbfc'" onmouseout="this.style.background='transparent'">
              <td style="padding:14px 18px; font-size:13px; font-weight:500; color:#94a3b8;">#<%= issue.getIssueId() %></td>
              <td style="padding:14px 18px;">
                <p style="font-size:13px; font-weight:600; color:#1e293b; margin:0;"><%= issue.getTitle() %></p>
                <p style="font-size:11px; color:#94a3b8; margin:2px 0 0;"><%= issue.getCategory() != null ? issue.getCategory() : "—" %></p>
              </td>
              <td style="padding:14px 18px; font-size:13px; color:#64748b;"><%= issue.getCitizenName() != null ? issue.getCitizenName() : "—" %></td>
              <td style="padding:14px 18px; font-size:13px; color:#64748b;"><%= String.format("%02d", issue.getWardNo()) %></td>
              <td style="padding:14px 18px;"><span style="padding:3px 10px; border-radius:99px; font-size:11px; font-weight:600; background:<%= bg %>; color:<%= fg %>;"><%= st %></span></td>
              <td style="padding:14px 18px; font-size:12px; color:#0f172a; font-weight:700;"><%= issue.getUpvoteCount() %></td>
              <td style="padding:14px 18px; font-size:12px; color:#94a3b8;"><%= issue.getCreatedAtShort() %></td>
              <td style="padding:14px 18px; text-align:right;">
                <a href="<%= contextPath %>/municipality/manage-issue?id=<%= issue.getId() %>"
                   style="background:<%= isOpen ? "#059669" : "#f1f5f9" %>; color:<%= isOpen ? "#fff" : "#64748b" %>; border:<%= isOpen ? "none" : "1px solid #e2e8f0" %>; padding:5px 14px; border-radius:6px; font-size:11px; font-weight:600; cursor:pointer; font-family:'Inter',sans-serif; text-decoration:none; display:inline-block;">Manage</a>
              </td>
            </tr>
            <% } } %>
          </tbody>
        </table>

        <div style="padding:12px 18px; border-top:1px solid #f1f5f9; display:flex; align-items:center; justify-content:space-between;">
          <span style="font-size:12px; color:#94a3b8;">Page <%= currentPage %> of <%= totalPages %></span>
          <% if (totalPages > 1) { %>
          <div style="display:flex; gap:4px;">
            <% if (currentPage > 1) { %>
            <a href="<%= contextPath %>/municipality/issue-list?page=<%= currentPage - 1 %>" style="width:28px; height:28px; border-radius:6px; border:1px solid #e2e8f0; background:#fff; color:#94a3b8; font-size:11px; display:flex; align-items:center; justify-content:center; text-decoration:none;">&lsaquo;</a>
            <% } %>
            <% for (int p = Math.max(1, currentPage - 2); p <= Math.min(totalPages, currentPage + 2); p++) { %>
            <a href="<%= contextPath %>/municipality/issue-list?page=<%= p %>" style="width:28px; height:28px; border-radius:6px; border:<%= p == currentPage ? "none" : "1px solid #e2e8f0" %>; background:<%= p == currentPage ? "#0f172a" : "#fff" %>; color:<%= p == currentPage ? "#fff" : "#64748b" %>; font-size:12px; font-weight:<%= p == currentPage ? "700" : "400" %>; display:flex; align-items:center; justify-content:center; text-decoration:none;"><%= p %></a>
            <% } %>
            <% if (currentPage < totalPages) { %>
            <a href="<%= contextPath %>/municipality/issue-list?page=<%= currentPage + 1 %>" style="width:28px; height:28px; border-radius:6px; border:1px solid #e2e8f0; background:#fff; color:#94a3b8; font-size:11px; display:flex; align-items:center; justify-content:center; text-decoration:none;">&rsaquo;</a>
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
