<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setAttribute("activePage", "citizens"); %>
<jsp:include page="../common/header.jsp"/>

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
				<div style="display:grid; grid-template-columns:1fr 1fr; gap:12px; margin-bottom:12px;">
					<input value="Ramesh" style="height:40px; border:1px solid #d1d5db; border-radius:8px; padding:0 10px; font-size:13px; font-family:'Inter',sans-serif;"/>
					<input value="Sharma" style="height:40px; border:1px solid #d1d5db; border-radius:8px; padding:0 10px; font-size:13px; font-family:'Inter',sans-serif;"/>
				</div>
				<div style="display:grid; grid-template-columns:1fr 1fr; gap:12px; margin-bottom:12px;">
					<input value="ramesh.s@gmail.com" style="height:40px; border:1px solid #d1d5db; border-radius:8px; padding:0 10px; font-size:13px; font-family:'Inter',sans-serif;"/>
					<input value="+977 9841000000" style="height:40px; border:1px solid #d1d5db; border-radius:8px; padding:0 10px; font-size:13px; font-family:'Inter',sans-serif;"/>
				</div>
				<div style="display:grid; grid-template-columns:1fr 1fr 1fr; gap:12px; margin-bottom:16px;">
					<input value="Ward 04" style="height:40px; border:1px solid #d1d5db; border-radius:8px; padding:0 10px; font-size:13px; font-family:'Inter',sans-serif;"/>
					<select style="height:40px; border:1px solid #d1d5db; border-radius:8px; padding:0 10px; font-size:13px; font-family:'Inter',sans-serif;"><option>Active</option><option>Pending</option><option>Suspended</option></select>
					<select style="height:40px; border:1px solid #d1d5db; border-radius:8px; padding:0 10px; font-size:13px; font-family:'Inter',sans-serif;"><option>Citizen</option></select>
				</div>
				<div style="display:flex; gap:8px;">
					<button style="background:#059669; color:#fff; border:none; padding:9px 16px; border-radius:8px; font-size:13px; font-weight:600; font-family:'Inter',sans-serif;">Save changes</button>
					<button style="background:#fff; color:#b45309; border:1px solid #fcd34d; padding:9px 16px; border-radius:8px; font-size:13px; font-weight:600; font-family:'Inter',sans-serif;">Suspend account</button>
					<button style="background:#fff; color:#dc2626; border:1px solid #fecaca; padding:9px 16px; border-radius:8px; font-size:13px; font-weight:600; font-family:'Inter',sans-serif;">Delete account</button>
				</div>
			</div>

			<div style="display:flex; flex-direction:column; gap:14px;">
				<div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:16px;">
					<h3 style="font-size:13px; font-weight:700; color:#0f172a; margin:0 0 10px;">Account Summary</h3>
					<p style="font-size:12px; color:#64748b; margin:0 0 8px;">Citizen ID: CT-001</p>
					<p style="font-size:12px; color:#64748b; margin:0 0 8px;">Joined: Oct 2023</p>
					<p style="font-size:12px; color:#64748b; margin:0;">Reports submitted: 12</p>
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
