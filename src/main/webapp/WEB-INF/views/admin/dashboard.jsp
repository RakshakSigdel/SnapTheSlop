<%--
  Admin Dashboard — NagarSewa
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setAttribute("activePage", "dashboard"); %>
<jsp:include page="../common/header.jsp"/>

<div class="flex min-h-screen">
  <jsp:include page="../common/sidebar.jsp"/>

  <div class="flex-1" style="margin-left:220px; background:#f8fafc; min-height:100vh;">

    <div style="padding:18px 32px; display:flex; align-items:center; justify-content:space-between; border-bottom:1px solid #e2e8f0; background:#fff;">
      <div>
        <h1 style="font-family:'Outfit',sans-serif; font-size:20px; font-weight:700; color:#0f172a;">System Admin</h1>
        <p style="font-size:13px; color:#64748b;">Platform-wide oversight</p>
      </div>
      <div style="display:flex; align-items:center; gap:10px;">
        <p style="font-size:12px; font-weight:600; color:#0f172a;">Admin</p>
        <div style="width:34px; height:34px; border-radius:50%; background:#dc2626; display:flex; align-items:center; justify-content:center; color:#fff; font-size:12px; font-weight:700;">SA</div>
      </div>
    </div>

    <div style="padding:28px 32px;">

      <!-- Stats -->
      <div style="display:grid; grid-template-columns:1fr 1fr 1fr 1fr; gap:14px; margin-bottom:28px;">
        <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:18px 20px;">
          <p style="font-size:12px; font-weight:600; color:#94a3b8; margin-bottom:8px;">Registered Users</p>
          <span style="font-family:'Outfit',sans-serif; font-size:28px; font-weight:800; color:#0f172a;">2,847</span>
          <span style="font-size:12px; color:#059669; font-weight:600; margin-left:6px;">+156</span>
        </div>
        <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:18px 20px;">
          <p style="font-size:12px; font-weight:600; color:#94a3b8; margin-bottom:8px;">Total Issues</p>
          <span style="font-family:'Outfit',sans-serif; font-size:28px; font-weight:800; color:#0f172a;">1,429</span>
        </div>
        <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:18px 20px;">
          <p style="font-size:12px; font-weight:600; color:#94a3b8; margin-bottom:8px;">Resolution Rate</p>
          <span style="font-family:'Outfit',sans-serif; font-size:28px; font-weight:800; color:#059669;">89%</span>
        </div>
        <div style="background:#fff; border:1px solid #fee2e2; border-radius:10px; padding:18px 20px;">
          <p style="font-size:12px; font-weight:600; color:#94a3b8; margin-bottom:8px;">Critical Issues</p>
          <span style="font-family:'Outfit',sans-serif; font-size:28px; font-weight:800; color:#dc2626;">12</span>
          <span style="font-size:12px; color:#dc2626; font-weight:600; margin-left:4px;">needs attention</span>
        </div>
      </div>

      <!-- Actions + Activity -->
      <div style="display:grid; grid-template-columns:1fr 1fr; gap:20px; margin-bottom:20px;">
        <a href="<%= request.getContextPath() %>/admin/user-management" style="text-decoration:none; display:flex; align-items:center; gap:14px; background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:20px; transition:box-shadow 0.2s;" onmouseover="this.style.boxShadow='0 2px 8px rgba(0,0,0,0.04)'" onmouseout="this.style.boxShadow='none'">
          <div style="width:40px; height:40px; border-radius:8px; background:#e0e7ff; display:flex; align-items:center; justify-content:center; flex-shrink:0;">
            <svg width="18" height="18" fill="#4f46e5" viewBox="0 0 20 20"><path d="M9 6a3 3 0 11-6 0 3 3 0 016 0zM17 6a3 3 0 11-6 0 3 3 0 016 0zM12.93 17c.046-.327.07-.66.07-1a6.97 6.97 0 00-1.5-4.33A5 5 0 0119 16v1h-6.07zM6 11a5 5 0 015 5v1H1v-1a5 5 0 015-5z"/></svg>
          </div>
          <div>
            <p style="font-size:14px; font-weight:700; color:#0f172a;">Manage Users</p>
            <p style="font-size:12px; color:#64748b;">View, edit, suspend accounts</p>
          </div>
        </a>
        <a href="<%= request.getContextPath() %>/admin/issue-management" style="text-decoration:none; display:flex; align-items:center; gap:14px; background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:20px; transition:box-shadow 0.2s;" onmouseover="this.style.boxShadow='0 2px 8px rgba(0,0,0,0.04)'" onmouseout="this.style.boxShadow='none'">
          <div style="width:40px; height:40px; border-radius:8px; background:#fef3c7; display:flex; align-items:center; justify-content:center; flex-shrink:0;">
            <svg width="18" height="18" fill="#d97706" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M4 4a2 2 0 012-2h4.586A2 2 0 0112 2.586L15.414 6A2 2 0 0116 7.414V16a2 2 0 01-2 2H6a2 2 0 01-2-2V4zm2 6a1 1 0 011-1h6a1 1 0 110 2H7a1 1 0 01-1-1zm1 3a1 1 0 100 2h6a1 1 0 100-2H7z" clip-rule="evenodd"/></svg>
          </div>
          <div>
            <p style="font-size:14px; font-weight:700; color:#0f172a;">Issue Oversight</p>
            <p style="font-size:12px; color:#64748b;">Monitor all civic reports</p>
          </div>
        </a>
      </div>

      <!-- Activity Log -->
      <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; overflow:hidden;">
        <div style="padding:16px 20px; border-bottom:1px solid #f1f5f9;"><h2 style="font-size:15px; font-weight:700; color:#0f172a;">Recent Activity</h2></div>
        <div style="padding:12px 20px; border-bottom:1px solid #f8fafc; display:flex; align-items:center; gap:10px;">
          <div style="width:6px; height:6px; border-radius:50%; background:#059669;"></div>
          <p style="font-size:13px; color:#1e293b; flex:1;"><strong>Priya Adhikari</strong> registered as a citizen</p>
          <span style="font-size:11px; color:#94a3b8;">2 min ago</span>
        </div>
        <div style="padding:12px 20px; border-bottom:1px solid #f8fafc; display:flex; align-items:center; gap:10px;">
          <div style="width:6px; height:6px; border-radius:50%; background:#dc2626;"></div>
          <p style="font-size:13px; color:#1e293b; flex:1;">Issue <strong>#NS-8921</strong> escalated to critical</p>
          <span style="font-size:11px; color:#94a3b8;">15 min ago</span>
        </div>
        <div style="padding:12px 20px; border-bottom:1px solid #f8fafc; display:flex; align-items:center; gap:10px;">
          <div style="width:6px; height:6px; border-radius:50%; background:#2563eb;"></div>
          <p style="font-size:13px; color:#1e293b; flex:1;">Ward 04 monthly report auto-generated</p>
          <span style="font-size:11px; color:#94a3b8;">1 hr ago</span>
        </div>
        <div style="padding:12px 20px; display:flex; align-items:center; gap:10px;">
          <div style="width:6px; height:6px; border-radius:50%; background:#059669;"></div>
          <p style="font-size:13px; color:#1e293b; flex:1;"><strong>Sushila Karki</strong> resolved issue #NS-8790</p>
          <span style="font-size:11px; color:#94a3b8;">3 hrs ago</span>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>
