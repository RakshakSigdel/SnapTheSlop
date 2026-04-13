<%--
  Issue Detail (Report Detail Citizen) - SnapTheSlop Smart Municipality
  Design: NagarSewa UI (Google Stitch)
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setAttribute("activePage", "issue-reports"); %>
<jsp:include page="../common/header.jsp"/>

<body class="bg-gray-50" style="font-family:'Inter',sans-serif;">
<div class="flex min-h-screen">

  <!-- Sidebar -->
  <jsp:include page="../common/citizen-sidebar.jsp"/>

  <!-- Main Content -->
  <div class="flex-1 flex flex-col min-h-screen" style="margin-left:200px;">

    <!-- Top Nav Bar -->
    <div class="bg-white border-b border-gray-100 px-8 py-4 flex items-center justify-between sticky top-0 z-10">
      <div class="flex items-center gap-3">
        <a href="<%= request.getContextPath() %>/citizen/my-issues" class="text-gray-400 hover:text-gray-600 transition-colors">
          <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"/></svg>
        </a>
        <h1 class="text-sm font-bold text-gray-400 tracking-widest uppercase">Report Details</h1>
      </div>
      <div class="flex items-center gap-4">
        <button class="text-gray-400 hover:text-gray-600">
          <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6 6 0 10-12 0v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"/>
          </svg>
        </button>
        <div class="flex items-center gap-2.5">
          <div class="text-right">
            <p class="text-xs font-semibold text-gray-700"><%= session.getAttribute("userName") != null ? session.getAttribute("userName") : "Arjun Sharma" %></p>
            <p class="text-xs text-gray-400">Citizen ID: #0001</p>
          </div>
          <div class="w-9 h-9 rounded-full bg-blue-600 flex items-center justify-center text-white text-sm font-bold">
            <%= session.getAttribute("userInitials") != null ? session.getAttribute("userInitials") : "AS" %>
          </div>
        </div>
      </div>
    </div>

    <div class="flex-1 p-8">
      <div class="grid grid-cols-3 gap-7 max-w-7xl">

        <!-- Left: Main Issue Content -->
        <div class="col-span-2 space-y-5">

          <!-- Issue Image & Header Card -->
          <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
            <!-- Issue Image -->
            <div class="relative" style="height:220px;">
              <% if (request.getAttribute("issueImage") != null) { %>
                <img src="<%= request.getAttribute("issueImage") %>" alt="Issue" class="w-full h-full object-cover"/>
              <% } else { %>
                <div class="w-full h-full bg-gradient-to-br from-slate-700 to-slate-900 flex items-center justify-center">
                  <div class="text-center">
                    <svg class="w-12 h-12 text-slate-500 mx-auto mb-2" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"/></svg>
                    <p class="text-slate-500 text-xs">No image provided</p>
                  </div>
                </div>
              <% } %>
              <!-- Category badge overlay -->
              <div class="absolute top-4 left-4">
                <span class="px-3 py-1.5 rounded-full text-xs font-bold bg-blue-600 text-white shadow-lg">
                  <%= request.getAttribute("category") != null ? request.getAttribute("category") : "Road & Infrastructure" %>
                </span>
              </div>
              <!-- Action buttons overlay -->
              <% if (Boolean.TRUE.equals(request.getAttribute("isOwner"))) { %>
              <div class="absolute top-4 right-4 flex items-center gap-2">
                <button class="flex items-center gap-1.5 px-3 py-1.5 rounded-lg bg-white text-gray-700 text-xs font-bold shadow-md hover:bg-gray-50 transition-colors">
                  <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z"/></svg>
                  EDIT
                </button>
                <button onclick="document.getElementById('deleteModal').classList.remove('hidden')"
                        class="w-8 h-8 rounded-lg bg-red-500 text-white flex items-center justify-center shadow-md hover:bg-red-600 transition-colors">
                  <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M9 2a1 1 0 00-.894.553L7.382 4H4a1 1 0 000 2v10a2 2 0 002 2h8a2 2 0 002-2V6a1 1 0 100-2h-3.382l-.724-1.447A1 1 0 0011 2H9zM7 8a1 1 0 012 0v6a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v6a1 1 0 102 0V8a1 1 0 00-1-1z" clip-rule="evenodd"/></svg>
                </button>
              </div>
              <% } %>
            </div>

            <!-- Issue Title & Meta -->
            <div class="p-6">
              <div class="flex items-start justify-between gap-4 mb-4">
                <h2 class="text-xl font-bold text-gray-800">
                  <%= request.getAttribute("issueTitle") != null ? request.getAttribute("issueTitle") : "Main Road Pothole - Sector 4" %>
                </h2>
                <form action="<%= request.getContextPath() %>/upvote" method="post" class="flex-shrink-0">
                  <input type="hidden" name="issueId" value="<%= request.getAttribute("issueId") != null ? request.getAttribute("issueId") : "1" %>"/>
                  <button type="submit" class="flex items-center gap-2 px-4 py-2 bg-gray-100 hover:bg-blue-50 text-gray-600 hover:text-blue-600 text-xs font-bold rounded-xl transition-colors border border-gray-200 hover:border-blue-200">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 10h4.764a2 2 0 011.789 2.894l-3.5 7A2 2 0 0115.263 21h-4.017c-.163 0-.326-.02-.485-.06L7 20m7-10V5a2 2 0 00-2-2h-.095c-.5 0-.905.405-.905.905 0 .714-.211 1.412-.608 2.006L7 11v9m7-10h-2M7 20H5a2 2 0 01-2-2v-6a2 2 0 012-2h2.5"/></svg>
                    <%= request.getAttribute("upvoteCount") != null ? request.getAttribute("upvoteCount") : "24" %> Upvotes
                  </button>
                </form>
              </div>

              <div class="flex items-center gap-2 text-sm text-gray-500 mb-4">
                <svg class="w-4 h-4 text-gray-400" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M5.05 4.05a7 7 0 119.9 9.9L10 18.9l-4.95-4.95a7 7 0 010-9.9zM10 11a2 2 0 100-4 2 2 0 000 4z" clip-rule="evenodd"/></svg>
                <span><%= request.getAttribute("location") != null ? request.getAttribute("location") : "Sector 4, Ward 08, East Zone HQ" %></span>
              </div>

              <p class="text-xs font-bold text-gray-400 tracking-widest uppercase mb-2">Description</p>
              <p class="text-sm text-gray-600 leading-relaxed">
                <%= request.getAttribute("description") != null ? request.getAttribute("description") : "A large pothole has developed at the main road intersection causing damage to vehicles and posing safety risks to motorists and pedestrians. The pothole is approximately 1 meter wide and 15cm deep. Immediate repair is requested." %>
              </p>

              <!-- Reporter Info -->
              <div class="flex items-center justify-between mt-5 pt-4 border-t border-gray-100">
                <div class="flex items-center gap-3">
                  <div class="w-9 h-9 rounded-full bg-blue-600 flex items-center justify-center text-white text-sm font-bold">AS</div>
                  <div>
                    <p class="text-sm font-semibold text-gray-700"><%= session.getAttribute("userName") != null ? session.getAttribute("userName") : "Arjun Sharma" %></p>
                    <p class="text-xs text-gray-400">Reported: Oct 12, 2023</p>
                  </div>
                </div>
                <div class="text-right">
                  <p class="text-xs text-gray-400 font-semibold uppercase tracking-wide">Internal ID</p>
                  <p class="text-xs font-bold text-gray-600">#NS-8821</p>
                </div>
              </div>
            </div>
          </div>

          <!-- Discussion & Updates -->
          <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6">
            <h3 class="text-base font-bold text-gray-800 mb-5">Discussion &amp; Updates</h3>

            <!-- Comments -->
            <div class="space-y-4 mb-6">
              <!-- Comment 1 -->
              <div class="flex gap-3">
                <div class="w-8 h-8 rounded-full bg-orange-500 flex items-center justify-center text-white text-xs font-bold flex-shrink-0">RK</div>
                <div class="flex-1">
                  <div class="flex items-center justify-between mb-1">
                    <p class="text-sm font-semibold text-gray-700">Rajesh Kumar</p>
                    <p class="text-xs text-gray-400">2 hrs ago</p>
                  </div>
                  <p class="text-sm text-gray-600">This pothole is blocking the entry to the local businesses. Please expedite.</p>
                </div>
              </div>

              <!-- Official Update -->
              <div class="flex gap-3">
                <div class="w-8 h-8 rounded-full bg-blue-600 flex items-center justify-center flex-shrink-0">
                  <svg class="w-4 h-4 text-white" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M6.267 3.455a3.066 3.066 0 001.745-.723 3.066 3.066 0 013.976 0 3.066 3.066 0 001.745.723 3.066 3.066 0 012.812 2.812c.051.643.304 1.254.723 1.745a3.066 3.066 0 010 3.976 3.066 3.066 0 00-.723 1.745 3.066 3.066 0 01-2.812 2.812 3.066 3.066 0 00-1.745.723 3.066 3.066 0 01-3.976 0 3.066 3.066 0 00-1.745-.723 3.066 3.066 0 01-2.812-2.812 3.066 3.066 0 00-.723-1.745 3.066 3.066 0 010-3.976 3.066 3.066 0 00.723-1.745 3.066 3.066 0 012.812-2.812zm7.44 5.252a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/></svg>
                </div>
                <div class="flex-1 bg-blue-50 rounded-xl p-3 border border-blue-100">
                  <div class="flex items-center justify-between mb-1">
                    <div class="flex items-center gap-2">
                      <p class="text-sm font-bold text-blue-700">Department of Public Works</p>
                      <span class="text-xs bg-blue-600 text-white px-2 py-0.5 rounded-full font-bold">OFFICIAL UPDATE</span>
                    </div>
                    <p class="text-xs text-blue-400">1 hr ago</p>
                  </div>
                  <p class="text-sm text-blue-700">A crew is dispatched to assess the situation. Work will begin today by 4 PM.</p>
                </div>
              </div>

              <!-- Comment 2 -->
              <div class="flex gap-3">
                <div class="w-8 h-8 rounded-full bg-purple-500 flex items-center justify-center text-white text-xs font-bold flex-shrink-0">SP</div>
                <div class="flex-1">
                  <div class="flex items-center justify-between mb-1">
                    <p class="text-sm font-semibold text-gray-700">Sunita Patel</p>
                    <p class="text-xs text-gray-400">30 min ago</p>
                  </div>
                  <p class="text-sm text-gray-600">The water supply of the entire sector has been affected too. Please look into it.</p>
                </div>
              </div>
            </div>

            <!-- Add Comment -->
            <form class="pt-4 border-t border-gray-100" action="<%= request.getContextPath() %>/issue/comment" method="post">
              <input type="hidden" name="issueId" value="<%= request.getAttribute("issueId") != null ? request.getAttribute("issueId") : "1" %>"/>
              <div class="flex gap-3">
                <div class="w-8 h-8 rounded-full bg-blue-600 flex items-center justify-center text-white text-sm font-bold flex-shrink-0 mt-1">
                  <%= session.getAttribute("userInitials") != null ? session.getAttribute("userInitials") : "AS" %>
                </div>
                <div class="flex-1">
                  <textarea name="comment" rows="3" placeholder="Write a comment..."
                            class="w-full border border-gray-200 rounded-xl px-4 py-3 text-sm text-gray-700 placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent bg-gray-50 resize-none mb-3"></textarea>
                  <div class="flex justify-end">
                    <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white text-xs font-bold px-6 py-2.5 rounded-xl tracking-widest uppercase transition-colors">
                      POST
                    </button>
                  </div>
                </div>
              </div>
            </form>
          </div>
        </div>

        <!-- Right: Status Panel -->
        <div class="space-y-5">

          <!-- Resolution Progress -->
          <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6">
            <h3 class="text-xs font-bold text-gray-400 tracking-widest uppercase mb-5">Resolution Progress</h3>
            <div class="space-y-0">
              <!-- Step 1: Reported -->
              <div class="flex items-start gap-3">
                <div class="flex flex-col items-center">
                  <div class="w-7 h-7 rounded-full bg-blue-600 flex items-center justify-center flex-shrink-0">
                    <svg class="w-3.5 h-3.5 text-white" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/></svg>
                  </div>
                  <div class="w-0.5 bg-blue-200 mt-1" style="height:36px;"></div>
                </div>
                <div class="pt-0.5 pb-4">
                  <p class="text-sm font-bold text-gray-800">Reported</p>
                  <p class="text-xs text-gray-400">Received by the system</p>
                  <p class="text-xs text-blue-500 font-semibold mt-1">MAR 12, 09:15 AM</p>
                </div>
              </div>
              <!-- Step 2: Assigned -->
              <div class="flex items-start gap-3">
                <div class="flex flex-col items-center">
                  <div class="w-7 h-7 rounded-full bg-blue-600 flex items-center justify-center flex-shrink-0">
                    <svg class="w-3.5 h-3.5 text-white" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/></svg>
                  </div>
                  <div class="w-0.5 bg-gray-200 mt-1" style="height:36px;"></div>
                </div>
                <div class="pt-0.5 pb-4">
                  <p class="text-sm font-bold text-gray-800">Assigned</p>
                  <p class="text-xs text-gray-400">Sent to Public Works Dept</p>
                  <p class="text-xs text-blue-500 font-semibold mt-1">MAR 13, 02:30 PM</p>
                </div>
              </div>
              <!-- Step 3: In Progress -->
              <div class="flex items-start gap-3">
                <div class="flex flex-col items-center">
                  <div class="w-7 h-7 rounded-full border-2 border-gray-300 bg-white flex items-center justify-center flex-shrink-0">
                    <div class="w-2 h-2 rounded-full bg-gray-300"></div>
                  </div>
                  <div class="w-0.5 bg-gray-200 mt-1" style="height:36px;"></div>
                </div>
                <div class="pt-0.5 pb-4">
                  <p class="text-sm font-semibold text-gray-400">In Progress</p>
                  <p class="text-xs text-gray-400">Work scheduled for repair</p>
                </div>
              </div>
              <!-- Step 4: Resolved -->
              <div class="flex items-start gap-3">
                <div class="w-7 h-7 rounded-full border-2 border-gray-200 bg-white flex items-center justify-center flex-shrink-0">
                  <div class="w-2 h-2 rounded-full bg-gray-200"></div>
                </div>
                <div class="pt-0.5">
                  <p class="text-sm font-semibold text-gray-400">Resolved</p>
                  <p class="text-xs text-gray-400">Verified and closed</p>
                </div>
              </div>
            </div>
          </div>

          <!-- Service Area Map -->
          <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
            <div class="px-5 pt-5 pb-2">
              <h3 class="text-xs font-bold text-gray-400 tracking-widest uppercase">Service Area</h3>
            </div>
            <div class="relative" style="height:140px; background: #e8edf1;">
              <div class="absolute inset-0" style="background: linear-gradient(135deg, #dde3e8 0%, #c8d0d9 100%);">
                <div class="absolute inset-0 opacity-15" style="background-image: repeating-linear-gradient(0deg, transparent, transparent 15px, rgba(0,0,0,0.1) 15px, rgba(0,0,0,0.1) 16px), repeating-linear-gradient(90deg, transparent, transparent 15px, rgba(0,0,0,0.1) 15px, rgba(0,0,0,0.1) 16px);"></div>
              </div>
              <div class="absolute inset-0 flex items-center justify-center">
                <div class="w-6 h-6 bg-blue-600 rounded-full border-3 border-white shadow-lg"></div>
              </div>
              <div class="absolute bottom-2 right-2 bg-white rounded-lg px-2 py-1 text-xs font-semibold text-gray-500 shadow-sm">Ward 08</div>
              <div class="absolute bottom-2 left-2 bg-white rounded-lg px-2 py-1 text-xs font-semibold text-gray-500 shadow-sm">East Zone HQ</div>
            </div>
          </div>

          <!-- Priority Level -->
          <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-5">
            <h3 class="text-xs font-bold text-gray-400 tracking-widest uppercase mb-3">Priority Level</h3>
            <div class="flex items-center gap-3">
              <div class="w-10 h-10 rounded-xl bg-orange-50 flex items-center justify-center">
                <svg class="w-5 h-5 text-orange-500" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z" clip-rule="evenodd"/></svg>
              </div>
              <div>
                <p class="text-base font-bold text-orange-500">HIGH</p>
                <p class="text-xs text-gray-400">Requires immediate attention</p>
              </div>
            </div>
          </div>

        </div>
      </div>
    </div>
  </div>
</div>

<!-- Delete Confirmation Modal -->
<div id="deleteModal" class="hidden fixed inset-0 bg-black bg-opacity-40 flex items-center justify-center z-50">
  <div class="bg-white rounded-2xl p-8 shadow-xl max-w-sm w-full mx-4">
    <div class="w-12 h-12 rounded-full bg-red-50 flex items-center justify-center mx-auto mb-4">
      <svg class="w-6 h-6 text-red-500" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M9 2a1 1 0 00-.894.553L7.382 4H4a1 1 0 000 2v10a2 2 0 002 2h8a2 2 0 002-2V6a1 1 0 100-2h-3.382l-.724-1.447A1 1 0 0011 2H9zM7 8a1 1 0 012 0v6a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v6a1 1 0 102 0V8a1 1 0 00-1-1z" clip-rule="evenodd"/></svg>
    </div>
    <h3 class="text-lg font-bold text-gray-800 text-center mb-2">Delete Report</h3>
    <p class="text-sm text-gray-500 text-center mb-6">Are you sure you want to delete this report? This action cannot be undone.</p>
    <div class="flex gap-3">
      <button onclick="document.getElementById('deleteModal').classList.add('hidden')"
              class="flex-1 py-3 rounded-xl border border-gray-200 text-sm font-semibold text-gray-600 hover:bg-gray-50 transition-colors">
        Cancel
      </button>
      <form action="<%= request.getContextPath() %>/issue/delete" method="post" class="flex-1">
        <input type="hidden" name="issueId" value="<%= request.getAttribute("issueId") != null ? request.getAttribute("issueId") : "" %>"/>
        <button type="submit" class="w-full py-3 rounded-xl bg-red-500 hover:bg-red-600 text-white text-sm font-bold transition-colors">
          Delete
        </button>
      </form>
    </div>
  </div>
</div>
</body>
</html>
