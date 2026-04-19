<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% String activePage = (String) request.getAttribute("activePage"); %>

<div style="position:fixed; top:0; left:0; height:100vh; width:220px; background:#0f172a; border-right:1px solid #1e293b; display:flex; flex-direction:column; z-index:50;">

    <div style="padding:20px 20px 16px; border-bottom:1px solid #1e293b;">
        <div style="display:flex; align-items:center; gap:10px;">
            <div style="width:30px; height:30px; border-radius:8px; background:#059669; display:flex; align-items:center; justify-content:center;">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="white"><path d="M12 3L3 7v2h18V7l-9-4zm-7 8v6H3v2h18v-2h-2v-6h-2v6h-2v-6h-2v6h-2v-6H9v6H7v-6H5z"/></svg>
            </div>
            <div>
                <div style="font-family:'Outfit',sans-serif; font-weight:700; font-size:15px; color:#f1f5f9;">SnapTheSlop</div>
                <div style="font-size:10px; font-weight:600; color:#475569; text-transform:uppercase; letter-spacing:1.5px;">Municipality</div>
            </div>
        </div>
    </div>

    <nav style="flex:1; overflow-y:auto; padding:12px 10px;">
        <p style="padding:4px 12px 8px; font-size:10px; font-weight:700; color:#334155; text-transform:uppercase; letter-spacing:1.5px;">Menu</p>

        <a href="<%= request.getContextPath() %>/municipality/dashboard"
           style="display:flex; align-items:center; gap:10px; padding:9px 12px; border-radius:8px; margin-bottom:2px; text-decoration:none; font-size:13px; font-weight:600;
           <%= "dashboard".equals(activePage) ? "background:#15342a; color:#34d399;" : "color:#64748b;" %>">
            <svg width="16" height="16" fill="currentColor" viewBox="0 0 20 20"><path d="M5 3a2 2 0 00-2 2v2a2 2 0 002 2h2a2 2 0 002-2V5a2 2 0 00-2-2H5zM5 11a2 2 0 00-2 2v2a2 2 0 002 2h2a2 2 0 002-2v-2a2 2 0 00-2-2H5zM11 5a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V5zM11 13a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z"/></svg>
            Dashboard
        </a>

        <a href="<%= request.getContextPath() %>/municipality/issue-list"
           style="display:flex; align-items:center; gap:10px; padding:9px 12px; border-radius:8px; margin-bottom:2px; text-decoration:none; font-size:13px; font-weight:600;
           <%= "issue-reports".equals(activePage) ? "background:#15342a; color:#34d399;" : "color:#64748b;" %>">
            <svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/></svg>
            Manage Issues
        </a>

        <a href="<%= request.getContextPath() %>/municipality/ward-management"
           style="display:flex; align-items:center; gap:10px; padding:9px 12px; border-radius:8px; margin-bottom:2px; text-decoration:none; font-size:13px; font-weight:600;
           <%= "ward-management".equals(activePage) ? "background:#15342a; color:#34d399;" : "color:#64748b;" %>">
            <svg width="16" height="16" fill="currentColor" viewBox="0 0 20 20"><path d="M9 6a3 3 0 11-6 0 3 3 0 016 0zM17 6a3 3 0 11-6 0 3 3 0 016 0zM12.93 17c.046-.327.07-.66.07-1a6.97 6.97 0 00-1.5-4.33A5 5 0 0119 16v1h-6.07zM6 11a5 5 0 015 5v1H1v-1a5 5 0 015-5z"/></svg>
            Ward Management
        </a>

        <a href="<%= request.getContextPath() %>/municipality/notifications"
           style="display:flex; align-items:center; gap:10px; padding:9px 12px; border-radius:8px; margin-bottom:2px; text-decoration:none; font-size:13px; font-weight:600;
           <%= "notifications".equals(activePage) ? "background:#15342a; color:#34d399;" : "color:#64748b;" %>">
            <svg width="16" height="16" fill="currentColor" viewBox="0 0 20 20"><path d="M10 2a6 6 0 00-6 6v3.586l-.707.707A1 1 0 004 14h12a1 1 0 00.707-1.707L16 11.586V8a6 6 0 00-6-6zM10 18a3 3 0 01-3-3h6a3 3 0 01-3 3z"/></svg>
            Notifications
        </a>
    </nav>

    <div style="padding:10px; border-top:1px solid #1e293b;">
        <% String userName = (String) session.getAttribute("userName"); %>
        <% String userInitials = (String) session.getAttribute("userInitials"); %>
        <% if (userName != null) { %>
        <div style="padding:12px; margin-bottom:12px; background:#15342a; border-radius:8px; display:flex; align-items:center; gap:10px;">
            <div style="width:36px; height:36px; border-radius:50%; background:#059669; display:flex; align-items:center; justify-content:center; color:#fff; font-size:13px; font-weight:700; flex-shrink:0;">
                <%= userInitials %>
            </div>
            <div style="flex:1; min-width:0;">
                <p style="font-size:12px; font-weight:600; color:#f1f5f9; margin:0; word-break:break-word; white-space:normal;"><%= userName %></p>
                <p style="font-size:10px; color:#94a3b8; margin:2px 0 0; text-transform:uppercase; letter-spacing:0.5px;">Municipality</p>
            </div>
        </div>
        <% } %>
        <a href="<%= request.getContextPath() %>/municipality/profile"
           style="display:flex; align-items:center; gap:10px; padding:9px 12px; border-radius:8px; margin-bottom:2px; text-decoration:none; font-size:13px; font-weight:600;
           <%= "profile".equals(activePage) ? "background:#15342a; color:#34d399;" : "color:#64748b;" %>">
            <svg width="16" height="16" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z" clip-rule="evenodd"/></svg>
            Profile
        </a>
        <a href="<%= request.getContextPath() %>/user/logout" style="display:flex; align-items:center; gap:10px; padding:9px 12px; border-radius:8px; text-decoration:none; color:#ef4444; font-size:13px; font-weight:600;">
            <svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"/></svg>
            Logout
        </a>
    </div>
</div>
