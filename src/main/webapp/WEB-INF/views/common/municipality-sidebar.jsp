<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% String activePage = (String) request.getAttribute("activePage"); %>

<script src="https://cdn.tailwindcss.com"></script>

<!-- Municipality Sidebar -->
<div class="fixed top-0 left-0 h-screen bg-white border-r border-gray-200 flex flex-col z-50" style="width: 208px;">

    <!-- Logo Section -->
    <div class="px-5 py-4 border-b border-gray-100 flex-shrink-0">
        <div class="text-lg font-extrabold text-blue-700 tracking-tight">NagarSewa</div>
        <div class="font-bold text-gray-400 uppercase" style="font-size:9px; letter-spacing:2px; margin-top:2px;">Municipal Portal</div>
    </div>

    <!-- Navigation Section -->
    <nav class="px-3 py-4 space-y-1 flex-shrink-0 overflow-y-auto">

        <!-- Dashboard -->
        <a href="<%= request.getContextPath() %>/municipality/dashboard"
           class="flex items-center gap-3 px-3 py-2.5 text-xs font-bold uppercase tracking-wider rounded-lg transition-colors
                  <%= "dashboard".equals(activePage) ? "bg-blue-50 text-blue-700" : "text-gray-600 hover:bg-gray-50 hover:text-gray-900" %>">
            <svg class="w-4 h-4 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
                <path d="M5 3a2 2 0 00-2 2v2a2 2 0 002 2h2a2 2 0 002-2V5a2 2 0 00-2-2H5zM5 11a2 2 0 00-2 2v2a2 2 0 002 2h2a2 2 0 002-2v-2a2 2 0 00-2-2H5zM11 5a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V5zM11 13a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z"/>
            </svg>
            Dashboard
        </a>

        <!-- Issue Reports -->
        <a href="<%= request.getContextPath() %>/municipality/issue-list"
           class="flex items-center gap-3 px-3 py-2.5 text-xs font-bold uppercase tracking-wider rounded-lg transition-colors
                  <%= "issue-reports".equals(activePage) ? "bg-blue-50 text-blue-700" : "text-gray-600 hover:bg-gray-50 hover:text-gray-900" %>">
            <svg class="w-4 h-4 flex-shrink-0" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"/>
            </svg>
            Issue Reports
        </a>

        <!-- Public Works -->
        <a href="#"
           class="flex items-center gap-3 px-3 py-2.5 text-xs font-bold uppercase tracking-wider rounded-lg transition-colors
                  <%= "public-works".equals(activePage) ? "bg-blue-50 text-blue-700" : "text-gray-600 hover:bg-gray-50 hover:text-gray-900" %>">
            <svg class="w-4 h-4 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
                <path d="M13 6a3 3 0 11-6 0 3 3 0 016 0zM18 8a2 2 0 11-4 0 2 2 0 014 0zM14 15a4 4 0 00-8 0v3h8v-3zM6 8a2 2 0 11-4 0 2 2 0 014 0zM16 18v-3a5.972 5.972 0 00-.75-2.906A3.005 3.005 0 0119 15v3h-3zM4.75 12.094A5.973 5.973 0 004 15v3H1v-3a3 3 0 013.75-2.906z"/>
            </svg>
            Public Works
        </a>

        <!-- Notifications -->
        <a href="#"
           class="flex items-center gap-3 px-3 py-2.5 text-xs font-bold uppercase tracking-wider rounded-lg transition-colors
                  <%= "notifications".equals(activePage) ? "bg-blue-50 text-blue-700" : "text-gray-600 hover:bg-gray-50 hover:text-gray-900" %>">
            <svg class="w-4 h-4 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
                <path d="M10 2a6 6 0 00-6 6v3.586l-.707.707A1 1 0 004 14h12a1 1 0 00.707-1.707L16 11.586V8a6 6 0 00-6-6zM10 18a3 3 0 01-3-3h6a3 3 0 01-3 3z"/>
            </svg>
            Notifications
        </a>

        <!-- Settings -->
        <a href="#"
           class="flex items-center gap-3 px-3 py-2.5 text-xs font-bold uppercase tracking-wider rounded-lg transition-colors
                  <%= "settings".equals(activePage) ? "bg-blue-50 text-blue-700" : "text-gray-600 hover:bg-gray-50 hover:text-gray-900" %>">
            <svg class="w-4 h-4 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" d="M11.49 3.17c-.38-1.56-2.6-1.56-2.98 0a1.532 1.532 0 01-2.286.948c-1.372-.836-2.942.734-2.106 2.106.54.886.061 2.042-.947 2.287-1.561.379-1.561 2.6 0 2.978a1.532 1.532 0 01.947 2.287c-.836 1.372.734 2.942 2.106 2.106a1.532 1.532 0 012.287.947c.379 1.561 2.6 1.561 2.978 0a1.533 1.533 0 012.287-.947c1.372.836 2.942-.734 2.106-2.106a1.533 1.533 0 01.947-2.287c1.561-.379 1.561-2.6 0-2.978a1.532 1.532 0 01-.947-2.287c.836-1.372-.734-2.942-2.106-2.106a1.532 1.532 0 01-2.287-.947zM10 13a3 3 0 100-6 3 3 0 000 6z" clip-rule="evenodd"/>
            </svg>
            Settings
        </a>
    </nav>

    <!-- Bottom Section: Support + Logout -->
    <div class="px-3 pb-4 mt-auto space-y-1 flex-shrink-0 border-t border-gray-100 pt-3">

        <!-- Support -->
        <a href="#" class="flex items-center gap-3 px-3 py-2.5 text-xs font-bold uppercase tracking-wider rounded-lg text-gray-600 hover:bg-gray-50 hover:text-gray-900 transition-colors">
            <svg class="w-4 h-4 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-8-3a1 1 0 00-.867.5 1 1 0 11-1.731-1A3 3 0 0113 8a3.001 3.001 0 01-2 2.83V11a1 1 0 11-2 0v-1a1 1 0 011-1 1 1 0 100-2zm0 8a1 1 0 100-2 1 1 0 000 2z" clip-rule="evenodd"/>
            </svg>
            Support
        </a>

        <!-- Logout -->
        <a href="<%= request.getContextPath() %>/user/logout"
           class="flex items-center gap-3 px-3 py-2.5 text-xs font-bold uppercase tracking-wider rounded-lg text-red-500 hover:bg-red-50 transition-colors">
            <svg class="w-4 h-4 flex-shrink-0" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"/>
            </svg>
            Logout
        </a>

    </div>

</div>
