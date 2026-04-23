<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.snaptheslop.snaptheslop.municipality.model.Municipality" %>
<jsp:include page="../common/header.jsp"/>

<%
    Object profileUserObj = request.getAttribute("profileUser");
    String firstName = "Ramesh", lastName = "Yadav", email = "ramesh.yadav@municipality.gov.np";
    String phone = "+977 9841123456", role = "Registered Citizen", status = "Verified Account";
    String municipality = "Janakpur Sub-Metropolitan City", wardNo = "Ward No. 7";
    String memberSince = "Jan 2023", province = "Madhesh Province", userId = "NS-UI-000001";
    String initials = (String) request.getAttribute("profileInitials");
    if (initials == null) initials = "RY";
    List<Municipality> municipalities = (List<Municipality>) request.getAttribute("municipalities");

    if (profileUserObj != null) {
        try {
            java.lang.reflect.Method gfn = profileUserObj.getClass().getMethod("getFirstName");
            java.lang.reflect.Method gln = profileUserObj.getClass().getMethod("getLastName");
            java.lang.reflect.Method gem = profileUserObj.getClass().getMethod("getEmail");
            java.lang.reflect.Method gpn = profileUserObj.getClass().getMethod("getPhoneNumber");
            java.lang.reflect.Method grl = profileUserObj.getClass().getMethod("getRole");
            java.lang.reflect.Method gas = profileUserObj.getClass().getMethod("getAccountStatus");
            java.lang.reflect.Method gmu = profileUserObj.getClass().getMethod("getMunicipality");
            java.lang.reflect.Method gwn = profileUserObj.getClass().getMethod("getWardNo");
            java.lang.reflect.Method gms = profileUserObj.getClass().getMethod("getMemberSince");
            java.lang.reflect.Method gpr = profileUserObj.getClass().getMethod("getProvince");
            java.lang.reflect.Method gui = profileUserObj.getClass().getMethod("getUserId");
            Object fn = gfn.invoke(profileUserObj); if (fn != null) firstName = fn.toString();
            Object ln = gln.invoke(profileUserObj); if (ln != null) lastName = ln.toString();
            Object em = gem.invoke(profileUserObj); if (em != null) email = em.toString();
            Object pn = gpn.invoke(profileUserObj); if (pn != null) phone = pn.toString();
            Object rl = grl.invoke(profileUserObj); if (rl != null) role = rl.toString();
            Object as = gas.invoke(profileUserObj); if (as != null) status = as.toString();
            Object mu = gmu.invoke(profileUserObj); if (mu != null) municipality = mu.toString();
            Object wn = gwn.invoke(profileUserObj); if (wn != null) wardNo = wn.toString();
            Object ms = gms.invoke(profileUserObj); if (ms != null) memberSince = ms.toString();
            Object pr = gpr.invoke(profileUserObj); if (pr != null) province = pr.toString();
            Object ui = gui.invoke(profileUserObj); if (ui != null) userId = ui.toString();
        } catch (Exception ignored) {}
    }
%>

<div class="flex min-h-screen">
  <jsp:include page="../common/citizen-sidebar.jsp"/>

  <div class="flex-1" style="margin-left:220px; background:#f8fafc; min-height:100vh;">

    <div style="padding:18px 32px; display:flex; align-items:center; justify-content:space-between; border-bottom:1px solid #e2e8f0; background:#fff;">
      <div>
        <h1 style="font-family:'Outfit',sans-serif; font-size:20px; font-weight:700; color:#0f172a; margin:0;">My Profile</h1>
        <p style="font-size:13px; color:#64748b; margin:2px 0 0;">Manage your personal and municipality details.</p>
      </div>
      <div style="width:34px; height:34px; border-radius:50%; background:#059669; display:flex; align-items:center; justify-content:center; color:#fff; font-size:12px; font-weight:700;">
        <%= initials %>
      </div>
    </div>

    <div style="padding:28px 32px;">
      <% if (request.getAttribute("success") != null) { %>
      <div style="background:#d1fae5; color:#065f46; padding:12px 14px; border-radius:8px; margin-bottom:16px; font-size:13px; border:1px solid #a7f3d0;">
          <%= request.getAttribute("success") %>
      </div>
      <% } %>
      <% if (request.getAttribute("error") != null) { %>
      <div style="background:#fef2f2; color:#dc2626; padding:12px 14px; border-radius:8px; margin-bottom:16px; font-size:13px; border:1px solid #fecaca;">
          <%= request.getAttribute("error") %>
      </div>
      <% } %>

      <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:28px; margin-bottom:16px;">
        <div style="display:flex; align-items:center; gap:18px;">
          <div style="width:64px; height:64px; border-radius:50%; background:#059669; display:flex; align-items:center; justify-content:center; color:#fff; font-family:'Outfit',sans-serif; font-size:22px; font-weight:800; flex-shrink:0;">
            <%= initials %>
          </div>
          <div>
            <h2 style="font-family:'Outfit',sans-serif; font-size:24px; font-weight:800; color:#0f172a; margin:0 0 4px;"><%= firstName %> <%= lastName %></h2>
            <p style="font-size:13px; color:#64748b; margin:0 0 8px;"><%= email %></p>
            <div style="display:flex; gap:6px;">
              <span style="padding:3px 10px; border-radius:99px; font-size:11px; font-weight:600; background:#dcfce7; color:#166534;"><%= role %></span>
              <span style="padding:3px 10px; border-radius:99px; font-size:11px; font-weight:600; background:#d1fae5; color:#065f46;"><%= status %></span>
            </div>
          </div>
        </div>
      </div>

      <div style="display:grid; grid-template-columns:1.4fr 1fr; gap:16px;">
        <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:24px;">
          <h3 style="font-size:16px; font-weight:700; color:#0f172a; margin-bottom:18px;">Edit Profile</h3>

          <form action="<%= request.getContextPath() %>/citizen/profile" method="post">
            <div style="display:grid; grid-template-columns:1fr 1fr; gap:12px; margin-bottom:12px;">
              <div>
                <label style="display:block; font-size:13px; font-weight:600; color:#374151; margin-bottom:5px;">First name</label>
                <input type="text" name="firstName" value="<%= firstName %>" style="width:100%; height:42px; border:1.5px solid #e5e7eb; border-radius:8px; padding:0 12px; font-size:14px; color:#111827; background:#fff; outline:none; font-family:'Inter',sans-serif;"/>
              </div>
              <div>
                <label style="display:block; font-size:13px; font-weight:600; color:#374151; margin-bottom:5px;">Last name</label>
                <input type="text" name="lastName" value="<%= lastName %>" style="width:100%; height:42px; border:1.5px solid #e5e7eb; border-radius:8px; padding:0 12px; font-size:14px; color:#111827; background:#fff; outline:none; font-family:'Inter',sans-serif;"/>
              </div>
            </div>

            <div style="margin-bottom:12px;">
              <label style="display:block; font-size:13px; font-weight:600; color:#374151; margin-bottom:5px;">Phone</label>
              <input type="tel" name="phoneNumber" value="<%= phone %>" style="width:100%; height:42px; border:1.5px solid #e5e7eb; border-radius:8px; padding:0 12px; font-size:14px; color:#111827; background:#fff; outline:none; font-family:'Inter',sans-serif;"/>
            </div>

            <div style="margin-bottom:12px;">
              <label style="display:block; font-size:13px; font-weight:600; color:#374151; margin-bottom:5px;">Municipality</label>
              <select name="municipality" required style="width:100%; height:42px; border:1.5px solid #e5e7eb; border-radius:8px; padding:0 12px; font-size:14px; color:#111827; background:#fff; outline:none; font-family:'Inter',sans-serif;">
                <option value="" disabled <%= (municipality == null || municipality.isBlank()) ? "selected" : "" %>>Select municipality</option>
                <% if (municipalities != null) {
                    for (Municipality muni : municipalities) {
                        String muniName = muni.getName();
                        boolean selected = muniName != null && muniName.equalsIgnoreCase(municipality);
                %>
                  <option value="<%= muniName %>" <%= selected ? "selected" : "" %>><%= muniName %></option>
                <%  }
                   } %>
              </select>
            </div>

            <div style="display:grid; grid-template-columns:1fr 1fr; gap:12px; margin-bottom:18px;">
              <div>
                <label style="display:block; font-size:13px; font-weight:600; color:#374151; margin-bottom:5px;">Ward</label>
                <input type="text" name="wardNo" value="<%= wardNo %>" style="width:100%; height:42px; border:1.5px solid #e5e7eb; border-radius:8px; padding:0 12px; font-size:14px; color:#111827; background:#fff; outline:none; font-family:'Inter',sans-serif;"/>
              </div>
              <div>
                <label style="display:block; font-size:13px; font-weight:600; color:#374151; margin-bottom:5px;">Province</label>
                <input type="text" name="province" value="<%= province %>" style="width:100%; height:42px; border:1.5px solid #e5e7eb; border-radius:8px; padding:0 12px; font-size:14px; color:#111827; background:#fff; outline:none; font-family:'Inter',sans-serif;"/>
              </div>
            </div>

            <button type="submit" style="background:#059669; color:#fff; border:none; font-weight:600; font-size:14px; padding:10px 22px; border-radius:8px; cursor:pointer; font-family:'Inter',sans-serif;">
              Save changes
            </button>
          </form>
        </div>

        <div style="display:flex; flex-direction:column; gap:16px;">
          <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:20px;">
            <h3 style="font-size:12px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px; margin-bottom:14px;">Account</h3>
            <div style="display:flex; flex-direction:column; gap:12px;">
              <div><p style="font-size:12px; color:#94a3b8;">User ID</p><p style="font-size:14px; font-weight:500; color:#0f172a;"><%= userId %></p></div>
              <div><p style="font-size:12px; color:#94a3b8;">Member since</p><p style="font-size:14px; font-weight:500; color:#0f172a;"><%= memberSince %></p></div>
              <div><p style="font-size:12px; color:#94a3b8;">Email</p><p style="font-size:14px; font-weight:500; color:#0f172a;"><%= email %></p></div>
            </div>
          </div>

          <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:20px;">
            <h3 style="font-size:12px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px; margin-bottom:14px;">Location</h3>
            <div style="display:flex; flex-direction:column; gap:12px;">
              <div><p style="font-size:12px; color:#94a3b8;">Municipality</p><p style="font-size:14px; font-weight:500; color:#0f172a;"><%= municipality %></p></div>
              <div><p style="font-size:12px; color:#94a3b8;">Ward</p><p style="font-size:14px; font-weight:500; color:#0f172a;"><%= wardNo %></p></div>
              <div><p style="font-size:12px; color:#94a3b8;">Province</p><p style="font-size:14px; font-weight:500; color:#0f172a;"><%= province %></p></div>
            </div>
          </div>

          <div style="background:#fff; border:1px solid #fecaca; border-radius:10px; padding:18px;">
            <p style="font-size:12px; font-weight:700; color:#dc2626; margin-bottom:4px;">Danger zone</p>
            <p style="font-size:12px; color:#64748b; margin-bottom:10px;">This action cannot be undone.</p>
            <button style="background:#fff; color:#dc2626; border:1px solid #fecaca; font-size:12px; font-weight:600; padding:7px 14px; border-radius:6px; cursor:pointer; font-family:'Inter',sans-serif;">Delete account</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>
