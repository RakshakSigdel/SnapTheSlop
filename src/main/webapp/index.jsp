<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>SnapTheSlop | Civic Reporting Platform</title>
    <meta name="description" content="Report local civic problems, track progress, and collaborate with municipalities for faster issue resolution." />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@500;600;700;800&family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet" />
    <style>
        :root {
            --bg: #f3f8f3;
            --surface: #ffffff;
            --ink: #0f172a;
            --muted: #475569;
            --line: #dbe7dc;
            --green-700: #047857;
            --green-600: #059669;
            --green-500: #10b981;
            --green-100: #dcfce7;
            --green-50: #f0fdf4;
        }

        * { box-sizing: border-box; }

        html { scroll-behavior: smooth; }

        body {
            margin: 0;
            font-family: 'Plus Jakarta Sans', sans-serif;
            color: var(--ink);
            background:
                radial-gradient(1100px 600px at 95% -10%, #c6f6d5 0%, rgba(198, 246, 213, 0) 65%),
                radial-gradient(900px 500px at -10% 0%, #d9f99d 0%, rgba(217, 249, 157, 0) 60%),
                var(--bg);
        }

        a { color: inherit; text-decoration: none; }

        .container {
            width: min(1120px, calc(100% - 40px));
            margin: 0 auto;
        }

        .topbar {
            position: sticky;
            top: 0;
            z-index: 100;
            backdrop-filter: blur(8px);
            background: rgba(243, 248, 243, 0.88);
            border-bottom: 1px solid var(--line);
        }

        .topbar-inner {
            min-height: 74px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 24px;
        }

        .brand {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            font-family: 'Outfit', sans-serif;
            font-weight: 700;
            font-size: 1.05rem;
        }

        .brand-badge {
            width: 34px;
            height: 34px;
            border-radius: 10px;
            background: linear-gradient(145deg, var(--green-500), var(--green-700));
            display: grid;
            place-items: center;
            color: #fff;
            box-shadow: 0 10px 24px rgba(5, 150, 105, 0.25);
        }

        .menu {
            display: flex;
            gap: 20px;
            align-items: center;
            color: var(--muted);
            font-weight: 600;
            font-size: 0.95rem;
        }

        .menu a:hover { color: var(--green-700); }

        .btn {
            border: 0;
            border-radius: 999px;
            font-family: inherit;
            font-weight: 700;
            font-size: 0.92rem;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 12px 20px;
            transition: transform 0.2s ease, box-shadow 0.2s ease, background 0.2s ease;
        }

        .btn:hover {
            transform: translateY(-1px);
        }

        .btn-primary {
            background: linear-gradient(145deg, var(--green-600), var(--green-700));
            color: #fff;
            box-shadow: 0 12px 24px rgba(4, 120, 87, 0.26);
        }

        .btn-secondary {
            background: #fff;
            color: var(--green-700);
            border: 1px solid #bbf7d0;
        }

        .hero {
            padding: 72px 0 40px;
        }

        .hero-wrap {
            display: grid;
            grid-template-columns: 1.2fr 0.8fr;
            gap: 28px;
            align-items: stretch;
        }

        .hero-card {
            background: rgba(255, 255, 255, 0.8);
            border: 1px solid #d6ead7;
            border-radius: 24px;
            padding: 36px;
            box-shadow: 0 20px 50px rgba(16, 24, 40, 0.08);
        }

        .eyebrow {
            color: var(--green-700);
            text-transform: uppercase;
            letter-spacing: 1.2px;
            font-weight: 800;
            font-size: 0.78rem;
            margin: 0 0 10px;
        }

        h1, h2, h3 {
            font-family: 'Outfit', sans-serif;
            margin: 0;
            letter-spacing: -0.02em;
        }

        h1 {
            font-size: clamp(2rem, 4.4vw, 3.4rem);
            line-height: 1.08;
            margin-bottom: 14px;
        }

        .hero-copy {
            margin: 0;
            color: var(--muted);
            line-height: 1.7;
            max-width: 56ch;
        }

        .hero-cta {
            margin-top: 22px;
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }

        .hero-stats {
            margin-top: 28px;
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 10px;
        }

        .hero-stats .stat {
            background: var(--green-50);
            border: 1px solid #ccf1d8;
            border-radius: 14px;
            padding: 14px;
        }

        .stat .big {
            font-family: 'Outfit', sans-serif;
            font-size: 1.5rem;
            font-weight: 800;
            color: var(--green-700);
            margin: 0;
        }

        .stat .label {
            margin: 4px 0 0;
            color: #166534;
            font-weight: 600;
            font-size: 0.82rem;
        }

        .status-panel {
            display: flex;
            flex-direction: column;
            gap: 12px;
            justify-content: center;
        }

        .status-tile {
            background: linear-gradient(145deg, #0f172a, #1e293b);
            color: #f8fafc;
            border-radius: 20px;
            padding: 22px;
            border: 1px solid #334155;
        }

        .status-tile h3 {
            font-size: 1.12rem;
            margin-bottom: 8px;
        }

        .status-tile p {
            margin: 0;
            font-size: 0.9rem;
            color: #cbd5e1;
            line-height: 1.6;
        }

        .status-list {
            background: #fff;
            border: 1px solid var(--line);
            border-radius: 16px;
            padding: 14px;
        }

        .status-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
            padding: 10px 8px;
            border-bottom: 1px solid #ecf2ec;
            font-size: 0.88rem;
        }

        .status-row:last-child { border-bottom: 0; }

        .pill {
            border-radius: 999px;
            padding: 5px 9px;
            font-size: 0.72rem;
            font-weight: 800;
            letter-spacing: 0.3px;
            text-transform: uppercase;
        }

        .pill-open { background: #fee2e2; color: #991b1b; }
        .pill-progress { background: #fef3c7; color: #92400e; }
        .pill-done { background: #dcfce7; color: #166534; }

        section.content {
            padding: 46px 0;
        }

        .grid-3 {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 14px;
        }

        .card {
            background: var(--surface);
            border: 1px solid var(--line);
            border-radius: 18px;
            padding: 18px;
            box-shadow: 0 10px 28px rgba(15, 23, 42, 0.04);
        }

        .card h3 {
            font-size: 1.02rem;
            margin-bottom: 8px;
        }

        .card p {
            margin: 0;
            color: var(--muted);
            line-height: 1.6;
            font-size: 0.92rem;
        }

        .roles {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 14px;
        }

        .role {
            border-radius: 18px;
            padding: 20px;
            border: 1px solid;
        }

        .role h3 { margin-bottom: 6px; }
        .role p { margin: 0 0 14px; color: var(--muted); }

        .role a {
            font-weight: 700;
            color: var(--green-700);
            font-size: 0.9rem;
        }

        .role-citizen { background: #f8fffb; border-color: #caefd7; }
        .role-muni { background: #f5fbff; border-color: #d4e8f9; }
        .role-admin { background: #faf8ff; border-color: #e5d9f8; }

        .quote-wrap {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 14px;
        }

        .quote {
            background: #fff;
            border: 1px solid var(--line);
            border-radius: 16px;
            padding: 16px;
        }

        .quote p {
            margin: 0;
            color: #334155;
            line-height: 1.6;
            font-size: 0.92rem;
        }

        .quote .who {
            margin-top: 10px;
            color: #0f172a;
            font-weight: 700;
            font-size: 0.85rem;
        }

        .access {
            margin-top: 10px;
            background: #0f172a;
            border-radius: 20px;
            border: 1px solid #1e293b;
            padding: 24px;
            color: #e2e8f0;
        }

        .access h2 {
            color: #fff;
            font-size: 1.35rem;
            margin-bottom: 8px;
        }

        .access p {
            color: #94a3b8;
            margin: 0 0 16px;
            font-size: 0.92rem;
        }

        .access-grid {
            display: grid;
            grid-template-columns: repeat(4, minmax(0, 1fr));
            gap: 12px;
        }

        .group {
            background: #111c2f;
            border: 1px solid #24354f;
            border-radius: 14px;
            padding: 12px;
        }

        .group h3 {
            font-size: 0.9rem;
            color: #a7f3d0;
            margin-bottom: 8px;
        }

        .group a {
            display: block;
            color: #cbd5e1;
            font-size: 0.82rem;
            padding: 6px 0;
            border-bottom: 1px dashed #22314a;
        }

        .group a:last-child { border-bottom: 0; }
        .group a:hover { color: #6ee7b7; }

        footer {
            padding: 34px 0 48px;
            color: #64748b;
            font-size: 0.88rem;
        }

        .reveal {
            opacity: 0;
            transform: translateY(22px);
            transition: opacity 0.65s ease, transform 0.65s ease;
        }

        .reveal.in {
            opacity: 1;
            transform: translateY(0);
        }

        @media (max-width: 1024px) {
            .hero-wrap,
            .roles,
            .grid-3,
            .access-grid,
            .quote-wrap {
                grid-template-columns: 1fr 1fr;
            }
        }

        @media (max-width: 760px) {
            .menu { display: none; }
            .hero { padding-top: 44px; }
            .hero-card { padding: 24px; }
            .hero-wrap,
            .roles,
            .grid-3,
            .access-grid,
            .quote-wrap,
            .hero-stats {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <header class="topbar">
        <div class="container topbar-inner">
            <a href="#home" class="brand">
                <span class="brand-badge">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor" aria-hidden="true">
                        <path d="M12 3L3 7v2h18V7l-9-4zm-7 8v6H3v2h18v-2h-2v-6h-2v6h-2v-6h-2v6h-2v-6H9v6H7v-6H5z"></path>
                    </svg>
                </span>
                SnapTheSlop
            </a>

            <nav class="menu" aria-label="Primary">
                <a href="#features">Features</a>
                <a href="#how">How It Works</a>
                <a href="#roles">Portals</a>
                <a href="#access">Quick Access</a>
            </nav>

            <div style="display:flex; gap:10px;">
                <a class="btn btn-secondary" href="<%= request.getContextPath() %>/login">Sign In</a>
                <a class="btn btn-primary" href="<%= request.getContextPath() %>/register">Get Started</a>
            </div>
        </div>
    </header>

    <main id="home" class="container">
        <section class="hero reveal">
            <div class="hero-wrap">
                <article class="hero-card">
                    <p class="eyebrow">Smart City Issue Reporting</p>
                    <h1>From one tap to real action in your ward.</h1>
                    <p class="hero-copy">
                        SnapTheSlop helps citizens report civic issues, municipalities track and resolve them, and admins monitor progress across the city. Faster reporting, clearer accountability, better neighborhoods.
                    </p>
                    <div class="hero-cta">
                        <a class="btn btn-primary" href="<%= request.getContextPath() %>/citizen/report-issue">Report an Issue</a>
                        <a class="btn btn-secondary" href="<%= request.getContextPath() %>/citizen/browse-issues">Explore Open Issues</a>
                    </div>

                    <div class="hero-stats">
                        <div class="stat">
                            <p class="big">2.8k+</p>
                            <p class="label">Registered Citizens</p>
                        </div>
                        <div class="stat">
                            <p class="big">89%</p>
                            <p class="label">Resolution Rate</p>
                        </div>
                        <div class="stat">
                            <p class="big">38</p>
                            <p class="label">Municipality Units</p>
                        </div>
                    </div>
                </article>

                <aside class="status-panel">
                    <div class="status-tile">
                        <h3>Live Operations Snapshot</h3>
                        <p>
                            Transparent issue flow from report to resolution. Citizens stay updated, municipality teams prioritize faster, and admins get system-wide control.
                        </p>
                    </div>

                    <div class="status-list" aria-label="Issue Samples">
                        <div class="status-row">
                            <span>Pothole near Ring Road</span>
                            <span class="pill pill-open">Open</span>
                        </div>
                        <div class="status-row">
                            <span>Streetlight outage</span>
                            <span class="pill pill-progress">In Progress</span>
                        </div>
                        <div class="status-row">
                            <span>Garbage overflow zone-4</span>
                            <span class="pill pill-done">Resolved</span>
                        </div>
                    </div>
                </aside>
            </div>
        </section>

        <section id="features" class="content reveal">
            <p class="eyebrow">Core Platform Features</p>
            <h2 style="font-size:clamp(1.6rem, 3.2vw, 2.4rem); margin-bottom:14px;">Everything a civic landing page should promise.</h2>
            <div class="grid-3">
                <article class="card">
                    <h3>Clear Reporting Workflow</h3>
                    <p>Citizens can submit reports with details and track status updates from a single dashboard.</p>
                </article>
                <article class="card">
                    <h3>Ward-Level Operations</h3>
                    <p>Municipality teams get issue lists, ward management, and resolution tools in one panel.</p>
                </article>
                <article class="card">
                    <h3>Admin Visibility</h3>
                    <p>Administrators oversee citizens, municipalities, and issue lifecycle performance platform-wide.</p>
                </article>
            </div>
        </section>

        <section id="how" class="content reveal">
            <p class="eyebrow">How It Works</p>
            <div class="grid-3">
                <article class="card">
                    <h3>1. Citizen Reports</h3>
                    <p>Users file an issue from mobile or desktop and instantly create a trackable case.</p>
                </article>
                <article class="card">
                    <h3>2. Municipality Acts</h3>
                    <p>Ward teams review, prioritize, assign, and update issue status with operational context.</p>
                </article>
                <article class="card">
                    <h3>3. Admin Audits</h3>
                    <p>Admin dashboards monitor trends, ensure accountability, and maintain quality of service.</p>
                </article>
            </div>
        </section>

        <section id="roles" class="content reveal">
            <p class="eyebrow">Role Portals</p>
            <div class="roles">
                <article class="role role-citizen">
                    <h3>Citizen Portal</h3>
                    <p>Report issues, browse neighborhood concerns, review history, and receive notifications.</p>
                    <a href="<%= request.getContextPath() %>/citizen/dashboard">Open Citizen Dashboard</a>
                </article>
                <article class="role role-muni">
                    <h3>Municipality Portal</h3>
                    <p>Handle issue queues, manage ward workflows, and publish action updates efficiently.</p>
                    <a href="<%= request.getContextPath() %>/municipality/dashboard">Open Municipality Dashboard</a>
                </article>
                <article class="role role-admin">
                    <h3>Admin Portal</h3>
                    <p>Oversee system operations, citizens, municipalities, and full issue lifecycle reports.</p>
                    <a href="<%= request.getContextPath() %>/admin/dashboard">Open Admin Dashboard</a>
                </article>
            </div>
        </section>

        <section class="content reveal">
            <p class="eyebrow">Voices From The Platform</p>
            <div class="quote-wrap">
                <article class="quote">
                    <p>"Our ward response time improved because reports now arrive structured and easy to prioritize."</p>
                    <p class="who">Municipality Officer, Ward 04</p>
                </article>
                <article class="quote">
                    <p>"I can finally see what happened after reporting. Tracking gave me confidence to keep participating."</p>
                    <p class="who">Citizen User, Kathmandu</p>
                </article>
            </div>
        </section>

        <section id="access" class="content reveal">
            <div class="access">
                <h2>Temporary Quick Access: All Current Pages</h2>
                <p>Use this section during development/testing to jump to every major route in the application.</p>

                <div class="access-grid">
                    <div class="group">
                        <h3>Auth</h3>
                        <a href="<%= request.getContextPath() %>/login">/login</a>
                        <a href="<%= request.getContextPath() %>/register">/register</a>
                        <a href="<%= request.getContextPath() %>/user/logout">/user/logout</a>
                    </div>

                    <div class="group">
                        <h3>Citizen</h3>
                        <a href="<%= request.getContextPath() %>/citizen/dashboard">/citizen/dashboard</a>
                        <a href="<%= request.getContextPath() %>/citizen/browse-issues">/citizen/browse-issues</a>
                        <a href="<%= request.getContextPath() %>/citizen/my-issues">/citizen/my-issues</a>
                        <a href="<%= request.getContextPath() %>/citizen/report-issue">/citizen/report-issue</a>
                        <a href="<%= request.getContextPath() %>/citizen/issue-detail?id=1">/citizen/issue-detail</a>
                        <a href="<%= request.getContextPath() %>/citizen/notifications">/citizen/notifications</a>
                        <a href="<%= request.getContextPath() %>/citizen/profile">/citizen/profile</a>
                    </div>

                    <div class="group">
                        <h3>Municipality</h3>
                        <a href="<%= request.getContextPath() %>/municipality/dashboard">/municipality/dashboard</a>
                        <a href="<%= request.getContextPath() %>/municipality/issue-list">/municipality/issue-list</a>
                        <a href="<%= request.getContextPath() %>/municipality/manage-issue?id=1">/municipality/manage-issue</a>
                        <a href="<%= request.getContextPath() %>/municipality/notifications">/municipality/notifications</a>
                        <a href="<%= request.getContextPath() %>/municipality/ward-management">/municipality/ward-management</a>
                        <a href="<%= request.getContextPath() %>/municipality/profile">/municipality/profile</a>
                    </div>

                    <div class="group">
                        <h3>Admin + Common</h3>
                        <a href="<%= request.getContextPath() %>/admin/dashboard">/admin/dashboard</a>
                        <a href="<%= request.getContextPath() %>/admin/users">/admin/users</a>
                        <a href="<%= request.getContextPath() %>/admin/manage-user?id=CT-001">/admin/manage-user</a>
                        <a href="<%= request.getContextPath() %>/admin/municipalities">/admin/municipalities</a>
                        <a href="<%= request.getContextPath() %>/admin/manage-municipality?id=1">/admin/manage-municipality</a>
                        <a href="<%= request.getContextPath() %>/admin/issue-management">/admin/issue-management</a>
                        <a href="<%= request.getContextPath() %>/admin/manage-issues">/admin/manage-issues</a>
                        <a href="<%= request.getContextPath() %>/sidebar">/sidebar</a>
                        <a href="<%= request.getContextPath() %>/footer">/footer</a>
                        <a href="<%= request.getContextPath() %>/error">/error</a>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <footer>
        <div class="container">
            <strong style="color:#0f172a;">SnapTheSlop</strong>
            <span style="margin-left:8px;">Built for transparent, faster civic issue resolution.</span>
        </div>
    </footer>

    <script>
        (function () {
            var items = document.querySelectorAll('.reveal');
            if (!('IntersectionObserver' in window)) {
                items.forEach(function (el) { el.classList.add('in'); });
                return;
            }

            var observer = new IntersectionObserver(function (entries) {
                entries.forEach(function (entry) {
                    if (entry.isIntersecting) {
                        entry.target.classList.add('in');
                        observer.unobserve(entry.target);
                    }
                });
            }, { threshold: 0.15 });

            items.forEach(function (el, idx) {
                el.style.transitionDelay = (idx * 80) + 'ms';
                observer.observe(el);
            });
        })();
    </script>
</body>
</html>
