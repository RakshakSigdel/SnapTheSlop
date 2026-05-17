<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.snaptheslop.snaptheslop.municipality.model.Municipality" %>
<% request.setAttribute("activePage", "municipalities"); %>
<jsp:include page="../common/header.jsp"/>

<div class="flex min-h-screen">
	<jsp:include page="../common/admin-sidebar.jsp"/>

	<div class="flex-1" style="margin-left:220px; background:#f8fafc; min-height:100vh;">
		<div style="padding:18px 32px; display:flex; align-items:center; justify-content:space-between; border-bottom:1px solid #e2e8f0; background:#fff;">
			<div>
				<h1 style="font-family:'Outfit',sans-serif; font-size:18px; font-weight:700; color:#0f172a; margin:0;">Municipalities</h1>
				<p style="font-size:13px; color:#64748b; margin:2px 0 0;">Register and manage municipalities and municipality admins.</p>
			</div>
			<a href="<%= request.getContextPath() %>/admin/dashboard" style="padding:8px 14px; border-radius:7px; font-size:12px; font-weight:600; border:1px solid #e2e8f0; background:#fff; color:#64748b; text-decoration:none;">Back to Dashboard</a>
		</div>

		<div style="padding:28px 32px; display:grid; grid-template-columns:1.7fr 1fr; gap:16px;">
			<div>
				<div style="display:grid; grid-template-columns:2fr 1fr 1fr; gap:10px; margin-bottom:14px;">
					<input type="text" placeholder="Search municipality or admin" style="height:40px; border:1px solid #d1d5db; border-radius:8px; padding:0 12px; font-size:13px; font-family:'Inter',sans-serif;"/>
					<select style="height:40px; border:1px solid #d1d5db; border-radius:8px; padding:0 10px; font-size:13px; font-family:'Inter',sans-serif;"><option>Status: All</option><option>Active</option><option>Pending</option></select>
					<select style="height:40px; border:1px solid #d1d5db; border-radius:8px; padding:0 10px; font-size:13px; font-family:'Inter',sans-serif;"><option>Sort: Name</option><option>Sort: Newest</option></select>
				</div>

				<div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; overflow:hidden;">
					<table style="width:100%; border-collapse:collapse;">
						<thead>
						<tr style="border-bottom:1px solid #f1f5f9;">
							<th style="text-align:left; padding:12px 18px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Municipality</th>
							<th style="text-align:left; padding:12px 18px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Admin</th>
							<th style="text-align:left; padding:12px 18px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Wards</th>
							<th style="text-align:left; padding:12px 18px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Status</th>
							<th style="text-align:right; padding:12px 18px;"></th>
						</tr>
						</thead>
						<tbody>
						<%
							List<Municipality> municipalities = (List<Municipality>) request.getAttribute("municipalities");
							if (municipalities != null && !municipalities.isEmpty()) {
								for (Municipality municipality : municipalities) {
									String adminEmail = municipality.getAdminEmail() != null && !municipality.getAdminEmail().trim().isEmpty()
										? municipality.getAdminEmail()
										: "pending setup";
									String status = municipality.getStatus() != null ? municipality.getStatus().trim() : "Pending";
									boolean isActive = "active".equalsIgnoreCase(status);
						%>
						<tr style="border-bottom:1px solid #f8fafc;" onmouseover="this.style.background='#fafbfc'" onmouseout="this.style.background='transparent'">
							<td style="padding:14px 18px;">
								<p style="font-size:13px; font-weight:600; color:#1e293b; margin:0;"><%= municipality.getName() %></p>
								<p style="font-size:11px; color:#94a3b8; margin:2px 0 0;"><%= municipality.getContactNumber() != null && !municipality.getContactNumber().trim().isEmpty() ? municipality.getContactNumber() : "No phone" %></p>
							</td>
							<td style="padding:14px 18px; font-size:13px; color:#64748b;"><%= adminEmail %></td>
							<td style="padding:14px 18px; font-size:13px; color:#64748b;"><%= municipality.getWardCount() %></td>
							<td style="padding:14px 18px;">
								<span style="padding:3px 10px; border-radius:99px; font-size:11px; font-weight:600; <%= isActive ? "background:#d1fae5; color:#065f46;" : "background:#fef3c7; color:#92400e;" %>"><%= isActive ? "Active" : "Pending" %></span>
							</td>
							<td style="padding:14px 18px; text-align:right;">
								<a href="<%= request.getContextPath() %>/admin/manage-municipality?id=<%= municipality.getId() %>" style="background:#059669; color:#fff; border:none; padding:5px 14px; border-radius:6px; font-size:11px; font-weight:600; text-decoration:none; display:inline-block;">Manage</a>
							</td>
						</tr>
						<%
								}
							} else {
						%>
						<tr>
							<td colspan="5" style="padding:18px; text-align:center; font-size:13px; color:#64748b;">No municipalities registered yet.</td>
						</tr>
						<%
							}
						%>
						</tbody>
					</table>
				</div>
			</div>

			<div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:18px;">
				<h2 style="font-size:14px; font-weight:700; color:#0f172a; margin:0 0 12px;">Add Municipality</h2>

				<% String errorMsg = (String) request.getAttribute("error"); %>
				<% String successMsg = (String) request.getAttribute("success"); %>

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

				<form method="POST" action="<%= request.getContextPath() %>/admin/municipalities" style="display:flex; flex-direction:column; gap:10px;">
					<input type="text" name="municipalityName" placeholder="Municipality Name" value="<%= request.getAttribute("municipalityName") != null ? request.getAttribute("municipalityName") : "" %>" style="width:100%; height:38px; border:1px solid #d1d5db; border-radius:7px; padding:0 10px; font-size:13px; font-family:'Inter',sans-serif;"/>
					<input type="text" name="municipalityCode" placeholder="Municipality Code" value="<%= request.getAttribute("municipalityCode") != null ? request.getAttribute("municipalityCode") : "" %>" style="width:100%; height:38px; border:1px solid #d1d5db; border-radius:7px; padding:0 10px; font-size:13px; font-family:'Inter',sans-serif;"/>
					<input type="text" name="officeAddress" placeholder="Office Address" value="<%= request.getAttribute("officeAddress") != null ? request.getAttribute("officeAddress") : "" %>" style="width:100%; height:38px; border:1px solid #d1d5db; border-radius:7px; padding:0 10px; font-size:13px; font-family:'Inter',sans-serif;"/>
					<input type="tel" name="municipalityPhone" placeholder="Municipality Phone Number" value="<%= request.getAttribute("municipalityPhone") != null ? request.getAttribute("municipalityPhone") : "" %>" style="width:100%; height:38px; border:1px solid #d1d5db; border-radius:7px; padding:0 10px; font-size:13px; font-family:'Inter',sans-serif;"/>
					<div style="display:grid; grid-template-columns:1fr 1fr; gap:10px;">
						<input type="text" name="adminFirstName" placeholder="Admin First Name" value="<%= request.getAttribute("adminFirstName") != null ? request.getAttribute("adminFirstName") : "" %>" style="width:100%; height:38px; border:1px solid #d1d5db; border-radius:7px; padding:0 10px; font-size:13px; font-family:'Inter',sans-serif;"/>
						<input type="text" name="adminLastName" placeholder="Admin Last Name" value="<%= request.getAttribute("adminLastName") != null ? request.getAttribute("adminLastName") : "" %>" style="width:100%; height:38px; border:1px solid #d1d5db; border-radius:7px; padding:0 10px; font-size:13px; font-family:'Inter',sans-serif;"/>
					</div>
					<input type="email" name="adminEmail" placeholder="Admin Email Address" value="<%= request.getAttribute("adminEmail") != null ? request.getAttribute("adminEmail") : "" %>" style="width:100%; height:38px; border:1px solid #d1d5db; border-radius:7px; padding:0 10px; font-size:13px; font-family:'Inter',sans-serif;"/>
					<input type="tel" name="adminPhone" placeholder="Admin Phone Number" value="<%= request.getAttribute("adminPhone") != null ? request.getAttribute("adminPhone") : "" %>" style="width:100%; height:38px; border:1px solid #d1d5db; border-radius:7px; padding:0 10px; font-size:13px; font-family:'Inter',sans-serif;"/>
					<input type="password" name="adminPassword" placeholder="Admin Password (Permanent)" style="width:100%; height:38px; border:1px solid #d1d5db; border-radius:7px; padding:0 10px; font-size:13px; font-family:'Inter',sans-serif;"/>
					<button type="submit" style="width:100%; background:#059669; color:#fff; border:none; height:38px; border-radius:7px; font-size:12px; font-weight:700; font-family:'Inter',sans-serif; cursor:pointer;">Register Municipality</button>
				</form>
			</div>
		</div>
	</div>
</div>
</body>
</html>
