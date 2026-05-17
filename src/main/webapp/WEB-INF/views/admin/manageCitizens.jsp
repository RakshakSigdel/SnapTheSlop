<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.snaptheslop.snaptheslop.user.model.User" %>
<% request.setAttribute("activePage", "citizens"); %>
<jsp:include page="../common/header.jsp"/>

<%
	User targetUser = (User) request.getAttribute("targetUser");
	String errorMsg = (String) request.getAttribute("error");
	String successMsg = (String) request.getAttribute("success");
	String firstName = targetUser != null && targetUser.getFirstName() != null ? targetUser.getFirstName() : "";
	String lastName = targetUser != null && targetUser.getLastName() != null ? targetUser.getLastName() : "";
	String email = targetUser != null && targetUser.getEmail() != null ? targetUser.getEmail() : "";
	String phone = targetUser != null && targetUser.getPhoneNumber() != null ? targetUser.getPhoneNumber() : "";
	String ward = targetUser != null && targetUser.getWardNo() != null ? targetUser.getWardNo() : "";
	String role = targetUser != null && targetUser.getRole() != null ? targetUser.getRole() : "Citizen";
	String accountStatus = targetUser != null && targetUser.getAccountStatus() != null ? targetUser.getAccountStatus() : "Active";
	String userId = targetUser != null && targetUser.getUserId() != null ? targetUser.getUserId() : "";
	boolean inactiveSelected = "inactive".equalsIgnoreCase(accountStatus) || "suspended".equalsIgnoreCase(accountStatus) || "disabled".equalsIgnoreCase(accountStatus);
%>

<div class="flex min-h-screen">
	<jsp:include page="../common/admin-sidebar.jsp"/>

	<div class="flex-1" style="margin-left:220px; background:#f8fafc; min-height:100vh;">
		<div style="padding:18px 32px; display:flex; align-items:center; justify-content:space-between; border-bottom:1px solid #e2e8f0; background:#fff;">
			<div>
				<h1 style="font-family:'Outfit',sans-serif; font-size:18px; font-weight:700; color:#0f172a; margin:0;">Manage Citizen</h1>
				<p style="font-size:13px; color:#64748b; margin:2px 0 0;">Review account details and moderation actions.</p>
			</div>
			<a href="<%= request.getContextPath() %>/admin/users" style="padding:8px 14px; border-radius:7px; font-size:12px; font-weight:600; border:1px solid #e2e8f0; background:#fff; color:#64748b; text-decoration:none;">Back to Citizens</a>
		</div>

		<div style="padding:28px 32px; display:grid; grid-template-columns:1.6fr 1fr; gap:16px;">
			<div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:20px;">
				<h2 style="font-size:15px; font-weight:700; color:#0f172a; margin:0 0 12px;">Profile Details</h2>

				<% if (errorMsg != null) { %>
				<div style="background:#fee2e2; border:1px solid #fecaca; border-radius:7px; padding:10px; margin-bottom:12px; font-size:12px; color:#dc2626;">
					<%= errorMsg %>
				</div>
				<% } %>

				<% if (successMsg != null) { %>
				<div style="background:#dcfce7; border:1px solid #bbf7d0; border-radius:7px; padding:10px; margin-bottom:12px; font-size:12px; color:#16a34a;">
					<%= successMsg %>
				</div>
				<% } %>

				<form method="post" action="<%= request.getContextPath() %>/admin/manage-user" style="margin:0;">
					<input type="hidden" name="userId" value="<%= userId %>"/>
				<div style="display:grid; grid-template-columns:1fr 1fr; gap:12px; margin-bottom:12px;">
					<input value="<%= firstName %>" readonly style="height:40px; border:1px solid #d1d5db; border-radius:8px; padding:0 10px; font-size:13px; font-family:'Inter',sans-serif; background:#f8fafc;"/>
					<input value="<%= lastName %>" readonly style="height:40px; border:1px solid #d1d5db; border-radius:8px; padding:0 10px; font-size:13px; font-family:'Inter',sans-serif; background:#f8fafc;"/>
				</div>
				<div style="display:grid; grid-template-columns:1fr 1fr; gap:12px; margin-bottom:12px;">
					<input value="<%= email %>" readonly style="height:40px; border:1px solid #d1d5db; border-radius:8px; padding:0 10px; font-size:13px; font-family:'Inter',sans-serif; background:#f8fafc;"/>
					<input value="<%= phone %>" readonly style="height:40px; border:1px solid #d1d5db; border-radius:8px; padding:0 10px; font-size:13px; font-family:'Inter',sans-serif; background:#f8fafc;"/>
				</div>
				<div style="display:grid; grid-template-columns:1fr 1fr 1fr; gap:12px; margin-bottom:16px;">
					<input value="<%= ward %>" readonly style="height:40px; border:1px solid #d1d5db; border-radius:8px; padding:0 10px; font-size:13px; font-family:'Inter',sans-serif; background:#f8fafc;"/>
					<select name="accountStatus" style="height:40px; border:1px solid #d1d5db; border-radius:8px; padding:0 10px; font-size:13px; font-family:'Inter',sans-serif;">
						<option value="active" <%= inactiveSelected ? "" : "selected" %>>Active</option>
						<option value="inactive" <%= inactiveSelected ? "selected" : "" %>>Inactive</option>
					</select>
					<input value="<%= role %>" readonly style="height:40px; border:1px solid #d1d5db; border-radius:8px; padding:0 10px; font-size:13px; font-family:'Inter',sans-serif; background:#f8fafc;"/>
				</div>
				<div style="display:flex; gap:8px;">
					<button type="submit" style="background:#059669; color:#fff; border:none; padding:9px 16px; border-radius:8px; font-size:13px; font-weight:600; font-family:'Inter',sans-serif;">Save status</button>
				</div>
				</form>
			</div>

			<div style="display:flex; flex-direction:column; gap:14px;">
				<div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:16px;">
					<h3 style="font-size:13px; font-weight:700; color:#0f172a; margin:0 0 10px;">Account Summary</h3>
					<p style="font-size:12px; color:#64748b; margin:0 0 8px;">Citizen ID: <%= userId %></p>
					<p style="font-size:12px; color:#64748b; margin:0 0 8px;">Joined: <%= targetUser != null ? targetUser.getMemberSince() : "" %></p>
					<p style="font-size:12px; color:#64748b; margin:0;">Current status: <%= accountStatus %></p>
				</div>
				<div style="background:#ecfdf5; border:1px solid #bbf7d0; border-radius:10px; padding:16px;">
					<p style="font-size:12px; font-weight:700; color:#065f46; margin:0 0 4px;">Moderation Tip</p>
					<p style="font-size:12px; color:#047857; margin:0; line-height:1.5;">If you suspend a user, include a clear reason in audit notes to maintain accountability.</p>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>
