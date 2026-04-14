<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../common/header.jsp"/>

<div class="flex min-h-screen">
	<jsp:include page="../common/citizen-sidebar.jsp"/>

	<div class="flex-1" style="margin-left:220px; background:#f8fafc; min-height:100vh;">

		<div style="padding:18px 32px; display:flex; align-items:center; justify-content:space-between; border-bottom:1px solid #e2e8f0; background:#fff;">
			<div>
				<h1 style="font-family:'Outfit',sans-serif; font-size:20px; font-weight:700; color:#0f172a; margin:0;">Notifications</h1>
				<p style="font-size:13px; color:#64748b; margin:2px 0 0;">Recent updates on your reports and municipality actions.</p>
			</div>
			<button type="button" style="height:36px; border:1px solid #d1fae5; border-radius:8px; background:#ecfdf5; color:#065f46; font-size:12px; font-weight:600; padding:0 12px; cursor:pointer; font-family:'Inter',sans-serif;">
				Mark all as read
			</button>
		</div>

		<div style="padding:28px 32px; max-width:980px;">
			<div style="display:flex; gap:8px; margin-bottom:16px;">
				<button style="padding:7px 14px; border:none; border-radius:7px; background:#065f46; color:#fff; font-size:12px; font-weight:600; font-family:'Inter',sans-serif; cursor:pointer;">All</button>
				<button style="padding:7px 14px; border:1px solid #e2e8f0; border-radius:7px; background:#fff; color:#64748b; font-size:12px; font-weight:600; font-family:'Inter',sans-serif; cursor:pointer;">Unread</button>
				<button style="padding:7px 14px; border:1px solid #e2e8f0; border-radius:7px; background:#fff; color:#64748b; font-size:12px; font-weight:600; font-family:'Inter',sans-serif; cursor:pointer;">Resolved</button>
			</div>

			<div style="display:flex; flex-direction:column; gap:10px;">
				<div style="background:#fff; border:1px solid #a7f3d0; border-left:4px solid #059669; border-radius:10px; padding:14px 16px;">
					<div style="display:flex; align-items:flex-start; justify-content:space-between; gap:10px;">
						<div>
							<p style="font-size:14px; font-weight:600; color:#0f172a; margin-bottom:2px;">Your issue #NS-8821 was acknowledged</p>
							<p style="font-size:13px; color:#64748b; line-height:1.6;">Ward Office has acknowledged your pothole report and assigned it to the road maintenance team.</p>
						</div>
						<span style="font-size:11px; color:#94a3b8; white-space:nowrap;">2 min ago</span>
					</div>
					<a href="<%= request.getContextPath() %>/citizen/issue-detail?id=1" style="display:inline-block; margin-top:10px; font-size:12px; color:#059669; font-weight:600; text-decoration:none;">View issue →</a>
				</div>

				<div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:14px 16px;">
					<div style="display:flex; align-items:flex-start; justify-content:space-between; gap:10px;">
						<div>
							<p style="font-size:14px; font-weight:600; color:#0f172a; margin-bottom:2px;">Issue #NS-8815 status changed to In Progress</p>
							<p style="font-size:13px; color:#64748b; line-height:1.6;">An electrician crew has been assigned and work has started on your streetlight report.</p>
						</div>
						<span style="font-size:11px; color:#94a3b8; white-space:nowrap;">1 hour ago</span>
					</div>
					<a href="<%= request.getContextPath() %>/citizen/issue-detail?id=2" style="display:inline-block; margin-top:10px; font-size:12px; color:#059669; font-weight:600; text-decoration:none;">View issue →</a>
				</div>

				<div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:14px 16px;">
					<div style="display:flex; align-items:flex-start; justify-content:space-between; gap:10px;">
						<div>
							<p style="font-size:14px; font-weight:600; color:#0f172a; margin-bottom:2px;">Community upvotes increased on your report</p>
							<p style="font-size:13px; color:#64748b; line-height:1.6;">Your report #NS-8821 received 7 new upvotes from nearby residents in Ward 04.</p>
						</div>
						<span style="font-size:11px; color:#94a3b8; white-space:nowrap;">Today, 9:10 AM</span>
					</div>
				</div>

				<div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:14px 16px;">
					<div style="display:flex; align-items:flex-start; justify-content:space-between; gap:10px;">
						<div>
							<p style="font-size:14px; font-weight:600; color:#0f172a; margin-bottom:2px;">Issue #NS-8790 marked Resolved</p>
							<p style="font-size:13px; color:#64748b; line-height:1.6;">Sanitation team closed the garbage pile report after cleanup completion and verification.</p>
						</div>
						<span style="font-size:11px; color:#94a3b8; white-space:nowrap;">Yesterday</span>
					</div>
					<a href="<%= request.getContextPath() %>/citizen/issue-detail?id=3" style="display:inline-block; margin-top:10px; font-size:12px; color:#059669; font-weight:600; text-decoration:none;">View issue →</a>
				</div>

				<div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:14px 16px;">
					<div style="display:flex; align-items:flex-start; justify-content:space-between; gap:10px;">
						<div>
							<p style="font-size:14px; font-weight:600; color:#0f172a; margin-bottom:2px;">Monthly ward bulletin published</p>
							<p style="font-size:13px; color:#64748b; line-height:1.6;">Ward 04 performance summary for this month is now available in the citizen dashboard.</p>
						</div>
						<span style="font-size:11px; color:#94a3b8; white-space:nowrap;">2 days ago</span>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>
