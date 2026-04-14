<%--
  Municipality Issue List — NagarSewa
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setAttribute("activePage", "issue-reports"); %>
<jsp:include page="../common/header.jsp"/>

<div class="flex min-h-screen">
  <jsp:include page="../common/municipality-sidebar.jsp"/>

  <div class="flex-1" style="margin-left:220px; background:#f8fafc; min-height:100vh;">

    <div style="padding:18px 32px; display:flex; align-items:center; justify-content:space-between; border-bottom:1px solid #e2e8f0; background:#fff;">
      <h1 style="font-family:'Outfit',sans-serif; font-size:18px; font-weight:700; color:#0f172a;">Issue Management</h1>
      <div style="display:flex; gap:8px;">
        <button style="padding:8px 14px; border-radius:6px; font-size:12px; font-weight:600; border:1px solid #e2e8f0; background:#fff; color:#64748b; cursor:pointer; font-family:'Inter',sans-serif; display:inline-flex; align-items:center; gap:4px;">
          <svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M3 4a1 1 0 011-1h16a1 1 0 011 1v2.586a1 1 0 01-.293.707l-6.414 6.414a1 1 0 00-.293.707V17l-4 4v-6.586a1 1 0 00-.293-.707L3.293 7.293A1 1 0 013 6.586V4z"/></svg>
          Filter
        </button>
        <button style="padding:8px 14px; border-radius:6px; font-size:12px; font-weight:600; border:1px solid #e2e8f0; background:#fff; color:#64748b; cursor:pointer; font-family:'Inter',sans-serif;">Export CSV</button>
      </div>
    </div>

    <div style="padding:28px 32px;">

      <!-- Quick stats -->
      <div style="display:flex; gap:24px; margin-bottom:24px;">
        <div><span style="font-size:12px; color:#94a3b8;">Total </span><span style="font-size:14px; font-weight:700; color:#0f172a;">847</span></div>
        <div style="width:1px; background:#e2e8f0;"></div>
        <div><span style="font-size:12px; color:#94a3b8;">Open </span><span style="font-size:14px; font-weight:700; color:#dc2626;">156</span></div>
        <div style="width:1px; background:#e2e8f0;"></div>
        <div><span style="font-size:12px; color:#94a3b8;">In Progress </span><span style="font-size:14px; font-weight:700; color:#2563eb;">268</span></div>
        <div style="width:1px; background:#e2e8f0;"></div>
        <div><span style="font-size:12px; color:#94a3b8;">Resolved </span><span style="font-size:14px; font-weight:700; color:#059669;">423</span></div>
      </div>

      <!-- Table -->
      <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; overflow:hidden;">
        <table style="width:100%; border-collapse:collapse;">
          <thead>
            <tr style="border-bottom:1px solid #f1f5f9;">
              <th style="text-align:left; padding:12px 18px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">ID</th>
              <th style="text-align:left; padding:12px 18px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Issue</th>
              <th style="text-align:left; padding:12px 18px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Citizen</th>
              <th style="text-align:left; padding:12px 18px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Ward</th>
              <th style="text-align:left; padding:12px 18px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Status</th>
              <th style="text-align:left; padding:12px 18px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Date</th>
              <th style="text-align:right; padding:12px 18px;"></th>
            </tr>
          </thead>
          <tbody>
            <tr style="border-bottom:1px solid #f8fafc;" onmouseover="this.style.background='#fafbfc'" onmouseout="this.style.background='transparent'">
              <td style="padding:14px 18px; font-size:13px; font-weight:500; color:#94a3b8;">#NW-29402</td>
              <td style="padding:14px 18px;"><p style="font-size:13px; font-weight:600; color:#1e293b;">Broken water pipeline</p><p style="font-size:11px; color:#94a3b8;">Water Supply</p></td>
              <td style="padding:14px 18px; font-size:13px; color:#64748b;">Ramesh S.</td>
              <td style="padding:14px 18px; font-size:13px; color:#64748b;">04</td>
              <td style="padding:14px 18px;"><span style="padding:3px 10px; border-radius:99px; font-size:11px; font-weight:600; background:#fee2e2; color:#991b1b;">Open</span></td>
              <td style="padding:14px 18px; font-size:12px; color:#94a3b8;">Today</td>
              <td style="padding:14px 18px; text-align:right;"><button style="background:#7c3aed; color:#fff; border:none; padding:5px 14px; border-radius:6px; font-size:11px; font-weight:600; cursor:pointer; font-family:'Inter',sans-serif;">Review</button></td>
            </tr>
            <tr style="border-bottom:1px solid #f8fafc;" onmouseover="this.style.background='#fafbfc'" onmouseout="this.style.background='transparent'">
              <td style="padding:14px 18px; font-size:13px; font-weight:500; color:#94a3b8;">#NW-29391</td>
              <td style="padding:14px 18px;"><p style="font-size:13px; font-weight:600; color:#1e293b;">Streetlight outage — Thamel</p><p style="font-size:11px; color:#94a3b8;">Electrical</p></td>
              <td style="padding:14px 18px; font-size:13px; color:#64748b;">Priya A.</td>
              <td style="padding:14px 18px; font-size:13px; color:#64748b;">09</td>
              <td style="padding:14px 18px;"><span style="padding:3px 10px; border-radius:99px; font-size:11px; font-weight:600; background:#dbeafe; color:#1e40af;">In Progress</span></td>
              <td style="padding:14px 18px; font-size:12px; color:#94a3b8;">Yesterday</td>
              <td style="padding:14px 18px; text-align:right;"><button style="background:#f1f5f9; color:#64748b; border:1px solid #e2e8f0; padding:5px 14px; border-radius:6px; font-size:11px; font-weight:600; cursor:pointer; font-family:'Inter',sans-serif;">View</button></td>
            </tr>
            <tr style="border-bottom:1px solid #f8fafc;" onmouseover="this.style.background='#fafbfc'" onmouseout="this.style.background='transparent'">
              <td style="padding:14px 18px; font-size:13px; font-weight:500; color:#94a3b8;">#NW-29385</td>
              <td style="padding:14px 18px;"><p style="font-size:13px; font-weight:600; color:#1e293b;">Garbage in park — Swayambhu</p><p style="font-size:11px; color:#94a3b8;">Sanitation</p></td>
              <td style="padding:14px 18px; font-size:13px; color:#64748b;">Anita D.</td>
              <td style="padding:14px 18px; font-size:13px; color:#64748b;">15</td>
              <td style="padding:14px 18px;"><span style="padding:3px 10px; border-radius:99px; font-size:11px; font-weight:600; background:#d1fae5; color:#065f46;">Resolved</span></td>
              <td style="padding:14px 18px; font-size:12px; color:#94a3b8;">Oct 14</td>
              <td style="padding:14px 18px; text-align:right;"><button style="background:#f1f5f9; color:#64748b; border:1px solid #e2e8f0; padding:5px 14px; border-radius:6px; font-size:11px; font-weight:600; cursor:pointer; font-family:'Inter',sans-serif;">View</button></td>
            </tr>
            <tr onmouseover="this.style.background='#fafbfc'" onmouseout="this.style.background='transparent'">
              <td style="padding:14px 18px; font-size:13px; font-weight:500; color:#94a3b8;">#NW-29377</td>
              <td style="padding:14px 18px;"><p style="font-size:13px; font-weight:600; color:#1e293b;">Pothole — Balaju bypass</p><p style="font-size:11px; color:#94a3b8;">Roads</p></td>
              <td style="padding:14px 18px; font-size:13px; color:#64748b;">Vikram S.</td>
              <td style="padding:14px 18px; font-size:13px; color:#64748b;">09</td>
              <td style="padding:14px 18px;"><span style="padding:3px 10px; border-radius:99px; font-size:11px; font-weight:600; background:#fef3c7; color:#92400e;">Pending</span></td>
              <td style="padding:14px 18px; font-size:12px; color:#94a3b8;">Oct 12</td>
              <td style="padding:14px 18px; text-align:right;"><button style="background:#7c3aed; color:#fff; border:none; padding:5px 14px; border-radius:6px; font-size:11px; font-weight:600; cursor:pointer; font-family:'Inter',sans-serif;">Review</button></td>
            </tr>
          </tbody>
        </table>

        <div style="padding:12px 18px; border-top:1px solid #f1f5f9; display:flex; align-items:center; justify-content:space-between;">
          <span style="font-size:12px; color:#94a3b8;">Page 1 of 42</span>
          <div style="display:flex; gap:4px;">
            <button style="width:28px; height:28px; border-radius:6px; border:1px solid #e2e8f0; background:#fff; color:#94a3b8; cursor:pointer; font-size:11px;">&lsaquo;</button>
            <button style="width:28px; height:28px; border-radius:6px; border:none; background:#0f172a; color:#fff; font-size:12px; font-weight:700; cursor:pointer;">1</button>
            <button style="width:28px; height:28px; border-radius:6px; border:1px solid #e2e8f0; background:#fff; color:#64748b; font-size:12px; cursor:pointer;">2</button>
            <button style="width:28px; height:28px; border-radius:6px; border:1px solid #e2e8f0; background:#fff; color:#94a3b8; cursor:pointer; font-size:11px;">&rsaquo;</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>
