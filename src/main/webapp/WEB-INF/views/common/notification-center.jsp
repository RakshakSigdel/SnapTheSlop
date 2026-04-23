<%@ page import="java.util.List" %>
<%@ page import="com.snaptheslop.snaptheslop.notification.model.NotificationItem" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.Duration" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String audience = (String) request.getAttribute("notificationAudience");
    if (audience == null) audience = "citizen";
    boolean municipalityView = "municipality".equalsIgnoreCase(audience);
    String sidebarInclude = municipalityView
            ? "../common/municipality-sidebar.jsp"
            : "../common/citizen-sidebar.jsp";
            
    List<NotificationItem> notifications = (List<NotificationItem>) request.getAttribute("notifications");
    int unreadCount = request.getAttribute("unreadCount") != null ? (int) request.getAttribute("unreadCount") : 0;
%>

<%!
    private String formatTimeAgo(LocalDateTime dt) {
        if (dt == null) return "Unknown";
        Duration d = Duration.between(dt, LocalDateTime.now());
        long hours = d.toHours();
        if (hours == 0) {
            long mins = d.toMinutes();
            if (mins == 0) return "Just now";
            return mins + " min ago";
        } else if (hours < 24) {
            return hours + " hr ago";
        } else {
            return dt.format(DateTimeFormatter.ofPattern("MMM dd, yyyy"));
        }
    }
%>

<div class="flex min-h-screen">
    <jsp:include page="<%= sidebarInclude %>"/>

    <div class="flex-1" style="margin-left:220px; background:#f8fafc; min-height:100vh;">
        <div style="padding:18px 32px; display:flex; align-items:center; justify-content:space-between; border-bottom:1px solid #e2e8f0; background:#fff;">
            <div>
                <h1 style="font-family:'Outfit',sans-serif; font-size:20px; font-weight:700; color:#0f172a; margin:0;">Notifications</h1>
                <p style="font-size:13px; color:#64748b; margin:2px 0 0;">
                    <%= municipalityView ? "Important updates for municipal operations and ward coordination." : "Recent updates on your reports and municipality actions." %>
                </p>
            </div>
            <% if (unreadCount > 0) { %>
            <form action="<%= request.getContextPath() %>/<%= municipalityView ? "municipality" : "citizen" %>/notifications/mark-read" method="post" style="margin:0;">
                <button type="submit" style="height:36px; border:1px solid #d1fae5; border-radius:8px; background:#ecfdf5; color:#065f46; font-size:12px; font-weight:600; padding:0 12px; cursor:pointer; font-family:'Inter',sans-serif;">
                    Mark all as read
                </button>
            </form>
            <% } %>
        </div>

        <div style="padding:28px 32px; max-width:980px;">
            <div style="display:flex; flex-direction:column; gap:10px;">
            
            <% if (notifications != null && !notifications.isEmpty()) { %>
                <% for (NotificationItem n : notifications) { 
                    String rowBg = n.isRead() ? "#ffffff" : "#f0fdf4";
                    String borderClass = n.isRead() ? "border: 1px solid #e2e8f0;" : "border: 1px solid #a7f3d0; border-left: 4px solid #059669;";
                    String actionLink = "";
                    String actionText = "";
                    if ("CITIZEN".equals(n.getAudience())) {
                        actionLink = request.getContextPath() + "/citizen/issue-detail?id=" + n.getIssueId();
                        actionText = "View issue \u2192";
                    } else if ("MUNICIPALITY".equals(n.getAudience())) {
                        actionLink = request.getContextPath() + "/municipality/manage-issue?id=" + n.getIssueId();
                        actionText = "Open issue \u2192";
                    }
                %>
                <div style="background:<%=rowBg%>; <%= borderClass %> border-radius:10px; padding:14px 16px;">
                    <div style="display:flex; align-items:flex-start; justify-content:space-between; gap:10px;">
                        <div>
                            <p style="font-size:14px; font-weight:600; color:#0f172a; margin-bottom:2px;"><%= n.getTitle() %></p>
                            <p style="font-size:13px; color:#64748b; line-height:1.6;"><%= n.getMessage() %></p>
                        </div>
                        <span style="font-size:11px; color:#94a3b8; white-space:nowrap;"><%= formatTimeAgo(n.getCreatedAt()) %></span>
                    </div>
                    <% if (n.getIssueId() != null && n.getIssueId() > 0) { %>
                    <a href="<%= actionLink %>" style="display:inline-block; margin-top:10px; font-size:12px; color:#059669; font-weight:600; text-decoration:none;"><%= actionText %></a>
                    <% } %>
                </div>
                <% } %>
            <% } else { %>
                <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:32px; text-align:center;">
                    <p style="font-size:14px; color:#64748b; margin:0;">No notifications found.</p>
                </div>
            <% } %>
            </div>
        </div>
    </div>
</div>
</body>
</html>