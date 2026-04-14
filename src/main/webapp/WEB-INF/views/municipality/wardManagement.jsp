<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setAttribute("activePage", "ward-management"); %>
<jsp:include page="../common/header.jsp"/>

<div class="flex min-h-screen">
	<jsp:include page="../common/municipality-sidebar.jsp"/>

	<div class="flex-1" style="margin-left:220px; background:#f8fafc; min-height:100vh;">
		<div style="padding:18px 32px; display:flex; align-items:center; justify-content:space-between; border-bottom:1px solid #e2e8f0; background:#fff;">
			<div>
				<h1 style="font-family:'Outfit',sans-serif; font-size:20px; font-weight:700; color:#0f172a; margin:0;">Ward Management</h1>
				<p style="font-size:13px; color:#64748b; margin:2px 0 0;">Add, update, or remove wards and maintain ward head contact details.</p>
			</div>
			<button style="background:#059669; color:#fff; border:none; padding:9px 16px; border-radius:8px; font-size:13px; font-weight:600; cursor:pointer; font-family:'Inter',sans-serif;">Add New Ward</button>
		</div>

		<div style="padding:28px 32px;">
			<div style="display:grid; grid-template-columns:2fr 1fr; gap:16px;">
				<div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; overflow:hidden;">
					<div style="padding:14px 18px; border-bottom:1px solid #f1f5f9; display:flex; justify-content:space-between; align-items:center;">
						<h2 style="font-size:15px; font-weight:700; color:#0f172a; margin:0;">Ward Directory</h2>
						<input type="text" placeholder="Search ward or head" style="height:34px; border:1px solid #d1d5db; border-radius:7px; padding:0 10px; font-size:12px; font-family:'Inter',sans-serif;"/>
					</div>

					<table style="width:100%; border-collapse:collapse;">
						<thead>
							<tr style="border-bottom:1px solid #f1f5f9;">
								<th style="text-align:left; padding:12px 18px; font-size:11px; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Ward</th>
								<th style="text-align:left; padding:12px 18px; font-size:11px; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Ward Head</th>
								<th style="text-align:left; padding:12px 18px; font-size:11px; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Contact</th>
								<th style="text-align:left; padding:12px 18px; font-size:11px; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Status</th>
								<th style="text-align:right; padding:12px 18px;"></th>
							</tr>
						</thead>
						<tbody>
							<tr style="border-bottom:1px solid #f8fafc;">
								<td style="padding:13px 18px; font-size:13px; font-weight:600; color:#1f2937;">Ward 02</td>
								<td style="padding:13px 18px; font-size:13px; color:#475569;">Anil Basnet</td>
								<td style="padding:13px 18px; font-size:13px; color:#475569;">+977 9851002202</td>
								<td style="padding:13px 18px;"><span style="font-size:11px; font-weight:600; color:#166534; background:#dcfce7; padding:3px 9px; border-radius:99px;">Active</span></td>
								<td style="padding:13px 18px; text-align:right;"><a href="#" style="font-size:12px; color:#059669; text-decoration:none; font-weight:600;">Edit</a> <span style="color:#cbd5e1;">|</span> <a href="#" style="font-size:12px; color:#dc2626; text-decoration:none; font-weight:600;">Remove</a></td>
							</tr>
							<tr style="border-bottom:1px solid #f8fafc;">
								<td style="padding:13px 18px; font-size:13px; font-weight:600; color:#1f2937;">Ward 04</td>
								<td style="padding:13px 18px; font-size:13px; color:#475569;">Pratima Shrestha</td>
								<td style="padding:13px 18px; font-size:13px; color:#475569;">+977 9851004404</td>
								<td style="padding:13px 18px;"><span style="font-size:11px; font-weight:600; color:#166534; background:#dcfce7; padding:3px 9px; border-radius:99px;">Active</span></td>
								<td style="padding:13px 18px; text-align:right;"><a href="#" style="font-size:12px; color:#059669; text-decoration:none; font-weight:600;">Edit</a> <span style="color:#cbd5e1;">|</span> <a href="#" style="font-size:12px; color:#dc2626; text-decoration:none; font-weight:600;">Remove</a></td>
							</tr>
							<tr style="border-bottom:1px solid #f8fafc;">
								<td style="padding:13px 18px; font-size:13px; font-weight:600; color:#1f2937;">Ward 09</td>
								<td style="padding:13px 18px; font-size:13px; color:#475569;">Suman Maharjan</td>
								<td style="padding:13px 18px; font-size:13px; color:#475569;">+977 9851009909</td>
								<td style="padding:13px 18px;"><span style="font-size:11px; font-weight:600; color:#166534; background:#dcfce7; padding:3px 9px; border-radius:99px;">Active</span></td>
								<td style="padding:13px 18px; text-align:right;"><a href="#" style="font-size:12px; color:#059669; text-decoration:none; font-weight:600;">Edit</a> <span style="color:#cbd5e1;">|</span> <a href="#" style="font-size:12px; color:#dc2626; text-decoration:none; font-weight:600;">Remove</a></td>
							</tr>
							<tr>
								<td style="padding:13px 18px; font-size:13px; font-weight:600; color:#1f2937;">Ward 15</td>
								<td style="padding:13px 18px; font-size:13px; color:#475569;">Pooja Khatri</td>
								<td style="padding:13px 18px; font-size:13px; color:#475569;">+977 9851015515</td>
								<td style="padding:13px 18px;"><span style="font-size:11px; font-weight:600; color:#92400e; background:#fef3c7; padding:3px 9px; border-radius:99px;">Pending</span></td>
								<td style="padding:13px 18px; text-align:right;"><a href="#" style="font-size:12px; color:#059669; text-decoration:none; font-weight:600;">Edit</a> <span style="color:#cbd5e1;">|</span> <a href="#" style="font-size:12px; color:#dc2626; text-decoration:none; font-weight:600;">Remove</a></td>
							</tr>
						</tbody>
					</table>
				</div>

				<div style="display:flex; flex-direction:column; gap:14px;">
					<div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:16px;">
						<h3 style="font-size:14px; font-weight:700; color:#0f172a; margin:0 0 12px;">Add / Update Ward</h3>

						<label style="display:block; font-size:12px; color:#6b7280; margin-bottom:4px;">Ward Number</label>
						<input type="text" value="Ward 16" style="width:100%; height:36px; border:1px solid #d1d5db; border-radius:7px; padding:0 10px; font-size:13px; margin-bottom:10px; font-family:'Inter',sans-serif;"/>

						<label style="display:block; font-size:12px; color:#6b7280; margin-bottom:4px;">Ward Head Name</label>
						<input type="text" value="" placeholder="Full name" style="width:100%; height:36px; border:1px solid #d1d5db; border-radius:7px; padding:0 10px; font-size:13px; margin-bottom:10px; font-family:'Inter',sans-serif;"/>

						<label style="display:block; font-size:12px; color:#6b7280; margin-bottom:4px;">Contact Number</label>
						<input type="text" value="" placeholder="+977 ..." style="width:100%; height:36px; border:1px solid #d1d5db; border-radius:7px; padding:0 10px; font-size:13px; margin-bottom:12px; font-family:'Inter',sans-serif;"/>

						<div style="display:flex; gap:8px;">
							<button style="flex:1; background:#059669; color:#fff; border:none; height:36px; border-radius:7px; font-size:12px; font-weight:600; cursor:pointer; font-family:'Inter',sans-serif;">Save</button>
							<button style="flex:1; background:#fff; color:#dc2626; border:1px solid #fecaca; height:36px; border-radius:7px; font-size:12px; font-weight:600; cursor:pointer; font-family:'Inter',sans-serif;">Remove</button>
						</div>
					</div>

					<div style="background:#ecfdf5; border:1px solid #bbf7d0; border-radius:10px; padding:16px;">
						<p style="font-size:12px; font-weight:700; color:#065f46; margin:0 0 4px;">Tip</p>
						<p style="font-size:12px; color:#047857; margin:0; line-height:1.5;">Keep ward contact details updated so issue escalation reaches the right ward head quickly.</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>
