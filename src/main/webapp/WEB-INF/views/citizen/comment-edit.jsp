
<%--
  Edit Comment — NagarSewa
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.snaptheslop.snaptheslop.issue.model.Issue" %>
<%@ page import="com.snaptheslop.snaptheslop.comment.model.Comment" %>
<jsp:include page="../common/header.jsp"/>
<%
  Comment comment = (Comment) request.getAttribute("comment");
  Issue issue = (Issue) request.getAttribute("issue");
  String returnUrl = (String) request.getAttribute("returnUrl");
  if (returnUrl == null || returnUrl.isBlank()) {
    returnUrl = request.getContextPath() + "/citizen/my-issues";
  }
  String successMessage = (String) request.getAttribute("successMessage");
  String errorMessage = (String) request.getAttribute("errorMessage");
  if (comment == null) { response.sendRedirect(returnUrl); return; }
%>

<div class="flex min-h-screen">
  <jsp:include page="../common/citizen-sidebar.jsp"/>

  <div class="flex-1" style="margin-left:220px; background:#f8fafc; min-height:100vh;">
    <div style="padding:18px 32px; border-bottom:1px solid #e2e8f0; background:#fff;">
      <nav style="display:flex; align-items:center; gap:6px; font-size:13px; color:#94a3b8;">
        <a href="<%= request.getContextPath() %>/citizen/dashboard" style="color:#64748b; text-decoration:none;">Dashboard</a>
        <span>/</span>
        <a href="<%= returnUrl %>" style="color:#64748b; text-decoration:none;">Issue Detail</a>
        <span>/</span>
        <span style="color:#0f172a; font-weight:600;">Edit Comment</span>
      </nav>
    </div>

    <div style="padding:32px; max-width:760px; margin:0 auto; width:100%;">
      <h1 style="font-family:'Outfit',sans-serif; font-size:24px; font-weight:800; color:#0f172a; margin-bottom:6px;">Edit Comment</h1>
      <p style="font-size:14px; color:#64748b; margin-bottom:24px;">
        <strong>Issue:</strong> <%= issue != null ? issue.getTitle() : "Comment" %>
      </p>

      <% if (successMessage != null) { %>
      <div style="background:#d1fae5; color:#065f46; padding:12px 14px; border-radius:8px; margin-bottom:20px; font-size:13px; border:1px solid #a7f3d0;">
        <%= successMessage %>
      </div>
      <% } %>
      <% if (errorMessage != null) { %>
      <div style="background:#fef2f2; color:#dc2626; padding:12px 14px; border-radius:8px; margin-bottom:20px; font-size:13px; border:1px solid #fecaca;">
        <%= errorMessage %>
      </div>
      <% } %>

      <form action="<%= request.getContextPath() %>/citizen/comment-edit" method="post">
        <input type="hidden" name="commentId" value="<%= comment.getId() %>"/>
        <input type="hidden" name="returnUrl" value="<%= returnUrl.replace("&", "&amp;") %>"/>

        <div style="margin-bottom:20px;">
          <label style="display:block; font-size:13px; font-weight:600; color:#374151; margin-bottom:6px;">Comment</label>
          <textarea name="content" rows="6" required style="width:100%; border:1.5px solid #e5e7eb; border-radius:8px; padding:12px 14px; font-size:14px; color:#111827; background:#fff; outline:none; resize:vertical; font-family:'Inter',sans-serif; line-height:1.6;"><%= comment.getContent() != null ? comment.getContent() : "" %></textarea>
        </div>

        <div style="display:flex; align-items:center; gap:12px;">
          <button type="submit" style="background:#059669; color:#fff; border:none; font-weight:600; font-size:14px; padding:11px 24px; border-radius:8px; cursor:pointer; font-family:'Inter',sans-serif;">Save Changes</button>
          <a href="<%= returnUrl %>" style="font-size:14px; font-weight:500; color:#64748b; text-decoration:none;">Cancel</a>
        </div>
      </form>
    </div>
  </div>
</div>
</body>
</html>
