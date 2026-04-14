<%--
  Issue Detail — NagarSewa
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../common/header.jsp"/>

<%
String issueId = String.valueOf(request.getAttribute("issueId") == null ? "1" : request.getAttribute("issueId"));
String issueTitle = String.valueOf(request.getAttribute("issueTitle") == null ? "Pothole near Ratna Park" : request.getAttribute("issueTitle"));
String issueCategory = String.valueOf(request.getAttribute("issueCategory") == null ? "Roads & Potholes" : request.getAttribute("issueCategory"));
String issueStatus = String.valueOf(request.getAttribute("issueStatus") == null ? "Pending" : request.getAttribute("issueStatus"));
String issuePriority = String.valueOf(request.getAttribute("issuePriority") == null ? "High Priority" : request.getAttribute("issuePriority"));
String issueLocation = String.valueOf(request.getAttribute("issueLocation") == null ? "Near Ratna Park bus stop, Ward 04" : request.getAttribute("issueLocation"));
%>

<div class="flex min-h-screen">
  <jsp:include page="../common/citizen-sidebar.jsp"/>

  <div class="flex-1" style="margin-left:220px; background:#f8fafc; min-height:100vh;">

    <div style="padding:18px 32px; border-bottom:1px solid #e2e8f0; background:#fff;">
      <nav style="display:flex; align-items:center; gap:6px; font-size:13px; color:#94a3b8;">
        <a href="<%= request.getContextPath() %>/citizen/dashboard" style="color:#64748b; text-decoration:none;">Dashboard</a>
        <span>/</span>
        <a href="<%= request.getContextPath() %>/citizen/my-issues" style="color:#64748b; text-decoration:none;">My Issues</a>
        <span>/</span>
        <span style="color:#0f172a; font-weight:600;">#NS-<%= issueId %></span>
      </nav>
    </div>

    <div style="padding:28px 32px;">

      <!-- Header -->
      <div style="margin-bottom:24px;">
        <div style="display:flex; align-items:center; gap:8px; margin-bottom:8px;">
          <span style="padding:3px 10px; border-radius:99px; font-size:11px; font-weight:600; background:#fef3c7; color:#92400e;"><%= issueStatus %></span>
          <span style="padding:3px 10px; border-radius:99px; font-size:11px; font-weight:600; background:#fee2e2; color:#991b1b;"><%= issuePriority %></span>
        </div>
        <h1 style="font-family:'Outfit',sans-serif; font-size:26px; font-weight:800; color:#0f172a; margin-bottom:4px; letter-spacing:-0.5px;"><%= issueTitle %></h1>
        <p style="font-size:13px; color:#94a3b8;">Filed Oct 11, 2023 · <%= issueCategory %> · <%= issueLocation %></p>
      </div>

      <div style="display:grid; grid-template-columns:5fr 3fr; gap:20px;">

        <!-- Left -->
        <div style="display:flex; flex-direction:column; gap:16px;">

          <!-- Description -->
          <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:22px;">
            <h2 style="font-size:14px; font-weight:700; color:#0f172a; margin-bottom:10px;">Description</h2>
            <p style="font-size:14px; color:#475569; line-height:1.8;">
              There's a large pothole that opened up on the road right next to the Ratna Park bus stop. 
              It's been there since the last heavy rain (probably about a week now). It's deep enough that 
              motorcycles have to swerve around it. One auto-rickshaw got stuck in it yesterday evening.
              The road sees heavy traffic — this needs fixing before someone gets hurt.
            </p>
          </div>

          <!-- Photos -->
          <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:22px;">
            <h2 style="font-size:14px; font-weight:700; color:#0f172a; margin-bottom:12px;">Photos</h2>
            <div style="display:grid; grid-template-columns:1fr 1fr; gap:10px;">
              <div style="height:140px; border-radius:8px; background:#f1f5f9; border:1px solid #e2e8f0; display:flex; align-items:center; justify-content:center;">
                <span style="font-size:12px; color:#94a3b8;">photo_1.jpg</span>
              </div>
              <div style="height:140px; border-radius:8px; background:#f1f5f9; border:1px solid #e2e8f0; display:flex; align-items:center; justify-content:center;">
                <span style="font-size:12px; color:#94a3b8;">photo_2.jpg</span>
              </div>
            </div>
          </div>

          <!-- Comments -->
          <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:22px;">
            <h2 style="font-size:14px; font-weight:700; color:#0f172a; margin-bottom:16px;">Comments (2)</h2>

            <div style="display:flex; gap:10px; margin-bottom:16px; padding-bottom:16px; border-bottom:1px solid #f1f5f9;">
              <div style="width:30px; height:30px; border-radius:50%; background:#dcfce7; display:flex; align-items:center; justify-content:center; color:#166534; font-size:11px; font-weight:700; flex-shrink:0;">AS</div>
              <div>
                <div style="display:flex; align-items:center; gap:8px; margin-bottom:4px;">
                  <span style="font-size:13px; font-weight:600; color:#1e293b;">Arjun Sharma</span>
                  <span style="font-size:11px; color:#94a3b8;">Oct 11</span>
                </div>
                <p style="font-size:13px; color:#475569; line-height:1.6;">This is getting worse every day. The rains last night made it even bigger. Can we get some urgency on this?</p>
              </div>
            </div>

            <div style="display:flex; gap:10px; margin-bottom:16px; padding-bottom:16px; border-bottom:1px solid #f1f5f9;">
              <div style="width:30px; height:30px; border-radius:50%; background:#d1fae5; display:flex; align-items:center; justify-content:center; color:#065f46; font-size:11px; font-weight:700; flex-shrink:0;">WO</div>
              <div>
                <div style="display:flex; align-items:center; gap:8px; margin-bottom:4px;">
                  <span style="font-size:13px; font-weight:600; color:#1e293b;">Ward Office</span>
                  <span style="padding:1px 6px; border-radius:4px; font-size:10px; font-weight:600; background:#dcfce7; color:#166534;">Official</span>
                  <span style="font-size:11px; color:#94a3b8;">Oct 12</span>
                </div>
                <p style="font-size:13px; color:#475569; line-height:1.6;">This has been forwarded to the roads department. A crew is scheduled for inspection this Friday.</p>
              </div>
            </div>

            <form action="<%= request.getContextPath() %>/comment/add" method="post">
              <input type="hidden" name="issueId" value="1"/>
              <textarea name="commentText" rows="2" placeholder="Write a comment..."
                        style="width:100%; border:1.5px solid #e5e7eb; border-radius:8px; padding:10px 12px; font-size:13px; color:#111827; background:#fff; outline:none; resize:none; font-family:'Inter',sans-serif; margin-bottom:8px;"></textarea>
              <button type="submit" style="background:#0f172a; color:#fff; border:none; font-size:12px; font-weight:600; padding:8px 16px; border-radius:6px; cursor:pointer; font-family:'Inter',sans-serif;">Post</button>
            </form>
          </div>
        </div>

        <!-- Right sidebar -->
        <div style="display:flex; flex-direction:column; gap:16px;">

          <!-- Details -->
          <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:20px;">
            <h3 style="font-size:12px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px; margin-bottom:14px;">Details</h3>
            <div style="display:flex; flex-direction:column; gap:12px;">
              <div><p style="font-size:12px; color:#94a3b8;">ID</p><p style="font-size:14px; font-weight:600; color:#0f172a;">#NS-<%= issueId %></p></div>
              <div><p style="font-size:12px; color:#94a3b8;">Category</p><p style="font-size:14px; color:#1e293b;"><%= issueCategory %></p></div>
              <div><p style="font-size:12px; color:#94a3b8;">Location</p><p style="font-size:14px; color:#1e293b;"><%= issueLocation %></p></div>
              <div><p style="font-size:12px; color:#94a3b8;">Ward</p><p style="font-size:14px; color:#1e293b;">Ward 04</p></div>
              <div><p style="font-size:12px; color:#94a3b8;">Filed by</p><p style="font-size:14px; color:#1e293b;">Arjun Sharma</p></div>
            </div>
          </div>

          <!-- Timeline -->
          <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:20px;">
            <h3 style="font-size:12px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px; margin-bottom:14px;">Timeline</h3>
            <div style="display:flex; flex-direction:column;">
              <div style="display:flex; gap:10px; padding-bottom:14px;">
                <div style="display:flex; flex-direction:column; align-items:center;">
                  <div style="width:8px; height:8px; border-radius:50%; background:#059669;"></div>
                  <div style="width:1px; flex:1; background:#e2e8f0;"></div>
                </div>
                <div><p style="font-size:12px; font-weight:600; color:#059669;">Submitted</p><p style="font-size:11px; color:#94a3b8;">Oct 11, 9:30 AM</p></div>
              </div>
              <div style="display:flex; gap:10px; padding-bottom:14px;">
                <div style="display:flex; flex-direction:column; align-items:center;">
                  <div style="width:8px; height:8px; border-radius:50%; background:#059669;"></div>
                  <div style="width:1px; flex:1; background:#e2e8f0;"></div>
                </div>
                <div><p style="font-size:12px; font-weight:600; color:#059669;">Acknowledged</p><p style="font-size:11px; color:#94a3b8;">Oct 12, 2:15 PM</p></div>
              </div>
              <div style="display:flex; gap:10px; padding-bottom:14px;">
                <div style="display:flex; flex-direction:column; align-items:center;">
                  <div style="width:8px; height:8px; border-radius:50%; background:#f59e0b; box-shadow:0 0 0 3px rgba(245,158,11,0.15);"></div>
                  <div style="width:1px; flex:1; background:#f1f5f9;"></div>
                </div>
                <div><p style="font-size:12px; font-weight:600; color:#d97706;">Under review</p><p style="font-size:11px; color:#94a3b8;">Waiting for crew</p></div>
              </div>
              <div style="display:flex; gap:10px;">
                <div><div style="width:8px; height:8px; border-radius:50%; background:#e2e8f0;"></div></div>
                <div><p style="font-size:12px; color:#cbd5e1;">Resolved</p></div>
              </div>
            </div>
          </div>

          <!-- Upvote -->
          <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:20px; text-align:center;">
            <p style="font-family:'Outfit',sans-serif; font-size:36px; font-weight:800; color:#0f172a;">24</p>
            <p style="font-size:12px; color:#94a3b8; margin-bottom:12px;">people support this report</p>
            <form action="<%= request.getContextPath() %>/upvote" method="post" style="display:inline;">
              <input type="hidden" name="issueId" value="1"/>
              <button type="submit" style="background:#f1f5f9; border:1px solid #e2e8f0; color:#1e293b; font-size:13px; font-weight:600; padding:8px 20px; border-radius:6px; cursor:pointer; font-family:'Inter',sans-serif; display:inline-flex; align-items:center; gap:6px;">
                ▲ Upvote
              </button>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>
