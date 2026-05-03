<%--
  My Issues — NagarSewa  (Sprint 5: live DB data)
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.snaptheslop.snaptheslop.issue.model.Issue, java.util.List" %>
<jsp:include page="../common/header.jsp"/>
<%
  List<Issue> issues        = (List<Issue>) request.getAttribute("issues");
  String statusFilter       = (String)      request.getAttribute("statusFilter");
  String keywordFilter      = (String)      request.getAttribute("keywordFilter");
  int currentPage           = request.getAttribute("currentPage")    != null ? (int) request.getAttribute("currentPage")    : 1;
  int totalPages            = request.getAttribute("totalPages")     != null ? (int) request.getAttribute("totalPages")     : 1;
  int totalCount            = request.getAttribute("totalCount")     != null ? (int) request.getAttribute("totalCount")     : 0;
  int countAll              = request.getAttribute("countAll")       != null ? (int) request.getAttribute("countAll")       : 0;
  int countOpen             = request.getAttribute("countOpen")      != null ? (int) request.getAttribute("countOpen")      : 0;
  int countInProgress       = request.getAttribute("countInProgress")!= null ? (int) request.getAttribute("countInProgress"): 0;
  int countResolved         = request.getAttribute("countResolved")  != null ? (int) request.getAttribute("countResolved")  : 0;
  String successMessage     = (String)      request.getAttribute("successMessage");
  String contextPath        = request.getContextPath();
  if (issues == null) issues = new java.util.ArrayList<>();
%>

<div class="flex min-h-screen">
  <jsp:include page="../common/citizen-sidebar.jsp"/>

  <div class="flex-1" style="margin-left:220px; background:#f8fafc; min-height:100vh;">

    <!-- Topbar -->
    <div style="padding:18px 32px; display:flex; align-items:center; justify-content:space-between; border-bottom:1px solid #e2e8f0; background:#fff;">
      <h1 style="font-family:'Outfit',sans-serif; font-size:18px; font-weight:700; color:#0f172a;">My Issue Reports</h1>
      <a href="<%= contextPath %>/citizen/report-issue" style="display:inline-flex; align-items:center; gap:6px; background:#059669; color:#fff; padding:9px 18px; border-radius:8px; font-size:13px; font-weight:600; text-decoration:none;">
        <span style="font-size:16px; line-height:1;">+</span> New Report
      </a>
    </div>

    <div style="padding:28px 32px;">

      <!-- Success banner -->
      <% if (successMessage != null) { %>
      <div style="background:#d1fae5; border:1px solid #6ee7b7; border-radius:8px; padding:12px 18px; margin-bottom:20px; font-size:13px; color:#065f46; font-weight:500;">
        ✓ <%= successMessage %>
      </div>
      <% } %>

      <!-- Filter tabs -->
      <form method="get" action="<%= contextPath %>/citizen/my-issues" style="display:flex; gap:8px; margin-bottom:14px; flex-wrap:wrap; align-items:center;">
        <input type="text" name="keyword" placeholder="Search title or category" value="<%= keywordFilter != null ? keywordFilter : "" %>" style="height:36px; width:min(100%, 280px); border:1px solid #e2e8f0; border-radius:6px; padding:0 10px; font-size:13px;"/>
        <% if (statusFilter != null) { %><input type="hidden" name="status" value="<%= statusFilter %>"/><% } %>
        <button type="submit" style="height:36px; padding:0 14px; border:none; border-radius:6px; background:#059669; color:#fff; font-size:13px; font-weight:600; cursor:pointer;">Search</button>
      </form>

      <div style="display:flex; gap:6px; margin-bottom:24px; flex-wrap:wrap;">
        <a href="<%= contextPath %>/citizen/my-issues<%= keywordFilter != null ? "?keyword=" + java.net.URLEncoder.encode(keywordFilter, "UTF-8") : "" %>" style="padding:7px 16px; border-radius:6px; font-size:13px; font-weight:600; text-decoration:none; <%= (statusFilter == null) ? "background:#0f172a; color:#fff; border:none;" : "border:1px solid #e2e8f0; background:#fff; color:#64748b;" %>">All (<%= countAll %>)</a>
        <a href="<%= contextPath %>/citizen/my-issues?status=Open<%= keywordFilter != null ? "&keyword=" + java.net.URLEncoder.encode(keywordFilter, "UTF-8") : "" %>" style="padding:7px 16px; border-radius:6px; font-size:13px; font-weight:600; text-decoration:none; <%= "Open".equals(statusFilter) ? "background:#0f172a; color:#fff; border:none;" : "border:1px solid #e2e8f0; background:#fff; color:#64748b;" %>">Open (<%= countOpen %>)</a>
        <a href="<%= contextPath %>/citizen/my-issues?status=In+Progress<%= keywordFilter != null ? "&keyword=" + java.net.URLEncoder.encode(keywordFilter, "UTF-8") : "" %>" style="padding:7px 16px; border-radius:6px; font-size:13px; font-weight:600; text-decoration:none; <%= "In Progress".equals(statusFilter) ? "background:#0f172a; color:#fff; border:none;" : "border:1px solid #e2e8f0; background:#fff; color:#64748b;" %>">In Progress (<%= countInProgress %>)</a>
        <a href="<%= contextPath %>/citizen/my-issues?status=Resolved<%= keywordFilter != null ? "&keyword=" + java.net.URLEncoder.encode(keywordFilter, "UTF-8") : "" %>" style="padding:7px 16px; border-radius:6px; font-size:13px; font-weight:600; text-decoration:none; <%= "Resolved".equals(statusFilter) ? "background:#0f172a; color:#fff; border:none;" : "border:1px solid #e2e8f0; background:#fff; color:#64748b;" %>">Resolved (<%= countResolved %>)</a>
      </div>

      <!-- Issues Table -->
      <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; overflow:hidden;">
        <table style="width:100%; border-collapse:collapse;">
          <thead>
            <tr style="border-bottom:1px solid #f1f5f9;">
              <th style="text-align:left; padding:12px 20px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Issue</th>
              <th style="text-align:left; padding:12px 16px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Category</th>
              <th style="text-align:left; padding:12px 16px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Status</th>
              <th style="text-align:left; padding:12px 16px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Priority</th>
              <th style="text-align:left; padding:12px 16px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Filed</th>
              <th style="text-align:left; padding:12px 16px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Upvotes</th>
              <th style="text-align:left; padding:12px 16px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Actions</th>
              <th style="text-align:right; padding:12px 20px;"></th>
            </tr>
          </thead>
          <tbody>
            <% if (issues.isEmpty()) { %>
            <tr>
              <td colspan="8" style="padding:40px 20px; text-align:center; color:#94a3b8; font-size:14px;">
                You haven't reported any issues yet. <a href="<%= contextPath %>/citizen/report-issue" style="color:#059669; font-weight:600; text-decoration:none;">Report one now →</a>
              </td>
            </tr>
            <% } else { for (Issue issue : issues) {
                String st = issue.getStatus();
                String statusBg, statusFg;
                if ("Open".equals(st))           { statusBg="#fee2e2"; statusFg="#991b1b"; }
                else if ("In Progress".equals(st)){ statusBg="#d1fae5"; statusFg="#065f46"; }
                else if ("Resolved".equals(st))  { statusBg="#dcfce7"; statusFg="#166534"; }
                else if ("Rejected".equals(st))  { statusBg="#f1f5f9"; statusFg="#64748b"; }
                else                             { statusBg="#fef3c7"; statusFg="#92400e"; }

                String pr = issue.getPriority();
                String priorBg, priorFg;
                if ("High".equals(pr)||"Critical".equals(pr)) { priorBg="#fee2e2"; priorFg="#991b1b"; }
                else if ("Low".equals(pr))                    { priorBg="#f0fdf4"; priorFg="#166534"; }
                else                                          { priorBg="#fef9c3"; priorFg="#854d0e"; }
            %>
            <tr style="border-bottom:1px solid #f8fafc; transition:background 0.15s;" onmouseover="this.style.background='#fafbfc'" onmouseout="this.style.background='transparent'">
              <td style="padding:14px 20px;">
                <p style="font-size:14px; font-weight:600; color:#1e293b; margin:0;"><%= issue.getTitle() %></p>
                <p style="font-size:12px; color:#94a3b8; margin:2px 0 0;">#<%= issue.getIssueId() %> · Ward <%= issue.getWardNo() %></p>
              </td>
              <td style="padding:14px 16px;"><span style="font-size:12px; color:#64748b;"><%= issue.getCategory() != null ? issue.getCategory() : "—" %></span></td>
              <td style="padding:14px 16px;">
                <span style="padding:3px 10px; border-radius:99px; font-size:11px; font-weight:600; background:<%= statusBg %>; color:<%= statusFg %>;"><%= st %></span>
              </td>
              <td style="padding:14px 16px;">
                <span style="padding:3px 10px; border-radius:99px; font-size:11px; font-weight:600; background:<%= priorBg %>; color:<%= priorFg %>;"><%= pr != null ? pr : "Medium" %></span>
              </td>
              <td style="padding:14px 16px; font-size:12px; color:#94a3b8;"><%= issue.getCreatedAtShort() %></td>
              <td style="padding:14px 16px; font-size:13px; font-weight:600; color:#64748b;"><%= issue.getUpvoteCount() %></td>
              <td style="padding:14px 16px;">
                <div style="display:flex; gap:8px; flex-wrap:wrap;">
                  <a href="<%= contextPath %>/citizen/issue-edit?id=<%= issue.getId() %>" style="display:inline-flex; align-items:center; justify-content:center; padding:6px 12px; border-radius:6px; background:#059669; color:#fff; font-size:11px; font-weight:700; text-decoration:none;">Edit</a>
                  <form action="<%= contextPath %>/citizen/issue-delete" method="post" onsubmit="return confirm('Delete this report permanently?');" style="margin:0; display:inline-flex;">
                    <input type="hidden" name="issueId" value="<%= issue.getId() %>"/>
                    <button type="submit" style="padding:6px 12px; border-radius:6px; background:#fff; color:#b91c1c; border:1px solid #fecaca; font-size:11px; font-weight:700; cursor:pointer;">Delete</button>
                  </form>
                </div>
              </td>
              <td style="padding:14px 20px; text-align:right;">
                <a href="<%= contextPath %>/citizen/issue-detail?id=<%= issue.getId() %>" style="font-size:12px; color:#059669; font-weight:600; text-decoration:none;">View →</a>
              </td>
            </tr>
            <% } } %>
          </tbody>
        </table>

        <div style="padding:12px 20px; border-top:1px solid #f1f5f9; display:flex; align-items:center; justify-content:space-between;">
          <span style="font-size:12px; color:#94a3b8;">Showing <%= issues.size() %> of <%= totalCount %> reports</span>
          <% if (totalPages > 1) { %>
          <div style="display:flex; gap:4px;">
            <% if (currentPage > 1) { %>
            <a href="<%= contextPath %>/citizen/my-issues?page=<%= currentPage - 1 %><%= statusFilter != null ? "&status=" + java.net.URLEncoder.encode(statusFilter, "UTF-8") : "" %><%= keywordFilter != null ? "&keyword=" + java.net.URLEncoder.encode(keywordFilter, "UTF-8") : "" %>" style="width:30px; height:30px; border-radius:6px; border:1px solid #e2e8f0; background:#fff; color:#64748b; font-size:12px; display:flex; align-items:center; justify-content:center; text-decoration:none;">&lsaquo;</a>
            <% } %>
            <% for (int p = 1; p <= totalPages; p++) { %>
            <a href="<%= contextPath %>/citizen/my-issues?page=<%= p %><%= statusFilter != null ? "&status=" + java.net.URLEncoder.encode(statusFilter, "UTF-8") : "" %><%= keywordFilter != null ? "&keyword=" + java.net.URLEncoder.encode(keywordFilter, "UTF-8") : "" %>" style="width:30px; height:30px; border-radius:6px; border:<%= p == currentPage ? "none" : "1px solid #e2e8f0" %>; background:<%= p == currentPage ? "#0f172a" : "#fff" %>; color:<%= p == currentPage ? "#fff" : "#64748b" %>; font-size:12px; font-weight:<%= p == currentPage ? "700" : "400" %>; display:flex; align-items:center; justify-content:center; text-decoration:none;"><%= p %></a>
            <% } %>
            <% if (currentPage < totalPages) { %>
            <a href="<%= contextPath %>/citizen/my-issues?page=<%= currentPage + 1 %><%= statusFilter != null ? "&status=" + java.net.URLEncoder.encode(statusFilter, "UTF-8") : "" %><%= keywordFilter != null ? "&keyword=" + java.net.URLEncoder.encode(keywordFilter, "UTF-8") : "" %>" style="width:30px; height:30px; border-radius:6px; border:1px solid #e2e8f0; background:#fff; color:#64748b; font-size:12px; display:flex; align-items:center; justify-content:center; text-decoration:none;">&rsaquo;</a>
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
