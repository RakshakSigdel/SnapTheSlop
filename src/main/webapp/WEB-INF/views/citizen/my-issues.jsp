<%--
  My Issues — NagarSewa
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../common/header.jsp"/>

<div class="flex min-h-screen">
  <jsp:include page="../common/citizen-sidebar.jsp"/>

  <div class="flex-1" style="margin-left:220px; background:#f8fafc; min-height:100vh;">

    <!-- Topbar -->
    <div style="padding:18px 32px; display:flex; align-items:center; justify-content:space-between; border-bottom:1px solid #e2e8f0; background:#fff;">
      <h1 style="font-family:'Outfit',sans-serif; font-size:18px; font-weight:700; color:#0f172a;">My Issue Reports</h1>
      <a href="<%= request.getContextPath() %>/citizen/report-issue" style="display:inline-flex; align-items:center; gap:6px; background:#059669; color:#fff; padding:9px 18px; border-radius:8px; font-size:13px; font-weight:600; text-decoration:none;">
        <span style="font-size:16px; line-height:1;">+</span> New Report
      </a>
    </div>

    <div style="padding:28px 32px;">

      <!-- Filter tabs -->
      <div style="display:flex; gap:6px; margin-bottom:24px;">
        <button style="padding:7px 16px; border-radius:6px; font-size:13px; font-weight:600; border:none; background:#0f172a; color:#fff; cursor:pointer; font-family:'Inter',sans-serif;">All (12)</button>
        <button style="padding:7px 16px; border-radius:6px; font-size:13px; font-weight:600; border:1px solid #e2e8f0; background:#fff; color:#64748b; cursor:pointer; font-family:'Inter',sans-serif;">Pending (3)</button>
        <button style="padding:7px 16px; border-radius:6px; font-size:13px; font-weight:600; border:1px solid #e2e8f0; background:#fff; color:#64748b; cursor:pointer; font-family:'Inter',sans-serif;">In Progress (1)</button>
        <button style="padding:7px 16px; border-radius:6px; font-size:13px; font-weight:600; border:1px solid #e2e8f0; background:#fff; color:#64748b; cursor:pointer; font-family:'Inter',sans-serif;">Resolved (8)</button>
      </div>

      <!-- Issues Table -->
      <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; overflow:hidden;">
        <table style="width:100%; border-collapse:collapse;">
          <thead>
            <tr style="border-bottom:1px solid #f1f5f9;">
              <th style="text-align:left; padding:12px 20px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Issue</th>
              <th style="text-align:left; padding:12px 16px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Category</th>
              <th style="text-align:left; padding:12px 16px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Status</th>
              <th style="text-align:left; padding:12px 16px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Filed</th>
              <th style="text-align:left; padding:12px 16px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Upvotes</th>
              <th style="text-align:right; padding:12px 20px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;"></th>
            </tr>
          </thead>
          <tbody>
            <tr style="border-bottom:1px solid #f8fafc; transition:background 0.15s;" onmouseover="this.style.background='#fafbfc'" onmouseout="this.style.background='transparent'">
              <td style="padding:14px 20px;">
                <p style="font-size:14px; font-weight:600; color:#1e293b;">Pothole near Ratna Park</p>
                <p style="font-size:12px; color:#94a3b8;">#NS-8821 · Ward 04</p>
              </td>
              <td style="padding:14px 16px;"><span style="font-size:12px; color:#64748b;">Roads</span></td>
              <td style="padding:14px 16px;"><span style="padding:3px 10px; border-radius:99px; font-size:11px; font-weight:600; background:#fef3c7; color:#92400e;">Pending</span></td>
              <td style="padding:14px 16px; font-size:12px; color:#94a3b8;">Oct 11</td>
              <td style="padding:14px 16px; font-size:13px; font-weight:600; color:#64748b;">24</td>
              <td style="padding:14px 20px; text-align:right;"><a href="<%= request.getContextPath() %>/citizen/issue-detail?id=1" style="font-size:12px; color:#059669; font-weight:600; text-decoration:none;">View →</a></td>
            </tr>
            <tr style="border-bottom:1px solid #f8fafc; transition:background 0.15s;" onmouseover="this.style.background='#fafbfc'" onmouseout="this.style.background='transparent'">
              <td style="padding:14px 20px;">
                <p style="font-size:14px; font-weight:600; color:#1e293b;">Streetlight out — Bagbazar</p>
                <p style="font-size:12px; color:#94a3b8;">#NS-8815 · Ward 04</p>
              </td>
              <td style="padding:14px 16px;"><span style="font-size:12px; color:#64748b;">Electrical</span></td>
              <td style="padding:14px 16px;"><span style="padding:3px 10px; border-radius:99px; font-size:11px; font-weight:600; background:#d1fae5; color:#065f46;">In Progress</span></td>
              <td style="padding:14px 16px; font-size:12px; color:#94a3b8;">Oct 8</td>
              <td style="padding:14px 16px; font-size:13px; font-weight:600; color:#64748b;">18</td>
              <td style="padding:14px 20px; text-align:right;"><a href="<%= request.getContextPath() %>/citizen/issue-detail?id=2" style="font-size:12px; color:#059669; font-weight:600; text-decoration:none;">View →</a></td>
            </tr>
            <tr style="border-bottom:1px solid #f8fafc; transition:background 0.15s;" onmouseover="this.style.background='#fafbfc'" onmouseout="this.style.background='transparent'">
              <td style="padding:14px 20px;">
                <p style="font-size:14px; font-weight:600; color:#1e293b;">Garbage pile at Thapathali bridge</p>
                <p style="font-size:12px; color:#94a3b8;">#NS-8790 · Ward 04</p>
              </td>
              <td style="padding:14px 16px;"><span style="font-size:12px; color:#64748b;">Sanitation</span></td>
              <td style="padding:14px 16px;"><span style="padding:3px 10px; border-radius:99px; font-size:11px; font-weight:600; background:#d1fae5; color:#065f46;">Resolved</span></td>
              <td style="padding:14px 16px; font-size:12px; color:#94a3b8;">Oct 5</td>
              <td style="padding:14px 16px; font-size:13px; font-weight:600; color:#64748b;">31</td>
              <td style="padding:14px 20px; text-align:right;"><a href="<%= request.getContextPath() %>/citizen/issue-detail?id=3" style="font-size:12px; color:#059669; font-weight:600; text-decoration:none;">View →</a></td>
            </tr>
            <tr style="border-bottom:1px solid #f8fafc; transition:background 0.15s;" onmouseover="this.style.background='#fafbfc'" onmouseout="this.style.background='transparent'">
              <td style="padding:14px 20px;">
                <p style="font-size:14px; font-weight:600; color:#1e293b;">Broken pipe near Pashupati</p>
                <p style="font-size:12px; color:#94a3b8;">#NS-8752 · Ward 07</p>
              </td>
              <td style="padding:14px 16px;"><span style="font-size:12px; color:#64748b;">Water</span></td>
              <td style="padding:14px 16px;"><span style="padding:3px 10px; border-radius:99px; font-size:11px; font-weight:600; background:#d1fae5; color:#065f46;">Resolved</span></td>
              <td style="padding:14px 16px; font-size:12px; color:#94a3b8;">Sep 28</td>
              <td style="padding:14px 16px; font-size:13px; font-weight:600; color:#64748b;">42</td>
              <td style="padding:14px 20px; text-align:right;"><a href="<%= request.getContextPath() %>/citizen/issue-detail?id=4" style="font-size:12px; color:#059669; font-weight:600; text-decoration:none;">View →</a></td>
            </tr>
            <tr style="transition:background 0.15s;" onmouseover="this.style.background='#fafbfc'" onmouseout="this.style.background='transparent'">
              <td style="padding:14px 20px;">
                <p style="font-size:14px; font-weight:600; color:#1e293b;">Overflowing drain — Sundhara</p>
                <p style="font-size:12px; color:#94a3b8;">#NS-8701 · Ward 04</p>
              </td>
              <td style="padding:14px 16px;"><span style="font-size:12px; color:#64748b;">Drainage</span></td>
              <td style="padding:14px 16px;"><span style="padding:3px 10px; border-radius:99px; font-size:11px; font-weight:600; background:#fef3c7; color:#92400e;">Pending</span></td>
              <td style="padding:14px 16px; font-size:12px; color:#94a3b8;">Sep 22</td>
              <td style="padding:14px 16px; font-size:13px; font-weight:600; color:#64748b;">15</td>
              <td style="padding:14px 20px; text-align:right;"><a href="<%= request.getContextPath() %>/citizen/issue-detail?id=5" style="font-size:12px; color:#059669; font-weight:600; text-decoration:none;">View →</a></td>
            </tr>
          </tbody>
        </table>

        <div style="padding:12px 20px; border-top:1px solid #f1f5f9; display:flex; align-items:center; justify-content:space-between;">
          <span style="font-size:12px; color:#94a3b8;">Showing 5 of 12 reports</span>
          <div style="display:flex; gap:4px;">
            <button style="width:30px; height:30px; border-radius:6px; border:1px solid #e2e8f0; background:#fff; color:#64748b; cursor:pointer; font-size:12px; display:flex; align-items:center; justify-content:center;">&lsaquo;</button>
            <button style="width:30px; height:30px; border-radius:6px; border:none; background:#0f172a; color:#fff; cursor:pointer; font-size:12px; font-weight:700;">1</button>
            <button style="width:30px; height:30px; border-radius:6px; border:1px solid #e2e8f0; background:#fff; color:#64748b; cursor:pointer; font-size:12px;">2</button>
            <button style="width:30px; height:30px; border-radius:6px; border:1px solid #e2e8f0; background:#fff; color:#64748b; cursor:pointer; font-size:12px;">3</button>
            <button style="width:30px; height:30px; border-radius:6px; border:1px solid #e2e8f0; background:#fff; color:#64748b; cursor:pointer; font-size:12px; display:flex; align-items:center; justify-content:center;">&rsaquo;</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>
