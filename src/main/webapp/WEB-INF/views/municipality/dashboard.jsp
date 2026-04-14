<%--
  Municipality Dashboard — NagarSewa
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setAttribute("activePage", "dashboard"); %>
<jsp:include page="../common/header.jsp"/>

<div class="flex min-h-screen">
  <jsp:include page="../common/municipality-sidebar.jsp"/>

  <div class="flex-1" style="margin-left:220px; background:#f8fafc; min-height:100vh;">

    <div style="padding:18px 32px; display:flex; align-items:center; justify-content:space-between; border-bottom:1px solid #e2e8f0; background:#fff;">
      <div>
        <h1 style="font-family:'Outfit',sans-serif; font-size:20px; font-weight:700; color:#0f172a; margin:0;">Municipality Dashboard</h1>
        <p style="font-size:13px; color:#64748b; margin:2px 0 0;">Operations overview across all wards.</p>
      </div>
      <div style="display:flex; align-items:center; gap:10px;">
        <div style="text-align:right;">
          <p style="font-size:12px; font-weight:600; color:#0f172a;"><%= session.getAttribute("userName") != null ? session.getAttribute("userName") : "Sushila Karki" %></p>
          <p style="font-size:11px; color:#94a3b8;">Municipality Head</p>
        </div>
        <div style="width:34px; height:34px; border-radius:50%; background:#059669; display:flex; align-items:center; justify-content:center; color:#fff; font-size:12px; font-weight:700;">SK</div>
      </div>
    </div>

    <div style="padding:28px 32px;">

      <!-- Stats -->
      <div style="display:grid; grid-template-columns:1fr 1fr 1fr 1fr; gap:14px; margin-bottom:28px;">
        <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:18px 20px;">
          <p style="font-size:12px; font-weight:600; color:#94a3b8; margin-bottom:8px;">Total Reports</p>
          <span style="font-family:'Outfit',sans-serif; font-size:28px; font-weight:800; color:#0f172a;">847</span>
        </div>
        <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:18px 20px;">
          <p style="font-size:12px; font-weight:600; color:#94a3b8; margin-bottom:8px;">Open</p>
          <span style="font-family:'Outfit',sans-serif; font-size:28px; font-weight:800; color:#dc2626;">156</span>
        </div>
        <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:18px 20px;">
          <p style="font-size:12px; font-weight:600; color:#94a3b8; margin-bottom:8px;">In Progress</p>
          <span style="font-family:'Outfit',sans-serif; font-size:28px; font-weight:800; color:#0d9488;">268</span>
        </div>
        <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:18px 20px;">
          <p style="font-size:12px; font-weight:600; color:#94a3b8; margin-bottom:8px;">Resolved (This Month)</p>
          <span style="font-family:'Outfit',sans-serif; font-size:28px; font-weight:800; color:#059669;">89</span>
        </div>
      </div>

      <div style="display:grid; grid-template-columns:5fr 3fr; gap:20px;">

        <!-- Issues By Ward: card grid visualization -->
        <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:22px;">
          <div style="display:flex; align-items:center; justify-content:space-between; margin-bottom:16px;">
            <h2 style="font-size:15px; font-weight:700; color:#0f172a; margin:0;">Issues by Ward</h2>
            <a href="<%= request.getContextPath() %>/municipality/ward-management" style="font-size:12px; color:#059669; text-decoration:none; font-weight:600;">Manage wards →</a>
          </div>

          <div style="display:grid; grid-template-columns:repeat(3, minmax(0,1fr)); gap:12px; margin-bottom:14px;">
            <div style="border:1px solid #d1fae5; background:#ecfdf5; border-radius:10px; padding:14px;">
              <p style="font-size:11px; color:#065f46; font-weight:700; margin:0 0 6px; letter-spacing:0.4px;">WARD 04</p>
              <p style="font-family:'Outfit',sans-serif; font-size:25px; font-weight:800; color:#065f46; margin:0 0 4px;">187</p>
              <p style="font-size:12px; color:#047857; margin:0;">Highest load</p>
            </div>
            <div style="border:1px solid #bbf7d0; background:#f0fdf4; border-radius:10px; padding:14px;">
              <p style="font-size:11px; color:#166534; font-weight:700; margin:0 0 6px; letter-spacing:0.4px;">WARD 09</p>
              <p style="font-family:'Outfit',sans-serif; font-size:25px; font-weight:800; color:#166534; margin:0 0 4px;">142</p>
              <p style="font-size:12px; color:#16a34a; margin:0;">Road and lighting</p>
            </div>
            <div style="border:1px solid #fde68a; background:#fffbeb; border-radius:10px; padding:14px;">
              <p style="font-size:11px; color:#92400e; font-weight:700; margin:0 0 6px; letter-spacing:0.4px;">WARD 02</p>
              <p style="font-family:'Outfit',sans-serif; font-size:25px; font-weight:800; color:#92400e; margin:0 0 4px;">124</p>
              <p style="font-size:12px; color:#b45309; margin:0;">Sanitation spikes</p>
            </div>
          </div>

          <div style="display:flex; flex-direction:column; gap:12px;">
            <div style="display:flex; align-items:center; justify-content:space-between; gap:10px;">
              <span style="font-size:13px; color:#1f2937; min-width:136px;">Ward 15</span>
              <div style="flex:1; background:#f1f5f9; border-radius:99px; height:7px;"><div style="height:100%; width:52%; border-radius:99px; background:#10b981;"></div></div>
              <span style="font-size:12px; font-weight:700; color:#0f172a; min-width:32px; text-align:right;">98</span>
            </div>
            <div style="display:flex; align-items:center; justify-content:space-between; gap:10px;">
              <span style="font-size:13px; color:#1f2937; min-width:136px;">Ward 07</span>
              <div style="flex:1; background:#f1f5f9; border-radius:99px; height:7px;"><div style="height:100%; width:39%; border-radius:99px; background:#34d399;"></div></div>
              <span style="font-size:12px; font-weight:700; color:#0f172a; min-width:32px; text-align:right;">71</span>
            </div>
            <div style="display:flex; align-items:center; justify-content:space-between; gap:10px;">
              <span style="font-size:13px; color:#1f2937; min-width:136px;">Ward 11</span>
              <div style="flex:1; background:#f1f5f9; border-radius:99px; height:7px;"><div style="height:100%; width:27%; border-radius:99px; background:#6ee7b7;"></div></div>
              <span style="font-size:12px; font-weight:700; color:#0f172a; min-width:32px; text-align:right;">49</span>
            </div>
          </div>
        </div>

        <!-- Recent + quick actions -->
        <div style="display:flex; flex-direction:column; gap:16px;">
          <a href="<%= request.getContextPath() %>/municipality/issue-list" style="display:block; background:#059669; border-radius:10px; padding:20px; color:#fff; text-decoration:none;">
            <p style="font-family:'Outfit',sans-serif; font-size:16px; font-weight:700; margin:0 0 4px;">Manage Issues</p>
            <p style="font-size:13px; color:rgba(255,255,255,0.78); margin:0;">156 issues need action from municipality team →</p>
          </a>

          <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; overflow:hidden;">
            <div style="padding:14px 18px; border-bottom:1px solid #f1f5f9;"><h3 style="font-size:13px; font-weight:700; color:#0f172a; margin:0;">Recent Reports</h3></div>
            <div style="padding:10px 18px; border-bottom:1px solid #f8fafc;">
              <p style="font-size:13px; font-weight:600; color:#1e293b;">Broken pipeline — Teku</p>
              <p style="font-size:11px; color:#94a3b8;">Ward 12 · Today</p>
            </div>
            <div style="padding:10px 18px; border-bottom:1px solid #f8fafc;">
              <p style="font-size:13px; font-weight:600; color:#1e293b;">Garbage at Swayambhu steps</p>
              <p style="font-size:11px; color:#94a3b8;">Ward 15 · Yesterday</p>
            </div>
            <div style="padding:10px 18px; border-bottom:1px solid #f8fafc;">
              <p style="font-size:13px; font-weight:600; color:#1e293b;">Road damage — Balaju bypass</p>
              <p style="font-size:11px; color:#94a3b8;">Ward 09 · 2 days ago</p>
            </div>
            <div style="padding:10px 18px;">
              <p style="font-size:13px; font-weight:600; color:#1e293b;">Missing manhole cover</p>
              <p style="font-size:11px; color:#94a3b8;">Ward 04 · 3 days ago</p>
            </div>
          </div>

          <div style="background:#ecfdf5; border:1px solid #bbf7d0; border-radius:10px; padding:16px 18px;">
            <p style="font-size:12px; font-weight:600; color:#065f46; margin-bottom:4px;">Monthly report deadline</p>
            <p style="font-size:12px; color:#047857; line-height:1.5;">Ward performance reports are due by the 15th. You have 3 wards left to review.</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>
