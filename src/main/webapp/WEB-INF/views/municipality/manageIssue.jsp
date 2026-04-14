<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setAttribute("activePage", "issue-reports"); %>
<jsp:include page="../common/header.jsp"/>
<%
	String reportImageUrl = (String) request.getAttribute("reportImageUrl");
%>

<div class="flex min-h-screen">
	<jsp:include page="../common/municipality-sidebar.jsp"/>

	<div class="flex-1" style="margin-left:220px; background:#f8fafc; min-height:100vh;">
		<div style="padding:18px 32px; display:flex; align-items:center; justify-content:space-between; border-bottom:1px solid #e2e8f0; background:#fff;">
			<div>
				<h1 style="font-family:'Outfit',sans-serif; font-size:20px; font-weight:700; color:#0f172a; margin:0;">Manage Issue #NW-29402</h1>
				<p style="font-size:13px; color:#64748b; margin:2px 0 0;">Review issue details, assign resources, and update status.</p>
			</div>
			<a href="<%= request.getContextPath() %>/municipality/issue-list" style="padding:8px 14px; border-radius:7px; font-size:12px; font-weight:600; border:1px solid #e2e8f0; background:#fff; color:#64748b; text-decoration:none;">Back to Issue List</a>
		</div>

		<div style="padding:28px 32px;">
			<div style="display:grid; grid-template-columns:2fr 1fr; gap:16px;">
				<div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:20px;">
					<h2 style="font-size:16px; font-weight:700; color:#0f172a; margin:0 0 12px;">Issue Details</h2>
					<div style="display:grid; grid-template-columns:1fr 1fr; gap:12px; margin-bottom:14px;">
						<div><p style="font-size:12px; color:#94a3b8; margin:0 0 4px;">Title</p><p style="font-size:14px; color:#1f2937; font-weight:600; margin:0;">Broken water pipeline</p></div>
						<div><p style="font-size:12px; color:#94a3b8; margin:0 0 4px;">Category</p><p style="font-size:14px; color:#1f2937; font-weight:600; margin:0;">Water Supply</p></div>
						<div><p style="font-size:12px; color:#94a3b8; margin:0 0 4px;">Ward</p><p style="font-size:14px; color:#1f2937; font-weight:600; margin:0;">Ward 04</p></div>
						<div><p style="font-size:12px; color:#94a3b8; margin:0 0 4px;">Upvotes</p><p style="font-size:14px; color:#1f2937; font-weight:600; margin:0;">34</p></div>
					</div>

					<div style="margin-bottom:16px;">
						<p style="font-size:12px; color:#94a3b8; margin:0 0 4px;">Description</p>
						<p style="font-size:13px; color:#334155; line-height:1.6; margin:0;">Main pipeline is leaking near Teku bridge intersection. Water is accumulating and road surface is getting damaged. Urgent repair requested by local residents.</p>
					</div>

					<div style="margin-bottom:16px;">
						<p style="font-size:12px; color:#94a3b8; margin:0 0 6px;">Municipality Notes</p>
						<textarea rows="4" style="width:100%; border:1px solid #d1d5db; border-radius:8px; padding:10px; font-size:13px; color:#1f2937; font-family:'Inter',sans-serif; resize:vertical;">Inspection requested from water unit. Need temporary road barricade before excavation starts.</textarea>
					</div>

					<div style="display:grid; grid-template-columns:1fr 1fr 1fr; gap:10px; margin-bottom:16px;">
						<div>
							<label style="display:block; font-size:12px; color:#6b7280; margin-bottom:4px;">Status</label>
							<select style="width:100%; height:38px; border:1px solid #d1d5db; border-radius:8px; padding:0 10px; font-size:13px; font-family:'Inter',sans-serif;">
								<option>Open</option>
								<option selected>In Progress</option>
								<option>Resolved</option>
								<option>Rejected</option>
							</select>
						</div>
						<div>
							<label style="display:block; font-size:12px; color:#6b7280; margin-bottom:4px;">Priority</label>
							<select style="width:100%; height:38px; border:1px solid #d1d5db; border-radius:8px; padding:0 10px; font-size:13px; font-family:'Inter',sans-serif;">
								<option>Low</option>
								<option selected>Medium</option>
								<option>High</option>
								<option>Critical</option>
							</select>
						</div>
						<div>
							<label style="display:block; font-size:12px; color:#6b7280; margin-bottom:4px;">Assign To</label>
							<select style="width:100%; height:38px; border:1px solid #d1d5db; border-radius:8px; padding:0 10px; font-size:13px; font-family:'Inter',sans-serif;">
								<option selected>Water Unit Team A</option>
								<option>Water Unit Team B</option>
								<option>Road Maintenance Team</option>
							</select>
						</div>
					</div>

					<div style="display:flex; gap:8px; flex-wrap:wrap;">
						<a href="<%= request.getContextPath() %>/municipality/issue-list" style="background:#fff; color:#64748b; border:1px solid #e2e8f0; padding:9px 16px; border-radius:8px; font-size:13px; font-weight:600; cursor:pointer; font-family:'Inter',sans-serif; text-decoration:none; display:inline-block;">Return to Issue List</a>
						<button style="background:#059669; color:#fff; border:none; padding:9px 16px; border-radius:8px; font-size:13px; font-weight:600; cursor:pointer; font-family:'Inter',sans-serif;">Save changes</button>
						<button style="background:#fff; color:#64748b; border:1px solid #e2e8f0; padding:9px 16px; border-radius:8px; font-size:13px; font-weight:600; cursor:pointer; font-family:'Inter',sans-serif;">Send citizen update</button>
					</div>
				</div>

				<div style="display:flex; flex-direction:column; gap:14px;">
					<div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:16px;">
						<h3 style="font-size:13px; font-weight:700; color:#0f172a; margin:0 0 10px;">Reported Image</h3>
						<% if (reportImageUrl != null && !reportImageUrl.trim().isEmpty()) { %>
							<img src="<%= reportImageUrl %>" alt="Issue image uploaded by citizen" style="width:100%; height:190px; object-fit:cover; border-radius:8px; border:1px solid #e2e8f0;"/>
						<% } else { %>
							<div style="height:190px; border:1px dashed #cbd5e1; border-radius:8px; background:#f8fafc; display:flex; align-items:center; justify-content:center; flex-direction:column; gap:8px;">
								<svg width="26" height="26" fill="none" stroke="#94a3b8" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M3 7a2 2 0 012-2h14a2 2 0 012 2v10a2 2 0 01-2 2H5a2 2 0 01-2-2V7z"/><path stroke-linecap="round" stroke-linejoin="round" d="M8.5 11a1.5 1.5 0 110-3 1.5 1.5 0 010 3z"/><path stroke-linecap="round" stroke-linejoin="round" d="M21 15l-5-5L5 21"/></svg>
								<p style="font-size:12px; color:#64748b; margin:0;">No preview available in demo data</p>
							</div>
						<% } %>
						<p style="font-size:11px; color:#94a3b8; margin:8px 0 0;">Citizens can submit issue reports with supporting images.</p>
					</div>

					<div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:16px;">
						<h3 style="font-size:13px; font-weight:700; color:#0f172a; margin:0 0 10px;">Reporter</h3>
						<p style="font-size:13px; color:#1f2937; margin:0 0 4px; font-weight:600;">Ramesh Sharma</p>
						<p style="font-size:12px; color:#64748b; margin:0 0 2px;">Ward 04 Resident</p>
						<p style="font-size:12px; color:#64748b; margin:0;">ramesh.sharma@mail.com</p>
					</div>

					<div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:16px;">
						<h3 style="font-size:13px; font-weight:700; color:#0f172a; margin:0 0 10px;">Timeline</h3>
						<p style="font-size:12px; color:#334155; margin:0 0 8px;">10:18 AM: Issue reported by citizen</p>
						<p style="font-size:12px; color:#334155; margin:0 0 8px;">10:41 AM: Auto-assigned to Ward 04 desk</p>
						<p style="font-size:12px; color:#334155; margin:0;">11:05 AM: Marked In Progress by officer</p>
					</div>

					<div style="background:#ecfdf5; border:1px solid #bbf7d0; border-radius:10px; padding:16px;">
						<p style="font-size:12px; font-weight:700; color:#065f46; margin:0 0 4px;">Recommendation</p>
						<p style="font-size:12px; color:#047857; margin:0; line-height:1.5;">This report has high public impact. Consider upgrading to High priority if work does not start in next 2 hours.</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>
