<%--
  Citizen Dashboard — NagarSewa (live data)
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
  int inProgressReports = request.getAttribute("inProgressReports") != null ? (int) request.getAttribute("inProgressReports") : 0;
  int resolvedReports = request.getAttribute("resolvedReports") != null ? (int) request.getAttribute("resolvedReports") : 0;

  String userName = session.getAttribute("userName") != null ? session.getAttribute("userName").toString() : "Citizen";
  String userInitials = session.getAttribute("userInitials") != null ? session.getAttribute("userInitials").toString() : "CU";
%>

<div class="flex min-h-screen">
  <jsp:include page="../common/citizen-sidebar.jsp"/>

  <div class="flex-1" style="margin-left:220px; background:#f8fafc; min-height:100vh;">

    <div style="padding:18px 32px; display:flex; align-items:center; justify-content:space-between; border-bottom:1px solid #e2e8f0; background:#fff;">
      <div>
        <h1 style="font-family:'Outfit',sans-serif; font-size:20px; font-weight:700; color:#0f172a; margin:0;">
          Namaste, <%= userName %>
        </h1>
        <p style="font-size:13px; color:#64748b; margin:2px 0 0;">Live summary of your reported issues.</p>
      </div>
      <div style="width:34px; height:34px; border-radius:50%; background:#059669; display:flex; align-items:center; justify-content:center; color:#fff; font-size:12px; font-weight:700;">
        <%= userInitials %>
      </div>
    </div>

    <div style="padding:28px 32px;">

      <div style="display:grid; grid-template-columns:1fr 1fr 1fr; gap:16px; margin-bottom:28px;">
        <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:20px 22px;">
          <p style="font-size:12px; font-weight:600; color:#94a3b8; text-transform:uppercase; letter-spacing:1px; margin-bottom:10px;">My Reports</p>
          <span style="font-family:'Outfit',sans-serif; font-size:32px; font-weight:800; color:#0f172a;"><%= totalReports %></span>
        </div>
        <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:20px 22px;">
          <p style="font-size:12px; font-weight:600; color:#94a3b8; text-transform:uppercase; letter-spacing:1px; margin-bottom:10px;">In Progress</p>
          <span style="font-family:'Outfit',sans-serif; font-size:32px; font-weight:800; color:#f59e0b;"><%= inProgressReports %></span>
        </div>
        <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:20px 22px;">
          <p style="font-size:12px; font-weight:600; color:#94a3b8; text-transform:uppercase; letter-spacing:1px; margin-bottom:10px;">Resolved</p>
          <span style="font-family:'Outfit',sans-serif; font-size:32px; font-weight:800; color:#059669;"><%= resolvedReports %></span>
        </div>
      </div>

      <div style="display:grid; grid-template-columns:5fr 3fr; gap:20px;">

        <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; overflow:hidden;">
          <div style="padding:18px 22px 14px; display:flex; align-items:center; justify-content:space-between; border-bottom:1px solid #f1f5f9;">
            <h2 style="font-size:15px; font-weight:700; color:#0f172a;">Recent Reports</h2>
            <a href="<%= request.getContextPath() %>/citizen/my-issues" style="font-size:12px; color:#059669; text-decoration:none; font-weight:600;">View all →</a>
          </div>

          <% if (recentIssues.isEmpty()) { %>
            <div style="padding:28px 22px; font-size:13px; color:#94a3b8;">No reports found yet. Start by reporting your first issue.</div>
          <% } else { %>
            <% for (Issue issue : recentIssues) {
                 String st = issue.getStatus();
                 String bg = "#f1f5f9";
                 String fg = "#64748b";
                 if ("Open".equals(st)) { bg = "#fee2e2"; fg = "#991b1b"; }
                 else if ("In Progress".equals(st)) { bg = "#fef3c7"; fg = "#92400e"; }
                 else if ("Resolved".equals(st)) { bg = "#d1fae5"; fg = "#065f46"; }
            %>
              <div style="padding:14px 22px; display:flex; align-items:center; justify-content:space-between; border-bottom:1px solid #f8fafc;">
                <div>
                  <p style="font-size:14px; font-weight:600; margin:0;">
                    <a href="<%= request.getContextPath() %>/citizen/issue-detail?id=<%= issue.getId() %>" style="color:#1e293b; text-decoration:none;"><%= issue.getTitle() %></a>
                  </p>
                  <p style="font-size:12px; color:#94a3b8; margin:2px 0 0;">#<%= issue.getIssueId() %> · <%= issue.getCreatedAtShort() %> · Ward <%= issue.getWardNo() %></p>
                </div>
                <span style="padding:4px 10px; border-radius:6px; font-size:11px; font-weight:600; background:<%= bg %>; color:<%= fg %>;"><%= st %></span>
              </div>
            <% } %>
          <% } %>
        </div>

        <div style="display:flex; flex-direction:column; gap:16px;">
          <a href="<%= request.getContextPath() %>/citizen/report-issue" style="text-decoration:none; display:block; background:#059669; border-radius:10px; padding:24px; color:#fff; transition:background 0.2s;">
            <div style="display:flex; align-items:center; gap:12px; margin-bottom:10px;">
              <svg width="24" height="24" fill="none" stroke="#fff" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4"/></svg>
              <span style="font-family:'Outfit',sans-serif; font-size:17px; font-weight:700;">Report an Issue</span>
            </div>
            <p style="font-size:13px; color:rgba(255,255,255,0.75); line-height:1.5;">Found something broken in your area? Let the municipality know.</p>
          </a>

          <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:20px 22px;">
            <h3 style="font-size:13px; font-weight:700; color:#0f172a; margin-bottom:14px;">Status Overview</h3>
            <div style="display:flex; flex-direction:column; gap:10px;">
              <div style="display:flex; justify-content:space-between;"><span style="font-size:13px; color:#64748b;">Total reports</span><span style="font-size:13px; font-weight:600; color:#0f172a;"><%= totalReports %></span></div>
              <div style="display:flex; justify-content:space-between;"><span style="font-size:13px; color:#64748b;">In progress</span><span style="font-size:13px; font-weight:600; color:#f59e0b;"><%= inProgressReports %></span></div>
              <div style="display:flex; justify-content:space-between;"><span style="font-size:13px; color:#64748b;">Resolved</span><span style="font-size:13px; font-weight:600; color:#059669;"><%= resolvedReports %></span></div>
            </div>
          </div>

          <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:16px 18px;">
            <p style="font-size:12px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px; margin-bottom:10px;">Quick Links</p>
            <div style="display:flex; flex-direction:column; gap:6px;">
              <a href="<%= request.getContextPath() %>/citizen/my-issues" style="font-size:13px; color:#059669; text-decoration:none; font-weight:500;">My issue history →</a>
              <a href="<%= request.getContextPath() %>/citizen/profile" style="font-size:13px; color:#059669; text-decoration:none; font-weight:500;">Edit profile →</a>
              <a href="<%= request.getContextPath() %>/citizen/browse-issues" style="font-size:13px; color:#059669; text-decoration:none; font-weight:500;">Browse community issues →</a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>
