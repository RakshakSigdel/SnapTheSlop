<%--
  Browse Community Issues — NagarSewa  (Sprint 5: live DB data)
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.snaptheslop.snaptheslop.issue.model.Issue,
                 com.snaptheslop.snaptheslop.municipality.model.Municipality,
                 java.util.List" %>
<jsp:include page="../common/header.jsp"/>
<%
  List<Issue>        issues         = (List<Issue>)        request.getAttribute("issues");
  List<Municipality> municipalities = (List<Municipality>) request.getAttribute("municipalities");
  String categoryFilter    = (String) request.getAttribute("categoryFilter");
  String municipalityFilter= (String) request.getAttribute("municipalityFilter");
  String wardFilter        = (String) request.getAttribute("wardFilter");
  String statusFilter      = (String) request.getAttribute("statusFilter");
  String contextPath       = request.getContextPath();
  if (issues == null) issues = new java.util.ArrayList<>();
  if (municipalities == null) municipalities = new java.util.ArrayList<>();
%>

<div class="flex min-h-screen">
  <jsp:include page="../common/citizen-sidebar.jsp"/>

  <div class="flex-1" style="margin-left:220px; background:#f8fafc; min-height:100vh;">
    <div style="padding:18px 32px; display:flex; align-items:center; justify-content:space-between; border-bottom:1px solid #e2e8f0; background:#fff;">
      <div>
        <h1 style="font-family:'Outfit',sans-serif; font-size:20px; font-weight:700; color:#0f172a; margin:0;">Browse Community Issues</h1>
        <p style="font-size:13px; color:#64748b; margin:2px 0 0;">Explore reports from other citizens and track civic progress.</p>
      </div>
    </div>

    <div style="padding:28px 32px;">
      <!-- Server-side filter form -->
      <form method="get" action="<%= contextPath %>/citizen/browse-issues">
        <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:16px; margin-bottom:16px; display:grid; grid-template-columns:1fr 1fr 1fr 1fr auto; gap:10px; align-items:center;">

          <select name="category" style="height:40px; border:1.5px solid #e5e7eb; border-radius:8px; padding:0 10px; font-size:13px; color:#111827; background:#fff; outline:none;">
            <option value="">All Categories</option>
            <option value="Roads"      <%= "Roads".equals(categoryFilter)      ? "selected" : "" %>>Roads</option>
            <option value="Sanitation" <%= "Sanitation".equals(categoryFilter) ? "selected" : "" %>>Sanitation</option>
            <option value="Water"      <%= "Water".equals(categoryFilter)      ? "selected" : "" %>>Water</option>
            <option value="Electrical" <%= "Electrical".equals(categoryFilter) ? "selected" : "" %>>Electrical</option>
            <option value="Drainage"   <%= "Drainage".equals(categoryFilter)   ? "selected" : "" %>>Drainage</option>
          </select>

          <select name="municipalityId" style="height:40px; border:1.5px solid #e5e7eb; border-radius:8px; padding:0 10px; font-size:13px; color:#111827; background:#fff; outline:none;">
            <option value="">All Municipalities</option>
            <% for (Municipality m : municipalities) { %>
            <option value="<%= m.getId() %>" <%= String.valueOf(m.getId()).equals(municipalityFilter) ? "selected" : "" %>><%= m.getName() %></option>
            <% } %>
          </select>

          <select name="ward" style="height:40px; border:1.5px solid #e5e7eb; border-radius:8px; padding:0 10px; font-size:13px; color:#111827; background:#fff; outline:none;">
            <option value="">All Wards</option>
            <% for (int w = 1; w <= 32; w++) { %>
            <option value="<%= w %>" <%= String.valueOf(w).equals(wardFilter) ? "selected" : "" %>>Ward <%= String.format("%02d", w) %></option>
            <% } %>
          </select>

          <select name="status" style="height:40px; border:1.5px solid #e5e7eb; border-radius:8px; padding:0 10px; font-size:13px; color:#111827; background:#fff; outline:none;">
            <option value="">All Statuses</option>
            <option value="Open"        <%= "Open".equals(statusFilter)        ? "selected" : "" %>>Open</option>
            <option value="In Progress" <%= "In Progress".equals(statusFilter) ? "selected" : "" %>>In Progress</option>
            <option value="Resolved"    <%= "Resolved".equals(statusFilter)    ? "selected" : "" %>>Resolved</option>
          </select>

          <button type="submit" style="height:40px; padding:0 18px; background:#059669; color:#fff; border:none; border-radius:8px; font-size:13px; font-weight:600; cursor:pointer; font-family:'Inter',sans-serif;">Filter</button>
        </div>
      </form>

      <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; overflow:hidden;">
        <table style="width:100%; border-collapse:collapse;">
          <thead>
            <tr style="border-bottom:1px solid #f1f5f9;">
              <th style="text-align:left; padding:12px 18px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Issue</th>
              <th style="text-align:left; padding:12px 18px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Category</th>
              <th style="text-align:left; padding:12px 18px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Municipality</th>
              <th style="text-align:left; padding:12px 18px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Ward</th>
              <th style="text-align:left; padding:12px 18px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Status</th>
              <th style="text-align:right; padding:12px 18px;"></th>
            </tr>
          </thead>
          <tbody>
            <% if (issues.isEmpty()) { %>
            <tr>
              <td colspan="6" style="padding:40px; text-align:center; color:#94a3b8; font-size:14px;">No issues found matching your filters.</td>
            </tr>
            <% } else { for (Issue issue : issues) {
                String st = issue.getStatus();
                String bg, fg;
                if ("Open".equals(st))            { bg="#fee2e2"; fg="#991b1b"; }
                else if ("In Progress".equals(st)){ bg="#d1fae5"; fg="#065f46"; }
                else if ("Resolved".equals(st))   { bg="#dcfce7"; fg="#166534"; }
                else if ("Rejected".equals(st))   { bg="#f1f5f9"; fg="#64748b"; }
                else                              { bg="#fef3c7"; fg="#92400e"; }
            %>
            <tr style="border-bottom:1px solid #f8fafc;" onmouseover="this.style.background='#fafbfc'" onmouseout="this.style.background='transparent'">
              <td style="padding:14px 18px;">
                <p style="font-size:13px; font-weight:600; color:#1e293b; margin:0;"><%= issue.getTitle() %></p>
                <p style="font-size:11px; color:#94a3b8; margin:2px 0 0;">#<%= issue.getIssueId() %></p>
              </td>
              <td style="padding:14px 18px; font-size:12px; color:#64748b;"><%= issue.getCategory() != null ? issue.getCategory() : "—" %></td>
              <td style="padding:14px 18px; font-size:12px; color:#64748b;"><%= issue.getMunicipalityName() != null ? issue.getMunicipalityName() : "—" %></td>
              <td style="padding:14px 18px; font-size:12px; color:#64748b;">Ward <%= String.format("%02d", issue.getWardNo()) %></td>
              <td style="padding:14px 18px;"><span style="padding:3px 9px; border-radius:99px; font-size:11px; font-weight:600; background:<%= bg %>; color:<%= fg %>;"><%= st %></span></td>
              <td style="padding:14px 18px; text-align:right;"><a href="<%= contextPath %>/citizen/issue-detail?id=<%= issue.getId() %>" style="font-size:12px; color:#059669; font-weight:600; text-decoration:none;">View →</a></td>
            </tr>
            <% } } %>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>
</body>
</html>
