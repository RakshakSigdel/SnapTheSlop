<%--
  My Reports (Issue Tracking) - SnapTheSlop
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setAttribute("activePage", "issue-reports"); %>
<jsp:include page="../common/header.jsp"/>

<body style="background:#f8fafc; font-family:'Inter','Segoe UI',sans-serif; margin:0; padding:0;">
<div style="display:flex; min-height:100vh;">

  <jsp:include page="../common/citizen-sidebar.jsp"/>

  <div style="flex:1; margin-left:200px; display:flex; flex-direction:column; min-height:100vh;">

    <!-- Top Nav -->
    <div style="background:#fff; border-bottom:1px solid #f0f0f0; padding:14px 28px; display:flex; align-items:center; justify-content:space-between; position:sticky; top:0; z-index:50;">
      <div style="display:flex; align-items:center; gap:12px;">
        <span style="font-size:14px; font-weight:700; color:#111827;">My Reports</span>
        <span style="color:#d1d5db;">|</span>
        <span style="font-size:12px; color:#9ca3af;">Review and manage your submitted civic concerns</span>
      </div>
      <div style="display:flex; align-items:center; gap:14px;">
        <button style="background:none; border:none; cursor:pointer; color:#9ca3af;">
          <svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6 6 0 10-12 0v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"/></svg>
        </button>
        <div style="display:flex; align-items:center; gap:8px;">
          <div style="text-align:right;">
            <div style="font-size:11px; font-weight:700; color:#374151;"><%= session.getAttribute("userName") != null ? session.getAttribute("userName") : "Aryan Sharma" %></div>
            <div style="font-size:10px; color:#9ca3af; letter-spacing:0.5px;">CITIZEN ID: 89283</div>
          </div>
          <div style="width:34px; height:34px; border-radius:50%; background:#2563eb; display:flex; align-items:center; justify-content:center; color:#fff; font-size:13px; font-weight:700;">AS</div>
        </div>
      </div>
    </div>

    <div style="flex:1; padding:28px;">

      <!-- Page Header -->
      <div style="display:flex; align-items:flex-start; justify-content:space-between; margin-bottom:20px;">
        <div>
          <h1 style="font-size:26px; font-weight:800; color:#111827; margin:0 0 4px 0;">Issue Tracking</h1>
          <p style="font-size:13px; color:#6b7280; margin:0;">Overview of all active and historical infrastructure reports submitted to the municipal council.</p>
        </div>
        <a href="<%= request.getContextPath() %>/citizen/report-issue"
           style="display:flex; align-items:center; gap:6px; background:#2563eb; color:#fff; text-decoration:none; padding:10px 18px; border-radius:10px; font-size:12px; font-weight:700; letter-spacing:0.5px;">
          <span style="font-size:16px; line-height:1;">+</span> New Report
        </a>
      </div>

      <!-- 4 Stat Cards -->
      <div style="display:grid; grid-template-columns:repeat(4,1fr); gap:16px; margin-bottom:24px;">
        <!-- Total Filed -->
        <div style="background:#fff; border-radius:12px; padding:18px 20px; border:1px solid #f0f0f0; box-shadow:0 1px 3px rgba(0,0,0,0.04);">
          <div style="font-size:10px; font-weight:700; color:#9ca3af; letter-spacing:1.5px; text-transform:uppercase; margin-bottom:8px;">Total Filed</div>
          <div style="display:flex; align-items:baseline; gap:8px;">
            <span style="font-size:28px; font-weight:800; color:#111827;">12</span>
            <span style="font-size:11px; font-weight:600; color:#22c55e;">+2 this month</span>
          </div>
        </div>
        <!-- Pending -->
        <div style="background:#fff; border-radius:12px; padding:18px 20px; border:1px solid #f0f0f0; box-shadow:0 1px 3px rgba(0,0,0,0.04);">
          <div style="font-size:10px; font-weight:700; color:#9ca3af; letter-spacing:1.5px; text-transform:uppercase; margin-bottom:8px;">Pending</div>
          <div style="display:flex; align-items:baseline; gap:8px;">
            <span style="font-size:28px; font-weight:800; color:#f97316;">03</span>
            <span style="font-size:11px; font-weight:600; color:#f97316;">Awaiting Review</span>
          </div>
        </div>
        <!-- Ongoing -->
        <div style="background:#fff; border-radius:12px; padding:18px 20px; border:1px solid #f0f0f0; box-shadow:0 1px 3px rgba(0,0,0,0.04);">
          <div style="font-size:10px; font-weight:700; color:#9ca3af; letter-spacing:1.5px; text-transform:uppercase; margin-bottom:8px;">Ongoing</div>
          <div style="display:flex; align-items:baseline; gap:8px;">
            <span style="font-size:28px; font-weight:800; color:#2563eb;">05</span>
            <span style="font-size:11px; font-weight:600; color:#2563eb;">In Progress</span>
          </div>
        </div>
        <!-- Resolved -->
        <div style="background:#fff; border-radius:12px; padding:18px 20px; border:1px solid #f0f0f0; box-shadow:0 1px 3px rgba(0,0,0,0.04);">
          <div style="font-size:10px; font-weight:700; color:#9ca3af; letter-spacing:1.5px; text-transform:uppercase; margin-bottom:8px;">Resolved</div>
          <div style="display:flex; align-items:baseline; gap:8px;">
            <span style="font-size:28px; font-weight:800; color:#16a34a;">04</span>
            <span style="font-size:11px; font-weight:600; color:#16a34a;">Completion rate: 33%</span>
          </div>
        </div>
      </div>

      <!-- Table Card -->
      <div style="background:#fff; border-radius:14px; border:1px solid #f0f0f0; box-shadow:0 1px 3px rgba(0,0,0,0.04); margin-bottom:24px; overflow:hidden;">

        <!-- Table Header -->
        <div style="display:grid; grid-template-columns:2.5fr 1.4fr 1fr 0.9fr 1.2fr 0.8fr; gap:0; padding:12px 20px; background:#f9fafb; border-bottom:1px solid #f0f0f0;">
          <div style="font-size:10px; font-weight:700; color:#9ca3af; letter-spacing:1.5px; text-transform:uppercase;">Issue Title</div>
          <div style="font-size:10px; font-weight:700; color:#9ca3af; letter-spacing:1.5px; text-transform:uppercase;">Category</div>
          <div style="font-size:10px; font-weight:700; color:#9ca3af; letter-spacing:1.5px; text-transform:uppercase;">Status</div>
          <div style="font-size:10px; font-weight:700; color:#9ca3af; letter-spacing:1.5px; text-transform:uppercase;">Priority</div>
          <div style="font-size:10px; font-weight:700; color:#9ca3af; letter-spacing:1.5px; text-transform:uppercase;">Date Submitted</div>
          <div style="font-size:10px; font-weight:700; color:#9ca3af; letter-spacing:1.5px; text-transform:uppercase; text-align:right;">Actions</div>
        </div>

        <!-- Row 1: Main Road Pothole - PENDING - High -->
        <div style="display:grid; grid-template-columns:2.5fr 1.4fr 1fr 0.9fr 1.2fr 0.8fr; gap:0; padding:14px 20px; border-bottom:1px solid #f9fafb; align-items:center;">
          <div style="display:flex; align-items:center; gap:12px;">
            <div style="width:40px; height:40px; border-radius:8px; background:#d1d5db; overflow:hidden; flex-shrink:0; display:flex; align-items:center; justify-content:center;">
              <svg width="20" height="20" fill="#9ca3af" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M4 3a2 2 0 00-2 2v10a2 2 0 002 2h12a2 2 0 002-2V5a2 2 0 00-2-2H4zm12 12H4l4-8 3 6 2-4 3 6z" clip-rule="evenodd"/></svg>
            </div>
            <a href="<%= request.getContextPath() %>/citizen/issue-detail?id=1" style="font-size:13px; font-weight:600; color:#111827; text-decoration:none;">Main Road Pothole</a>
          </div>
          <div style="font-size:12px; color:#6b7280;">Road &amp;<br>Infrastructure</div>
          <div><span style="background:#fff7ed; color:#ea580c; border:1px solid #fed7aa; padding:3px 10px; border-radius:20px; font-size:10px; font-weight:700; letter-spacing:0.5px; text-transform:uppercase;">Pending</span></div>
          <div style="display:flex; align-items:center; gap:5px;"><span style="color:#ef4444; font-size:14px;">&#9679;</span><span style="font-size:12px; color:#ef4444; font-weight:600;">High</span></div>
          <div style="font-size:12px; color:#6b7280;">Oct 24, 2023</div>
          <div style="display:flex; align-items:center; justify-content:flex-end; gap:8px;">
            <a href="<%= request.getContextPath() %>/citizen/issue-detail?id=1" style="color:#374151; cursor:pointer;"><svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/><path stroke-linecap="round" stroke-linejoin="round" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/></svg></a>
            <span style="color:#2563eb; cursor:pointer;"><svg width="15" height="15" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/></svg></span>
            <span style="color:#ef4444; cursor:pointer;"><svg width="15" height="15" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"/></svg></span>
          </div>
        </div>

        <!-- Row 2: Broken Streetlight - ONGOING - Medium -->
        <div style="display:grid; grid-template-columns:2.5fr 1.4fr 1fr 0.9fr 1.2fr 0.8fr; gap:0; padding:14px 20px; border-bottom:1px solid #f9fafb; align-items:center;">
          <div style="display:flex; align-items:center; gap:12px;">
            <div style="width:40px; height:40px; border-radius:8px; background:#fef3c7; overflow:hidden; flex-shrink:0; display:flex; align-items:center; justify-content:center;">
              <svg width="20" height="20" fill="#d97706" viewBox="0 0 20 20"><path d="M11 3a1 1 0 10-2 0v1a1 1 0 102 0V3zM15.657 5.757a1 1 0 00-1.414-1.414l-.707.707a1 1 0 001.414 1.414l.707-.707zM18 10a1 1 0 01-1 1h-1a1 1 0 110-2h1a1 1 0 011 1zM5.05 6.464A1 1 0 106.464 5.05l-.707-.707a1 1 0 00-1.414 1.414l.707.707zM5 10a1 1 0 01-1 1H3a1 1 0 110-2h1a1 1 0 011 1zM8 16v-1h4v1a2 2 0 11-4 0zM12 14c.015-.298.059-.591.138-.876a7 7 0 10-4.277 0c.08.285.123.578.138.876H12z"/></svg>
            </div>
            <a href="<%= request.getContextPath() %>/citizen/issue-detail?id=2" style="font-size:13px; font-weight:600; color:#111827; text-decoration:none;">Broken Streetlight #42</a>
          </div>
          <div style="font-size:12px; color:#6b7280;">Electrical</div>
          <div><span style="background:#eff6ff; color:#2563eb; border:1px solid #bfdbfe; padding:3px 10px; border-radius:20px; font-size:10px; font-weight:700; letter-spacing:0.5px; text-transform:uppercase;">Ongoing</span></div>
          <div style="display:flex; align-items:center; gap:5px;"><span style="color:#f97316; font-size:14px;">&#9679;</span><span style="font-size:12px; color:#f97316; font-weight:600;">Medium</span></div>
          <div style="font-size:12px; color:#6b7280;">Oct 19, 2023</div>
          <div style="display:flex; align-items:center; justify-content:flex-end; gap:8px;">
            <a href="<%= request.getContextPath() %>/citizen/issue-detail?id=2" style="color:#374151;"><svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/><path stroke-linecap="round" stroke-linejoin="round" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/></svg></a>
            <span style="color:#d1d5db;"><svg width="15" height="15" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/></svg></span>
            <span style="color:#d1d5db;"><svg width="15" height="15" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"/></svg></span>
          </div>
        </div>

        <!-- Row 3: Water Pipe Leakage - RESOLVED - Low -->
        <div style="display:grid; grid-template-columns:2.5fr 1.4fr 1fr 0.9fr 1.2fr 0.8fr; gap:0; padding:14px 20px; border-bottom:1px solid #f9fafb; align-items:center;">
          <div style="display:flex; align-items:center; gap:12px;">
            <div style="width:40px; height:40px; border-radius:8px; background:#dbeafe; overflow:hidden; flex-shrink:0; display:flex; align-items:center; justify-content:center;">
              <svg width="20" height="20" fill="#2563eb" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M5.05 4.05a7 7 0 119.9 9.9L10 18.9l-4.95-4.95a7 7 0 010-9.9zM10 11a2 2 0 100-4 2 2 0 000 4z" clip-rule="evenodd"/></svg>
            </div>
            <a href="<%= request.getContextPath() %>/citizen/issue-detail?id=3" style="font-size:13px; font-weight:600; color:#111827; text-decoration:none;">Water Pipe Leakage</a>
          </div>
          <div style="font-size:12px; color:#6b7280;">Sanitation</div>
          <div><span style="background:#f0fdf4; color:#16a34a; border:1px solid #bbf7d0; padding:3px 10px; border-radius:20px; font-size:10px; font-weight:700; letter-spacing:0.5px; text-transform:uppercase;">Resolved</span></div>
          <div style="display:flex; align-items:center; gap:5px;"><span style="color:#22c55e; font-size:14px;">&#9679;</span><span style="font-size:12px; color:#22c55e; font-weight:600;">Low</span></div>
          <div style="font-size:12px; color:#6b7280;">Oct 12, 2023</div>
          <div style="display:flex; align-items:center; justify-content:flex-end; gap:8px;">
            <a href="<%= request.getContextPath() %>/citizen/issue-detail?id=3" style="color:#374151;"><svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/><path stroke-linecap="round" stroke-linejoin="round" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/></svg></a>
            <span style="color:#d1d5db;"><svg width="15" height="15" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/></svg></span>
            <span style="color:#d1d5db;"><svg width="15" height="15" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"/></svg></span>
          </div>
        </div>

        <!-- Row 4: Uncollected Trash - PENDING - Medium -->
        <div style="display:grid; grid-template-columns:2.5fr 1.4fr 1fr 0.9fr 1.2fr 0.8fr; gap:0; padding:14px 20px; align-items:center;">
          <div style="display:flex; align-items:center; gap:12px;">
            <div style="width:40px; height:40px; border-radius:8px; background:#dcfce7; overflow:hidden; flex-shrink:0; display:flex; align-items:center; justify-content:center;">
              <svg width="20" height="20" fill="#16a34a" viewBox="0 0 20 20"><path d="M9 6a3 3 0 11-6 0 3 3 0 016 0zM17 6a3 3 0 11-6 0 3 3 0 016 0zM12.93 17c.046-.327.07-.66.07-1a6.97 6.97 0 00-1.5-4.33A5 5 0 0119 16v1h-6.07zM6 11a5 5 0 015 5v1H1v-1a5 5 0 015-5z"/></svg>
            </div>
            <a href="<%= request.getContextPath() %>/citizen/issue-detail?id=4" style="font-size:13px; font-weight:600; color:#111827; text-decoration:none;">Uncollected Trash</a>
          </div>
          <div style="font-size:12px; color:#6b7280;">Waste Management</div>
          <div><span style="background:#fff7ed; color:#ea580c; border:1px solid #fed7aa; padding:3px 10px; border-radius:20px; font-size:10px; font-weight:700; letter-spacing:0.5px; text-transform:uppercase;">Pending</span></div>
          <div style="display:flex; align-items:center; gap:5px;"><span style="color:#f97316; font-size:14px;">&#9679;</span><span style="font-size:12px; color:#f97316; font-weight:600;">Medium</span></div>
          <div style="font-size:12px; color:#6b7280;">Oct 26, 2023</div>
          <div style="display:flex; align-items:center; justify-content:flex-end; gap:8px;">
            <a href="<%= request.getContextPath() %>/citizen/issue-detail?id=4" style="color:#374151;"><svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/><path stroke-linecap="round" stroke-linejoin="round" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/></svg></a>
            <span style="color:#2563eb; cursor:pointer;"><svg width="15" height="15" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/></svg></span>
            <span style="color:#ef4444; cursor:pointer;"><svg width="15" height="15" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"/></svg></span>
          </div>
        </div>

        <!-- Pagination Row -->
        <div style="display:flex; align-items:center; justify-content:space-between; padding:12px 20px; border-top:1px solid #f0f0f0; background:#fafafa;">
          <span style="font-size:11px; color:#9ca3af; font-weight:600; text-transform:uppercase; letter-spacing:0.5px;">Showing 1 to 4 of 12 reports</span>
          <div style="display:flex; align-items:center; gap:4px;">
            <button style="width:28px; height:28px; border-radius:6px; border:1px solid #e5e7eb; background:#fff; display:flex; align-items:center; justify-content:center; cursor:pointer; color:#9ca3af;">
              <svg width="12" height="12" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M15 19l-7-7 7-7"/></svg>
            </button>
            <button style="width:28px; height:28px; border-radius:6px; border:none; background:#2563eb; color:#fff; font-size:12px; font-weight:700; cursor:pointer;">1</button>
            <button style="width:28px; height:28px; border-radius:6px; border:1px solid #e5e7eb; background:#fff; color:#6b7280; font-size:12px; font-weight:600; cursor:pointer;">2</button>
            <button style="width:28px; height:28px; border-radius:6px; border:1px solid #e5e7eb; background:#fff; color:#6b7280; font-size:12px; font-weight:600; cursor:pointer;">3</button>
            <button style="width:28px; height:28px; border-radius:6px; border:1px solid #e5e7eb; background:#fff; display:flex; align-items:center; justify-content:center; cursor:pointer; color:#9ca3af;">
              <svg width="12" height="12" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M9 5l7 7-7 7"/></svg>
            </button>
          </div>
        </div>
      </div>

      <!-- Bottom Section: Resolution Timeline + Emergency -->
      <div style="display:grid; grid-template-columns:1.2fr 1fr; gap:20px;">

        <!-- Resolution Timeline -->
        <div style="background:#fff; border-radius:14px; border:1px solid #f0f0f0; box-shadow:0 1px 3px rgba(0,0,0,0.04); padding:22px;">
          <h3 style="font-size:16px; font-weight:700; color:#111827; margin:0 0 16px 0;">Resolution Timeline</h3>
          <div style="display:flex; flex-direction:column; gap:0;">
            <!-- Entry 1 -->
            <div style="display:flex; gap:12px; padding-bottom:16px;">
              <div style="display:flex; flex-direction:column; align-items:center;">
                <div style="width:10px; height:10px; border-radius:50%; background:#2563eb; flex-shrink:0; margin-top:2px;"></div>
                <div style="width:1px; flex:1; background:#e5e7eb; margin-top:4px;"></div>
              </div>
              <div style="padding-bottom:4px;">
                <p style="font-size:10px; font-weight:700; color:#2563eb; letter-spacing:0.5px; text-transform:uppercase; margin:0 0 2px 0;">Today, 09:12 AM</p>
                <p style="font-size:13px; font-weight:600; color:#111827; margin:0 0 3px 0;">Water Pipe Repair Completed</p>
                <p style="font-size:12px; color:#6b7280; margin:0; line-height:1.5;">The sanitation department has closed ticket #3319.</p>
              </div>
            </div>
            <!-- Entry 2 -->
            <div style="display:flex; gap:12px;">
              <div style="display:flex; flex-direction:column; align-items:center;">
                <div style="width:10px; height:10px; border-radius:50%; background:#d1d5db; flex-shrink:0; margin-top:2px;"></div>
              </div>
              <div>
                <p style="font-size:10px; font-weight:700; color:#9ca3af; letter-spacing:0.5px; text-transform:uppercase; margin:0 0 2px 0;">Yesterday</p>
                <p style="font-size:13px; font-weight:600; color:#111827; margin:0 0 3px 0;">Status Updated: Ongoing</p>
                <p style="font-size:12px; color:#6b7280; margin:0; line-height:1.5;">Broken Streetlight #42 has been assigned to a technician.</p>
              </div>
            </div>
          </div>
        </div>

        <!-- Need Immediate Assistance -->
        <div style="background:#f0f7ff; border-radius:14px; border:1px solid #bfdbfe; padding:28px 24px; display:flex; flex-direction:column; align-items:center; justify-content:center; text-align:center;">
          <div style="width:48px; height:48px; border-radius:50%; background:#2563eb; display:flex; align-items:center; justify-content:center; margin-bottom:14px;">
            <svg width="22" height="22" fill="#fff" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd"/></svg>
          </div>
          <h3 style="font-size:17px; font-weight:700; color:#1e3a8a; margin:0 0 10px 0;">Need immediate assistance?</h3>
          <p style="font-size:12px; color:#3b82f6; margin:0 0 20px 0; line-height:1.6;">If your report involves a life-threatening emergency or major gas leak, please call the municipal hotline directly at <strong>311</strong>.</p>
          <div style="display:flex; gap:10px;">
            <button style="background:#2563eb; color:#fff; border:none; padding:10px 16px; border-radius:8px; font-size:11px; font-weight:700; letter-spacing:0.5px; cursor:pointer; text-transform:uppercase;">Emergency Contacts</button>
            <button style="background:#fff; color:#2563eb; border:1px solid #93c5fd; padding:10px 16px; border-radius:8px; font-size:11px; font-weight:700; letter-spacing:0.5px; cursor:pointer; text-transform:uppercase;">Support Chat</button>
          </div>
        </div>

      </div>
    </div>
  </div>
</div>
</body>
</html>
