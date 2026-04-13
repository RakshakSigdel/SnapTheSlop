<%--
  Municipality Issue Management - SnapTheSlop Smart Municipality
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setAttribute("activePage", "issue-reports"); %>
<jsp:include page="../common/header.jsp"/>

<body class="bg-gray-50" style="font-family:'Inter',sans-serif;">
<div class="flex min-h-screen">

  <!-- Sidebar -->
  <jsp:include page="../common/municipality-sidebar.jsp"/>

  <!-- Main Content -->
  <div class="flex-1 flex flex-col min-h-screen" style="margin-left:208px;">

    <!-- Top Nav Bar -->
    <div class="bg-white border-b border-gray-100 px-8 py-4 flex items-center justify-between sticky top-0 z-10">
      <h1 class="text-base font-bold text-gray-700 tracking-wide">Issue Management Reports</h1>
      <div class="flex items-center gap-4">
        <button class="text-gray-400 hover:text-gray-600 relative">
          <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6 6 0 10-12 0v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"/>
          </svg>
        </button>
        <div class="flex items-center gap-2.5">
          <div class="text-right">
            <p class="text-xs font-semibold text-gray-700"><%= session.getAttribute("userName") != null ? session.getAttribute("userName") : "Admin Head" %></p>
            <p class="text-xs text-gray-400">WARD 04 • CENTRAL</p>
          </div>
          <div class="w-9 h-9 rounded-full bg-blue-600 flex items-center justify-center text-white text-sm font-bold">
            <%= session.getAttribute("userInitials") != null ? session.getAttribute("userInitials") : "AH" %>
          </div>
        </div>
      </div>
    </div>

    <!-- Page Body -->
    <div class="flex-1 p-8">

      <!-- Filter Section -->
      <div class="bg-white rounded-xl shadow-sm border border-gray-100 p-6 mb-6">
        <div class="grid grid-cols-6 gap-4 items-end">
          <!-- Search -->
          <div>
            <label class="text-xs font-bold text-gray-500 tracking-widest uppercase mb-2 block">Search</label>
            <div class="relative">
              <svg class="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
              </svg>
              <input type="text" placeholder="ID or Keyword" class="w-full pl-10 pr-3 py-2 border border-gray-200 rounded-lg text-sm focus:outline-none focus:border-blue-500 focus:ring-1 focus:ring-blue-500"/>
            </div>
          </div>

          <!-- Status Dropdown -->
          <div>
            <label class="text-xs font-bold text-gray-500 tracking-widest uppercase mb-2 block">Status</label>
            <select class="w-full px-3 py-2 border border-gray-200 rounded-lg text-sm bg-white focus:outline-none focus:border-blue-500 focus:ring-1 focus:ring-blue-500 appearance-none cursor-pointer" style="background-image: url('data:image/svg+xml;utf8,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 24 24%22 fill=%22none%22 stroke=%22%239ca3af%22 stroke-width=%222%22><path d=%22M19 14l-7 7m0 0l-7-7m7 7V3%22/></svg>'); background-repeat: no-repeat; background-position: right 0.5rem center; background-size: 1.25em 1.25em; padding-right: 2.5rem;">
              <option value="">All Status</option>
              <option value="open">Open</option>
              <option value="in_progress">In Progress</option>
              <option value="resolved">Resolved</option>
              <option value="pending">Pending</option>
            </select>
          </div>

          <!-- Category Dropdown -->
          <div>
            <label class="text-xs font-bold text-gray-500 tracking-widest uppercase mb-2 block">Category</label>
            <select class="w-full px-3 py-2 border border-gray-200 rounded-lg text-sm bg-white focus:outline-none focus:border-blue-500 focus:ring-1 focus:ring-blue-500 appearance-none cursor-pointer" style="background-image: url('data:image/svg+xml;utf8,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 24 24%22 fill=%22none%22 stroke=%22%239ca3af%22 stroke-width=%222%22><path d=%22M19 14l-7 7m0 0l-7-7m7 7V3%22/></svg>'); background-repeat: no-repeat; background-position: right 0.5rem center; background-size: 1.25em 1.25em; padding-right: 2.5rem;">
              <option value="">All Categories</option>
              <option value="water_supply">Water Supply</option>
              <option value="electricity">Electricity</option>
              <option value="sanitation">Sanitation</option>
              <option value="roadwork">Roadwork</option>
            </select>
          </div>

          <!-- Ward Dropdown -->
          <div>
            <label class="text-xs font-bold text-gray-500 tracking-widest uppercase mb-2 block">Ward</label>
            <select class="w-full px-3 py-2 border border-gray-200 rounded-lg text-sm bg-white focus:outline-none focus:border-blue-500 focus:ring-1 focus:ring-blue-500 appearance-none cursor-pointer" style="background-image: url('data:image/svg+xml;utf8,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 24 24%22 fill=%22none%22 stroke=%22%239ca3af%22 stroke-width=%222%22><path d=%22M19 14l-7 7m0 0l-7-7m7 7V3%22/></svg>'); background-repeat: no-repeat; background-position: right 0.5rem center; background-size: 1.25em 1.25em; padding-right: 2.5rem;">
              <option value="">All Wards</option>
              <option value="01">Ward 01</option>
              <option value="04">Ward 04</option>
              <option value="09">Ward 09</option>
              <option value="12">Ward 12</option>
            </select>
          </div>

          <!-- Priority Dropdown -->
          <div>
            <label class="text-xs font-bold text-gray-500 tracking-widest uppercase mb-2 block">Priority</label>
            <select class="w-full px-3 py-2 border border-gray-200 rounded-lg text-sm bg-white focus:outline-none focus:border-blue-500 focus:ring-1 focus:ring-blue-500 appearance-none cursor-pointer" style="background-image: url('data:image/svg+xml;utf8,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 24 24%22 fill=%22none%22 stroke=%22%239ca3af%22 stroke-width=%222%22><path d=%22M19 14l-7 7m0 0l-7-7m7 7V3%22/></svg>'); background-repeat: no-repeat; background-position: right 0.5rem center; background-size: 1.25em 1.25em; padding-right: 2.5rem;">
              <option value="">All Priorities</option>
              <option value="critical">Critical</option>
              <option value="high">High</option>
              <option value="medium">Medium</option>
              <option value="low">Low</option>
            </select>
          </div>

          <!-- Date Range -->
          <div>
            <label class="text-xs font-bold text-gray-500 tracking-widest uppercase mb-2 block">Date Range</label>
            <input type="date" class="w-full px-3 py-2 border border-gray-200 rounded-lg text-sm focus:outline-none focus:border-blue-500 focus:ring-1 focus:ring-blue-500"/>
          </div>
        </div>
      </div>

      <!-- Issues Table -->
      <div class="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden mb-6">
        <div class="overflow-x-auto">
          <table class="w-full">
            <thead>
              <tr class="border-b border-gray-100 bg-gray-50">
                <th class="text-left py-3 px-6 text-xs font-bold text-gray-500 tracking-widest uppercase">ID</th>
                <th class="text-left py-3 px-6 text-xs font-bold text-gray-500 tracking-widest uppercase">Issue Title</th>
                <th class="text-left py-3 px-6 text-xs font-bold text-gray-500 tracking-widest uppercase">Citizen</th>
                <th class="text-left py-3 px-6 text-xs font-bold text-gray-500 tracking-widest uppercase">Ward</th>
                <th class="text-left py-3 px-6 text-xs font-bold text-gray-500 tracking-widest uppercase">Status</th>
                <th class="text-left py-3 px-6 text-xs font-bold text-gray-500 tracking-widest uppercase">Priority</th>
                <th class="text-left py-3 px-6 text-xs font-bold text-gray-500 tracking-widest uppercase">Date</th>
                <th class="text-left py-3 px-6 text-xs font-bold text-gray-500 tracking-widest uppercase">Actions</th>
              </tr>
            </thead>
            <tbody>
              <!-- Row 1 -->
              <tr class="border-b border-gray-50 hover:bg-gray-50 transition-colors">
                <td class="py-4 px-6">
                  <span class="text-sm font-semibold text-gray-600">#NS-8921</span>
                </td>
                <td class="py-4 px-6">
                  <div class="text-sm font-semibold text-gray-800">Broken Water Main pipe</div>
                  <div class="text-xs text-gray-500">Water Supply & Distribution</div>
                </td>
                <td class="py-4 px-6">
                  <div class="text-sm font-semibold text-gray-800">Ramesh Sharma</div>
                </td>
                <td class="py-4 px-6">
                  <span class="px-3 py-1 rounded-lg bg-gray-100 text-sm font-semibold text-gray-700">Ward 12</span>
                </td>
                <td class="py-4 px-6">
                  <span class="px-3 py-1 rounded-lg text-sm font-bold tracking-widest uppercase bg-red-50 text-red-600">Open</span>
                </td>
                <td class="py-4 px-6">
                  <span class="px-3 py-1 rounded-lg text-sm font-bold tracking-widest uppercase bg-red-100 text-red-700">Critical</span>
                </td>
                <td class="py-4 px-6 text-sm text-gray-600">
                  12 Oct 2023
                </td>
                <td class="py-4 px-6">
                  <button class="text-gray-400 hover:text-gray-600">
                    <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                      <path d="M10.5 1.5H5.75A2.75 2.75 0 003 4.25v11A2.75 2.75 0 005.75 18h8.5A2.75 2.75 0 0017 15.25V8m-5-5v4a1.5 1.5 0 001.5 1.5h4m0-5.5l-5 5"/>
                    </svg>
                  </button>
                </td>
              </tr>

              <!-- Row 2 -->
              <tr class="border-b border-gray-50 hover:bg-gray-50 transition-colors">
                <td class="py-4 px-6">
                  <span class="text-sm font-semibold text-gray-600">#NS-8922</span>
                </td>
                <td class="py-4 px-6">
                  <div class="text-sm font-semibold text-gray-800">Garbage accumulation near Park</div>
                  <div class="text-xs text-gray-500">Sanitation & Waste</div>
                </td>
                <td class="py-4 px-6">
                  <div class="text-sm font-semibold text-gray-800">Anita Desai</div>
                </td>
                <td class="py-4 px-6">
                  <span class="px-3 py-1 rounded-lg bg-gray-100 text-sm font-semibold text-gray-700">Ward 04</span>
                </td>
                <td class="py-4 px-6">
                  <span class="px-3 py-1 rounded-lg text-sm font-bold tracking-widest uppercase bg-blue-50 text-blue-600">In Progress</span>
                </td>
                <td class="py-4 px-6">
                  <span class="px-3 py-1 rounded-lg text-sm font-bold tracking-widest uppercase bg-yellow-100 text-yellow-700">High</span>
                </td>
                <td class="py-4 px-6 text-sm text-gray-600">
                  11 Oct 2023
                </td>
                <td class="py-4 px-6">
                  <button class="text-gray-400 hover:text-gray-600">
                    <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                      <path d="M10.5 1.5H5.75A2.75 2.75 0 003 4.25v11A2.75 2.75 0 005.75 18h8.5A2.75 2.75 0 0017 15.25V8m-5-5v4a1.5 1.5 0 001.5 1.5h4m0-5.5l-5 5"/>
                    </svg>
                  </button>
                </td>
              </tr>

              <!-- Row 3 -->
              <tr class="border-b border-gray-50 hover:bg-gray-50 transition-colors">
                <td class="py-4 px-6">
                  <span class="text-sm font-semibold text-gray-600">#NS-8923</span>
                </td>
                <td class="py-4 px-6">
                  <div class="text-sm font-semibold text-gray-800">Streetlight outage in Main St</div>
                  <div class="text-xs text-gray-500">Public Lighting</div>
                </td>
                <td class="py-4 px-6">
                  <div class="text-sm font-semibold text-gray-800">Vikram Singh</div>
                </td>
                <td class="py-4 px-6">
                  <span class="px-3 py-1 rounded-lg bg-gray-100 text-sm font-semibold text-gray-700">Ward 01</span>
                </td>
                <td class="py-4 px-6">
                  <span class="px-3 py-1 rounded-lg text-sm font-bold tracking-widest uppercase bg-green-50 text-green-600">Resolved</span>
                </td>
                <td class="py-4 px-6">
                  <span class="px-3 py-1 rounded-lg text-sm font-bold tracking-widest uppercase bg-blue-100 text-blue-700">Low</span>
                </td>
                <td class="py-4 px-6 text-sm text-gray-600">
                  10 Oct 2023
                </td>
                <td class="py-4 px-6">
                  <button class="text-gray-400 hover:text-gray-600">
                    <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                      <path d="M10.5 1.5H5.75A2.75 2.75 0 003 4.25v11A2.75 2.75 0 005.75 18h8.5A2.75 2.75 0 0017 15.25V8m-5-5v4a1.5 1.5 0 001.5 1.5h4m0-5.5l-5 5"/>
                    </svg>
                  </button>
                </td>
              </tr>

              <!-- Row 4 -->
              <tr class="hover:bg-gray-50 transition-colors">
                <td class="py-4 px-6">
                  <span class="text-sm font-semibold text-gray-600">#NS-8924</span>
                </td>
                <td class="py-4 px-6">
                  <div class="text-sm font-semibold text-gray-800">Pothole near Central Mall</div>
                  <div class="text-xs text-gray-500">Road Infrastructure</div>
                </td>
                <td class="py-4 px-6">
                  <div class="text-sm font-semibold text-gray-800">Sunil Kumar</div>
                </td>
                <td class="py-4 px-6">
                  <span class="px-3 py-1 rounded-lg bg-gray-100 text-sm font-semibold text-gray-700">Ward 09</span>
                </td>
                <td class="py-4 px-6">
                  <span class="px-3 py-1 rounded-lg text-sm font-bold tracking-widest uppercase bg-red-50 text-red-600">Open</span>
                </td>
                <td class="py-4 px-6">
                  <span class="px-3 py-1 rounded-lg text-sm font-bold tracking-widest uppercase bg-blue-100 text-blue-700">Medium</span>
                </td>
                <td class="py-4 px-6 text-sm text-gray-600">
                  09 Oct 2023
                </td>
                <td class="py-4 px-6">
                  <button class="text-gray-400 hover:text-gray-600">
                    <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                      <path d="M10.5 1.5H5.75A2.75 2.75 0 003 4.25v11A2.75 2.75 0 005.75 18h8.5A2.75 2.75 0 0017 15.25V8m-5-5v4a1.5 1.5 0 001.5 1.5h4m0-5.5l-5 5"/>
                    </svg>
                  </button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>

        <!-- Pagination -->
        <div class="border-t border-gray-100 px-6 py-4 flex items-center justify-between bg-gray-50">
          <p class="text-xs font-semibold text-gray-500 tracking-widest uppercase">Showing 1-4 of 1,204 Reports</p>
          <div class="flex items-center gap-2">
            <button class="px-3 py-2 rounded-lg border border-gray-200 text-sm font-semibold text-gray-600 hover:bg-gray-100 transition-colors">
              <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z" clip-rule="evenodd"/>
              </svg>
            </button>
            <button class="px-3 py-2 rounded-lg bg-blue-600 text-sm font-bold text-white">1</button>
            <button class="px-3 py-2 rounded-lg border border-gray-200 text-sm font-semibold text-gray-600 hover:bg-gray-100 transition-colors">2</button>
            <button class="px-3 py-2 rounded-lg border border-gray-200 text-sm font-semibold text-gray-600 hover:bg-gray-100 transition-colors">3</button>
            <button class="px-3 py-2 rounded-lg border border-gray-200 text-sm font-semibold text-gray-600 hover:bg-gray-100 transition-colors">
              <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd"/>
              </svg>
            </button>
          </div>
        </div>
      </div>

      <!-- Stats Footer Section -->
      <div class="grid grid-cols-4 gap-6">
        <!-- Critical Priority -->
        <div class="bg-red-50 rounded-xl border border-red-100 p-6">
          <div class="flex items-center gap-3 mb-2">
            <div class="w-8 h-8 rounded-full bg-red-100 flex items-center justify-center">
              <svg class="w-5 h-5 text-red-600" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.21 3.03-1.742 3.03H4.42c-1.532 0-2.492-1.696-1.742-3.03l5.58-9.92zM10 13a1 1 0 110-2 1 1 0 010 2zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z" clip-rule="evenodd"/>
              </svg>
            </div>
            <span class="text-xs font-bold text-red-600 tracking-widest uppercase">Critical Priority</span>
          </div>
          <div class="text-3xl font-bold text-red-700">12 <span class="text-lg text-red-600">Active</span></div>
        </div>

        <!-- Avg Response -->
        <div class="bg-blue-50 rounded-xl border border-blue-100 p-6">
          <div class="flex items-center gap-3 mb-2">
            <div class="w-8 h-8 rounded-full bg-blue-100 flex items-center justify-center">
              <svg class="w-5 h-5 text-blue-600" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm1-12a1 1 0 10-2 0v4a1 1 0 00-.293.707l-.707.707a1 1 0 101.414 1.414L9 9.414V6z" clip-rule="evenodd"/>
              </svg>
            </div>
            <span class="text-xs font-bold text-blue-600 tracking-widest uppercase">Avg Response</span>
          </div>
          <div class="text-3xl font-bold text-blue-700">4.2 <span class="text-lg text-blue-600">Hours</span></div>
        </div>

        <!-- Resolution Rate -->
        <div class="bg-green-50 rounded-xl border border-green-100 p-6">
          <div class="flex items-center gap-3 mb-2">
            <div class="w-8 h-8 rounded-full bg-green-100 flex items-center justify-center">
              <svg class="w-5 h-5 text-green-600" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
              </svg>
            </div>
            <span class="text-xs font-bold text-green-600 tracking-widest uppercase">Resolution Rate</span>
          </div>
          <div class="text-3xl font-bold text-green-700">94.1%</div>
        </div>

        <!-- Export Report -->
        <div class="bg-blue-600 rounded-xl p-6 flex flex-col justify-center items-center text-center hover:bg-blue-700 transition-colors cursor-pointer">
          <span class="text-xs font-bold text-white tracking-widest uppercase mb-1">Export Report</span>
          <div class="text-2xl font-bold text-white mb-2">Generate PDF</div>
          <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M9 19l3 3m0 0l3-3m-3 3V10"/>
          </svg>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>
