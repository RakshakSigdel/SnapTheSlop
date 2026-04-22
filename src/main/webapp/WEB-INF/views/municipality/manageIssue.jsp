<%--
  Municipality Manage Issue — NagarSewa  (Sprint 5: live DB data + status transitions)
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.snaptheslop.snaptheslop.issue.model.Issue" %>
<% request.setAttribute("activePage", "issue-reports"); %>
<jsp:include page="../common/header.jsp"/>
<%
  Issue issue          = (Issue)  request.getAttribute("issue");
  String reportImageUrl= (String) request.getAttribute("reportImageUrl");
  String contextPath   = request.getContextPath();
  if (issue == null) { response.sendRedirect(contextPath + "/municipality/issue-list"); return; }
  String currentStatus   = issue.getStatus()   != null ? issue.getStatus()   : "Open";
  String currentPriority = issue.getPriority() != null ? issue.getPriority() : "Medium";
%>

<div class="flex min-h-screen">
  <jsp:include page="../common/municipality-sidebar.jsp"/>

  <div class="flex-1" style="margin-left:220px; background:#f8fafc; min-height:100vh;">
    <div style="padding:18px 32px; display:flex; align-items:center; justify-content:space-between; border-bottom:1px solid #e2e8f0; background:#fff;">
      <div>
        <h1 style="font-family:'Outfit',sans-serif; font-size:20px; font-weight:700; color:#0f172a; margin:0;">Manage Issue #<%= issue.getIssueId() %></h1>
        <p style="font-size:13px; color:#64748b; margin:2px 0 0;">Review issue details, assign resources, and update status.</p>
      </div>
      <a href="<%= contextPath %>/municipality/issue-list" style="padding:8px 14px; border-radius:7px; font-size:12px; font-weight:600; border:1px solid #e2e8f0; background:#fff; color:#64748b; text-decoration:none;">Back to Issue List</a>
    </div>

    <div style="padding:28px 32px;">
      <div style="display:grid; grid-template-columns:2fr 1fr; gap:16px;">

        <!-- Left: Issue form -->
        <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:20px;">
          <h2 style="font-size:16px; font-weight:700; color:#0f172a; margin:0 0 12px;">Issue Details</h2>
          <div style="display:grid; grid-template-columns:1fr 1fr; gap:12px; margin-bottom:14px;">
            <div><p style="font-size:12px; color:#94a3b8; margin:0 0 4px;">Title</p><p style="font-size:14px; color:#1f2937; font-weight:600; margin:0;"><%= issue.getTitle() %></p></div>
            <div><p style="font-size:12px; color:#94a3b8; margin:0 0 4px;">Category</p><p style="font-size:14px; color:#1f2937; font-weight:600; margin:0;"><%= issue.getCategory() != null ? issue.getCategory() : "—" %></p></div>
            <div><p style="font-size:12px; color:#94a3b8; margin:0 0 4px;">Ward</p><p style="font-size:14px; color:#1f2937; font-weight:600; margin:0;">Ward <%= String.format("%02d", issue.getWardNo()) %></p></div>
            <div><p style="font-size:12px; color:#94a3b8; margin:0 0 4px;">Upvotes</p><p style="font-size:14px; color:#1f2937; font-weight:600; margin:0;"><%= issue.getUpvoteCount() %></p></div>
            <div><p style="font-size:12px; color:#94a3b8; margin:0 0 4px;">Location</p><p style="font-size:14px; color:#1f2937; font-weight:600; margin:0;"><%= issue.getLocation() != null ? issue.getLocation() : "—" %></p></div>
            <div><p style="font-size:12px; color:#94a3b8; margin:0 0 4px;">Reported on</p><p style="font-size:14px; color:#1f2937; font-weight:600; margin:0;"><%= issue.getCreatedAtFormatted() %></p></div>
          </div>

          <div style="margin-bottom:16px;">
            <p style="font-size:12px; color:#94a3b8; margin:0 0 4px;">Description</p>
            <p style="font-size:13px; color:#334155; line-height:1.6; margin:0;"><%= issue.getDescription() != null ? issue.getDescription() : "No description." %></p>
          </div>

          <!-- Status transition form (Sprint 5 Task 4 & 5) -->
          <form method="post" action="<%= contextPath %>/municipality/manage-issue">
            <input type="hidden" name="issueId" value="<%= issue.getId() %>"/>

            <!-- Status transition note -->
            <div style="background:#fffbeb; border:1px solid #fde68a; border-radius:8px; padding:10px 14px; margin-bottom:14px; font-size:12px; color:#92400e;">
              <strong>Status flow:</strong> Open → In Progress → Resolved / Rejected. Resolved and Rejected issues cannot be changed further.
            </div>

            <div style="display:grid; grid-template-columns:1fr 1fr; gap:10px; margin-bottom:16px;">
              <div>
                <label style="display:block; font-size:12px; color:#6b7280; margin-bottom:4px;">Status</label>
                <select name="status" style="width:100%; height:38px; border:1px solid #d1d5db; border-radius:8px; padding:0 10px; font-size:13px; font-family:'Inter',sans-serif;"
                  <%= ("Resolved".equals(currentStatus) || "Rejected".equals(currentStatus)) ? "disabled" : "" %>>
                  <option value="Open"        <%= "Open".equals(currentStatus)        ? "selected" : "" %>>Open</option>
                  <option value="In Progress" <%= "In Progress".equals(currentStatus) ? "selected" : "" %>>In Progress</option>
                  <option value="Resolved"    <%= "Resolved".equals(currentStatus)    ? "selected" : "" %>>Resolved</option>
                  <option value="Rejected"    <%= "Rejected".equals(currentStatus)    ? "selected" : "" %>>Rejected</option>
                </select>
              </div>
              <div>
                <label style="display:block; font-size:12px; color:#6b7280; margin-bottom:4px;">Priority</label>
                <select name="priority" style="width:100%; height:38px; border:1px solid #d1d5db; border-radius:8px; padding:0 10px; font-size:13px; font-family:'Inter',sans-serif;">
                  <option value="Low"      <%= "Low".equals(currentPriority)      ? "selected" : "" %>>Low</option>
                  <option value="Medium"   <%= "Medium".equals(currentPriority)   ? "selected" : "" %>>Medium</option>
                  <option value="High"     <%= "High".equals(currentPriority)     ? "selected" : "" %>>High</option>
                  <option value="Critical" <%= "Critical".equals(currentPriority) ? "selected" : "" %>>Critical</option>
                </select>
              </div>
            </div>

            <div style="display:flex; gap:8px; flex-wrap:wrap;">
              <a href="<%= contextPath %>/municipality/issue-list" style="background:#fff; color:#64748b; border:1px solid #e2e8f0; padding:9px 16px; border-radius:8px; font-size:13px; font-weight:600; font-family:'Inter',sans-serif; text-decoration:none; display:inline-block;">Return to Issue List</a>
              <% if (!"Resolved".equals(currentStatus) && !"Rejected".equals(currentStatus)) { %>
              <button type="submit" style="background:#059669; color:#fff; border:none; padding:9px 16px; border-radius:8px; font-size:13px; font-weight:600; cursor:pointer; font-family:'Inter',sans-serif;">Save Changes</button>
              <% } else { %>
              <span style="padding:9px 16px; border-radius:8px; font-size:13px; font-weight:600; background:#f1f5f9; color:#94a3b8; display:inline-block;">Issue is <%= currentStatus %> — no further updates allowed</span>
              <% } %>
            </div>
          </form>
        </div>

        <!-- Right: Meta panel -->
        <div style="display:flex; flex-direction:column; gap:14px;">

          <!-- Reported image -->
          <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:16px;">
            <h3 style="font-size:13px; font-weight:700; color:#0f172a; margin:0 0 10px;">Reported Image</h3>
            <% if (reportImageUrl != null && !reportImageUrl.trim().isEmpty()) { %>
            <img src="<%= reportImageUrl %>" alt="Issue image" style="width:100%; height:190px; object-fit:cover; border-radius:8px; border:1px solid #e2e8f0;"/>
            <% } else { %>
            <div style="height:190px; border:1px dashed #cbd5e1; border-radius:8px; background:#f8fafc; display:flex; align-items:center; justify-content:center; flex-direction:column; gap:8px;">
              <svg width="26" height="26" fill="none" stroke="#94a3b8" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M3 7a2 2 0 012-2h14a2 2 0 012 2v10a2 2 0 01-2 2H5a2 2 0 01-2-2V7z"/><path stroke-linecap="round" stroke-linejoin="round" d="M8.5 11a1.5 1.5 0 110-3 1.5 1.5 0 010 3z"/><path stroke-linecap="round" stroke-linejoin="round" d="M21 15l-5-5L5 21"/></svg>
              <p style="font-size:12px; color:#64748b; margin:0;">No image uploaded</p>
            </div>
            <% } %>
          </div>

          <!-- Reporter info -->
          <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:16px;">
            <h3 style="font-size:13px; font-weight:700; color:#0f172a; margin:0 0 10px;">Reporter</h3>
            <p style="font-size:13px; color:#1f2937; margin:0 0 4px; font-weight:600;"><%= issue.getCitizenName() != null ? issue.getCitizenName() : "—" %></p>
            <p style="font-size:12px; color:#64748b; margin:0 0 2px;">Ward <%= String.format("%02d", issue.getWardNo()) %> Resident</p>
            <p style="font-size:12px; color:#64748b; margin:0;"><%= issue.getCitizenEmail() != null ? issue.getCitizenEmail() : "" %></p>
          </div>

          <!-- Timeline (Sprint 5 Task 5 — audit-friendly timestamps) -->
          <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:16px;">
            <h3 style="font-size:13px; font-weight:700; color:#0f172a; margin:0 0 10px;">Timeline</h3>
            <p style="font-size:12px; color:#334155; margin:0 0 6px;"><strong>Reported:</strong> <%= issue.getCreatedAtFormatted() %></p>
            <% if (issue.getUpdatedAt() != null && !issue.getUpdatedAt().equals(issue.getCreatedAt())) { %>
            <p style="font-size:12px; color:#334155; margin:0;"><strong>Last updated:</strong> <%= new java.text.SimpleDateFormat("MMM dd, yyyy HH:mm").format(issue.getUpdatedAt()) %></p>
            <% } %>
            <p style="font-size:12px; color:#94a3b8; margin:6px 0 0;">Current status: <strong><%= currentStatus %></strong></p>
          </div>

          <!-- Allowed transitions hint -->
          <div style="background:#ecfdf5; border:1px solid #bbf7d0; border-radius:10px; padding:16px;">
            <p style="font-size:12px; font-weight:700; color:#065f46; margin:0 0 4px;">Status Transitions</p>
            <% if ("Open".equals(currentStatus)) { %>
            <p style="font-size:12px; color:#047857; margin:0; line-height:1.5;">Can move to: <strong>In Progress</strong> or <strong>Rejected</strong></p>
            <% } else if ("In Progress".equals(currentStatus)) { %>
            <p style="font-size:12px; color:#047857; margin:0; line-height:1.5;">Can move to: <strong>Resolved</strong> or <strong>Rejected</strong></p>
            <% } else { %>
            <p style="font-size:12px; color:#047857; margin:0; line-height:1.5;">This issue is <strong><%= currentStatus %></strong>. No further transitions are allowed.</p>
            <% } %>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>
