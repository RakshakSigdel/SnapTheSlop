<%--
  Municipality Dashboard - SnapTheSlop Smart Municipality
  Design: NagarSewa UI (Google Stitch)
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setAttribute("activePage", "dashboard"); %>
<jsp:include page="../common/header.jsp"/>

<body class="bg-gray-50" style="font-family:'Inter',sans-serif;">
<div class="flex min-h-screen">

  <!-- Sidebar -->
  <jsp:include page="../common/municipality-sidebar.jsp"/>

  <!-- Main Content -->
  <div class="flex-1 flex flex-col min-h-screen" style="margin-left:208px;">

    <!-- Top Nav Bar -->
    <div class="bg-white border-b border-gray-100 px-8 py-4 flex items-center justify-between sticky top-0 z-10">
      <h1 class="text-base font-bold text-gray-700 tracking-wide">Municipal Overview</h1>
      <div class="flex items-center gap-4">
        <button class="text-gray-400 hover:text-gray-600 relative">
          <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6 6 0 10-12 0v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"/>
          </svg>
        </button>
        <div class="flex items-center gap-2.5">
          <div class="text-right">
            <p class="text-xs font-semibold text-gray-700"><%= session.getAttribute("userName") != null ? session.getAttribute("userName") : "Municipal Head" %></p>
            <p class="text-xs text-gray-400">ADMIN HEAD</p>
          </div>
          <div class="w-9 h-9 rounded-full bg-blue-600 flex items-center justify-center text-white text-sm font-bold">
            <%= session.getAttribute("userInitials") != null ? session.getAttribute("userInitials") : "MH" %>
          </div>
        </div>
      </div>
    </div>

    <!-- Page Body -->
    <div class="flex-1 p-8">

      <!-- Stat Cards (4 columns) -->
      <div class="grid grid-cols-4 gap-5 mb-8">

        <!-- Total Issues -->
        <div class="bg-white rounded-xl p-6 shadow-sm border border-gray-100">
          <div class="flex items-start justify-between mb-4">
            <div class="w-10 h-10 rounded-lg bg-gray-100 flex items-center justify-center">
              <svg class="w-5 h-5 text-gray-600" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" d="M4 4a2 2 0 012-2h4.586A2 2 0 0112 2.586L15.414 6A2 2 0 0116 7.414V16a2 2 0 01-2 2H6a2 2 0 01-2-2V4zm2 6a1 1 0 011-1h6a1 1 0 110 2H7a1 1 0 01-1-1zm1 3a1 1 0 100 2h6a1 1 0 100-2H7z" clip-rule="evenodd"/>
              </svg>
            </div>
            <span class="text-xs font-bold text-gray-400 tracking-widest uppercase">Total</span>
          </div>
          <div class="text-3xl font-bold text-gray-800 mb-1">1,429</div>
          <div class="text-xs text-green-600 font-semibold">+12% from last month</div>
        </div>

        <!-- Pending Issues -->
        <div class="bg-white rounded-xl p-6 shadow-sm border border-gray-100">
          <div class="flex items-start justify-between mb-4">
            <div class="w-10 h-10 rounded-lg bg-red-50 flex items-center justify-center">
              <svg class="w-5 h-5 text-red-500" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.21 3.03-1.742 3.03H4.42c-1.532 0-2.492-1.696-1.742-3.03l5.58-9.92zM10 13a1 1 0 110-2 1 1 0 010 2zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z" clip-rule="evenodd"/>
              </svg>
            </div>
            <span class="text-xs font-bold text-gray-400 tracking-widest uppercase">Pending</span>
          </div>
          <div class="text-3xl font-bold text-red-600 mb-1">284</div>
          <div class="text-xs text-red-500 font-semibold">+5% attention required</div>
        </div>

        <!-- Ongoing Issues -->
        <div class="bg-white rounded-xl p-6 shadow-sm border border-gray-100">
          <div class="flex items-start justify-between mb-4">
            <div class="w-10 h-10 rounded-lg bg-blue-50 flex items-center justify-center">
              <svg class="w-5 h-5 text-blue-600" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" d="M4 4a2 2 0 00-2 2v4a2 2 0 002 2V6h10a2 2 0 00-2-2H4zm2 6a2 2 0 012-2h8a2 2 0 012 2v4a2 2 0 01-2 2H8a2 2 0 01-2-2v-4zm6 4a2 2 0 100-4 2 2 0 000 4z" clip-rule="evenodd"/>
              </svg>
            </div>
            <span class="text-xs font-bold text-gray-400 tracking-widest uppercase">Ongoing</span>
          </div>
          <div class="text-3xl font-bold text-blue-600 mb-1">512</div>
          <div class="text-xs text-gray-600 font-semibold">On track with current pipeline</div>
        </div>

        <!-- Resolved Issues -->
        <div class="bg-white rounded-xl p-6 shadow-sm border border-gray-100">
          <div class="flex items-start justify-between mb-4">
            <div class="w-10 h-10 rounded-lg bg-green-50 flex items-center justify-center">
              <svg class="w-5 h-5 text-green-600" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
              </svg>
            </div>
            <span class="text-xs font-bold text-gray-400 tracking-widest uppercase">Resolved</span>
          </div>
          <div class="text-3xl font-bold text-green-600 mb-1">633</div>
          <div class="text-xs text-green-600 font-semibold">80% efficiency rate</div>
        </div>
      </div>

      <!-- Bottom Grid: Issues by Ward + Recent Reports -->
      <div class="grid grid-cols-2 gap-6">

        <!-- Issues by Ward Chart -->
        <div class="bg-white rounded-xl shadow-sm border border-gray-100 p-6">
          <div class="flex items-center justify-between mb-6">
            <h3 class="text-base font-bold text-gray-800">Issues by Ward</h3>
            <span class="text-xs font-bold text-gray-500 tracking-widest uppercase">May 2024</span>
          </div>

          <div class="space-y-4">
            <!-- Ward 04 -->
            <div>
              <div class="flex items-center justify-between mb-2">
                <p class="text-sm font-semibold text-gray-700">Ward 04 - Civil Lines</p>
                <span class="text-sm font-bold text-gray-600">420</span>
              </div>
              <div class="w-full bg-gray-100 rounded-full h-2">
                <div class="bg-blue-600 h-2 rounded-full" style="width: 85%"></div>
              </div>
            </div>

            <!-- Ward 09 -->
            <div>
              <div class="flex items-center justify-between mb-2">
                <p class="text-sm font-semibold text-gray-700">Ward 09 - Model Town</p>
                <span class="text-sm font-bold text-gray-600">312</span>
              </div>
              <div class="w-full bg-gray-100 rounded-full h-2">
                <div class="bg-blue-600 h-2 rounded-full" style="width: 63%"></div>
              </div>
            </div>

            <!-- Ward 02 -->
            <div>
              <div class="flex items-center justify-between mb-2">
                <p class="text-sm font-semibold text-gray-700">Ward 02 - Rajpath</p>
                <span class="text-sm font-bold text-gray-600">288</span>
              </div>
              <div class="w-full bg-gray-100 rounded-full h-2">
                <div class="bg-blue-600 h-2 rounded-full" style="width: 58%"></div>
              </div>
            </div>

            <!-- Ward 15 -->
            <div>
              <div class="flex items-center justify-between mb-2">
                <p class="text-sm font-semibold text-gray-700">Ward 15 - Industrial Area</p>
                <span class="text-sm font-bold text-gray-600">194</span>
              </div>
              <div class="w-full bg-gray-100 rounded-full h-2">
                <div class="bg-blue-600 h-2 rounded-full" style="width: 39%"></div>
              </div>
            </div>

            <!-- Ward 07 -->
            <div>
              <div class="flex items-center justify-between mb-2">
                <p class="text-sm font-semibold text-gray-700">Ward 07 - Suburbia</p>
                <span class="text-sm font-bold text-gray-600">115</span>
              </div>
              <div class="w-full bg-gray-100 rounded-full h-2">
                <div class="bg-blue-600 h-2 rounded-full" style="width: 23%"></div>
              </div>
            </div>
          </div>

          <button class="w-full mt-6 py-3 text-blue-600 font-bold text-sm uppercase tracking-widest hover:bg-blue-50 rounded-lg transition-colors">
            Download Report
          </button>
        </div>

        <!-- Recent Reports Table -->
        <div class="bg-white rounded-xl shadow-sm border border-gray-100 p-6">
          <div class="flex items-center justify-between mb-6">
            <h3 class="text-base font-bold text-gray-800">Recent Reports</h3>
            <div class="flex items-center gap-2">
              <button class="p-2 text-gray-400 hover:bg-gray-50 rounded-lg">
                <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                  <path d="M3 3a1 1 0 000 2h11a1 1 0 100-2H3zM3 7a1 1 0 000 2h5a1 1 0 000-2H3zM3 11a1 1 0 100 2h4a1 1 0 100-2H3zM13 16a1 1 0 102 0v-5.586l1.293 1.293a1 1 0 001.414-1.414l-3-3a1 1 0 00-1.414 0l-3 3a1 1 0 101.414 1.414L13 10.414V16z"/>
                </svg>
              </button>
              <button class="p-2 text-gray-400 hover:bg-gray-50 rounded-lg">
                <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                  <path d="M6 10a2 2 0 11-4 0 2 2 0 014 0zM12 10a2 2 0 11-4 0 2 2 0 014 0zM16 12a2 2 0 100-4 2 2 0 000 4z"/>
                </svg>
              </button>
            </div>
          </div>

          <div class="space-y-3">
            <!-- Report Row 1 -->
            <div class="flex items-center justify-between py-3 border-b border-gray-50 hover:bg-gray-50 px-2 rounded transition-colors cursor-pointer">
              <div class="flex-1">
                <p class="text-sm font-semibold text-gray-800">Broken Pipeline Sector 4</p>
                <p class="text-xs text-gray-500">ID: #NW-29402</p>
              </div>
              <div class="flex items-center gap-2">
                <span class="px-2 py-1 rounded text-xs font-semibold bg-blue-50 text-blue-600">Water Supply</span>
                <span class="px-2 py-1 rounded text-xs font-semibold bg-red-50 text-red-600">PENDING</span>
                <span class="px-2 py-1 rounded text-xs font-semibold bg-red-100 text-red-700">CRITICAL</span>
                <span class="text-xs text-gray-500">Today, 09:12 AM</span>
              </div>
            </div>

            <!-- Report Row 2 -->
            <div class="flex items-center justify-between py-3 border-b border-gray-50 hover:bg-gray-50 px-2 rounded transition-colors cursor-pointer">
              <div class="flex-1">
                <p class="text-sm font-semibold text-gray-800">Street Light Outage - Main Rd</p>
                <p class="text-xs text-gray-500">ID: #NW-29391</p>
              </div>
              <div class="flex items-center gap-2">
                <span class="px-2 py-1 rounded text-xs font-semibold bg-yellow-50 text-yellow-700">Electricity</span>
                <span class="px-2 py-1 rounded text-xs font-semibold bg-blue-50 text-blue-600">ONGOING</span>
                <span class="px-2 py-1 rounded text-xs font-semibold bg-orange-100 text-orange-700">HIGH</span>
                <span class="text-xs text-gray-500">Yesterday</span>
              </div>
            </div>

            <!-- Report Row 3 -->
            <div class="flex items-center justify-between py-3 border-b border-gray-50 hover:bg-gray-50 px-2 rounded transition-colors cursor-pointer">
              <div class="flex-1">
                <p class="text-sm font-semibold text-gray-800">Garbage Accumulation - Park</p>
                <p class="text-xs text-gray-500">ID: #NW-29385</p>
              </div>
              <div class="flex items-center gap-2">
                <span class="px-2 py-1 rounded text-xs font-semibold bg-green-50 text-green-700">Sanitation</span>
                <span class="px-2 py-1 rounded text-xs font-semibold bg-green-50 text-green-600">RESOLVED</span>
                <span class="px-2 py-1 rounded text-xs font-semibold bg-blue-100 text-blue-700">MEDIUM</span>
                <span class="text-xs text-gray-500">14 May 2024</span>
              </div>
            </div>

            <!-- Report Row 4 -->
            <div class="flex items-center justify-between py-3 hover:bg-gray-50 px-2 rounded transition-colors cursor-pointer">
              <div class="flex-1">
                <p class="text-sm font-semibold text-gray-800">Pothole Filling - Avenue 7</p>
                <p class="text-xs text-gray-500">ID: #NW-29377</p>
              </div>
              <div class="flex items-center gap-2">
                <span class="px-2 py-1 rounded text-xs font-semibold bg-purple-50 text-purple-700">Roadwork</span>
                <span class="px-2 py-1 rounded text-xs font-semibold bg-blue-50 text-blue-600">ONGOING</span>
                <span class="px-2 py-1 rounded text-xs font-semibold bg-blue-100 text-blue-700">MEDIUM</span>
                <span class="text-xs text-gray-500">12 May 2024</span>
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
