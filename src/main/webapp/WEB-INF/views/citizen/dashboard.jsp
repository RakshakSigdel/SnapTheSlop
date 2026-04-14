<%--
  Citizen Dashboard — NagarSewa
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setAttribute("activePage", "dashboard"); %>
<jsp:include page="../common/header.jsp"/>

<div class="flex min-h-screen">
  <jsp:include page="../common/citizen-sidebar.jsp"/>

  <!-- Main content — light bg against dark sidebar -->
  <div class="flex-1" style="margin-left:220px; background:#f8fafc; min-height:100vh;">

    <!-- Topbar -->
    <div style="padding:18px 32px; display:flex; align-items:center; justify-content:space-between; border-bottom:1px solid #e2e8f0; background:#fff;">
      <div>
        <h1 style="font-family:'Outfit',sans-serif; font-size:20px; font-weight:700; color:#0f172a; margin:0;">
          नमस्ते, <%= session.getAttribute("userName") != null ? session.getAttribute("userName") : "Arjun" %> 👋
        </h1>
        <p style="font-size:13px; color:#64748b; margin:2px 0 0;">Here's what's happening in Ward 04 today.</p>
      </div>
      <div style="display:flex; align-items:center; gap:16px;">
        <div style="position:relative; cursor:pointer;">
          <svg width="20" height="20" fill="none" stroke="#64748b" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6 6 0 10-12 0v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"/></svg>
          <span style="position:absolute; top:-2px; right:-2px; width:8px; height:8px; border-radius:50%; background:#ef4444; border:2px solid #fff;"></span>
        </div>
        <div style="width:34px; height:34px; border-radius:50%; background:#4f46e5; display:flex; align-items:center; justify-content:center; color:#fff; font-size:12px; font-weight:700;">
          <%= session.getAttribute("userInitials") != null ? session.getAttribute("userInitials") : "AS" %>
        </div>
      </div>
    </div>

    <div style="padding:28px 32px;">

      <!-- Stats row — intentionally different sizes -->
      <div style="display:grid; grid-template-columns:1fr 1fr 1fr; gap:16px; margin-bottom:28px;">
        <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:20px 22px;">
          <p style="font-size:12px; font-weight:600; color:#94a3b8; text-transform:uppercase; letter-spacing:1px; margin-bottom:10px;">My Reports</p>
          <div style="display:flex; align-items:baseline; gap:6px;">
            <span style="font-family:'Outfit',sans-serif; font-size:32px; font-weight:800; color:#0f172a;">12</span>
            <span style="font-size:12px; color:#64748b;">total filed</span>
          </div>
        </div>
        <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:20px 22px;">
          <p style="font-size:12px; font-weight:600; color:#94a3b8; text-transform:uppercase; letter-spacing:1px; margin-bottom:10px;">In Progress</p>
          <div style="display:flex; align-items:baseline; gap:6px;">
            <span style="font-family:'Outfit',sans-serif; font-size:32px; font-weight:800; color:#f59e0b;">4</span>
            <span style="font-size:12px; color:#64748b;">being worked on</span>
          </div>
        </div>
        <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:20px 22px;">
          <p style="font-size:12px; font-weight:600; color:#94a3b8; text-transform:uppercase; letter-spacing:1px; margin-bottom:10px;">Resolved</p>
          <div style="display:flex; align-items:baseline; gap:6px;">
            <span style="font-family:'Outfit',sans-serif; font-size:32px; font-weight:800; color:#059669;">8</span>
            <span style="font-size:12px; color:#64748b;">issues fixed</span>
          </div>
        </div>
      </div>

      <!-- Two-column: Recent + Quick Actions -->
      <div style="display:grid; grid-template-columns:5fr 3fr; gap:20px;">

        <!-- Recent Reports -->
        <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; overflow:hidden;">
          <div style="padding:18px 22px 14px; display:flex; align-items:center; justify-content:space-between; border-bottom:1px solid #f1f5f9;">
            <h2 style="font-size:15px; font-weight:700; color:#0f172a;">Recent Reports</h2>
            <a href="<%= request.getContextPath() %>/citizen/my-issues" style="font-size:12px; color:#4f46e5; text-decoration:none; font-weight:600;">View all →</a>
          </div>

          <!-- Issue rows — each slightly different -->
          <div style="padding:14px 22px; display:flex; align-items:center; justify-content:space-between; border-bottom:1px solid #f8fafc;">
            <div style="display:flex; align-items:center; gap:12px;">
              <div style="width:8px; height:8px; border-radius:50%; background:#ef4444;"></div>
              <div>
                <p style="font-size:14px; font-weight:600; color:#1e293b;">Pothole near Ratna Park</p>
                <p style="font-size:12px; color:#94a3b8;">Filed 2 days ago · #NS-8821</p>
              </div>
            </div>
            <span style="padding:4px 10px; border-radius:6px; font-size:11px; font-weight:600; background:#fef3c7; color:#92400e;">Pending</span>
          </div>

          <div style="padding:14px 22px; display:flex; align-items:center; justify-content:space-between; border-bottom:1px solid #f8fafc;">
            <div style="display:flex; align-items:center; gap:12px;">
              <div style="width:8px; height:8px; border-radius:50%; background:#3b82f6;"></div>
              <div>
                <p style="font-size:14px; font-weight:600; color:#1e293b;">Streetlight out — Bagbazar chowk</p>
                <p style="font-size:12px; color:#94a3b8;">Filed 5 days ago · #NS-8815</p>
              </div>
            </div>
            <span style="padding:4px 10px; border-radius:6px; font-size:11px; font-weight:600; background:#dbeafe; color:#1e40af;">In Progress</span>
          </div>

          <div style="padding:14px 22px; display:flex; align-items:center; justify-content:space-between; border-bottom:1px solid #f8fafc;">
            <div style="display:flex; align-items:center; gap:12px;">
              <div style="width:8px; height:8px; border-radius:50%; background:#10b981;"></div>
              <div>
                <p style="font-size:14px; font-weight:600; color:#1e293b;">Garbage pile — Thapathali bridge</p>
                <p style="font-size:12px; color:#94a3b8;">Fixed Oct 8 · #NS-8790</p>
              </div>
            </div>
            <span style="padding:4px 10px; border-radius:6px; font-size:11px; font-weight:600; background:#d1fae5; color:#065f46;">Resolved</span>
          </div>

          <div style="padding:14px 22px; display:flex; align-items:center; justify-content:space-between; border-bottom:1px solid #f8fafc;">
            <div style="display:flex; align-items:center; gap:12px;">
              <div style="width:8px; height:8px; border-radius:50%; background:#10b981;"></div>
              <div>
                <p style="font-size:14px; font-weight:600; color:#1e293b;">Broken pipe near Pashupati area</p>
                <p style="font-size:12px; color:#94a3b8;">Fixed Oct 5 · #NS-8752</p>
              </div>
            </div>
            <span style="padding:4px 10px; border-radius:6px; font-size:11px; font-weight:600; background:#d1fae5; color:#065f46;">Resolved</span>
          </div>

          <div style="padding:14px 22px; display:flex; align-items:center; justify-content:space-between;">
            <div style="display:flex; align-items:center; gap:12px;">
              <div style="width:8px; height:8px; border-radius:50%; background:#10b981;"></div>
              <div>
                <p style="font-size:14px; font-weight:600; color:#1e293b;">Illegal hoarding — New Road</p>
                <p style="font-size:12px; color:#94a3b8;">Fixed Sep 28 · #NS-8610</p>
              </div>
            </div>
            <span style="padding:4px 10px; border-radius:6px; font-size:11px; font-weight:600; background:#d1fae5; color:#065f46;">Resolved</span>
          </div>
        </div>

        <!-- Right side — mixed content -->
        <div style="display:flex; flex-direction:column; gap:16px;">

          <!-- Report CTA -->
          <a href="<%= request.getContextPath() %>/citizen/report-issue" style="text-decoration:none; display:block; background:#4f46e5; border-radius:10px; padding:24px; color:#fff; transition:background 0.2s;">
            <div style="display:flex; align-items:center; gap:12px; margin-bottom:10px;">
              <svg width="24" height="24" fill="none" stroke="#fff" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4"/></svg>
              <span style="font-family:'Outfit',sans-serif; font-size:17px; font-weight:700;">Report an Issue</span>
            </div>
            <p style="font-size:13px; color:rgba(255,255,255,0.75); line-height:1.5;">Found something broken in your area? Let the municipality know.</p>
          </a>

          <!-- Ward Info -->
          <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:20px 22px;">
            <h3 style="font-size:13px; font-weight:700; color:#0f172a; margin-bottom:14px;">Your Ward</h3>
            <div style="display:flex; flex-direction:column; gap:10px;">
              <div style="display:flex; justify-content:space-between;">
                <span style="font-size:13px; color:#64748b;">Ward</span>
                <span style="font-size:13px; font-weight:600; color:#0f172a;">04 — Central</span>
              </div>
              <div style="display:flex; justify-content:space-between;">
                <span style="font-size:13px; color:#64748b;">Municipality</span>
                <span style="font-size:13px; font-weight:600; color:#0f172a;">KMC</span>
              </div>
              <div style="display:flex; justify-content:space-between;">
                <span style="font-size:13px; color:#64748b;">Active issues</span>
                <span style="font-size:13px; font-weight:600; color:#f59e0b;">23</span>
              </div>
              <div style="display:flex; justify-content:space-between;">
                <span style="font-size:13px; color:#64748b;">Avg. fix time</span>
                <span style="font-size:13px; font-weight:600; color:#0f172a;">4.2 days</span>
              </div>
            </div>
          </div>

          <!-- Tip -->
          <div style="background:#fffbeb; border:1px solid #fef3c7; border-radius:10px; padding:16px 18px;">
            <p style="font-size:12px; font-weight:700; color:#92400e; margin-bottom:4px;">💡 Tip</p>
            <p style="font-size:13px; color:#78716c; line-height:1.5;">Adding a photo to your report increases the chance of it being resolved within 48 hours by <strong>3x</strong>.</p>
          </div>

          <!-- Quick links -->
          <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:16px 18px;">
            <p style="font-size:12px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px; margin-bottom:10px;">Quick Links</p>
            <div style="display:flex; flex-direction:column; gap:6px;">
              <a href="<%= request.getContextPath() %>/citizen/my-issues" style="font-size:13px; color:#4f46e5; text-decoration:none; font-weight:500;">My issue history →</a>
              <a href="<%= request.getContextPath() %>/profile" style="font-size:13px; color:#4f46e5; text-decoration:none; font-weight:500;">Edit profile →</a>
              <a href="#" style="font-size:13px; color:#4f46e5; text-decoration:none; font-weight:500;">Contact ward office →</a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>
