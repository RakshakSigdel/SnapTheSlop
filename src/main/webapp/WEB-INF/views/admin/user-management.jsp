<%--
  Admin User Management — NagarSewa
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setAttribute("activePage", "user-management"); %>
<jsp:include page="../common/header.jsp"/>

<div class="flex min-h-screen">
  <jsp:include page="../common/sidebar.jsp"/>

  <div class="flex-1" style="margin-left:220px; background:#f8fafc; min-height:100vh;">

    <div style="padding:18px 32px; display:flex; align-items:center; justify-content:space-between; border-bottom:1px solid #e2e8f0; background:#fff;">
      <h1 style="font-family:'Outfit',sans-serif; font-size:18px; font-weight:700; color:#0f172a;">User Management</h1>
      <button style="display:inline-flex; align-items:center; gap:6px; background:#0f172a; color:#fff; padding:9px 18px; border-radius:8px; font-size:13px; font-weight:600; border:none; cursor:pointer; font-family:'Inter',sans-serif;">
        <span style="font-size:16px;">+</span> Add User
      </button>
    </div>

    <div style="padding:28px 32px;">

      <p style="font-size:14px; color:#64748b; margin-bottom:20px;">2,847 registered accounts across all municipalities.</p>

      <!-- Search bar -->
      <div style="margin-bottom:20px;">
        <input type="text" placeholder="Search by name, email, or ID..." style="width:320px; height:40px; border:1.5px solid #e2e8f0; border-radius:8px; padding:0 14px; font-size:13px; color:#111827; background:#fff; outline:none; font-family:'Inter',sans-serif;"/>
      </div>

      <!-- Table -->
      <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; overflow:hidden;">
        <table style="width:100%; border-collapse:collapse;">
          <thead>
            <tr style="border-bottom:1px solid #f1f5f9;">
              <th style="text-align:left; padding:12px 20px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">User</th>
              <th style="text-align:left; padding:12px 16px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Email</th>
              <th style="text-align:left; padding:12px 16px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Role</th>
              <th style="text-align:left; padding:12px 16px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Status</th>
              <th style="text-align:left; padding:12px 16px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Joined</th>
              <th style="text-align:right; padding:12px 20px;"></th>
            </tr>
          </thead>
          <tbody>
            <tr style="border-bottom:1px solid #f8fafc;" onmouseover="this.style.background='#fafbfc'" onmouseout="this.style.background='transparent'">
              <td style="padding:14px 20px;">
                <div style="display:flex; align-items:center; gap:10px;">
                  <div style="width:32px; height:32px; border-radius:50%; background:#e0e7ff; display:flex; align-items:center; justify-content:center; color:#4338ca; font-size:11px; font-weight:700;">RS</div>
                  <div>
                    <p style="font-size:13px; font-weight:600; color:#1e293b;">Ramesh Sharma</p>
                    <p style="font-size:11px; color:#94a3b8;">NS-001</p>
                  </div>
                </div>
              </td>
              <td style="padding:14px 16px; font-size:13px; color:#64748b;">ramesh.s@gmail.com</td>
              <td style="padding:14px 16px;"><span style="font-size:12px; color:#4f46e5; font-weight:600;">Citizen</span></td>
              <td style="padding:14px 16px;"><span style="padding:3px 10px; border-radius:99px; font-size:11px; font-weight:600; background:#d1fae5; color:#065f46;">Active</span></td>
              <td style="padding:14px 16px; font-size:12px; color:#94a3b8;">Oct 2023</td>
              <td style="padding:14px 20px; text-align:right;">
                <div style="display:flex; gap:6px; justify-content:flex-end;">
                  <button style="background:none; border:none; cursor:pointer; color:#64748b; padding:4px;" title="Edit"><svg width="15" height="15" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/></svg></button>
                  <button style="background:none; border:none; cursor:pointer; color:#dc2626; padding:4px;" title="Delete"><svg width="15" height="15" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"/></svg></button>
                </div>
              </td>
            </tr>
            <tr style="border-bottom:1px solid #f8fafc;" onmouseover="this.style.background='#fafbfc'" onmouseout="this.style.background='transparent'">
              <td style="padding:14px 20px;">
                <div style="display:flex; align-items:center; gap:10px;">
                  <div style="width:32px; height:32px; border-radius:50%; background:#ede9fe; display:flex; align-items:center; justify-content:center; color:#6d28d9; font-size:11px; font-weight:700;">SK</div>
                  <div>
                    <p style="font-size:13px; font-weight:600; color:#1e293b;">Sushila Karki</p>
                    <p style="font-size:11px; color:#94a3b8;">NS-002</p>
                  </div>
                </div>
              </td>
              <td style="padding:14px 16px; font-size:13px; color:#64748b;">sushila.k@kmc.gov.np</td>
              <td style="padding:14px 16px;"><span style="font-size:12px; color:#7c3aed; font-weight:600;">Municipal Head</span></td>
              <td style="padding:14px 16px;"><span style="padding:3px 10px; border-radius:99px; font-size:11px; font-weight:600; background:#d1fae5; color:#065f46;">Active</span></td>
              <td style="padding:14px 16px; font-size:12px; color:#94a3b8;">Sep 2023</td>
              <td style="padding:14px 20px; text-align:right;">
                <div style="display:flex; gap:6px; justify-content:flex-end;">
                  <button style="background:none; border:none; cursor:pointer; color:#64748b; padding:4px;" title="Edit"><svg width="15" height="15" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/></svg></button>
                  <button style="background:none; border:none; cursor:pointer; color:#dc2626; padding:4px;" title="Delete"><svg width="15" height="15" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"/></svg></button>
                </div>
              </td>
            </tr>
            <tr style="border-bottom:1px solid #f8fafc;" onmouseover="this.style.background='#fafbfc'" onmouseout="this.style.background='transparent'">
              <td style="padding:14px 20px;">
                <div style="display:flex; align-items:center; gap:10px;">
                  <div style="width:32px; height:32px; border-radius:50%; background:#fef3c7; display:flex; align-items:center; justify-content:center; color:#92400e; font-size:11px; font-weight:700;">VS</div>
                  <div>
                    <p style="font-size:13px; font-weight:600; color:#1e293b;">Vikram Shrestha</p>
                    <p style="font-size:11px; color:#94a3b8;">NS-003</p>
                  </div>
                </div>
              </td>
              <td style="padding:14px 16px; font-size:13px; color:#64748b;">vikram.sh@yahoo.com</td>
              <td style="padding:14px 16px;"><span style="font-size:12px; color:#4f46e5; font-weight:600;">Citizen</span></td>
              <td style="padding:14px 16px;"><span style="padding:3px 10px; border-radius:99px; font-size:11px; font-weight:600; background:#fef3c7; color:#92400e;">Pending</span></td>
              <td style="padding:14px 16px; font-size:12px; color:#94a3b8;">Oct 2023</td>
              <td style="padding:14px 20px; text-align:right;">
                <div style="display:flex; gap:6px; justify-content:flex-end;">
                  <button style="background:none; border:none; cursor:pointer; color:#64748b; padding:4px;" title="Edit"><svg width="15" height="15" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/></svg></button>
                  <button style="background:none; border:none; cursor:pointer; color:#dc2626; padding:4px;" title="Delete"><svg width="15" height="15" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"/></svg></button>
                </div>
              </td>
            </tr>
            <tr onmouseover="this.style.background='#fafbfc'" onmouseout="this.style.background='transparent'">
              <td style="padding:14px 20px;">
                <div style="display:flex; align-items:center; gap:10px;">
                  <div style="width:32px; height:32px; border-radius:50%; background:#fee2e2; display:flex; align-items:center; justify-content:center; color:#991b1b; font-size:11px; font-weight:700;">BP</div>
                  <div>
                    <p style="font-size:13px; font-weight:600; color:#1e293b;">Binod Poudel</p>
                    <p style="font-size:11px; color:#94a3b8;">NS-004</p>
                  </div>
                </div>
              </td>
              <td style="padding:14px 16px; font-size:13px; color:#64748b;">binod.p@mail.com</td>
              <td style="padding:14px 16px;"><span style="font-size:12px; color:#4f46e5; font-weight:600;">Citizen</span></td>
              <td style="padding:14px 16px;"><span style="padding:3px 10px; border-radius:99px; font-size:11px; font-weight:600; background:#fee2e2; color:#991b1b;">Suspended</span></td>
              <td style="padding:14px 16px; font-size:12px; color:#94a3b8;">Aug 2023</td>
              <td style="padding:14px 20px; text-align:right;">
                <div style="display:flex; gap:6px; justify-content:flex-end;">
                  <button style="background:none; border:none; cursor:pointer; color:#64748b; padding:4px;" title="Edit"><svg width="15" height="15" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/></svg></button>
                  <button style="background:none; border:none; cursor:pointer; color:#dc2626; padding:4px;" title="Delete"><svg width="15" height="15" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"/></svg></button>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
        <div style="padding:12px 20px; border-top:1px solid #f1f5f9; display:flex; align-items:center; justify-content:space-between;">
          <span style="font-size:12px; color:#94a3b8;">Showing 4 of 2,847</span>
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
