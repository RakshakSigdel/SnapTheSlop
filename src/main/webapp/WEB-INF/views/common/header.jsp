<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>SnapTheSlop — Smart Municipal Governance</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&family=Outfit:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <style>
        * { box-sizing: border-box; }
        body {
            font-family: 'Inter', system-ui, sans-serif;
            margin: 0;
            padding: 0;
            overflow-x: hidden;
            background: #f8fafc;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }

        /* Scrollbar */
        ::-webkit-scrollbar { width: 5px; height: 5px; }
        ::-webkit-scrollbar-track { background: #f1f5f9; }
        ::-webkit-scrollbar-thumb { background: #cbd5e1; border-radius: 99px; }
        ::-webkit-scrollbar-thumb:hover { background: #94a3b8; }

        /* Utility: flex layout */
        .flex { display: flex; }
        .min-h-screen { min-height: 100vh; }

        /* Table row hover */
        .table-row-hover { transition: background 0.15s; }
        .table-row-hover:hover { background: #fafbfc; }

        .app-sidebar {
            transition: transform 0.25s ease;
        }

        .sidebar-overlay {
            display: none;
        }

        .sidebar-toggle {
            display: none;
        }

        @media (max-width: 1024px) {
            div[style*="grid-template-columns:1fr 1fr 1fr 1fr"] {
                grid-template-columns: 1fr 1fr !important;
            }

            div[style*="grid-template-columns:5fr 3fr"] {
                grid-template-columns: 1fr !important;
            }
        }

        @media (max-width: 768px) {
            .app-sidebar {
                position: fixed !important;
                top: 0 !important;
                left: 0 !important;
                bottom: 0 !important;
                width: min(82vw, 280px) !important;
                height: 100vh !important;
                min-height: 100vh !important;
                transform: translateX(-105%) !important;
                border-right: 1px solid #1e293b !important;
                border-bottom: 0 !important;
                z-index: 60 !important;
            }

            .app-sidebar nav {
                overflow-y: auto !important;
                max-height: none !important;
            }

            body.sidebar-open .app-sidebar {
                transform: translateX(0) !important;
            }

            .sidebar-overlay {
                display: block;
                position: fixed;
                inset: 0;
                background: rgba(15, 23, 42, 0.56);
                opacity: 0;
                visibility: hidden;
                pointer-events: none;
                transition: opacity 0.25s ease, visibility 0.25s ease;
                z-index: 55;
            }

            body.sidebar-open .sidebar-overlay {
                opacity: 1;
                visibility: visible;
                pointer-events: auto;
            }

            .sidebar-toggle {
                display: inline-flex !important;
                position: fixed;
                top: 14px;
                left: 14px;
                width: 44px;
                height: 44px;
                align-items: center;
                justify-content: center;
                border: 1px solid #cbd5e1;
                border-radius: 14px;
                background: rgba(255, 255, 255, 0.96);
                color: #0f172a;
                box-shadow: 0 10px 30px rgba(15, 23, 42, 0.14);
                z-index: 70;
                cursor: pointer;
            }

            div[style*="margin-left:220px"] {
                margin-left: 0 !important;
                width: 100% !important;
                min-height: auto !important;
                padding-top: 72px !important;
            }

            div[style*="padding:18px 32px"] {
                padding: 16px !important;
                flex-direction: column !important;
                align-items: flex-start !important;
                gap: 12px !important;
            }

            div[style*="padding:28px 32px"] {
                padding: 16px !important;
            }

            div[style*="display:grid; grid-template-columns:1fr 1fr 1fr 1fr"] {
                grid-template-columns: 1fr !important;
            }

            div[style*="display:grid; grid-template-columns:1fr 1fr 1fr;"] {
                grid-template-columns: 1fr !important;
            }

            div[style*="display:grid; grid-template-columns:1fr 1fr;"] {
                grid-template-columns: 1fr !important;
            }

            div[style*="grid-template-columns:5fr 3fr"] {
                grid-template-columns: 1fr !important;
            }

            div[style*="display:flex; align-items:center; justify-content:space-between;"] {
                flex-wrap: wrap !important;
                align-items: flex-start !important;
                gap: 10px !important;
            }
        }
    </style>
</head>
<body>
    <button type="button" class="sidebar-toggle" data-sidebar-toggle aria-label="Open navigation menu" aria-expanded="false">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
            <path d="M4 6h16" />
            <path d="M4 12h16" />
            <path d="M4 18h16" />
        </svg>
    </button>
    <div class="sidebar-overlay" data-sidebar-overlay></div>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var toggleButton = document.querySelector('[data-sidebar-toggle]');
            var overlay = document.querySelector('[data-sidebar-overlay]');
            var sidebar = document.querySelector('.app-sidebar');

            if (!toggleButton || !overlay || !sidebar) {
                return;
            }

            var closeSidebar = function () {
                document.body.classList.remove('sidebar-open');
                toggleButton.setAttribute('aria-expanded', 'false');
            };

            var openSidebar = function () {
                document.body.classList.add('sidebar-open');
                toggleButton.setAttribute('aria-expanded', 'true');
            };

            toggleButton.addEventListener('click', function () {
                if (document.body.classList.contains('sidebar-open')) {
                    closeSidebar();
                } else {
                    openSidebar();
                }
            });

            overlay.addEventListener('click', closeSidebar);

            sidebar.querySelectorAll('a').forEach(function (link) {
                link.addEventListener('click', function () {
                    if (window.innerWidth <= 768) {
                        closeSidebar();
                    }
                });
            });

            window.addEventListener('resize', function () {
                if (window.innerWidth > 768) {
                    closeSidebar();
                }
            });
        });
    </script>
