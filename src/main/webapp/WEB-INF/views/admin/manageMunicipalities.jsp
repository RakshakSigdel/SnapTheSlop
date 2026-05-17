<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.snaptheslop.snaptheslop.municipality.model.Municipality" %>
<% request.setAttribute("activePage", "municipalities"); %>
<jsp:include page="../common/header.jsp"/>

<%
	Municipality municipality = (Municipality) request.getAttribute("municipality");
	boolean municipalityExists = municipality != null;
	boolean adminExists = municipalityExists
		&& municipality.getAdminEmail() != null
		&& !municipality.getAdminEmail().trim().isEmpty();
	String disableMunicipalityFields = municipalityExists ? "" : "disabled";
	String disableAdminFields = adminExists ? "" : "disabled";

	String errorMsg = (String) request.getAttribute("error");
	String successMsg = (String) request.getAttribute("success");

	String municipalityIdValue = municipalityExists ? String.valueOf(municipality.getId()) : "";
	String municipalityName = municipalityExists && municipality.getName() != null ? municipality.getName() : "";
	String district = municipalityExists && municipality.getDistrict() != null ? municipality.getDistrict() : "";
	String province = municipalityExists && municipality.getProvince() != null ? municipality.getProvince() : "";
	String municipalityPhone = municipalityExists && municipality.getContactNumber() != null ? municipality.getContactNumber() : "";
	String officeAddress = municipalityExists && municipality.getOfficeAddress() != null ? municipality.getOfficeAddress() : "";
	String wardCount = municipalityExists ? String.valueOf(municipality.getWardCount()) : "";

	String adminFirstName = municipalityExists && municipality.getAdminFirstName() != null ? municipality.getAdminFirstName() : "";
	String adminLastName = municipalityExists && municipality.getAdminLastName() != null ? municipality.getAdminLastName() : "";
	String adminEmail = municipalityExists && municipality.getAdminEmail() != null ? municipality.getAdminEmail() : "";
	String adminPhone = municipalityExists && municipality.getAdminPhone() != null ? municipality.getAdminPhone() : "";
	String adminStatus = municipalityExists && municipality.getStatus() != null ? municipality.getStatus() : "Pending";
%>

<div class="flex min-h-screen">
	<jsp:include page="../common/admin-sidebar.jsp"/>

	<div class="flex-1" style="margin-left:220px; background:#f8fafc; min-height:100vh;">
		<div style="padding:18px 32px; display:flex; align-items:center; justify-content:space-between; border-bottom:1px solid #e2e8f0; background:#fff;">
			<div>
				<h1 style="font-family:'Outfit',sans-serif; font-size:18px; font-weight:700; color:#0f172a; margin:0;">Manage Municipality</h1>
				<p style="font-size:13px; color:#64748b; margin:2px 0 0;">Update municipality profile and municipality admin details.</p>
			</div>
			<a href="<%= request.getContextPath() %>/admin/municipalities" style="padding:8px 14px; border-radius:7px; font-size:12px; font-weight:600; border:1px solid #e2e8f0; background:#fff; color:#64748b; text-decoration:none;">Back to Municipalities</a>
		</div>

		<% if (errorMsg != null) { %>
		<div style="margin:16px 32px 0; background:#fee2e2; border:1px solid #fecaca; border-radius:8px; padding:12px; font-size:13px; color:#b91c1c;">
			<%= errorMsg %>
		</div>
		<% } %>

		<% if (successMsg != null) { %>
		<div style="margin:16px 32px 0; background:#dcfce7; border:1px solid #bbf7d0; border-radius:8px; padding:12px; font-size:13px; color:#166534;">
			<%= successMsg %>
		</div>
		<% } %>

		<div style="padding:28px 32px; display:grid; grid-template-columns:1.6fr 1fr; gap:16px;">
			<div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:20px;">
				<h2 style="font-size:15px; font-weight:700; color:#0f172a; margin:0 0 12px;">Municipality Details</h2>

				<% if (!municipalityExists) { %>
					<div style="margin-bottom:12px; background:#fffbeb; border:1px solid #fde68a; border-radius:8px; padding:10px; font-size:12px; color:#92400e;">
						This municipality does not exist in the database. Fields are disabled.
					</div>
				<% } %>

				<form method="POST" action="<%= request.getContextPath() %>/admin/manage-municipality" style="display:flex; flex-direction:column; gap:0;">
					<input type="hidden" name="action" value="save"/>
					<input type="hidden" name="municipalityId" value="<%= municipalityIdValue %>"/>

					<div style="display:grid; grid-template-columns:1fr 1fr; gap:12px; margin-bottom:12px;">
						<input name="municipalityName" value="<%= municipalityName %>" placeholder="Municipality name" <%= disableMunicipalityFields %> style="height:40px; border:1px solid #d1d5db; border-radius:8px; padding:0 10px; font-size:13px; font-family:'Inter',sans-serif;"/>
						<input value="<%= municipalityIdValue %>" placeholder="Municipality ID" disabled style="height:40px; border:1px solid #e5e7eb; border-radius:8px; padding:0 10px; font-size:13px; color:#6b7280; background:#f8fafc; font-family:'Inter',sans-serif;"/>
					</div>

					<div style="display:grid; grid-template-columns:1fr 1fr; gap:12px; margin-bottom:12px;">
						<input name="district" value="<%= district %>" placeholder="District" <%= disableMunicipalityFields %> style="height:40px; border:1px solid #d1d5db; border-radius:8px; padding:0 10px; font-size:13px; font-family:'Inter',sans-serif;"/>
						<input name="province" value="<%= province %>" placeholder="Province" <%= disableMunicipalityFields %> style="height:40px; border:1px solid #d1d5db; border-radius:8px; padding:0 10px; font-size:13px; font-family:'Inter',sans-serif;"/>
					</div>

					<div style="display:grid; grid-template-columns:1fr 1fr; gap:12px; margin-bottom:12px;">
						<input name="municipalityPhone" value="<%= municipalityPhone %>" placeholder="Municipality phone" <%= disableMunicipalityFields %> style="height:40px; border:1px solid #d1d5db; border-radius:8px; padding:0 10px; font-size:13px; font-family:'Inter',sans-serif;"/>
						<input value="<%= wardCount %>" placeholder="Ward count" disabled style="height:40px; border:1px solid #e5e7eb; border-radius:8px; padding:0 10px; font-size:13px; color:#6b7280; background:#f8fafc; font-family:'Inter',sans-serif;"/>
					</div>

					<div style="margin-bottom:12px;">
						<input name="officeAddress" value="<%= officeAddress %>" placeholder="Office address" <%= disableMunicipalityFields %> style="width:100%; height:40px; border:1px solid #d1d5db; border-radius:8px; padding:0 10px; font-size:13px; font-family:'Inter',sans-serif;"/>
					</div>

					<h3 style="font-size:14px; font-weight:700; color:#0f172a; margin:14px 0 10px;">Municipality Admin</h3>

					<% if (!adminExists && municipalityExists) { %>
						<div style="margin-bottom:12px; background:#fef3c7; border:1px solid #fde68a; border-radius:8px; padding:10px; font-size:12px; color:#92400e;">
							No municipal head account found in database. Admin fields are disabled.
						</div>
					<% } %>

					<div style="display:grid; grid-template-columns:1fr 1fr; gap:12px; margin-bottom:12px;">
						<input name="adminFirstName" value="<%= adminFirstName %>" placeholder="Admin first name" <%= disableAdminFields %> style="height:40px; border:1px solid #d1d5db; border-radius:8px; padding:0 10px; font-size:13px; font-family:'Inter',sans-serif;"/>
						<input name="adminLastName" value="<%= adminLastName %>" placeholder="Admin last name" <%= disableAdminFields %> style="height:40px; border:1px solid #d1d5db; border-radius:8px; padding:0 10px; font-size:13px; font-family:'Inter',sans-serif;"/>
					</div>

					<div style="display:grid; grid-template-columns:1fr 1fr; gap:12px; margin-bottom:12px;">
						<input name="adminEmail" type="email" value="<%= adminEmail %>" placeholder="Admin email" <%= disableAdminFields %> style="height:40px; border:1px solid #d1d5db; border-radius:8px; padding:0 10px; font-size:13px; font-family:'Inter',sans-serif;"/>
						<input name="adminPhone" value="<%= adminPhone %>" placeholder="Admin phone" <%= disableAdminFields %> style="height:40px; border:1px solid #d1d5db; border-radius:8px; padding:0 10px; font-size:13px; font-family:'Inter',sans-serif;"/>
					</div>

					<div style="margin-bottom:14px;">
						<select name="adminStatus" <%= disableAdminFields %> style="width:100%; height:40px; border:1px solid #d1d5db; border-radius:8px; padding:0 10px; font-size:13px; font-family:'Inter',sans-serif;">
							<option value="Active" <%= "Active".equalsIgnoreCase(adminStatus) ? "selected" : "" %>>Active</option>
							<option value="Pending" <%= "Pending".equalsIgnoreCase(adminStatus) ? "selected" : "" %>>Pending</option>
							<option value="Disabled" <%= "Disabled".equalsIgnoreCase(adminStatus) ? "selected" : "" %>>Disabled</option>
						</select>
					</div>

					<div style="display:flex; gap:8px; margin-bottom:10px;">
						<button type="submit" <%= municipalityExists ? "" : "disabled" %> style="background:#059669; color:#fff; border:none; padding:9px 16px; border-radius:8px; font-size:13px; font-weight:600; font-family:'Inter',sans-serif; <%= municipalityExists ? "cursor:pointer;" : "opacity:.6; cursor:not-allowed;" %>">Save changes</button>
					</div>
				</form>

				<form method="POST" action="<%= request.getContextPath() %>/admin/manage-municipality" style="display:flex; gap:8px; margin-bottom:8px;">
					<input type="hidden" name="action" value="reset-password"/>
					<input type="hidden" name="municipalityId" value="<%= municipalityIdValue %>"/>
					<input name="newPassword" type="password" placeholder="New admin password" <%= adminExists ? "" : "disabled" %> style="flex:1; height:40px; border:1px solid #d1d5db; border-radius:8px; padding:0 10px; font-size:13px; font-family:'Inter',sans-serif;"/>
					<button type="submit" <%= adminExists ? "" : "disabled" %> style="background:#fff; color:#b45309; border:1px solid #fcd34d; padding:9px 16px; border-radius:8px; font-size:13px; font-weight:600; font-family:'Inter',sans-serif; <%= adminExists ? "cursor:pointer;" : "opacity:.6; cursor:not-allowed;" %>">Reset password</button>
				</form>

				<form method="POST" action="<%= request.getContextPath() %>/admin/manage-municipality" style="display:flex;">
					<input type="hidden" name="action" value="disable"/>
					<input type="hidden" name="municipalityId" value="<%= municipalityIdValue %>"/>
					<button type="submit" <%= adminExists ? "" : "disabled" %> style="background:#fff; color:#dc2626; border:1px solid #fecaca; padding:9px 16px; border-radius:8px; font-size:13px; font-weight:600; font-family:'Inter',sans-serif; <%= adminExists ? "cursor:pointer;" : "opacity:.6; cursor:not-allowed;" %>">Disable municipality admin</button>
				</form>
			</div>

			<div style="display:flex; flex-direction:column; gap:14px;">
				<div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:16px;">
					<h3 style="font-size:13px; font-weight:700; color:#0f172a; margin:0 0 10px;">Operational Summary</h3>
					<p style="font-size:12px; color:#64748b; margin:0 0 8px;">Municipality ID: <%= municipalityIdValue.isEmpty() ? "N/A" : municipalityIdValue %></p>
					<p style="font-size:12px; color:#64748b; margin:0 0 8px;">Ward Count: <%= wardCount.isEmpty() ? "N/A" : wardCount %></p>
					<p style="font-size:12px; color:#64748b; margin:0;">Admin Status: <%= municipalityExists ? adminStatus : "N/A" %></p>
				</div>
				<div style="background:#ecfdf5; border:1px solid #bbf7d0; border-radius:10px; padding:16px;">
					<p style="font-size:12px; font-weight:700; color:#065f46; margin:0 0 4px;">Provisioning Tip</p>
					<p style="font-size:12px; color:#047857; margin:0; line-height:1.5;">When municipality or admin data is missing in database, this page keeps related controls disabled to prevent invalid updates.</p>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>
