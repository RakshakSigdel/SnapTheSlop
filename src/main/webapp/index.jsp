<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>NagarSewa — Smart Municipality Portal</title>
    <meta name="description" content="Report civic issues, track municipal responses, and help build better neighborhoods."/>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&family=Outfit:wght@500;600;700;800;900&display=swap" rel="stylesheet">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Inter', sans-serif; background: #fff; color: #1e293b; }
        a { text-decoration: none; }
        .nav-link { color: #64748b; font-size: 14px; font-weight: 500; transition: color 0.15s; }
        .nav-link:hover { color: #0f172a; }
        .btn { display: inline-flex; align-items: center; gap: 6px; padding: 10px 22px; border-radius: 8px; font-size: 14px; font-weight: 600; cursor: pointer; transition: all 0.2s; border: none; font-family: 'Inter', sans-serif; }
        .btn-dark { background: #0f172a; color: #fff; }
        .btn-dark:hover { background: #1e293b; }
        .btn-outline { background: transparent; color: #0f172a; border: 1.5px solid #e2e8f0; }
        .btn-outline:hover { border-color: #94a3b8; }

        .card-link {
            display: block; background: #fff; border: 1px solid #e2e8f0; border-radius: 10px;
            padding: 24px; transition: all 0.2s; text-decoration: none; color: inherit;
        }
        .card-link:hover { border-color: #cbd5e1; box-shadow: 0 4px 12px rgba(0,0,0,0.04); transform: translateY(-2px); }

        .section-tag {
            display: inline-block; font-size: 11px; font-weight: 700; text-transform: uppercase;
            letter-spacing: 2px; color: #94a3b8; margin-bottom: 12px;
        }
    </style>
</head>
<body>

    <!-- Navbar -->
    <nav style="padding:16px 48px; display:flex; align-items:center; justify-content:space-between; border-bottom:1px solid #f1f5f9;">
        <div style="display:flex; align-items:center; gap:8px;">
            <div style="width:28px; height:28px; border-radius:6px; background:#0f172a; display:flex; align-items:center; justify-content:center;">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="white"><path d="M12 3L3 7v2h18V7l-9-4zm-7 8v6H3v2h18v-2h-2v-6h-2v6h-2v-6h-2v6h-2v-6H9v6H7v-6H5z"/></svg>
            </div>
            <span style="font-family:'Outfit',sans-serif; font-weight:700; font-size:16px; color:#0f172a;">NagarSewa</span>
        </div>
        <div style="display:flex; align-items:center; gap:32px;">
            <a href="#features" class="nav-link">Features</a>
            <a href="#pages" class="nav-link">Pages</a>
            <a href="<%= request.getContextPath() %>/login" class="nav-link">Sign in</a>
            <a href="<%= request.getContextPath() %>/register" class="btn btn-dark">Get Started</a>
        </div>
    </nav>

    <!-- Hero -->
    <section style="padding:80px 48px 60px; max-width:720px;">
        <p class="section-tag">Smart Municipal Governance</p>
        <h1 style="font-family:'Outfit',sans-serif; font-size:52px; font-weight:900; color:#0f172a; line-height:1.1; margin-bottom:18px; letter-spacing:-1.5px;">
            Report it.<br>Track it.<br>Fix it.
        </h1>
        <p style="font-size:18px; color:#64748b; line-height:1.7; max-width:520px; margin-bottom:32px;">
            NagarSewa connects citizens with their municipality. Report potholes, broken lights, garbage — anything that needs fixing. We make sure it gets done.
        </p>
        <div style="display:flex; gap:12px; align-items:center;">
            <a href="<%= request.getContextPath() %>/register" class="btn btn-dark" style="padding:14px 28px; font-size:15px;">
                Start Reporting
                <svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M17 8l4 4m0 0l-4 4m4-4H3"/></svg>
            </a>
            <a href="<%= request.getContextPath() %>/login" class="btn btn-outline" style="padding:14px 28px; font-size:15px;">Sign In</a>
        </div>

        <!-- Social proof -->
        <div style="margin-top:40px; display:flex; align-items:center; gap:20px;">
            <div style="display:flex;">
                <div style="width:32px; height:32px; border-radius:50%; background:#e0e7ff; border:2px solid #fff; display:flex; align-items:center; justify-content:center; font-size:10px; font-weight:700; color:#4338ca;">RA</div>
                <div style="width:32px; height:32px; border-radius:50%; background:#d1fae5; border:2px solid #fff; margin-left:-8px; display:flex; align-items:center; justify-content:center; font-size:10px; font-weight:700; color:#065f46;">SD</div>
                <div style="width:32px; height:32px; border-radius:50%; background:#fef3c7; border:2px solid #fff; margin-left:-8px; display:flex; align-items:center; justify-content:center; font-size:10px; font-weight:700; color:#92400e;">PK</div>
                <div style="width:32px; height:32px; border-radius:50%; background:#fce7f3; border:2px solid #fff; margin-left:-8px; display:flex; align-items:center; justify-content:center; font-size:10px; font-weight:700; color:#9d174d;">BT</div>
            </div>
            <p style="font-size:13px; color:#64748b;"><strong style="color:#0f172a;">2,847</strong> citizens already reporting</p>
        </div>
    </section>

    <!-- Divider -->
    <div style="border-top:1px solid #f1f5f9; margin:0 48px;"></div>

    <!-- Page Directory -->
    <section id="pages" style="padding:60px 48px 80px; max-width:1100px;">
        <p class="section-tag">All Pages</p>
        <h2 style="font-family:'Outfit',sans-serif; font-size:28px; font-weight:800; color:#0f172a; margin-bottom:32px; letter-spacing:-0.5px;">Quick access to every section</h2>

        <!-- Auth -->
        <p style="font-size:12px; font-weight:700; color:#4f46e5; text-transform:uppercase; letter-spacing:1.5px; margin-bottom:12px;">Account</p>
        <div style="display:grid; grid-template-columns:1fr 1fr 1fr; gap:14px; margin-bottom:32px;">
            <a href="<%= request.getContextPath() %>/login" class="card-link">
                <p style="font-size:15px; font-weight:700; color:#0f172a; margin-bottom:4px;">Login</p>
                <p style="font-size:13px; color:#64748b;">Sign in to your account</p>
            </a>
            <a href="<%= request.getContextPath() %>/register" class="card-link">
                <p style="font-size:15px; font-weight:700; color:#0f172a; margin-bottom:4px;">Register</p>
                <p style="font-size:13px; color:#64748b;">Create a new account</p>
            </a>
            <a href="<%= request.getContextPath() %>/citizen/profile" class="card-link">
                <p style="font-size:15px; font-weight:700; color:#0f172a; margin-bottom:4px;">Profile</p>
                <p style="font-size:13px; color:#64748b;">View & edit your details</p>
            </a>
        </div>

        <!-- Citizen -->
        <p style="font-size:12px; font-weight:700; color:#059669; text-transform:uppercase; letter-spacing:1.5px; margin-bottom:12px;">Citizen Portal</p>
        <div style="display:grid; grid-template-columns:1fr 1fr 1fr 1fr; gap:14px; margin-bottom:32px;">
            <a href="<%= request.getContextPath() %>/citizen/dashboard" class="card-link">
                <p style="font-size:15px; font-weight:700; color:#0f172a; margin-bottom:4px;">Dashboard</p>
                <p style="font-size:13px; color:#64748b;">Your civic overview</p>
            </a>
            <a href="<%= request.getContextPath() %>/citizen/my-issues" class="card-link">
                <p style="font-size:15px; font-weight:700; color:#0f172a; margin-bottom:4px;">My Issues</p>
                <p style="font-size:13px; color:#64748b;">Track your reports</p>
            </a>
            <a href="<%= request.getContextPath() %>/citizen/report-issue" class="card-link">
                <p style="font-size:15px; font-weight:700; color:#0f172a; margin-bottom:4px;">Report Issue</p>
                <p style="font-size:13px; color:#64748b;">Submit a new report</p>
            </a>
            <a href="<%= request.getContextPath() %>/citizen/issue-detail?id=1" class="card-link">
                <p style="font-size:15px; font-weight:700; color:#0f172a; margin-bottom:4px;">Issue Detail</p>
                <p style="font-size:13px; color:#64748b;">View issue info</p>
            </a>
        </div>

        <!-- Municipality -->
        <p style="font-size:12px; font-weight:700; color:#7c3aed; text-transform:uppercase; letter-spacing:1.5px; margin-bottom:12px;">Municipality Panel</p>
        <div style="display:grid; grid-template-columns:1fr 1fr; gap:14px; margin-bottom:32px;">
            <a href="<%= request.getContextPath() %>/municipality/dashboard" class="card-link">
                <p style="font-size:15px; font-weight:700; color:#0f172a; margin-bottom:4px;">Municipality Dashboard</p>
                <p style="font-size:13px; color:#64748b;">Ward statistics and issue overview</p>
            </a>
            <a href="<%= request.getContextPath() %>/municipality/issue-list" class="card-link">
                <p style="font-size:15px; font-weight:700; color:#0f172a; margin-bottom:4px;">Issue Management</p>
                <p style="font-size:13px; color:#64748b;">Review and resolve reports</p>
            </a>
        </div>

        <!-- Admin -->
        <p style="font-size:12px; font-weight:700; color:#dc2626; text-transform:uppercase; letter-spacing:1.5px; margin-bottom:12px;">System Admin</p>
        <div style="display:grid; grid-template-columns:1fr 1fr 1fr; gap:14px;">
            <a href="<%= request.getContextPath() %>/admin/dashboard" class="card-link">
                <p style="font-size:15px; font-weight:700; color:#0f172a; margin-bottom:4px;">Admin Dashboard</p>
                <p style="font-size:13px; color:#64748b;">System-wide overview</p>
            </a>
            <a href="<%= request.getContextPath() %>/admin/user-management" class="card-link">
                <p style="font-size:15px; font-weight:700; color:#0f172a; margin-bottom:4px;">User Management</p>
                <p style="font-size:13px; color:#64748b;">Manage all accounts</p>
            </a>
            <a href="<%= request.getContextPath() %>/admin/issue-management" class="card-link">
                <p style="font-size:15px; font-weight:700; color:#0f172a; margin-bottom:4px;">Issue Oversight</p>
                <p style="font-size:13px; color:#64748b;">Global issue monitor</p>
            </a>
        </div>
    </section>

    <!-- Footer -->
    <footer style="padding:32px 48px; border-top:1px solid #f1f5f9; display:flex; align-items:center; justify-content:space-between;">
        <span style="font-size:13px; color:#94a3b8;">&copy; 2025 NagarSewa. Built for better cities.</span>
        <div style="display:flex; gap:20px;">
            <a href="#" style="font-size:13px; color:#94a3b8;">Privacy</a>
            <a href="#" style="font-size:13px; color:#94a3b8;">Terms</a>
            <a href="#" style="font-size:13px; color:#94a3b8;">Help</a>
        </div>
    </footer>
</body>
</html>