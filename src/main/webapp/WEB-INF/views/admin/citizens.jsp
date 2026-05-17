<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.snaptheslop.snaptheslop.user.model.User" %>
<% request.setAttribute("activePage", "citizens"); %>
<jsp:include page="../common/header.jsp"/>

<%
	List<User> users = (List<User>) request.getAttribute("users");
%>

<div class="flex min-h-screen">
	<jsp:include page="../common/admin-sidebar.jsp"/>

	<div class="flex-1" style="margin-left:220px; background:#f8fafc; min-height:100vh;">
		<div style="padding:18px 32px; display:flex; align-items:center; justify-content:space-between; border-bottom:1px solid #e2e8f0; background:#fff;">
			<div>
				<h1 style="font-family:'Outfit',sans-serif; font-size:18px; font-weight:700; color:#0f172a; margin:0;">Citizens</h1>
				<p style="font-size:13px; color:#64748b; margin:2px 0 0;">Search, filter, and manage citizen accounts.</p>
			</div>
			<a href="<%= request.getContextPath() %>/admin/dashboard" style="padding:8px 14px; border-radius:7px; font-size:12px; font-weight:600; border:1px solid #e2e8f0; background:#fff; color:#64748b; text-decoration:none;">Back to Dashboard</a>
		</div>

		<div style="padding:28px 32px;">
			<div style="display:grid; grid-template-columns:2fr 1fr 1fr 1fr; gap:10px; margin-bottom:16px;">
				<input type="text" placeholder="Search by name, email, or citizen ID" style="height:40px; border:1px solid #d1d5db; border-radius:8px; padding:0 12px; font-size:13px; font-family:'Inter',sans-serif;"/>
				<select style="height:40px; border:1px solid #d1d5db; border-radius:8px; padding:0 10px; font-size:13px; font-family:'Inter',sans-serif;">
					<option>Ward: All</option>
					<option>Ward 02</option>
					<option>Ward 04</option>
					<option>Ward 09</option>
				</select>
				<select style="height:40px; border:1px solid #d1d5db; border-radius:8px; padding:0 10px; font-size:13px; font-family:'Inter',sans-serif;">
					<option>Status: All</option>
					<option>Active</option>
					<option>Pending</option>
					<option>Suspended</option>
				</select>
				<select style="height:40px; border:1px solid #d1d5db; border-radius:8px; padding:0 10px; font-size:13px; font-family:'Inter',sans-serif;">
					<option>Sort: Newest</option>
					<option>Sort: Oldest</option>
					<option>Sort: Most Active</option>
				</select>
			</div>

			<div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; overflow:hidden;">
				<table style="width:100%; border-collapse:collapse;">
					<thead>
					<tr style="border-bottom:1px solid #f1f5f9;">
						<th style="text-align:left; padding:12px 18px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Citizen</th>
						<th style="text-align:left; padding:12px 18px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Email</th>
						<th style="text-align:left; padding:12px 18px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Ward</th>
						<th style="text-align:left; padding:12px 18px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Status</th>
						<th style="text-align:left; padding:12px 18px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Joined</th>
						<th style="text-align:right; padding:12px 18px;"></th>
					</tr>
					</thead>
					<tbody>
					<% if (users == null || users.isEmpty()) { %>
					<tr>
						<td colspan="6" style="padding:14px 18px; font-size:13px; color:#64748b; text-align:center;">No users found.</td>
					</tr>
					<% } else { %>
					<% for (User user : users) { %>
					<%
						String status = user.getAccountStatus() != null ? user.getAccountStatus() : "Active";
						boolean inactive = "inactive".equalsIgnoreCase(status) || "suspended".equalsIgnoreCase(status) || "disabled".equalsIgnoreCase(status);
						String statusBg = inactive ? "#fee2e2" : "#d1fae5";
						String statusColor = inactive ? "#991b1b" : "#065f46";
					%>
					<tr style="border-bottom:1px solid #f8fafc;" onmouseover="this.style.background='#fafbfc'" onmouseout="this.style.background='transparent'">
						<td style="padding:14px 18px;"><p style="font-size:13px; font-weight:600; color:#1e293b; margin:0;"><%= (user.getFirstName() != null ? user.getFirstName() : "") %> <%= (user.getLastName() != null ? user.getLastName() : "") %></p><p style="font-size:11px; color:#94a3b8; margin:2px 0 0;"><%= user.getUserId() %></p></td>
						<td style="padding:14px 18px; font-size:13px; color:#64748b;"><%= user.getEmail() %></td>
						<td style="padding:14px 18px; font-size:13px; color:#64748b;"><%= user.getWardNo() != null ? user.getWardNo() : "-" %></td>
						<td style="padding:14px 18px;"><span style="padding:3px 10px; border-radius:99px; font-size:11px; font-weight:600; background:<%= statusBg %>; color:<%= statusColor %>;"><%= status %></span></td>
						<td style="padding:14px 18px; font-size:12px; color:#94a3b8;"><%= user.getMemberSince() != null ? user.getMemberSince() : "-" %></td>
						<td style="padding:14px 18px; text-align:right;"><a href="<%= request.getContextPath() %>/admin/manage-user?id=<%= user.getUserId() %>" style="background:#059669; color:#fff; border:none; padding:5px 14px; border-radius:6px; font-size:11px; font-weight:600; text-decoration:none; display:inline-block;">Manage</a></td>
					</tr>
					<% } %>
					<% } %>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
</body>
</html>
