<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setAttribute("activePage", "profile"); %>
<jsp:include page="../common/header.jsp"/>

<div class="flex min-h-screen">
	<jsp:include page="../common/municipality-sidebar.jsp"/>

	<div class="flex-1" style="margin-left:220px; background:#f8fafc; min-height:100vh;">
		<div style="padding:18px 32px; display:flex; align-items:center; justify-content:space-between; border-bottom:1px solid #e2e8f0; background:#fff;">
			<div>
				<h1 style="font-family:'Outfit',sans-serif; font-size:20px; font-weight:700; color:#0f172a; margin:0;">Municipality Profile</h1>
				<p style="font-size:13px; color:#64748b; margin:2px 0 0;">Update municipal head and office contact information.</p>
			</div>
			<div style="width:34px; height:34px; border-radius:50%; background:#059669; display:flex; align-items:center; justify-content:center; color:#fff; font-size:12px; font-weight:700;">SK</div>
		</div>

		<div style="padding:28px 32px;">
			<div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:28px; margin-bottom:16px;">
				<div style="display:flex; align-items:center; gap:18px;">
					<div style="width:64px; height:64px; border-radius:50%; background:#059669; display:flex; align-items:center; justify-content:center; color:#fff; font-family:'Outfit',sans-serif; font-size:22px; font-weight:800; flex-shrink:0;">SK</div>
					<div>
						<h2 style="font-family:'Outfit',sans-serif; font-size:24px; font-weight:800; color:#0f172a; margin:0 0 4px;">Sushila Karki</h2>
						<p style="font-size:13px; color:#64748b; margin:0 0 8px;">s.karki@ktm.gov.np</p>
						<div style="display:flex; gap:6px;">
							<span style="padding:3px 10px; border-radius:99px; font-size:11px; font-weight:600; background:#dcfce7; color:#166534;">Municipality Head</span>
							<span style="padding:3px 10px; border-radius:99px; font-size:11px; font-weight:600; background:#d1fae5; color:#065f46;">Verified Office</span>
						</div>
					</div>
				</div>
			</div>

			<div style="display:grid; grid-template-columns:1.4fr 1fr; gap:16px;">
				<div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:24px;">
					<h3 style="font-size:16px; font-weight:700; color:#0f172a; margin-bottom:18px;">Edit Municipality Profile</h3>

					<form action="#" method="post">
						<div style="display:grid; grid-template-columns:1fr 1fr; gap:12px; margin-bottom:12px;">
							<div>
								<label style="display:block; font-size:13px; font-weight:600; color:#374151; margin-bottom:5px;">Head first name</label>
								<input type="text" value="Sushila" style="width:100%; height:42px; border:1.5px solid #e5e7eb; border-radius:8px; padding:0 12px; font-size:14px; color:#111827; background:#fff; outline:none; font-family:'Inter',sans-serif;"/>
							</div>
							<div>
								<label style="display:block; font-size:13px; font-weight:600; color:#374151; margin-bottom:5px;">Head last name</label>
								<input type="text" value="Karki" style="width:100%; height:42px; border:1.5px solid #e5e7eb; border-radius:8px; padding:0 12px; font-size:14px; color:#111827; background:#fff; outline:none; font-family:'Inter',sans-serif;"/>
							</div>
						</div>

						<div style="margin-bottom:12px;">
							<label style="display:block; font-size:13px; font-weight:600; color:#374151; margin-bottom:5px;">Official email</label>
							<input type="email" value="s.karki@ktm.gov.np" style="width:100%; height:42px; border:1.5px solid #e5e7eb; border-radius:8px; padding:0 12px; font-size:14px; color:#111827; background:#fff; outline:none; font-family:'Inter',sans-serif;"/>
						</div>

						<div style="display:grid; grid-template-columns:1fr 1fr; gap:12px; margin-bottom:12px;">
							<div>
								<label style="display:block; font-size:13px; font-weight:600; color:#374151; margin-bottom:5px;">Office phone</label>
								<input type="tel" value="+977 01-4251234" style="width:100%; height:42px; border:1.5px solid #e5e7eb; border-radius:8px; padding:0 12px; font-size:14px; color:#111827; background:#fff; outline:none; font-family:'Inter',sans-serif;"/>
							</div>
							<div>
								<label style="display:block; font-size:13px; font-weight:600; color:#374151; margin-bottom:5px;">Emergency line</label>
								<input type="tel" value="+977 9851000000" style="width:100%; height:42px; border:1.5px solid #e5e7eb; border-radius:8px; padding:0 12px; font-size:14px; color:#111827; background:#fff; outline:none; font-family:'Inter',sans-serif;"/>
							</div>
						</div>

						<div style="margin-bottom:12px;">
							<label style="display:block; font-size:13px; font-weight:600; color:#374151; margin-bottom:5px;">Municipality name</label>
							<input type="text" value="Kathmandu Metropolitan City" style="width:100%; height:42px; border:1.5px solid #e5e7eb; border-radius:8px; padding:0 12px; font-size:14px; color:#111827; background:#fff; outline:none; font-family:'Inter',sans-serif;"/>
						</div>

						<div style="margin-bottom:18px;">
							<label style="display:block; font-size:13px; font-weight:600; color:#374151; margin-bottom:5px;">Office address</label>
							<input type="text" value="Bagdurbar, Kathmandu" style="width:100%; height:42px; border:1.5px solid #e5e7eb; border-radius:8px; padding:0 12px; font-size:14px; color:#111827; background:#fff; outline:none; font-family:'Inter',sans-serif;"/>
						</div>

						<button type="submit" style="background:#059669; color:#fff; border:none; font-weight:600; font-size:14px; padding:10px 22px; border-radius:8px; cursor:pointer; font-family:'Inter',sans-serif;">
							Save changes
						</button>
					</form>
				</div>

				<div style="display:flex; flex-direction:column; gap:16px;">
					<div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:20px;">
						<h3 style="font-size:12px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px; margin-bottom:14px;">Office</h3>
						<div style="display:flex; flex-direction:column; gap:12px;">
							<div><p style="font-size:12px; color:#94a3b8;">Municipality ID</p><p style="font-size:14px; font-weight:500; color:#0f172a;">KMC-NE-01</p></div>
							<div><p style="font-size:12px; color:#94a3b8;">Province</p><p style="font-size:14px; font-weight:500; color:#0f172a;">Bagmati Province</p></div>
							<div><p style="font-size:12px; color:#94a3b8;">Wards</p><p style="font-size:14px; font-weight:500; color:#0f172a;">32 active wards</p></div>
						</div>
					</div>

					<div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:20px;">
						<h3 style="font-size:12px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px; margin-bottom:14px;">Operations</h3>
						<div style="display:flex; flex-direction:column; gap:12px;">
							<div><p style="font-size:12px; color:#94a3b8;">Open issues</p><p style="font-size:14px; font-weight:500; color:#b91c1c;">156 active reports</p></div>
							<div><p style="font-size:12px; color:#94a3b8;">Average resolution time</p><p style="font-size:14px; font-weight:500; color:#0f172a;">4.2 days</p></div>
							<div><p style="font-size:12px; color:#94a3b8;">Compliance rate</p><p style="font-size:14px; font-weight:500; color:#059669;">91.4%</p></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>
