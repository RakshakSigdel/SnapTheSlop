<%--
  Issue Detail — NagarSewa  (Sprint 5: live DB data)
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.snaptheslop.snaptheslop.issue.model.Issue" %>
<%@ page import="com.snaptheslop.snaptheslop.comment.model.Comment" %>
<%@ page import="com.snaptheslop.snaptheslop.util.SessionUtil" %>
<%@ page import="java.util.List" %>
<jsp:include page="../common/header.jsp"/>
<%
  Issue issue      = (Issue) request.getAttribute("issue");
  List<Comment> issueComments = (List<Comment>) request.getAttribute("issueComments");
  boolean canModifyIssue = request.getAttribute("canModifyIssue") != null && Boolean.TRUE.equals(request.getAttribute("canModifyIssue"));
  int currentUserDbId = SessionUtil.getLoggedInUserDbId(request);
  String successMessage = (String) request.getAttribute("successMessage");
  String errorMessage = (String) request.getAttribute("errorMessage");
  if (issueComments == null) issueComments = new java.util.ArrayList<>();
  String contextPath = request.getContextPath();
  if (issue == null) { response.sendRedirect(contextPath + "/citizen/my-issues"); return; }
  String commentReturnUrl = "/citizen/issue-detail?id=" + issue.getId();

  String st = issue.getStatus();
  String statusBg, statusFg;
  if ("Open".equals(st))            { statusBg="#fee2e2"; statusFg="#991b1b"; }
  else if ("In Progress".equals(st)){ statusBg="#d1fae5"; statusFg="#065f46"; }
  else if ("Resolved".equals(st))   { statusBg="#dcfce7"; statusFg="#166534"; }
  else if ("Rejected".equals(st))   { statusBg="#f1f5f9"; statusFg="#64748b"; }
  else                              { statusBg="#fef3c7"; statusFg="#92400e"; }

  String pr = issue.getPriority() != null ? issue.getPriority() : "Medium";
  String priorBg, priorFg;
  if ("High".equals(pr)||"Critical".equals(pr)) { priorBg="#fee2e2"; priorFg="#991b1b"; }
  else if ("Low".equals(pr))                    { priorBg="#f0fdf4"; priorFg="#166534"; }
  else                                          { priorBg="#fef9c3"; priorFg="#854d0e"; }
%>

<div class="flex min-h-screen">
  <jsp:include page="../common/citizen-sidebar.jsp"/>

  <div class="flex-1" style="margin-left:220px; background:#f8fafc; min-height:100vh;">

    <div style="padding:18px 32px; border-bottom:1px solid #e2e8f0; background:#fff;">
      <nav style="display:flex; align-items:center; gap:6px; font-size:13px; color:#94a3b8;">
        <a href="<%= contextPath %>/citizen/dashboard" style="color:#64748b; text-decoration:none;">Dashboard</a>
        <span>/</span>
        <a href="<%= contextPath %>/citizen/my-issues" style="color:#64748b; text-decoration:none;">My Issues</a>
        <span>/</span>
        <span style="color:#0f172a; font-weight:600;">#<%= issue.getIssueId() %></span>
      </nav>
    </div>

    <div style="padding:28px 32px;">
      <% if (successMessage != null) { %>
      <div style="background:#d1fae5; border:1px solid #6ee7b7; border-radius:8px; padding:12px 14px; margin-bottom:16px; font-size:13px; color:#065f46;">
        <%= successMessage %>
      </div>
      <% } %>
      <% if (errorMessage != null) { %>
      <div style="background:#fee2e2; border:1px solid #fca5a5; border-radius:8px; padding:12px 14px; margin-bottom:16px; font-size:13px; color:#991b1b;">
        <%= errorMessage %>
      </div>
      <% } %>

      <!-- Header -->
      <div style="margin-bottom:24px;">
        <div style="display:flex; align-items:center; gap:8px; margin-bottom:8px;">
          <span style="padding:3px 10px; border-radius:99px; font-size:11px; font-weight:600; background:<%= statusBg %>; color:<%= statusFg %>;"><%= st %></span>
          <span style="padding:3px 10px; border-radius:99px; font-size:11px; font-weight:600; background:<%= priorBg %>; color:<%= priorFg %>;"><%= pr %> Priority</span>
        </div>
        <h1 style="font-family:'Outfit',sans-serif; font-size:26px; font-weight:800; color:#0f172a; margin-bottom:4px; letter-spacing:-0.5px;"><%= issue.getTitle() %></h1>
        <p style="font-size:13px; color:#94a3b8;">Filed <%= issue.getCreatedAtFormatted() %> · <%= issue.getCategory() != null ? issue.getCategory() : "—" %> · <%= issue.getLocation() != null ? issue.getLocation() : "—" %></p>
      </div>

      <div style="display:grid; grid-template-columns:5fr 3fr; gap:20px;">

        <!-- Left -->
        <div style="display:flex; flex-direction:column; gap:16px;">

          <!-- Description -->
          <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:22px;">
            <h2 style="font-size:14px; font-weight:700; color:#0f172a; margin-bottom:10px;">Description</h2>
            <p style="font-size:14px; color:#475569; line-height:1.8;"><%= issue.getDescription() != null ? issue.getDescription() : "No description provided." %></p>
          </div>

          <!-- Photo -->
          <% if (issue.getImagePath() != null && !issue.getImagePath().isBlank()) { %>
          <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:22px;">
            <h2 style="font-size:14px; font-weight:700; color:#0f172a; margin-bottom:12px;">Photo</h2>
            <img src="<%= contextPath + issue.getImagePath() %>" alt="Issue photo"
                 style="width:100%; max-height:300px; object-fit:cover; border-radius:8px; border:1px solid #e2e8f0;"/>
          </div>
          <% } %>

          <!-- Comments -->
          <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:22px;">
            <h2 style="font-size:14px; font-weight:700; color:#0f172a; margin-bottom:16px;">Comments</h2>

            <% if (issueComments.isEmpty()) { %>
            <p style="font-size:13px; color:#94a3b8; margin-bottom:12px;">No comments yet. Start the discussion.</p>
            <% } else { %>
              <% for (Comment comment : issueComments) { %>
              <div style="padding:10px 0; border-bottom:1px solid #f1f5f9; margin-bottom:4px;">
                <p style="font-size:12px; color:#64748b; margin:0 0 4px;">
                  <strong><%= comment.getCommenterName() != null ? comment.getCommenterName() : "Citizen" %></strong>
                  · <%= comment.getCreatedAtShort() %>
                </p>
                <p style="font-size:13px; color:#1f2937; margin:0; line-height:1.6;"><%= comment.getContent() %></p>
                <% if (currentUserDbId > 0 && currentUserDbId == comment.getUserId()) { %>
                <div style="display:flex; gap:8px; margin-top:8px;">
                  <a href="<%= contextPath %>/citizen/comment-edit?id=<%= comment.getId() %>&returnUrl=<%= java.net.URLEncoder.encode(commentReturnUrl, java.nio.charset.StandardCharsets.UTF_8) %>" style="display:inline-flex; align-items:center; justify-content:center; padding:6px 12px; border-radius:6px; background:#059669; color:#fff; font-size:11px; font-weight:700; text-decoration:none;">Edit</a>
                  <form action="<%= contextPath %>/citizen/comment-delete" method="post" onsubmit="return confirm('Delete this comment permanently?');" style="margin:0;">
                    <input type="hidden" name="commentId" value="<%= comment.getId() %>"/>
                    <input type="hidden" name="returnUrl" value="<%= commentReturnUrl %>"/>
                    <button type="submit" style="padding:6px 12px; border-radius:6px; background:#fff; color:#b91c1c; border:1px solid #fecaca; font-size:11px; font-weight:700; cursor:pointer;">Delete</button>
                  </form>
                </div>
                <% } %>
              </div>
              <% } %>
            <% } %>

            <form action="<%= contextPath %>/comment/add" method="post">
              <input type="hidden" name="issueId" value="<%= issue.getId() %>"/>
              <input type="hidden" name="returnUrl" value="/citizen/issue-detail?id=<%= issue.getId() %>"/>
              <textarea name="commentText" rows="2" placeholder="Write a comment..."
                        style="width:100%; border:1.5px solid #e5e7eb; border-radius:8px; padding:10px 12px; font-size:13px; color:#111827; background:#fff; outline:none; resize:none; font-family:'Inter',sans-serif; margin-bottom:8px; box-sizing:border-box;"></textarea>
              <button type="submit" style="background:#0f172a; color:#fff; border:none; font-size:12px; font-weight:600; padding:8px 16px; border-radius:6px; cursor:pointer; font-family:'Inter',sans-serif;">Post</button>
            </form>
          </div>
        </div>

        <!-- Right sidebar -->
        <div style="display:flex; flex-direction:column; gap:16px;">

          <!-- Details -->
          <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:20px;">
            <h3 style="font-size:12px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px; margin-bottom:14px;">Details</h3>
            <div style="display:flex; flex-direction:column; gap:12px;">
              <div><p style="font-size:12px; color:#94a3b8; margin:0 0 2px;">ID</p><p style="font-size:14px; font-weight:600; color:#0f172a; margin:0;">#<%= issue.getIssueId() %></p></div>
              <div><p style="font-size:12px; color:#94a3b8; margin:0 0 2px;">Category</p><p style="font-size:14px; color:#1e293b; margin:0;"><%= issue.getCategory() != null ? issue.getCategory() : "—" %></p></div>
              <div><p style="font-size:12px; color:#94a3b8; margin:0 0 2px;">Location</p><p style="font-size:14px; color:#1e293b; margin:0;"><%= issue.getLocation() != null ? issue.getLocation() : "—" %></p></div>
              <div><p style="font-size:12px; color:#94a3b8; margin:0 0 2px;">Ward</p><p style="font-size:14px; color:#1e293b; margin:0;">Ward <%= String.format("%02d", issue.getWardNo()) %></p></div>
              <div><p style="font-size:12px; color:#94a3b8; margin:0 0 2px;">Municipality</p><p style="font-size:14px; color:#1e293b; margin:0;"><%= issue.getMunicipalityName() != null ? issue.getMunicipalityName() : "—" %></p></div>
              <div><p style="font-size:12px; color:#94a3b8; margin:0 0 2px;">Filed by</p><p style="font-size:14px; color:#1e293b; margin:0;"><%= issue.getCitizenName() != null ? issue.getCitizenName() : "—" %></p></div>
              <div><p style="font-size:12px; color:#94a3b8; margin:0 0 2px;">Filed on</p><p style="font-size:14px; color:#1e293b; margin:0;"><%= issue.getCreatedAtFormatted() %></p></div>
              <% if (issue.getUpdatedAt() != null) { %>
              <div><p style="font-size:12px; color:#94a3b8; margin:0 0 2px;">Last updated</p><p style="font-size:14px; color:#1e293b; margin:0;"><%= issue.getCreatedAtFormatted() %></p></div>
              <% } %>
            </div>

            <% if (canModifyIssue) { %>
            <div style="display:flex; gap:10px; margin-top:18px; flex-wrap:wrap;">
              <a href="<%= contextPath %>/citizen/issue-edit?id=<%= issue.getId() %>" style="display:inline-flex; align-items:center; justify-content:center; padding:10px 16px; border-radius:8px; background:#059669; color:#fff; font-size:13px; font-weight:700; text-decoration:none;">Edit Report</a>
              <form action="<%= contextPath %>/citizen/issue-delete" method="post" onsubmit="return confirm('Delete this report permanently?');" style="margin:0;">
                <input type="hidden" name="issueId" value="<%= issue.getId() %>"/>
                <button type="submit" style="padding:10px 16px; border-radius:8px; background:#fff; color:#b91c1c; border:1px solid #fecaca; font-size:13px; font-weight:700; cursor:pointer;">Delete Report</button>
              </form>
            </div>
            <% } %>
          </div>

          <!-- Status Timeline -->
          <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:20px;">
            <h3 style="font-size:12px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px; margin-bottom:14px;">Status Timeline</h3>
            <div style="display:flex; flex-direction:column;">

              <!-- Submitted (always shown) -->
              <div style="display:flex; gap:10px; padding-bottom:14px;">
                <div style="display:flex; flex-direction:column; align-items:center;">
                  <div style="width:8px; height:8px; border-radius:50%; background:#059669;"></div>
                  <div style="width:1px; flex:1; background:#e2e8f0;"></div>
                </div>
                <div><p style="font-size:12px; font-weight:600; color:#059669; margin:0;">Submitted</p><p style="font-size:11px; color:#94a3b8; margin:2px 0 0;"><%= issue.getCreatedAtFormatted() %></p></div>
              </div>

              <!-- In Progress -->
              <div style="display:flex; gap:10px; padding-bottom:14px;">
                <div style="display:flex; flex-direction:column; align-items:center;">
                  <div style="width:8px; height:8px; border-radius:50%; background:<%= ("In Progress".equals(st)||"Resolved".equals(st)||"Rejected".equals(st)) ? "#059669" : "#e2e8f0" %>;"></div>
                  <div style="width:1px; flex:1; background:#e2e8f0;"></div>
                </div>
                <div><p style="font-size:12px; font-weight:600; color:<%= ("In Progress".equals(st)||"Resolved".equals(st)||"Rejected".equals(st)) ? "#059669" : "#cbd5e1" %>; margin:0;">In Progress</p></div>
              </div>

              <!-- Resolved / Rejected -->
              <div style="display:flex; gap:10px;">
                <div><div style="width:8px; height:8px; border-radius:50%; background:<%= ("Resolved".equals(st)||"Rejected".equals(st)) ? "#059669" : "#e2e8f0" %>;"></div></div>
                <div><p style="font-size:12px; font-weight:600; color:<%= ("Resolved".equals(st)||"Rejected".equals(st)) ? "#059669" : "#cbd5e1" %>; margin:0;"><%= "Rejected".equals(st) ? "Rejected" : "Resolved" %></p></div>
              </div>
            </div>
          </div>

          <!-- Upvote -->
          <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:20px; text-align:center;">
            <p style="font-family:'Outfit',sans-serif; font-size:36px; font-weight:800; color:#0f172a; margin:0;"><%= issue.getUpvoteCount() %></p>
            <p style="font-size:12px; color:#94a3b8; margin:4px 0 12px;">people support this report</p>
            <form action="<%= contextPath %>/upvote" method="post" style="display:inline;">
              <input type="hidden" name="issueId" value="<%= issue.getId() %>"/>
              <input type="hidden" name="returnUrl" value="/citizen/issue-detail?id=<%= issue.getId() %>"/>
              <button type="submit" style="background:#f1f5f9; border:1px solid #e2e8f0; color:#1e293b; font-size:13px; font-weight:600; padding:8px 20px; border-radius:6px; cursor:pointer; font-family:'Inter',sans-serif; display:inline-flex; align-items:center; gap:6px;">
                ▲ Upvote
              </button>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>
