<%--
  Admin Issue Management — NagarSewa
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setAttribute("activePage", "issue-management"); %>
<jsp:include page="../common/header.jsp"/>

<div class="flex min-h-screen">
  <jsp:include page="../common/sidebar.jsp"/>

  <div class="flex-1" style="margin-left:220px; background:#f8fafc; min-height:100vh;">

    <div style="padding:18px 32px; display:flex; align-items:center; justify-content:space-between; border-bottom:1px solid #e2e8f0; background:#fff;">
      <h1 style="font-family:'Outfit',sans-serif; font-size:18px; font-weight:700; color:#0f172a;">Issue Oversight</h1>
      <button style="padding:9px 18px; border-radius:8px; font-size:13px; font-weight:600; border:1px solid #e2e8f0; background:#fff; color:#64748b; cursor:pointer; font-family:'Inter',sans-serif;">Export Report</button>
    </div>

    <div style="padding:28px 32px;">

      <!-- Inline stats -->
      <div style="display:flex; gap:24px; margin-bottom:20px; padding-bottom:20px; border-bottom:1px solid #f1f5f9;">
        <div><p style="font-size:11px; color:#94a3b8; font-weight:600; text-transform:uppercase; letter-spacing:0.5px;">Total</p><p style="font-size:22px; font-weight:800; color:#0f172a; font-family:'Outfit',sans-serif;">1,429</p></div>
        <div style="border-left:1px solid #e2e8f0; padding-left:24px;"><p style="font-size:11px; color:#94a3b8; font-weight:600; text-transform:uppercase; letter-spacing:0.5px;">Open</p><p style="font-size:22px; font-weight:800; color:#dc2626; font-family:'Outfit',sans-serif;">284</p></div>
        <div style="border-left:1px solid #e2e8f0; padding-left:24px;"><p style="font-size:11px; color:#94a3b8; font-weight:600; text-transform:uppercase; letter-spacing:0.5px;">In Progress</p><p style="font-size:22px; font-weight:800; color:#2563eb; font-family:'Outfit',sans-serif;">512</p></div>
        <div style="border-left:1px solid #e2e8f0; padding-left:24px;"><p style="font-size:11px; color:#94a3b8; font-weight:600; text-transform:uppercase; letter-spacing:0.5px;">Resolved</p><p style="font-size:22px; font-weight:800; color:#059669; font-family:'Outfit',sans-serif;">633</p></div>
        <div style="border-left:1px solid #e2e8f0; padding-left:24px;"><p style="font-size:11px; color:#94a3b8; font-weight:600; text-transform:uppercase; letter-spacing:0.5px;">Avg Response</p><p style="font-size:22px; font-weight:800; color:#0f172a; font-family:'Outfit',sans-serif;">4.2h</p></div>
      </div>

      <!-- Table -->
      <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; overflow:hidden;">
        <table style="width:100%; border-collapse:collapse;">
          <thead>
            <tr style="border-bottom:1px solid #f1f5f9;">
              <th style="text-align:left; padding:12px 18px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">ID</th>
              <th style="text-align:left; padding:12px 18px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Issue</th>
              <th style="text-align:left; padding:12px 18px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Reporter</th>
              <th style="text-align:left; padding:12px 18px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Ward</th>
              <th style="text-align:left; padding:12px 18px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Status</th>
              <th style="text-align:left; padding:12px 18px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Priority</th>
              <th style="text-align:left; padding:12px 18px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Date</th>
            </tr>
          </thead>
          <tbody>
            <tr style="border-bottom:1px solid #f8fafc;" onmouseover="this.style.background='#fafbfc'" onmouseout="this.style.background='transparent'">
              <td style="padding:14px 18px; font-size:13px; color:#94a3b8;">#NS-8921</td>
              <td style="padding:14px 18px;"><p style="font-size:13px; font-weight:600; color:#1e293b;">Broken water main — Teku</p><p style="font-size:11px; color:#94a3b8;">Water Supply</p></td>
              <td style="padding:14px 18px; font-size:13px; color:#64748b;">Ramesh S.</td>
              <td style="padding:14px 18px; font-size:13px; color:#64748b;">12</td>
              <td style="padding:14px 18px;"><span style="padding:3px 10px; border-radius:99px; font-size:11px; font-weight:600; background:#fee2e2; color:#991b1b;">Open</span></td>
              <td style="padding:14px 18px;"><span style="font-size:12px; font-weight:600; color:#dc2626;">● Critical</span></td>
              <td style="padding:14px 18px; font-size:12px; color:#94a3b8;">Oct 12</td>
            </tr>
            <tr style="border-bottom:1px solid #f8fafc;" onmouseover="this.style.background='#fafbfc'" onmouseout="this.style.background='transparent'">
              <td style="padding:14px 18px; font-size:13px; color:#94a3b8;">#NS-8922</td>
              <td style="padding:14px 18px;"><p style="font-size:13px; font-weight:600; color:#1e293b;">Garbage at Swayambhu</p><p style="font-size:11px; color:#94a3b8;">Sanitation</p></td>
              <td style="padding:14px 18px; font-size:13px; color:#64748b;">Anita D.</td>
              <td style="padding:14px 18px; font-size:13px; color:#64748b;">15</td>
              <td style="padding:14px 18px;"><span style="padding:3px 10px; border-radius:99px; font-size:11px; font-weight:600; background:#dbeafe; color:#1e40af;">In Progress</span></td>
              <td style="padding:14px 18px;"><span style="font-size:12px; font-weight:600; color:#d97706;">● High</span></td>
              <td style="padding:14px 18px; font-size:12px; color:#94a3b8;">Oct 11</td>
            </tr>
            <tr style="border-bottom:1px solid #f8fafc;" onmouseover="this.style.background='#fafbfc'" onmouseout="this.style.background='transparent'">
              <td style="padding:14px 18px; font-size:13px; color:#94a3b8;">#NS-8923</td>
              <td style="padding:14px 18px;"><p style="font-size:13px; font-weight:600; color:#1e293b;">Streetlight — Balaju bypass</p><p style="font-size:11px; color:#94a3b8;">Electrical</p></td>
              <td style="padding:14px 18px; font-size:13px; color:#64748b;">Vikram S.</td>
              <td style="padding:14px 18px; font-size:13px; color:#64748b;">09</td>
              <td style="padding:14px 18px;"><span style="padding:3px 10px; border-radius:99px; font-size:11px; font-weight:600; background:#d1fae5; color:#065f46;">Resolved</span></td>
              <td style="padding:14px 18px;"><span style="font-size:12px; font-weight:600; color:#64748b;">● Low</span></td>
              <td style="padding:14px 18px; font-size:12px; color:#94a3b8;">Oct 10</td>
            </tr>
            <tr onmouseover="this.style.background='#fafbfc'" onmouseout="this.style.background='transparent'">
              <td style="padding:14px 18px; font-size:13px; color:#94a3b8;">#NS-8924</td>
              <td style="padding:14px 18px;"><p style="font-size:13px; font-weight:600; color:#1e293b;">Pothole — Ratna Park junction</p><p style="font-size:11px; color:#94a3b8;">Roads</p></td>
              <td style="padding:14px 18px; font-size:13px; color:#64748b;">Binod P.</td>
              <td style="padding:14px 18px; font-size:13px; color:#64748b;">04</td>
              <td style="padding:14px 18px;"><span style="padding:3px 10px; border-radius:99px; font-size:11px; font-weight:600; background:#fef3c7; color:#92400e;">Pending</span></td>
              <td style="padding:14px 18px;"><span style="font-size:12px; font-weight:600; color:#2563eb;">● Medium</span></td>
              <td style="padding:14px 18px; font-size:12px; color:#94a3b8;">Oct 9</td>
            </tr>
          </tbody>
        </table>
        <div style="padding:12px 18px; border-top:1px solid #f1f5f9; display:flex; align-items:center; justify-content:space-between;">
          <span style="font-size:12px; color:#94a3b8;">Showing 4 of 1,429</span>
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
