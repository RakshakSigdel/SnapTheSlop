<%--
  Citizen Dashboard - SnapTheSlop Smart Municipality
  Design: NagarSewa UI (Google Stitch)
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setAttribute("activePage", "dashboard"); %>
<jsp:include page="../common/header.jsp"/>

<body class="bg-gray-50" style="font-family:'Inter',sans-serif;">
<div class="flex min-h-screen">

  <!-- Sidebar -->
  <jsp:include page="../common/citizen-sidebar.jsp"/>

  <!-- Main Content -->
  <div class="flex-1 flex flex-col min-h-screen" style="margin-left:200px;">

    <!-- Top Nav Bar -->
    <div class="bg-white border-b border-gray-100 px-8 py-4 flex items-center justify-between sticky top-0 z-10">
      <h1 class="text-sm font-bold text-gray-400 tracking-widest uppercase">Citizen Portal</h1>
      <div class="flex items-center gap-4">
        <button class="text-gray-400 hover:text-gray-600 relative">
          <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6 6 0 10-12 0v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"/>
          </svg>
        </button>
        <div class="flex items-center gap-2.5">
          <div class="text-right">
            <p class="text-xs font-semibold text-gray-700"><%= session.getAttribute("userName") != null ? session.getAttribute("userName") : "Arjun Sharma" %></p>
            <p class="text-xs text-gray-400">WARD 04 &bull; CENTRAL</p>
          </div>
          <div class="w-9 h-9 rounded-full bg-blue-600 flex items-center justify-center text-white text-sm font-bold">
            <%= session.getAttribute("userInitials") != null ? session.getAttribute("userInitials") : "AS" %>
          </div>
        </div>
      </div>
    </div>

    <!-- Page Body -->
    <div class="flex-1 p-8">

      <!-- Welcome Banner -->
      <div class="rounded-2xl mb-8 overflow-hidden" style="background: linear-gradient(135deg, #1d4ed8 0%, #1e3a8a 60%, #172554 100%); min-height: 140px; position: relative;">
        <div class="px-8 py-8 relative z-10">
          <h2 class="text-2xl font-bold text-white mb-1">Hello, <%= session.getAttribute("userName") != null ? session.getAttribute("userName") : "Arjun Sharma" %></h2>
          <p class="text-blue-200 text-sm mb-5">Welcome back to your civic dashboard. Your active participation in Ward 04<br>helps us build a more responsive municipality.</p>
          <div class="flex items-center gap-3 flex-wrap">
            <span class="flex items-center gap-1.5 px-3 py-1.5 rounded-full text-xs font-semibold text-white" style="background: rgba(255,255,255,0.15);">
              <span class="w-1.5 h-1.5 rounded-full bg-green-400 inline-block"></span>
              STATUS: ACTIVE RESIDENT
            </span>
            <span class="flex items-center gap-1.5 px-3 py-1.5 rounded-full text-xs font-semibold text-white" style="background: rgba(255,255,255,0.15);">
              <svg class="w-3 h-3" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M5.05 4.05a7 7 0 119.9 9.9L10 18.9l-4.95-4.95a7 7 0 010-9.9zM10 11a2 2 0 100-4 2 2 0 000 4z" clip-rule="evenodd"/></svg>
              WARD 04, CENTRAL ZONE
            </span>
          </div>
        </div>
        <!-- Decorative circles -->
        <div style="position:absolute; right:-40px; top:-40px; width:220px; height:220px; border-radius:50%; background:rgba(255,255,255,0.04);"></div>
        <div style="position:absolute; right:60px; bottom:-60px; width:180px; height:180px; border-radius:50%; background:rgba(255,255,255,0.04);"></div>
      </div>

      <!-- Stat Cards -->
      <div class="grid grid-cols-3 gap-6 mb-8">

        <!-- Total Reports -->
        <div class="bg-white rounded-2xl p-6 shadow-sm border border-gray-100">
          <div class="flex items-start justify-between mb-4">
            <div class="w-10 h-10 rounded-xl bg-blue-50 flex items-center justify-center">
              <svg class="w-5 h-5 text-blue-600" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" d="M4 4a2 2 0 012-2h4.586A2 2 0 0112 2.586L15.414 6A2 2 0 0116 7.414V16a2 2 0 01-2 2H6a2 2 0 01-2-2V4zm2 6a1 1 0 011-1h6a1 1 0 110 2H7a1 1 0 01-1-1zm1 3a1 1 0 100 2h6a1 1 0 100-2H7z" clip-rule="evenodd"/>
              </svg>
            </div>
            <span class="text-xs font-bold text-gray-300 tracking-widest uppercase">Total</span>
          </div>
          <div class="text-4xl font-bold text-gray-800 mb-1">12</div>
          <div class="text-sm text-gray-500">My Reports Submitted</div>
        </div>

        <!-- Processing -->
        <div class="bg-white rounded-2xl p-6 shadow-sm border border-gray-100">
          <div class="flex items-start justify-between mb-4">
            <div class="w-10 h-10 rounded-xl bg-red-50 flex items-center justify-center">
              <svg class="w-5 h-5 text-red-500" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm1-12a1 1 0 10-2 0v4a1 1 0 00.293.707l2.828 2.829a1 1 0 101.415-1.415L11 9.586V6z" clip-rule="evenodd"/>
              </svg>
            </div>
            <span class="text-xs font-bold text-gray-300 tracking-widest uppercase">Processing</span>
          </div>
          <div class="text-4xl font-bold text-gray-800 mb-1">04</div>
          <div class="text-sm text-gray-500">Pending Resolution</div>
        </div>

        <!-- Fixed -->
        <div class="bg-white rounded-2xl p-6 shadow-sm border border-gray-100">
          <div class="flex items-start justify-between mb-4">
            <div class="w-10 h-10 rounded-xl bg-green-50 flex items-center justify-center">
              <svg class="w-5 h-5 text-green-500" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
              </svg>
            </div>
            <span class="text-xs font-bold text-gray-300 tracking-widest uppercase">Fixed</span>
          </div>
          <div class="text-4xl font-bold text-gray-800 mb-1">08</div>
          <div class="text-sm text-gray-500">Issues Resolved</div>
        </div>
      </div>

      <!-- Bottom Grid: Recent Reports + Right Panel -->
      <div class="grid grid-cols-3 gap-6">

        <!-- Recent Reports (2/3 width) -->
        <div class="col-span-2 bg-white rounded-2xl shadow-sm border border-gray-100 p-6">
          <div class="flex items-center justify-between mb-1">
            <h3 class="text-base font-bold text-gray-800">Recent Reports</h3>
            <a href="<%= request.getContextPath() %>/citizen/my-issues" class="text-xs font-bold text-blue-600 hover:text-blue-700 tracking-widest uppercase">View All</a>
          </div>
          <p class="text-xs text-gray-400 mb-5">Latest updates from your submitted issues</p>

          <div class="space-y-1">
            <!-- Row 1 -->
            <div class="flex items-center gap-4 py-3 border-b border-gray-50 hover:bg-gray-50 rounded-xl px-2 transition-colors cursor-pointer">
              <div class="w-12 h-10 rounded-lg bg-yellow-100 flex items-center justify-center flex-shrink-0">
                <svg class="w-6 h-6 text-yellow-500" fill="currentColor" viewBox="0 0 20 20"><path d="M11 3a1 1 0 10-2 0v1a1 1 0 102 0V3zM15.657 5.757a1 1 0 00-1.414-1.414l-.707.707a1 1 0 001.414 1.414l.707-.707zM18 10a1 1 0 01-1 1h-1a1 1 0 110-2h1a1 1 0 011 1zM5.05 6.464A1 1 0 106.464 5.05l-.707-.707a1 1 0 00-1.414 1.414l.707.707zM5 10a1 1 0 01-1 1H3a1 1 0 110-2h1a1 1 0 011 1zM8 16v-1h4v1a2 2 0 11-4 0zM12 14c.015-.298.059-.591.138-.876a7 7 0 10-4.277 0c.08.285.123.578.138.876H12z"/></svg>
              </div>
              <div class="flex-1 min-w-0">
                <p class="text-sm font-semibold text-gray-800 truncate">Street Light Outage - Sector 4</p>
                <p class="text-xs text-gray-400 mt-0.5">Oct 12, 2023 &bull; Report ID: #NS-8821</p>
              </div>
              <span class="px-2.5 py-1 rounded-full text-xs font-bold tracking-wide bg-red-50 text-red-500 uppercase flex-shrink-0">Pending</span>
            </div>

            <!-- Row 2 -->
            <div class="flex items-center gap-4 py-3 border-b border-gray-50 hover:bg-gray-50 rounded-xl px-2 transition-colors cursor-pointer">
              <div class="w-12 h-10 rounded-lg bg-gray-200 overflow-hidden flex-shrink-0">
                <div class="w-full h-full bg-gradient-to-br from-gray-300 to-gray-400 flex items-center justify-center">
                  <svg class="w-5 h-5 text-gray-500" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M4 3a2 2 0 00-2 2v10a2 2 0 002 2h12a2 2 0 002-2V5a2 2 0 00-2-2H4zm12 12H4l4-8 3 6 2-4 3 6z" clip-rule="evenodd"/></svg>
                </div>
              </div>
              <div class="flex-1 min-w-0">
                <p class="text-sm font-semibold text-gray-800 truncate">Major Pothole on Lakeview Ave</p>
                <p class="text-xs text-gray-400 mt-0.5">Oct 10, 2023 &bull; Report ID: #NS-8815</p>
              </div>
              <span class="px-2.5 py-1 rounded-full text-xs font-bold tracking-wide bg-blue-50 text-blue-600 uppercase flex-shrink-0">Work Started</span>
            </div>

            <!-- Row 3 -->
            <div class="flex items-center gap-4 py-3 border-b border-gray-50 hover:bg-gray-50 rounded-xl px-2 transition-colors cursor-pointer">
              <div class="w-12 h-10 rounded-lg bg-green-100 flex items-center justify-center flex-shrink-0">
                <svg class="w-6 h-6 text-green-500" fill="currentColor" viewBox="0 0 20 20"><path d="M9 6a3 3 0 11-6 0 3 3 0 016 0zM17 6a3 3 0 11-6 0 3 3 0 016 0zM12.93 17c.046-.327.07-.66.07-1a6.97 6.97 0 00-1.5-4.33A5 5 0 0119 16v1h-6.07zM6 11a5 5 0 015 5v1H1v-1a5 5 0 015-5z"/></svg>
              </div>
              <div class="flex-1 min-w-0">
                <p class="text-sm font-semibold text-gray-800 truncate">Garbage Collection Request</p>
                <p class="text-xs text-gray-400 mt-0.5">Oct 08, 2023 &bull; Report ID: #NS-8790</p>
              </div>
              <span class="px-2.5 py-1 rounded-full text-xs font-bold tracking-wide bg-green-50 text-green-600 uppercase flex-shrink-0">Resolved</span>
            </div>

            <!-- Row 4 -->
            <div class="flex items-center gap-4 py-3 border-b border-gray-50 hover:bg-gray-50 rounded-xl px-2 transition-colors cursor-pointer">
              <div class="w-12 h-10 rounded-lg bg-blue-100 flex items-center justify-center flex-shrink-0">
                <svg class="w-6 h-6 text-blue-500" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M5.05 4.05a7 7 0 119.9 9.9L10 18.9l-4.95-4.95a7 7 0 010-9.9zM10 11a2 2 0 100-4 2 2 0 000 4z" clip-rule="evenodd"/></svg>
              </div>
              <div class="flex-1 min-w-0">
                <p class="text-sm font-semibold text-gray-800 truncate">Broken Pipeline Near Park</p>
                <p class="text-xs text-gray-400 mt-0.5">Oct 05, 2023 &bull; Report ID: #NS-8752</p>
              </div>
              <span class="px-2.5 py-1 rounded-full text-xs font-bold tracking-wide bg-green-50 text-green-600 uppercase flex-shrink-0">Resolved</span>
            </div>

            <!-- Row 5 -->
            <div class="flex items-center gap-4 py-3 hover:bg-gray-50 rounded-xl px-2 transition-colors cursor-pointer">
              <div class="w-12 h-10 rounded-lg bg-gray-100 flex items-center justify-center flex-shrink-0">
                <svg class="w-6 h-6 text-gray-400" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M4 4a2 2 0 012-2h4.586A2 2 0 0112 2.586L15.414 6A2 2 0 0116 7.414V16a2 2 0 01-2 2H6a2 2 0 01-2-2V4z" clip-rule="evenodd"/></svg>
              </div>
              <div class="flex-1 min-w-0">
                <p class="text-sm font-semibold text-gray-800 truncate">Illegal Signage Removal</p>
                <p class="text-xs text-gray-400 mt-0.5">Sep 28, 2023 &bull; Report ID: #NS-8610</p>
              </div>
              <span class="px-2.5 py-1 rounded-full text-xs font-bold tracking-wide bg-green-50 text-green-600 uppercase flex-shrink-0">Resolved</span>
            </div>
          </div>
        </div>

        <!-- Right Panel (1/3 width) -->
        <div class="space-y-5">

          <!-- Report an Issue Card -->
          <div class="bg-blue-50 rounded-2xl p-6 border border-blue-100">
            <h3 class="text-base font-bold text-blue-800 mb-2">Report an Issue</h3>
            <p class="text-sm text-blue-600 mb-5">See something that needs attention in your neighborhood?</p>
            <a href="<%= request.getContextPath() %>/citizen/report-issue"
               class="block w-full bg-blue-700 hover:bg-blue-800 text-white text-xs font-bold tracking-widest uppercase text-center py-3 rounded-xl transition-colors">
              Create New Report
            </a>
          </div>

          <!-- Ward 04 Service Map -->
          <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
            <div class="px-5 pt-5 pb-3">
              <h3 class="text-sm font-bold text-gray-700">Ward 04 Service Map</h3>
            </div>
            <div class="relative" style="height: 180px; background: linear-gradient(135deg, #0f172a 0%, #1e293b 50%, #0f172a 100%);">
              <!-- Simulated dark satellite map -->
              <div class="absolute inset-0 opacity-20" style="background-image: radial-gradient(circle at 30% 40%, rgba(255,255,255,0.1) 1px, transparent 1px), radial-gradient(circle at 70% 60%, rgba(255,255,255,0.1) 1px, transparent 1px), radial-gradient(circle at 50% 20%, rgba(255,255,255,0.15) 1px, transparent 1px); background-size: 20px 20px, 15px 15px, 25px 25px;"></div>
              <div class="absolute inset-0 flex items-center justify-center">
                <div class="grid grid-cols-5 gap-1 opacity-30">
                  <% for(int i=0; i<25; i++) { %>
                  <div style="width:8px; height:4px; background: rgba(255,255,255,0.5); border-radius:1px;"></div>
                  <% } %>
                </div>
              </div>
              <!-- Live badge -->
              <div class="absolute bottom-3 left-1/2 -translate-x-1/2">
                <span class="flex items-center gap-1.5 px-3 py-1.5 rounded-full text-xs font-bold text-white" style="background: rgba(0,0,0,0.6); backdrop-filter: blur(4px);">
                  <span class="w-1.5 h-1.5 rounded-full bg-green-400 inline-block animate-pulse"></span>
                  LIVE UPDATES ACTIVE
                </span>
              </div>
            </div>
          </div>

        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>
