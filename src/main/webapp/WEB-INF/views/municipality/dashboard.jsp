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
        <h1 style="font-family:'Outfit',sans-serif; font-size:20px; font-weight:700; color:#0f172a;">Municipal Dashboard</h1>
        <p style="font-size:13px; color:#64748b;">Ward-level overview — Kathmandu MC</p>
      </div>
      <div style="display:flex; align-items:center; gap:10px;">
        <div style="text-align:right;">
          <p style="font-size:12px; font-weight:600; color:#0f172a;"><%= session.getAttribute("userName") != null ? session.getAttribute("userName") : "Sushila Karki" %></p>
          <p style="font-size:11px; color:#94a3b8;">Municipality Head</p>
        </div>
        <div style="width:34px; height:34px; border-radius:50%; background:#7c3aed; display:flex; align-items:center; justify-content:center; color:#fff; font-size:12px; font-weight:700;">SK</div>
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
          <span style="font-family:'Outfit',sans-serif; font-size:28px; font-weight:800; color:#2563eb;">268</span>
        </div>
        <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:18px 20px;">
          <p style="font-size:12px; font-weight:600; color:#94a3b8; margin-bottom:8px;">Resolved (This Month)</p>
          <span style="font-family:'Outfit',sans-serif; font-size:28px; font-weight:800; color:#059669;">89</span>
        </div>
      </div>

      <div style="display:grid; grid-template-columns:5fr 3fr; gap:20px;">

        <!-- Issues By Ward -->
        <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:22px;">
          <h2 style="font-size:15px; font-weight:700; color:#0f172a; margin-bottom:18px;">Issues by Ward</h2>
          <div style="display:flex; flex-direction:column; gap:14px;">
            <div>
              <div style="display:flex; justify-content:space-between; margin-bottom:4px;"><span style="font-size:13px; color:#1e293b;">Ward 04 — Ratna Park area</span><span style="font-size:13px; font-weight:700; color:#0f172a;">187</span></div>
              <div style="width:100%; height:5px; border-radius:99px; background:#f1f5f9;"><div style="width:82%; height:100%; border-radius:99px; background:#4f46e5;"></div></div>
            </div>
            <div>
              <div style="display:flex; justify-content:space-between; margin-bottom:4px;"><span style="font-size:13px; color:#1e293b;">Ward 09 — Balaju</span><span style="font-size:13px; font-weight:700; color:#0f172a;">142</span></div>
              <div style="width:100%; height:5px; border-radius:99px; background:#f1f5f9;"><div style="width:62%; height:100%; border-radius:99px; background:#7c3aed;"></div></div>
            </div>
            <div>
              <div style="display:flex; justify-content:space-between; margin-bottom:4px;"><span style="font-size:13px; color:#1e293b;">Ward 02 — New Road</span><span style="font-size:13px; font-weight:700; color:#0f172a;">124</span></div>
              <div style="width:100%; height:5px; border-radius:99px; background:#f1f5f9;"><div style="width:54%; height:100%; border-radius:99px; background:#7c3aed;"></div></div>
            </div>
            <div>
              <div style="display:flex; justify-content:space-between; margin-bottom:4px;"><span style="font-size:13px; color:#1e293b;">Ward 15 — Kalanki</span><span style="font-size:13px; font-weight:700; color:#0f172a;">98</span></div>
              <div style="width:100%; height:5px; border-radius:99px; background:#f1f5f9;"><div style="width:43%; height:100%; border-radius:99px; background:#a78bfa;"></div></div>
            </div>
            <div>
              <div style="display:flex; justify-content:space-between; margin-bottom:4px;"><span style="font-size:13px; color:#1e293b;">Ward 07 — Chabahil</span><span style="font-size:13px; font-weight:700; color:#0f172a;">71</span></div>
              <div style="width:100%; height:5px; border-radius:99px; background:#f1f5f9;"><div style="width:31%; height:100%; border-radius:99px; background:#c4b5fd;"></div></div>
            </div>
          </div>
        </div>

        <!-- Recent + quick actions -->
        <div style="display:flex; flex-direction:column; gap:16px;">
          <a href="<%= request.getContextPath() %>/municipality/issue-list" style="display:block; background:#7c3aed; border-radius:10px; padding:20px; color:#fff; text-decoration:none;">
            <p style="font-family:'Outfit',sans-serif; font-size:16px; font-weight:700; margin-bottom:4px;">Review Open Issues</p>
            <p style="font-size:13px; color:rgba(255,255,255,0.7);">156 issues need your attention →</p>
          </a>

          <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; overflow:hidden;">
            <div style="padding:14px 18px; border-bottom:1px solid #f1f5f9;"><h3 style="font-size:13px; font-weight:700; color:#0f172a;">Recent Reports</h3></div>
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

          <div style="background:#eff6ff; border:1px solid #dbeafe; border-radius:10px; padding:16px 18px;">
            <p style="font-size:12px; font-weight:600; color:#1e40af; margin-bottom:4px;">📊 Monthly report due</p>
            <p style="font-size:12px; color:#3b82f6; line-height:1.5;">Ward performance reports are due by the 15th. You have 3 wards left to review.</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>
