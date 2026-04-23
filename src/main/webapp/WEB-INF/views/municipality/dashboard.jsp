<%--
  Municipality Dashboard — NagarSewa (live data)
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.snaptheslop.snaptheslop.issue.model.Issue" %>
<% request.setAttribute("activePage", "dashboard"); %>
<jsp:include page="../common/header.jsp"/>
<%
  List<Issue> recentIssues = (List<Issue>) request.getAttribute("recentIssues");
  if (recentIssues == null) recentIssues = new java.util.ArrayList<>();

  int totalReports = request.getAttribute("totalReports") != null ? (int) request.getAttribute("totalReports") : 0;
  int openReports = request.getAttribute("openReports") != null ? (int) request.getAttribute("openReports") : 0;
  int inProgressReports = request.getAttribute("inProgressReports") != null ? (int) request.getAttribute("inProgressReports") : 0;
  int resolvedReports = request.getAttribute("resolvedReports") != null ? (int) request.getAttribute("resolvedReports") : 0;

  String userName = session.getAttribute("userName") != null ? session.getAttribute("userName").toString() : "Municipality User";
%>

<div class="flex min-h-screen">
  <jsp:include page="../common/municipality-sidebar.jsp"/>

  <div class="flex-1" style="margin-left:220px; background:#f8fafc; min-height:100vh;">

    <div style="padding:18px 32px; display:flex; align-items:center; justify-content:space-between; border-bottom:1px solid #e2e8f0; background:#fff;">
      <div>
        <h1 style="font-family:'Outfit',sans-serif; font-size:20px; font-weight:700; color:#0f172a; margin:0;">Municipality Dashboard</h1>
        <p style="font-size:13px; color:#64748b; margin:2px 0 0;">Real-time reports for your municipality.</p>
      </div>
      <div style="display:flex; align-items:center; gap:10px;">
        <div style="text-align:right;">
          <p style="font-size:12px; font-weight:600; color:#0f172a;"><%= userName %></p>
          <p style="font-size:11px; color:#94a3b8;">Municipality Head</p>
        </div>
      </div>
    </div>

    <div style="padding:28px 32px;">

      <div style="display:grid; grid-template-columns:1fr 1fr 1fr 1fr; gap:14px; margin-bottom:28px;">
        <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:18px 20px;">
          <p style="font-size:12px; font-weight:600; color:#94a3b8; margin-bottom:8px;">Total Reports</p>
          <span style="font-family:'Outfit',sans-serif; font-size:28px; font-weight:800; color:#0f172a;"><%= totalReports %></span>
        </div>
        <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:18px 20px;">
          <p style="font-size:12px; font-weight:600; color:#94a3b8; margin-bottom:8px;">Open</p>
          <span style="font-family:'Outfit',sans-serif; font-size:28px; font-weight:800; color:#dc2626;"><%= openReports %></span>
        </div>
        <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:18px 20px;">
          <p style="font-size:12px; font-weight:600; color:#94a3b8; margin-bottom:8px;">In Progress</p>
          <span style="font-family:'Outfit',sans-serif; font-size:28px; font-weight:800; color:#0d9488;"><%= inProgressReports %></span>
        </div>
        <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:18px 20px;">
          <p style="font-size:12px; font-weight:600; color:#94a3b8; margin-bottom:8px;">Resolved</p>
          <span style="font-family:'Outfit',sans-serif; font-size:28px; font-weight:800; color:#059669;"><%= resolvedReports %></span>
        </div>
      </div>

      <div style="display:grid; grid-template-columns:5fr 3fr; gap:20px;">

        <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; overflow:hidden;">
          <div style="padding:16px 20px; border-bottom:1px solid #f1f5f9; display:flex; justify-content:space-between; align-items:center;">
            <h2 style="font-size:15px; font-weight:700; color:#0f172a; margin:0;">Latest Municipality Reports</h2>
            <a href="<%= request.getContextPath() %>/municipality/issue-list" style="font-size:12px; color:#059669; text-decoration:none; font-weight:600;">View all →</a>
          </div>

          <% if (recentIssues.isEmpty()) { %>
            <div style="padding:22px 20px; color:#94a3b8; font-size:13px;">No reports found for your municipality yet.</div>
          <% } else { %>
            <% for (Issue issue : recentIssues) {
                 String st = issue.getStatus();
                 String bg = "#f1f5f9";
                 String fg = "#64748b";
                 if ("Open".equals(st)) { bg = "#fee2e2"; fg = "#991b1b"; }
                 else if ("In Progress".equals(st)) { bg = "#fef3c7"; fg = "#92400e"; }
                 else if ("Resolved".equals(st)) { bg = "#d1fae5"; fg = "#065f46"; }
            %>
            <div style="padding:12px 20px; border-bottom:1px solid #f8fafc; display:flex; align-items:center; justify-content:space-between; gap:12px;">
              <div>
                <p style="font-size:13px; font-weight:600; color:#1e293b; margin:0;"><%= issue.getTitle() %></p>
                <p style="font-size:11px; color:#94a3b8; margin:2px 0 0;">#<%= issue.getIssueId() %> · Ward <%= String.format("%02d", issue.getWardNo()) %> · <%= issue.getCreatedAtShort() %></p>
              </div>
              <span style="padding:3px 10px; border-radius:99px; font-size:11px; font-weight:600; background:<%= bg %>; color:<%= fg %>;"><%= st %></span>
            </div>
            <% } %>
          <% } %>
        </div>

        <div style="display:flex; flex-direction:column; gap:16px;">
          <a href="<%= request.getContextPath() %>/municipality/issue-list" style="display:block; background:#059669; border-radius:10px; padding:20px; color:#fff; text-decoration:none;">
            <p style="font-family:'Outfit',sans-serif; font-size:16px; font-weight:700; margin:0 0 4px;">Manage Issues</p>
            <p style="font-size:13px; color:rgba(255,255,255,0.78); margin:0;"><%= openReports %> open reports need action →</p>
          </a>

          <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:16px 18px;">
            <p style="font-size:12px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px; margin-bottom:10px;">Status Breakdown</p>
            <div style="display:flex; flex-direction:column; gap:8px;">
              <div style="display:flex; justify-content:space-between;"><span style="font-size:13px; color:#64748b;">Open</span><span style="font-size:13px; font-weight:600; color:#dc2626;"><%= openReports %></span></div>
              <div style="display:flex; justify-content:space-between;"><span style="font-size:13px; color:#64748b;">In Progress</span><span style="font-size:13px; font-weight:600; color:#0d9488;"><%= inProgressReports %></span></div>
              <div style="display:flex; justify-content:space-between;"><span style="font-size:13px; color:#64748b;">Resolved</span><span style="font-size:13px; font-weight:600; color:#059669;"><%= resolvedReports %></span></div>
              <div style="display:flex; justify-content:space-between;"><span style="font-size:13px; color:#64748b;">Total</span><span style="font-size:13px; font-weight:600; color:#0f172a;"><%= totalReports %></span></div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>
