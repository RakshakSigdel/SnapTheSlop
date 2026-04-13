<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>NagarSewa Sidebar</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600&family=Space+Mono:wght@700&display=swap" rel="stylesheet"/>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: {
                        sans: ['DM Sans', 'sans-serif'],
                        mono: ['Space Mono', 'monospace'],
                    },
                    colors: {
                        brand: '#1A56DB',
                        'brand-light': '#EBF2FF',
                    }
                }
            }
        }
    </script>
    <style>
        .sidebar { transition: width 0.28s cubic-bezier(.4,0,.2,1); width: 220px; }
        .sidebar.collapsed { width: 64px; }
        .fade { transition: opacity 0.2s ease; }
        .sidebar.collapsed .fade { opacity: 0; pointer-events: none; }
        .sidebar.collapsed .nav-item[data-tip]:hover::after {
            content: attr(data-tip);
            position: absolute;
            left: calc(100% + 12px);
            top: 50%;
            transform: translateY(-50%);
            background: #111827;
            color: #fff;
            font-size: 11px;
            padding: 5px 10px;
            border-radius: 6px;
            white-space: nowrap;
            z-index: 999;
        }
    </style>
</head>
<body class="m-0 p-0 h-screen">

<!--
    ╔══════════════════════════════════════════════════════╗
    ║   SIDEBAR ONLY — include this in your layout JSP     ║
    ║   Use: <%@ include file="sidebar.html" %>            ║
    ║   Or Thymeleaf: th:replace="~{sidebar :: sidebar}"  ║
    ╚══════════════════════════════════════════════════════╝
  -->

<aside id="sidebar"
       class="sidebar fixed top-0 left-0 h-screen flex flex-col bg-white border-r border-gray-100 z-50 overflow-hidden">

    <!-- Toggle button -->
    <button id="toggleBtn"
            class="absolute -right-3 top-5 z-50 w-6 h-6 rounded-full bg-white border border-gray-200 shadow-sm
             flex items-center justify-center hover:bg-gray-50 transition-colors"
            aria-label="Toggle sidebar">
        <svg id="toggleIcon" class="w-3 h-3 text-gray-400 transition-transform duration-300"
             viewBox="0 0 10 10" fill="none" stroke="currentColor"
             stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
            <polyline points="6.5,2 3.5,5 6.5,8"/>
        </svg>
    </button>

    <!-- Logo -->
    <div class="flex items-center gap-3 px-4 py-5 border-b border-gray-100 shrink-0">
        <div class="w-8 h-8 min-w-[32px] rounded-lg bg-brand flex items-center justify-center">
            <svg class="w-4 h-4" viewBox="0 0 17 17" fill="none" stroke="white"
                 stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                <path d="M2 15 L2 7.5 L8.5 2 L15 7.5 L15 15"/>
                <rect x="6" y="9.5" width="5" height="5.5" rx="1.2"/>
            </svg>
        </div>
        <div class="fade overflow-hidden whitespace-nowrap">
            <div class="font-mono font-bold text-brand text-[13px] leading-tight tracking-tight">NagarSewa</div>
            <div class="text-[10px] text-gray-400 uppercase tracking-widest font-medium">Municipal Portal</div>
        </div>
    </div>

    <!-- Nav -->
    <nav class="flex-1 overflow-y-auto px-2 py-3 space-y-0.5">

        <p class="fade px-2 pt-1 pb-2 text-[10px] font-semibold uppercase tracking-widest text-gray-400">Main</p>

        <a href="/dashboard" data-tip="Dashboard"
           class="nav-item active relative flex items-center gap-3 px-2.5 py-2 rounded-lg bg-brand-light cursor-pointer">
        <span class="w-5 h-5 min-w-[20px] flex items-center justify-center">
          <svg class="w-4 h-4 stroke-brand" viewBox="0 0 16 16" fill="none"
               stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round">
            <rect x="1" y="1" width="6" height="6" rx="1.2"/>
            <rect x="9" y="1" width="6" height="6" rx="1.2"/>
            <rect x="1" y="9" width="6" height="6" rx="1.2"/>
            <rect x="9" y="9" width="6" height="6" rx="1.2"/>
          </svg>
        </span>
            <span class="fade text-[13px] font-medium text-brand whitespace-nowrap">Dashboard</span>
        </a>

        <a href="/issues" data-tip="Issue Reports"
           class="nav-item relative flex items-center gap-3 px-2.5 py-2 rounded-lg hover:bg-gray-50 cursor-pointer">
        <span class="w-5 h-5 min-w-[20px] flex items-center justify-center">
          <svg class="w-4 h-4 stroke-gray-500" viewBox="0 0 16 16" fill="none"
               stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round">
            <rect x="2" y="1" width="12" height="14" rx="1.5"/>
            <path d="M5 5h6M5 8h4M5 11h3"/>
          </svg>
        </span>
            <span class="fade text-[13px] font-medium text-gray-700 whitespace-nowrap flex-1">Issue Reports</span>
            <span class="fade text-[10px] font-semibold bg-red-100 text-red-600 px-1.5 py-0.5 rounded-full">284</span>
        </a>

        <a href="/public-works" data-tip="Public Works"
           class="nav-item relative flex items-center gap-3 px-2.5 py-2 rounded-lg hover:bg-gray-50 cursor-pointer">
        <span class="w-5 h-5 min-w-[20px] flex items-center justify-center">
          <svg class="w-4 h-4 stroke-gray-500" viewBox="0 0 16 16" fill="none"
               stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round">
            <path d="M8 1a5 5 0 015 5c0 3.5-5 9-5 9S3 9.5 3 6a5 5 0 015-5z"/>
            <circle cx="8" cy="6" r="1.8"/>
          </svg>
        </span>
            <span class="fade text-[13px] font-medium text-gray-700 whitespace-nowrap">Public Works</span>
        </a>

        <a href="/analytics" data-tip="Ward Analytics"
           class="nav-item relative flex items-center gap-3 px-2.5 py-2 rounded-lg hover:bg-gray-50 cursor-pointer">
        <span class="w-5 h-5 min-w-[20px] flex items-center justify-center">
          <svg class="w-4 h-4 stroke-gray-500" viewBox="0 0 16 16" fill="none"
               stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round">
            <path d="M1 12 L5 7 L8 10 L11 5 L15 8"/>
            <path d="M1 14h14"/>
          </svg>
        </span>
            <span class="fade text-[13px] font-medium text-gray-700 whitespace-nowrap">Ward Analytics</span>
        </a>

        <p class="fade px-2 pt-4 pb-2 text-[10px] font-semibold uppercase tracking-widest text-gray-400">System</p>

        <a href="/notifications" data-tip="Notifications"
           class="nav-item relative flex items-center gap-3 px-2.5 py-2 rounded-lg hover:bg-gray-50 cursor-pointer">
        <span class="w-5 h-5 min-w-[20px] flex items-center justify-center">
          <svg class="w-4 h-4 stroke-gray-500" viewBox="0 0 16 16" fill="none"
               stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round">
            <path d="M8 1a5 5 0 015 5v3l1.5 2.5H1.5L3 9V6a5 5 0 015-5z"/>
            <path d="M6.5 13.5a1.5 1.5 0 003 0"/>
          </svg>
        </span>
            <span class="fade text-[13px] font-medium text-gray-700 whitespace-nowrap flex-1">Notifications</span>
            <span class="fade text-[10px] font-semibold bg-brand-light text-brand px-1.5 py-0.5 rounded-full">9</span>
        </a>

        <a href="/settings" data-tip="Settings"
           class="nav-item relative flex items-center gap-3 px-2.5 py-2 rounded-lg hover:bg-gray-50 cursor-pointer">
        <span class="w-5 h-5 min-w-[20px] flex items-center justify-center">
          <svg class="w-4 h-4 stroke-gray-500" viewBox="0 0 16 16" fill="none"
               stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round">
            <circle cx="8" cy="8" r="2.5"/>
            <path d="M8 1v1.5M8 13.5V15M1 8h1.5M13.5 8H15M3.2 3.2l1.1 1.1M11.7 11.7l1.1 1.1M3.2 12.8l1.1-1.1M11.7 4.3l1.1-1.1"/>
          </svg>
        </span>
            <span class="fade text-[13px] font-medium text-gray-700 whitespace-nowrap">Settings</span>
        </a>

        <a href="/support" data-tip="Support"
           class="nav-item relative flex items-center gap-3 px-2.5 py-2 rounded-lg hover:bg-gray-50 cursor-pointer">
        <span class="w-5 h-5 min-w-[20px] flex items-center justify-center">
          <svg class="w-4 h-4 stroke-gray-500" viewBox="0 0 16 16" fill="none"
               stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round">
            <circle cx="8" cy="8" r="6.5"/>
            <path d="M8 9.5V10M6.3 6.3a2 2 0 113.4 1.4C9 8.5 8 9 8 9"/>
          </svg>
        </span>
            <span class="fade text-[13px] font-medium text-gray-700 whitespace-nowrap">Support</span>
        </a>

        <a href="/logout" data-tip="Logout"
           class="nav-item relative flex items-center gap-3 px-2.5 py-2 rounded-lg hover:bg-red-50 cursor-pointer mt-1">
        <span class="w-5 h-5 min-w-[20px] flex items-center justify-center">
          <svg class="w-4 h-4 stroke-red-400" viewBox="0 0 16 16" fill="none"
               stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round">
            <path d="M6 14H3a1 1 0 01-1-1V3a1 1 0 011-1h3"/>
            <path d="M10 11l4-3-4-3M14 8H6"/>
          </svg>
        </span>
            <span class="fade text-[13px] font-medium text-red-500 whitespace-nowrap">Logout</span>
        </a>

    </nav>

    <!-- User footer -->
    <div class="border-t border-gray-100 p-2 shrink-0">
        <div class="flex items-center gap-2.5 px-2 py-2 rounded-lg hover:bg-gray-50 cursor-pointer transition-colors">
            <div class="w-8 h-8 min-w-[32px] rounded-full bg-brand flex items-center justify-center
                    text-white text-[11px] font-semibold shrink-0">MH</div>
            <div class="fade overflow-hidden whitespace-nowrap">
                <div class="text-[12.5px] font-medium text-gray-800">Admin Portal</div>
                <div class="text-[10.5px] text-gray-400">Municipal Head</div>
            </div>
        </div>
    </div>

</aside>

<script>
    const sidebar = document.getElementById('sidebar');
    const icon    = document.getElementById('toggleIcon');

    document.getElementById('toggleBtn').addEventListener('click', () => {
        sidebar.classList.toggle('collapsed');
        icon.style.transform = sidebar.classList.contains('collapsed') ? 'rotate(180deg)' : '';
    });
</script>

</body>
</html>