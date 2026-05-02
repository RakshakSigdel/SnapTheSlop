<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setAttribute("activePage", "profile"); %>
<jsp:include page="../common/header.jsp"/>

<%
	// Safely read user information from session using reflection to avoid compile-time coupling
	Object userObj = session.getAttribute("user");
	String firstName = "";
	String lastName = "";
	String fullName = "";
	String email = "";
	String municipalityName = "";
	String municipalityId = "";
	String province = "";
	String officePhone = "";
	String emergencyLine = "";
	String officeAddress = "";
	String wardsCount = "";
	String openIssuesCount = "";
	String avgResolutionTime = "";
	String complianceRate = "";

	if (userObj != null) {
		try {
			java.lang.reflect.Method m;
			try { m = userObj.getClass().getMethod("getFirstName"); Object v = m.invoke(userObj); if (v!=null) firstName = v.toString(); } catch (Exception e){}
			try { m = userObj.getClass().getMethod("getLastName"); Object v = m.invoke(userObj); if (v!=null) lastName = v.toString(); } catch (Exception e){}
			try { m = userObj.getClass().getMethod("getFullName"); Object v = m.invoke(userObj); if (v!=null) fullName = v.toString(); } catch (Exception e){}
			try { m = userObj.getClass().getMethod("getEmail"); Object v = m.invoke(userObj); if (v!=null) email = v.toString(); } catch (Exception e){}
			try { m = userObj.getClass().getMethod("getMunicipalityName"); Object v = m.invoke(userObj); if (v!=null) municipalityName = v.toString(); } catch (Exception e){}
			try { m = userObj.getClass().getMethod("getMunicipalityId"); Object v = m.invoke(userObj); if (v!=null) municipalityId = v.toString(); } catch (Exception e){}
			try { m = userObj.getClass().getMethod("getProvince"); Object v = m.invoke(userObj); if (v!=null) province = v.toString(); } catch (Exception e){}
			try { m = userObj.getClass().getMethod("getOfficePhone"); Object v = m.invoke(userObj); if (v!=null) officePhone = v.toString(); } catch (Exception e){}
			try { m = userObj.getClass().getMethod("getEmergencyLine"); Object v = m.invoke(userObj); if (v!=null) emergencyLine = v.toString(); } catch (Exception e){}
			try { m = userObj.getClass().getMethod("getOfficeAddress"); Object v = m.invoke(userObj); if (v!=null) officeAddress = v.toString(); } catch (Exception e){}
			try { m = userObj.getClass().getMethod("getWardsCount"); Object v = m.invoke(userObj); if (v!=null) wardsCount = v.toString(); } catch (Exception e){}
			try { m = userObj.getClass().getMethod("getOpenIssuesCount"); Object v = m.invoke(userObj); if (v!=null) openIssuesCount = v.toString(); } catch (Exception e){}
			try { m = userObj.getClass().getMethod("getAvgResolutionTime"); Object v = m.invoke(userObj); if (v!=null) avgResolutionTime = v.toString(); } catch (Exception e){}
			try { m = userObj.getClass().getMethod("getComplianceRate"); Object v = m.invoke(userObj); if (v!=null) complianceRate = v.toString(); } catch (Exception e){}
		} catch (Exception e) {
			// ignore
		}
	}

	if ((fullName == null || fullName.isEmpty()) && (firstName != null && !firstName.isEmpty())) {
		fullName = firstName + (lastName!=null && lastName.length()>0 ? " " + lastName : "");
	}

	String initials = "NA";
	try {
		StringBuilder sb = new StringBuilder();
		if (firstName != null && firstName.length() > 0) sb.append(Character.toUpperCase(firstName.charAt(0)));
		if (lastName != null && lastName.length() > 0) sb.append(Character.toUpperCase(lastName.charAt(0)));
		if (sb.length() > 0) initials = sb.toString();
	} catch (Exception e) { initials = "NA"; }
%>

<div class="flex min-h-screen">
	<jsp:include page="../common/municipality-sidebar.jsp"/>

	<div class="flex-1" style="margin-left:220px; background:#f8fafc; min-height:100vh;">
		<div style="padding:18px 32px; display:flex; align-items:center; justify-content:space-between; border-bottom:1px solid #e2e8f0; background:#fff;">
			<div>
				<h1 style="font-family:'Outfit',sans-serif; font-size:20px; font-weight:700; color:#0f172a; margin:0;">Municipality Profile</h1>
				<p style="font-size:13px; color:#64748b; margin:2px 0 0;">Update municipal head and office contact information.</p>
			</div>
			<div style="width:34px; height:34px; border-radius:50%; background:#059669; display:flex; align-items:center; justify-content:center; color:#fff; font-size:12px; font-weight:700;"><%= initials %></div>
		</div>

		<div style="padding:28px 32px;">
		<%
			String profileSuccess = (String) session.getAttribute("profileSuccess");
			if (profileSuccess != null) {
		%>
			<div style="background:#d1fae5; color:#065f46; padding:12px 14px; border-radius:8px; margin-bottom:16px; font-size:13px; border:1px solid #a7f3d0;">
				<%= profileSuccess %>
			</div>
		<%
				session.removeAttribute("profileSuccess");
			}
		%>
			<div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:28px; margin-bottom:16px;">
				<div style="display:flex; align-items:center; gap:18px;">
					<div style="width:64px; height:64px; border-radius:50%; background:#059669; display:flex; align-items:center; justify-content:center; color:#fff; font-family:'Outfit',sans-serif; font-size:22px; font-weight:800; flex-shrink:0;"><%= initials %></div>
					<div>
						<h2 style="font-family:'Outfit',sans-serif; font-size:24px; font-weight:800; color:#0f172a; margin:0 0 4px;"><%= (fullName==null || fullName.isEmpty()) ? "Municipality Head" : fullName %></h2>
						<p style="font-size:13px; color:#64748b; margin:0 0 8px;"><%= (email==null || email.isEmpty()) ? "-" : email %></p>
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

					<form id="municipalityProfileForm" action="<%= request.getContextPath() %>/municipality/profile" method="post">
						<div style="display:grid; grid-template-columns:1fr 1fr; gap:12px; margin-bottom:12px;">
							<div>
								<label style="display:block; font-size:13px; font-weight:600; color:#374151; margin-bottom:5px;">Head first name</label>
								<input type="text" name="headFirstName" value="<%= firstName %>" style="width:100%; height:42px; border:1.5px solid #e5e7eb; border-radius:8px; padding:0 12px; font-size:14px; color:#111827; background:#fff; outline:none; font-family:'Inter',sans-serif;"/>
							</div>
							<div>
								<label style="display:block; font-size:13px; font-weight:600; color:#374151; margin-bottom:5px;">Head last name</label>
								<input type="text" name="headLastName" value="<%= lastName %>" style="width:100%; height:42px; border:1.5px solid #e5e7eb; border-radius:8px; padding:0 12px; font-size:14px; color:#111827; background:#fff; outline:none; font-family:'Inter',sans-serif;"/>
							</div>
						</div>

						<div style="margin-bottom:12px;">
							<label style="display:block; font-size:13px; font-weight:600; color:#374151; margin-bottom:5px;">Official email</label>
							<input type="email" name="officialEmail" value="<%= email %>" style="width:100%; height:42px; border:1.5px solid #e5e7eb; border-radius:8px; padding:0 12px; font-size:14px; color:#111827; background:#fff; outline:none; font-family:'Inter',sans-serif;"/>
						</div>

						<div style="display:grid; grid-template-columns:1fr 1fr; gap:12px; margin-bottom:12px;">
							<div>
								<label style="display:block; font-size:13px; font-weight:600; color:#374151; margin-bottom:5px;">Office phone</label>
								<input type="tel" name="officePhone" value="<%= officePhone %>" style="width:100%; height:42px; border:1.5px solid #e5e7eb; border-radius:8px; padding:0 12px; font-size:14px; color:#111827; background:#fff; outline:none; font-family:'Inter',sans-serif;"/>
							</div>
							<div>
								<label style="display:block; font-size:13px; font-weight:600; color:#374151; margin-bottom:5px;">Emergency line</label>
								<input type="tel" name="emergencyLine" value="<%= emergencyLine %>" style="width:100%; height:42px; border:1.5px solid #e5e7eb; border-radius:8px; padding:0 12px; font-size:14px; color:#111827; background:#fff; outline:none; font-family:'Inter',sans-serif;"/>
							</div>
						</div>

						<div style="margin-bottom:12px;">
							<label style="display:block; font-size:13px; font-weight:600; color:#374151; margin-bottom:5px;">Municipality name</label>
							<input type="text" name="municipalityName" value="<%= municipalityName %>" style="width:100%; height:42px; border:1.5px solid #e5e7eb; border-radius:8px; padding:0 12px; font-size:14px; color:#111827; background:#fff; outline:none; font-family:'Inter',sans-serif;"/>
						</div>

						<div style="margin-bottom:18px;">
							<label style="display:block; font-size:13px; font-weight:600; color:#374151; margin-bottom:5px;">Office address</label>
							<input type="text" name="officeAddress" value="<%= officeAddress %>" style="width:100%; height:42px; border:1.5px solid #e5e7eb; border-radius:8px; padding:0 12px; font-size:14px; color:#111827; background:#fff; outline:none; font-family:'Inter',sans-serif;"/>
						</div>

						<div style="display:flex; gap:8px; align-items:center;">
							<button id="editBtn" type="button" style="background:#ffffff; color:#059669; border:1px solid #059669; font-weight:600; font-size:14px; padding:8px 18px; border-radius:8px; cursor:pointer; font-family:'Inter',sans-serif;">Edit</button>
							<button id="cancelEditBtn" type="button" style="background:#fff; color:#6b7280; border:1px solid #e5e7eb; font-weight:600; font-size:14px; padding:8px 18px; border-radius:8px; cursor:pointer; font-family:'Inter',sans-serif; display:none;">Cancel</button>
							<button id="saveChangesBtn" type="submit" style="background:#059669; color:#fff; border:none; font-weight:600; font-size:14px; padding:10px 22px; border-radius:8px; cursor:pointer; font-family:'Inter',sans-serif; display:none;">Save changes</button>
						</div>
					</form>
				</div>

				<div style="display:flex; flex-direction:column; gap:16px;">
					<div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:20px;">
						<h3 style="font-size:12px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px; margin-bottom:14px;">Office</h3>
						<div style="display:flex; flex-direction:column; gap:12px;">
							<div><p style="font-size:12px; color:#94a3b8;">Municipality ID</p><p style="font-size:14px; font-weight:500; color:#0f172a;"><%= (municipalityId==null||municipalityId.isEmpty())?"-":municipalityId %></p></div>
							<div><p style="font-size:12px; color:#94a3b8;">Province</p><p style="font-size:14px; font-weight:500; color:#0f172a;"><%= (province==null||province.isEmpty())?"-":province %></p></div>
							<div><p style="font-size:12px; color:#94a3b8;">Wards</p><p style="font-size:14px; font-weight:500; color:#0f172a;"><%= (wardsCount==null||wardsCount.isEmpty())?"-":(wardsCount + " active wards") %></p></div>
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
				</div>

				<script>
				  (function(){
					var form = document.getElementById('municipalityProfileForm');
					var editBtn = document.getElementById('editBtn');
					var cancelBtn = document.getElementById('cancelEditBtn');
					var saveBtn = document.getElementById('saveChangesBtn');
					if (!form) return;

					// disable all form controls initially
					function setReadonly(readonly) {
					  var elements = form.querySelectorAll('input, textarea, select');
					  elements.forEach(function(el){
						if (readonly) {
						  el.setAttribute('disabled','disabled');
						} else {
						  el.removeAttribute('disabled');
						}
					  });
					}

					// store original values to allow cancel
					var orig = {};
					Array.from(form.elements).forEach(function(el){ if (el.name) orig[el.name] = el.value; });

					setReadonly(true);

					editBtn && editBtn.addEventListener('click', function(){
					  setReadonly(false);
					  editBtn.style.display = 'none';
					  cancelBtn.style.display = 'inline-block';
					  saveBtn.style.display = 'inline-block';
					});

					cancelBtn && cancelBtn.addEventListener('click', function(){
					  // restore original values
					  Array.from(form.elements).forEach(function(el){ if (el.name && orig.hasOwnProperty(el.name)) el.value = orig[el.name]; });
					  setReadonly(true);
					  editBtn.style.display = 'inline-block';
					  cancelBtn.style.display = 'none';
					  saveBtn.style.display = 'none';
					});

					// when form submits, leave native flow; server redirects back with flash message
				  })();
				</script>
</body>
</html>
