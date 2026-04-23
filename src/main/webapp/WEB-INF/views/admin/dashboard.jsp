<%--
  Admin Dashboard — NagarSewa (live data)
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.snaptheslop.snaptheslop.issue.model.Issue" %>
<% request.setAttribute("activePage", "dashboard"); %>
<jsp:include page="../common/header.jsp"/>
<%
  int totalCitizens = request.getAttribute("totalCitizens") != null ? (int) request.getAttribute("totalCitizens") : 0;
  int totalMunicipalities = request.getAttribute("totalMunicipalities") != null ? (int) request.getAttribute("totalMunicipalities") : 0;
  int totalIssues = request.getAttribute("totalIssues") != null ? (int) request.getAttribute("totalIssues") : 0;
  int resolutionRate = request.getAttribute("resolutionRate") != null ? (int) request.getAttribute("resolutionRate") : 0;
  int openIssues = request.getAttribute("openIssues") != null ? (int) request.getAttribute("openIssues") : 0;
  int inProgressIssues = request.getAttribute("inProgressIssues") != null ? (int) request.getAttribute("inProgressIssues") : 0;
  int resolvedIssues = request.getAttribute("resolvedIssues") != null ? (int) request.getAttribute("resolvedIssues") : 0;

  List<Issue> recentIssues = (List<Issue>) request.getAttribute("recentIssues");
  if (recentIssues == null) recentIssues = new java.util.ArrayList<>();
%>

<div class="flex min-h-screen">
  <jsp:include page="../common/admin-sidebar.jsp"/>

  <div class="flex-1" style="margin-left:220px; background:#f8fafc; min-height:100vh;">

    <div style="padding:18px 32px; display:flex; align-items:center; justify-content:space-between; border-bottom:1px solid #e2e8f0; background:#fff;">
      <div>
        <h1 style="font-family:'Outfit',sans-serif; font-size:20px; font-weight:700; color:#0f172a; margin:0;">System Admin</h1>
        <p style="font-size:13px; color:#64748b; margin:2px 0 0;">Live platform control over citizens, municipalities, and issues.</p>
      </div>
      <div style="display:flex; align-items:center; gap:10px;">
        <p style="font-size:12px; font-weight:600; color:#0f172a;">Admin</p>
        <div style="width:34px; height:34px; border-radius:50%; background:#059669; display:flex; align-items:center; justify-content:center; color:#fff; font-size:12px; font-weight:700;">SA</div>
      </div>
    </div>

    <div style="padding:28px 32px;">

      <div style="display:grid; grid-template-columns:1fr 1fr 1fr 1fr; gap:14px; margin-bottom:28px;">
        <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:18px 20px;">
          <p style="font-size:12px; font-weight:600; color:#94a3b8; margin-bottom:8px;">Citizens</p>
          <span style="font-family:'Outfit',sans-serif; font-size:28px; font-weight:800; color:#0f172a;"><%= totalCitizens %></span>
        </div>
        <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:18px 20px;">
          <p style="font-size:12px; font-weight:600; color:#94a3b8; margin-bottom:8px;">Municipalities</p>
          <span style="font-family:'Outfit',sans-serif; font-size:28px; font-weight:800; color:#0f172a;"><%= totalMunicipalities %></span>
        </div>
        <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:18px 20px;">
          <p style="font-size:12px; font-weight:600; color:#94a3b8; margin-bottom:8px;">Total Issues</p>
          <span style="font-family:'Outfit',sans-serif; font-size:28px; font-weight:800; color:#0f172a;"><%= totalIssues %></span>
        </div>
        <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:18px 20px;">
          <p style="font-size:12px; font-weight:600; color:#94a3b8; margin-bottom:8px;">Resolution Rate</p>
          <span style="font-family:'Outfit',sans-serif; font-size:28px; font-weight:800; color:#059669;"><%= resolutionRate %>%</span>
        </div>
      </div>

      <div style="display:grid; grid-template-columns:1fr 1fr 1fr; gap:16px; margin-bottom:20px;">
        <a href="<%= request.getContextPath() %>/admin/users" style="text-decoration:none; display:flex; align-items:center; gap:14px; background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:20px;">
          <div style="width:40px; height:40px; border-radius:8px; background:#d1fae5; display:flex; align-items:center; justify-content:center; flex-shrink:0;">
            <svg width="18" height="18" fill="#059669" viewBox="0 0 20 20"><path d="M9 6a3 3 0 11-6 0 3 3 0 016 0zM17 6a3 3 0 11-6 0 3 3 0 016 0zM12.93 17c.046-.327.07-.66.07-1a6.97 6.97 0 00-1.5-4.33A5 5 0 0119 16v1h-6.07zM6 11a5 5 0 015 5v1H1v-1a5 5 0 015-5z"/></svg>
          </div>
          <div>
            <p style="font-size:14px; font-weight:700; color:#0f172a;">Citizens</p>
            <p style="font-size:12px; color:#64748b;">Browse and manage citizens</p>
          </div>
        </a>

        <a href="<%= request.getContextPath() %>/admin/municipalities" style="text-decoration:none; display:flex; align-items:center; gap:14px; background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:20px;">
          <div style="width:40px; height:40px; border-radius:8px; background:#d1fae5; display:flex; align-items:center; justify-content:center; flex-shrink:0;">
            <svg width="18" height="18" fill="none" stroke="#059669" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M3 21h18M5 21V7l7-4 7 4v14"/></svg>
          </div>
          <div>
            <p style="font-size:14px; font-weight:700; color:#0f172a;">Municipalities</p>
            <p style="font-size:12px; color:#64748b;">Add and manage municipality admins</p>
          </div>
        </a>

        <a href="<%= request.getContextPath() %>/admin/manage-issues" style="text-decoration:none; display:flex; align-items:center; gap:14px; background:#059669; border:1px solid #059669; border-radius:10px; padding:20px;">
          <div style="width:40px; height:40px; border-radius:8px; background:rgba(255,255,255,0.18); display:flex; align-items:center; justify-content:center; flex-shrink:0;">
            <svg width="18" height="18" fill="none" stroke="#ffffff" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/></svg>
          </div>
          <div>
            <p style="font-size:14px; font-weight:700; color:#ffffff;">Manage Issues</p>
            <p style="font-size:12px; color:rgba(255,255,255,0.82);"><%= openIssues %> open issues pending action</p>
          </div>
        </a>
      </div>

      <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; overflow:hidden; margin-bottom:16px;">
        <div style="padding:16px 20px; border-bottom:1px solid #f1f5f9;"><h2 style="font-size:15px; font-weight:700; color:#0f172a;">Issue Status Snapshot</h2></div>
        <div style="padding:14px 20px; display:grid; grid-template-columns:1fr 1fr 1fr; gap:16px;">
          <div style="padding:12px; border:1px solid #fee2e2; border-radius:8px; background:#fff7f7;"><p style="font-size:12px; color:#991b1b;">Open</p><p style="font-size:20px; font-weight:800; color:#991b1b;"><%= openIssues %></p></div>
          <div style="padding:12px; border:1px solid #fef3c7; border-radius:8px; background:#fffbeb;"><p style="font-size:12px; color:#92400e;">In Progress</p><p style="font-size:20px; font-weight:800; color:#92400e;"><%= inProgressIssues %></p></div>
          <div style="padding:12px; border:1px solid #d1fae5; border-radius:8px; background:#ecfdf5;"><p style="font-size:12px; color:#065f46;">Resolved</p><p style="font-size:20px; font-weight:800; color:#065f46;"><%= resolvedIssues %></p></div>
        </div>
      </div>

      <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; overflow:hidden;">
        <div style="padding:16px 20px; border-bottom:1px solid #f1f5f9;"><h2 style="font-size:15px; font-weight:700; color:#0f172a;">Recent Reported Issues</h2></div>
        <% if (recentIssues.isEmpty()) { %>
          <div style="padding:16px 20px; color:#94a3b8; font-size:13px;">No issue reports found yet.</div>
        <% } else {
             for (Issue issue : recentIssues) {
               String st = issue.getStatus();
               String dot = "#64748b";
               if ("Open".equals(st)) dot = "#dc2626";
               else if ("In Progress".equals(st)) dot = "#d97706";
               else if ("Resolved".equals(st)) dot = "#059669";
        %>
          <div style="padding:12px 20px; border-bottom:1px solid #f8fafc; display:flex; align-items:center; gap:10px;">
            <div style="width:6px; height:6px; border-radius:50%; background:<%= dot %>;"></div>
            <p style="font-size:13px; color:#1e293b; flex:1;">
              <strong>#<%= issue.getIssueId() %></strong> · <%= issue.getTitle() %> · <%= issue.getMunicipalityName() != null ? issue.getMunicipalityName() : "Unknown municipality" %> · Ward <%= issue.getWardNo() %>
            </p>
            <span style="font-size:11px; color:#94a3b8;"><%= issue.getCreatedAtShort() %></span>
          </div>
        <%   }
           } %>
      </div>
    </div>
  </div>
</div>
</body>
</html>
