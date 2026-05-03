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
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;600;700;800&family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet" />
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
            --glass-bg: rgba(255, 255, 255, 0.6);
            --glass-border: rgba(255, 255, 255, 0.8);
            --glass-shadow: 0 8px 32px 0 rgba(4, 120, 87, 0.07);
        }

        * { box-sizing: border-box; }
        html { scroll-behavior: smooth; }

        body {
            margin: 0;
            font-family: 'Plus Jakarta Sans', sans-serif;
            color: var(--ink);
            background-color: var(--bg);
            overflow-x: hidden;
            position: relative;
        }

        /* Animated Background */
        .bg-shapes {
            position: fixed;
            top: 0; left: 0; width: 100vw; height: 100vh;
            z-index: -1;
            overflow: hidden;
            pointer-events: none;
        }
        .shape {
            position: absolute;
            filter: blur(90px);
            opacity: 0.7;
            animation: float 20s infinite ease-in-out;
            border-radius: 50%;
        }
        .shape-1 {
            top: -15%; right: -5%;
            width: 60vw; height: 60vw;
            background: #c6f6d5;
        }
        .shape-2 {
            bottom: -10%; left: -10%;
            width: 50vw; height: 50vw;
            background: #d9f99d;
            animation-delay: -5s;
        }
        .shape-3 {
            top: 40%; left: 50%;
            width: 40vw; height: 40vw;
            background: #bbf7d0;
            animation-delay: -10s;
        }

        @keyframes float {
            0%, 100% { transform: translate(0, 0) scale(1); }
            33% { transform: translate(-30px, 40px) scale(1.05); }
            66% { transform: translate(40px, -30px) scale(0.95); }
        }

        a { color: inherit; text-decoration: none; }
        h1, h2, h3, h4 { font-family: 'Outfit', sans-serif; margin: 0; }
        p { margin: 0; line-height: 1.6; }

        .container {
            width: min(1200px, calc(100% - 48px));
            margin: 0 auto;
        }

        /* Glassmorphism Utilities */
        .glass {
            background: var(--glass-bg);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            border: 1px solid var(--glass-border);
            box-shadow: var(--glass-shadow);
        }

        /* Navbar */
        .topbar {
            position: sticky;
            top: 16px;
            z-index: 100;
            margin: 0 auto;
            width: min(1200px, calc(100% - 48px));
            border-radius: 999px;
            transition: all 0.3s ease;
        }

        .topbar-inner {
            height: 70px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 24px;
        }

        .brand {
            display: inline-flex;
            align-items: center;
            gap: 12px;
            font-family: 'Outfit', sans-serif;
            font-weight: 700;
            font-size: 1.25rem;
            color: var(--ink);
        }

        .brand-badge {
            width: 38px; height: 38px;
            border-radius: 12px;
            background: linear-gradient(135deg, var(--green-500), var(--green-700));
            display: grid; place-items: center;
            color: #fff;
            box-shadow: 0 8px 16px rgba(5, 150, 105, 0.3);
        }

        .menu { display: flex; gap: 32px; align-items: center; }
        .menu a {
            color: var(--muted);
            font-weight: 600;
            font-size: 0.95rem;
            transition: color 0.2s ease;
        }
        .menu a:hover { color: var(--green-700); }

        .btn {
            border: none; border-radius: 999px;
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-weight: 700; font-size: 0.95rem;
            cursor: pointer;
            display: inline-flex; align-items: center; justify-content: center;
            padding: 12px 24px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .btn:hover { transform: translateY(-2px); }
        .btn:active { transform: translateY(0); }

        .btn-primary {
            background: linear-gradient(135deg, var(--green-500), var(--green-700));
            color: #fff;
            box-shadow: 0 10px 20px rgba(4, 120, 87, 0.2);
        }
        .btn-primary:hover {
            box-shadow: 0 14px 24px rgba(4, 120, 87, 0.3);
        }
        
        .btn-secondary {
            background: rgba(255,255,255,0.8);
            color: var(--green-700);
            border: 1px solid var(--green-100);
        }
        .btn-secondary:hover {
            background: #fff;
            border-color: var(--green-500);
        }

        /* Hero Section */
        .hero {
            padding: 120px 0 80px;
            min-height: 100vh;
            display: flex;
            align-items: center;
        }

        .hero-wrap {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 60px;
            align-items: center;
        }

        .hero-content h1 {
            font-size: clamp(3rem, 5vw, 4.5rem);
            line-height: 1.1;
            letter-spacing: -0.03em;
            margin-bottom: 24px;
            background: linear-gradient(to right, var(--ink), var(--green-700));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .hero-content p {
            font-size: 1.125rem;
            color: var(--muted);
            margin-bottom: 40px;
            max-width: 90%;
        }

        .hero-cta { display: flex; gap: 16px; flex-wrap: wrap; }

        /* Dynamic Mockup */
        .hero-visual {
            position: relative;
        }
        
        .mockup-card {
            background: rgba(255, 255, 255, 0.9);
            border: 1px solid rgba(255,255,255,0.4);
            border-radius: 24px;
            padding: 24px;
            box-shadow: 0 24px 48px rgba(0,0,0,0.05);
            backdrop-filter: blur(20px);
            transform: rotate(-2deg);
            transition: transform 0.5s ease;
        }
        .hero-visual:hover .mockup-card {
            transform: rotate(0deg) scale(1.02);
        }
        
        .mockup-header {
            display: flex; justify-content: space-between; align-items: center;
            margin-bottom: 24px;
            padding-bottom: 16px;
            border-bottom: 1px solid var(--line);
        }
        .mockup-title { font-weight: 700; font-size: 1.1rem; }
        .mockup-badge { background: var(--green-100); color: var(--green-700); padding: 4px 12px; border-radius: 999px; font-size: 0.8rem; font-weight: 700; }
        
        .mockup-item {
            display: flex; gap: 16px; align-items: center; margin-bottom: 16px;
            background: var(--bg); padding: 16px; border-radius: 16px;
        }
        .mockup-icon { width: 48px; height: 48px; border-radius: 12px; background: #fff; display: grid; place-items: center; box-shadow: 0 4px 12px rgba(0,0,0,0.03); }
        .mockup-info h4 { font-size: 0.95rem; margin-bottom: 4px; }
        .mockup-info p { font-size: 0.85rem; color: var(--muted); }

        .floating-stat {
            position: absolute;
            background: #fff;
            padding: 16px 24px;
            border-radius: 16px;
            box-shadow: 0 16px 32px rgba(0,0,0,0.08);
            display: flex; gap: 16px; align-items: center;
            animation: float-slow 6s infinite ease-in-out;
        }
        .fs-1 { top: -20px; right: -20px; }
        .fs-2 { bottom: 40px; left: -40px; animation-delay: -3s; }
        @keyframes float-slow {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }

        /* Trusted By */
        .trusted-by {
            padding: 40px 0;
            border-top: 1px solid rgba(255,255,255,0.5);
            border-bottom: 1px solid rgba(255,255,255,0.5);
            background: linear-gradient(90deg, rgba(255,255,255,0), rgba(255,255,255,0.4), rgba(255,255,255,0));
            text-align: center;
        }
        .trusted-by p { font-weight: 600; color: var(--muted); margin-bottom: 24px; text-transform: uppercase; letter-spacing: 1.5px; font-size: 0.85rem; }
        .logos { display: flex; justify-content: center; gap: 48px; flex-wrap: wrap; opacity: 0.6; filter: grayscale(100%); transition: all 0.3s; }
        .logos:hover { opacity: 1; filter: grayscale(0%); }
        .logo-item { font-family: 'Outfit', sans-serif; font-size: 1.2rem; font-weight: 800; display: flex; align-items: center; gap: 8px; }

        /* Section Headings */
        .section-header { text-align: center; margin-bottom: 64px; }
        .eyebrow { color: var(--green-600); font-weight: 700; text-transform: uppercase; letter-spacing: 1.5px; font-size: 0.85rem; margin-bottom: 12px; display: block; }
        .section-header h2 { font-size: clamp(2rem, 3vw, 2.5rem); margin-bottom: 16px; }
        .section-header p { color: var(--muted); font-size: 1.1rem; max-width: 600px; margin: 0 auto; }

        /* Features */
        .features { padding: 120px 0; }
        .features-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 32px; }
        .feature-card {
            padding: 32px; border-radius: 24px;
            transition: all 0.3s ease;
            position: relative; overflow: hidden;
        }
        .feature-card:hover { transform: translateY(-8px); box-shadow: 0 20px 40px rgba(4, 120, 87, 0.1); border-color: #fff; background: #fff;}
        .feature-icon {
            width: 56px; height: 56px; border-radius: 16px; background: var(--green-50); color: var(--green-600);
            display: grid; place-items: center; margin-bottom: 24px;
        }
        .feature-card h3 { font-size: 1.25rem; margin-bottom: 12px; }
        .feature-card p { color: var(--muted); font-size: 0.95rem; }

        /* How it works */
        .how-it-works { padding: 100px 0; background: linear-gradient(180deg, rgba(255,255,255,0) 0%, rgba(255,255,255,0.6) 100%); }
        .steps { display: grid; grid-template-columns: repeat(3, 1fr); gap: 40px; position: relative; }
        .step { text-align: center; position: relative; z-index: 1; }
        .step-number {
            width: 64px; height: 64px; border-radius: 50%; background: #fff;
            color: var(--green-700); font-family: 'Outfit'; font-size: 1.5rem; font-weight: 800;
            display: grid; place-items: center; margin: 0 auto 24px;
            box-shadow: 0 12px 24px rgba(0,0,0,0.06);
            border: 2px solid var(--green-100);
        }
        .step h3 { font-size: 1.2rem; margin-bottom: 12px; }
        .step p { color: var(--muted); font-size: 0.95rem; }
        
        .steps-line {
            position: absolute; top: 32px; left: 10%; right: 10%; height: 2px;
            background: linear-gradient(90deg, var(--green-100) 50%, transparent 50%);
            background-size: 16px 2px;
            z-index: 0;
        }

        /* Portals */
        .portals { padding: 120px 0; }
        .portals-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 32px; }
        .portal-card {
            padding: 40px 32px; border-radius: 32px; text-align: center;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            border: 1px solid transparent;
        }
        .portal-citizen { background: linear-gradient(180deg, #f0fdf4 0%, #ffffff 100%); border-color: #dcfce7; }
        .portal-muni { background: linear-gradient(180deg, #f0f9ff 0%, #ffffff 100%); border-color: #e0f2fe; }
        .portal-admin { background: linear-gradient(180deg, #f5f3ff 0%, #ffffff 100%); border-color: #ede9fe; }
        
        .portal-card:hover { transform: translateY(-10px); box-shadow: 0 24px 48px rgba(0,0,0,0.05); }
        .portal-card h3 { font-size: 1.5rem; margin-bottom: 16px; }
        .portal-card p { color: var(--muted); margin-bottom: 32px; }
        .portal-link { font-weight: 700; display: inline-flex; align-items: center; gap: 8px; }
        .portal-citizen .portal-link { color: var(--green-600); }
        .portal-muni .portal-link { color: #0284c7; }
        .portal-admin .portal-link { color: #7c3aed; }

        /* Testimonials */
        .testimonials { padding: 100px 0; }
        .testi-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 24px; }
        .testi-card { padding: 32px; border-radius: 24px; background: #fff; box-shadow: 0 10px 30px rgba(0,0,0,0.03); }
        .stars { color: #fbbf24; margin-bottom: 16px; font-size: 1.2rem; }
        .testi-card p { font-size: 1.05rem; font-style: italic; margin-bottom: 24px; }
        .author { display: flex; align-items: center; gap: 12px; }
        .author-avatar { width: 40px; height: 40px; border-radius: 50%; background: var(--green-100); display: grid; place-items: center; font-weight: 700; color: var(--green-700); }
        .author-info h4 { font-size: 0.95rem; }
        .author-info span { font-size: 0.8rem; color: var(--muted); }



        /* Footer */
        footer { padding: 64px 0 32px; border-top: 1px solid var(--line); background: #fff; }
        .footer-content { display: flex; justify-content: space-between; align-items: center; margin-bottom: 32px; }
        .footer-brand .brand { margin-bottom: 12px; }
        .footer-brand p { color: var(--muted); max-width: 300px; font-size: 0.95rem; }
        .footer-links { display: flex; gap: 48px; }
        .footer-col h4 { font-size: 1rem; margin-bottom: 16px; }
        .footer-col a { display: block; color: var(--muted); margin-bottom: 12px; font-size: 0.9rem; }
        .footer-col a:hover { color: var(--green-600); }
        .footer-bottom { padding-top: 32px; border-top: 1px solid var(--line); display: flex; justify-content: space-between; color: var(--muted); font-size: 0.85rem; }

        /* Reveal Animation */
        .reveal { opacity: 0; transform: translateY(30px); transition: all 0.8s cubic-bezier(0.4, 0, 0.2, 1); }
        .reveal.active { opacity: 1; transform: translateY(0); }

        @media (max-width: 1024px) {
            .hero-wrap, .features-grid, .portals-grid, .testi-grid { grid-template-columns: 1fr 1fr; }
            .hero-visual { display: none; }
            .hero-wrap { grid-template-columns: 1fr; text-align: center; }
            .hero-content p { margin: 0 auto 40px; }
            .hero-cta { justify-content: center; }
        }
        @media (max-width: 768px) {
            .menu { display: none; }
            .features-grid, .portals-grid, .testi-grid, .steps { grid-template-columns: 1fr; }
            .steps-line { display: none; }
            .footer-content { flex-direction: column; gap: 32px; text-align: center; }
            .footer-links { flex-direction: column; gap: 32px; }
            .footer-bottom { flex-direction: column; gap: 16px; text-align: center; }
        }
    </style>
</head>
<body>
    <div class="bg-shapes">
        <div class="shape shape-1"></div>
        <div class="shape shape-2"></div>
        <div class="shape shape-3"></div>
    </div>

    <header class="topbar glass">
        <div class="topbar-inner">
            <a href="#home" class="brand">
                <span class="brand-badge">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
                        <path d="M12 3L3 7v2h18V7l-9-4zm-7 8v6H3v2h18v-2h-2v-6h-2v6h-2v-6h-2v6h-2v-6H9v6H7v-6H5z"/>
                    </svg>
                </span>
                SnapTheSlop
            </a>
            <nav class="menu">
                <a href="#features">Features</a>
                <a href="#how">How It Works</a>
                <a href="#portals">Portals</a>
            </nav>
            <div style="display:flex; gap:12px;">
                <a class="btn btn-secondary" href="<%= request.getContextPath() %>/login">Log in</a>
                <a class="btn btn-primary" href="<%= request.getContextPath() %>/register">Get Started</a>
            </div>
        </div>
    </header>

    <main id="home">
        <section class="hero container reveal">
            <div class="hero-wrap">
                <div class="hero-content">
                    <span class="eyebrow">Smart City Issue Reporting</span>
                    <h1>From one tap to real action in your ward.</h1>
                    <p>Empowering citizens and municipalities to collaborate seamlessly. Report issues, track progress, and build a better neighborhood together with complete transparency.</p>
                    <div class="hero-cta">
                        <a class="btn btn-primary" href="<%= request.getContextPath() %>/citizen/report-issue">
                            Report an Issue
                            <svg style="margin-left:8px;" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
                        </a>
                        <a class="btn btn-secondary" href="<%= request.getContextPath() %>/citizen/browse-issues">Explore Open Issues</a>
                    </div>
                </div>
                <div class="hero-visual">
                    <div class="floating-stat fs-1">
                        <div style="width:40px;height:40px;border-radius:10px;background:var(--green-100);color:var(--green-700);display:grid;place-items:center;font-weight:bold;font-size:1.2rem;">✓</div>
                        <div>
                            <div style="font-weight:700;font-size:1.1rem;color:var(--ink);">89%</div>
                            <div style="font-size:0.8rem;color:var(--muted);">Resolution Rate</div>
                        </div>
                    </div>
                    <div class="floating-stat fs-2">
                        <div style="width:40px;height:40px;border-radius:10px;background:#fef3c7;color:#d97706;display:grid;place-items:center;font-weight:bold;font-size:1.2rem;">!</div>
                        <div>
                            <div style="font-weight:700;font-size:1.1rem;color:var(--ink);">Active</div>
                            <div style="font-size:0.8rem;color:var(--muted);">Live Tracking</div>
                        </div>
                    </div>
                    
                    <div class="mockup-card">
                        <div class="mockup-header">
                            <span class="mockup-title">Recent Reports</span>
                            <span class="mockup-badge">Live Updates</span>
                        </div>
                        <div class="mockup-item">
                            <div class="mockup-icon" style="color:#ef4444;"><svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"/></svg></div>
                            <div class="mockup-info">
                                <h4>Pothole on Ring Road</h4>
                                <p>Reported 10 mins ago • Ward 4</p>
                            </div>
                        </div>
                        <div class="mockup-item">
                            <div class="mockup-icon" style="color:#f59e0b;"><svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M13 10V3L4 14h7v7l9-11h-7z"/></svg></div>
                            <div class="mockup-info">
                                <h4>Streetlight Outage</h4>
                                <p>In Progress • Ward 12</p>
                            </div>
                        </div>
                        <div class="mockup-item">
                            <div class="mockup-icon" style="color:var(--green-500);"><svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 13l4 4L19 7"/></svg></div>
                            <div class="mockup-info">
                                <h4>Garbage Overflow</h4>
                                <p>Resolved • Ward 7</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="trusted-by reveal">
            <div class="container">
                <p>Trusted by Progressive Municipalities</p>
                <div class="logos">
                    <div class="logo-item"><svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2L2 7l10 5 10-5-10-5zM2 17l10 5 10-5M2 12l10 5 10-5"/></svg> Kathmandu Metro</div>
                    <div class="logo-item"><svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor"><circle cx="12" cy="12" r="10"/></svg> Lalitpur Sub-Metro</div>
                    <div class="logo-item"><svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor"><rect x="3" y="3" width="18" height="18" rx="2"/></svg> Bhaktapur Muni</div>
                    <div class="logo-item"><svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/></svg> Pokhara Metro</div>
                </div>
            </div>
        </section>

        <section id="features" class="features container reveal">
            <div class="section-header">
                <span class="eyebrow">Platform Capabilities</span>
                <h2>Everything you need for civic management</h2>
                <p>A unified platform that bridges the gap between citizens reporting issues and authorities resolving them.</p>
            </div>
            <div class="features-grid">
                <div class="feature-card glass">
                    <div class="feature-icon"><svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/></svg></div>
                    <h3>Effortless Reporting</h3>
                    <p>Snap a photo, add a location, and submit. Our streamlined process makes reporting issues take less than a minute.</p>
                </div>
                <div class="feature-card glass">
                    <div class="feature-icon"><svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 12h-4l-3 9L9 3l-3 9H2"/></svg></div>
                    <h3>Live Status Tracking</h3>
                    <p>No more wondering what happened to your report. Track its status from 'Submitted' all the way to 'Resolved' in real-time.</p>
                </div>
                <div class="feature-card glass">
                    <div class="feature-icon"><svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg></div>
                    <h3>Ward Management</h3>
                    <p>Dedicated queues for each ward ensure that issues are routed directly to the specific teams responsible for fixing them.</p>
                </div>
                <div class="feature-card glass">
                    <div class="feature-icon"><svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"/><path d="M13.73 21a2 2 0 0 1-3.46 0"/></svg></div>
                    <h3>Instant Notifications</h3>
                    <p>Receive email and dashboard alerts the moment your issue is assigned, updated, or marked as completed by authorities.</p>
                </div>
                <div class="feature-card glass">
                    <div class="feature-icon"><svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21.21 15.89A10 10 0 1 1 8 2.83"/><path d="M22 12A10 10 0 0 0 12 2v10z"/></svg></div>
                    <h3>Data Analytics</h3>
                    <p>Admins get powerful insights into resolution times, common issue types, and overall municipality performance.</p>
                </div>
                <div class="feature-card glass">
                    <div class="feature-icon"><svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/></svg></div>
                    <h3>Secure & Reliable</h3>
                    <p>Enterprise-grade security ensures that user data and municipal operations are kept safe and running 24/7.</p>
                </div>
            </div>
        </section>

        <section id="how" class="how-it-works reveal">
            <div class="container">
                <div class="section-header">
                    <span class="eyebrow">Process Overview</span>
                    <h2>How SnapTheSlop Works</h2>
                    <p>Three simple steps to transform complaints into solutions.</p>
                </div>
                <div class="steps">
                    <div class="steps-line"></div>
                    <div class="step">
                        <div class="step-number">1</div>
                        <h3>Report an Issue</h3>
                        <p>Spot a problem in your neighborhood? Take a picture, write a brief description, and submit it through our portal.</p>
                    </div>
                    <div class="step">
                        <div class="step-number">2</div>
                        <h3>Authorities Act</h3>
                        <p>The issue is automatically routed to the correct ward. Municipality officers review, prioritize, and assign workers.</p>
                    </div>
                    <div class="step">
                        <div class="step-number">3</div>
                        <h3>Issue Resolved</h3>
                        <p>Once fixed, authorities update the status with photo proof. You get notified immediately that the job is done.</p>
                    </div>
                </div>
            </div>
        </section>

        <section id="portals" class="portals container reveal">
            <div class="section-header">
                <span class="eyebrow">Dedicated Experiences</span>
                <h2>Portals tailored for every role</h2>
                <p>Specialized dashboards designed to give each user exactly what they need.</p>
            </div>
            <div class="portals-grid">
                <div class="portal-card portal-citizen">
                    <h3>Citizen Portal</h3>
                    <p>Your central hub to report new issues, track the status of your existing reports, and engage with neighborhood concerns.</p>
                    <a href="<%= request.getContextPath() %>/citizen/dashboard" class="portal-link">
                        Enter Citizen Portal
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
                    </a>
                </div>
                <div class="portal-card portal-muni">
                    <h3>Municipality Portal</h3>
                    <p>The operational dashboard for ward officers to manage queues, assign tasks, and update issue resolutions efficiently.</p>
                    <a href="<%= request.getContextPath() %>/municipality/dashboard" class="portal-link">
                        Enter Municipality Portal
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
                    </a>
                </div>
                <div class="portal-card portal-admin">
                    <h3>Admin Portal</h3>
                    <p>The control center for system administrators to oversee users, manage municipalities, and review platform analytics.</p>
                    <a href="<%= request.getContextPath() %>/admin/dashboard" class="portal-link">
                        Enter Admin Portal
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
                    </a>
                </div>
            </div>
        </section>

        <section class="testimonials reveal" style="background:var(--green-50);">
            <div class="container">
                <div class="section-header">
                    <span class="eyebrow">Community Voices</span>
                    <h2>What people are saying</h2>
                </div>
                <div class="testi-grid">
                    <div class="testi-card">
                        <div class="stars">★★★★★</div>
                        <p>"I reported a broken streetlight and it was fixed within 48 hours. The ability to track the progress made all the difference."</p>
                        <div class="author">
                            <div class="author-avatar">S</div>
                            <div class="author-info">
                                <h4>Sita Sharma</h4>
                                <span>Active Citizen, Ward 10</span>
                            </div>
                        </div>
                    </div>
                    <div class="testi-card">
                        <div class="stars">★★★★★</div>
                        <p>"Our ward response time improved significantly because reports now arrive structured and are incredibly easy to prioritize."</p>
                        <div class="author">
                            <div class="author-avatar" style="background:#e0f2fe; color:#0284c7;">R</div>
                            <div class="author-info">
                                <h4>Rajesh Shrestha</h4>
                                <span>Ward Officer, Ward 04</span>
                            </div>
                        </div>
                    </div>
                    <div class="testi-card">
                        <div class="stars">★★★★★</div>
                        <p>"Finally, a platform that holds authorities accountable while making it super easy for citizens to participate in local governance."</p>
                        <div class="author">
                            <div class="author-avatar" style="background:#fce7f3; color:#be185d;">A</div>
                            <div class="author-info">
                                <h4>Anita Maharjan</h4>
                                <span>Community Leader</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>


    </main>

    <footer>
        <div class="container">
            <div class="footer-content">
                <div class="footer-brand">
                    <div class="brand">
                        <span class="brand-badge" style="width:30px;height:30px;border-radius:8px;">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
                                <path d="M12 3L3 7v2h18V7l-9-4zm-7 8v6H3v2h18v-2h-2v-6h-2v6h-2v-6h-2v6h-2v-6H9v6H7v-6H5z"/>
                            </svg>
                        </span>
                        SnapTheSlop
                    </div>
                    <p>A smart civic reporting platform empowering citizens and municipalities to build better communities together.</p>
                </div>
                <div class="footer-links">
                    <div class="footer-col">
                        <h4>Platform</h4>
                        <a href="#features">Features</a>
                        <a href="#how">How it Works</a>
                        <a href="#portals">Portals</a>
                    </div>
                    <div class="footer-col">
                        <h4>Resources</h4>
                        <a href="#">Help Center</a>
                        <a href="#">Guidelines</a>
                        <a href="#">Contact Support</a>
                    </div>
                    <div class="footer-col">
                        <h4>Legal</h4>
                        <a href="#">Privacy Policy</a>
                        <a href="#">Terms of Service</a>
                    </div>
                </div>
            </div>
            <div class="footer-bottom">
                <span>&copy; 2026 SnapTheSlop. All rights reserved.</span>
                <span style="display:flex;gap:16px;">
                    <a href="#">Twitter</a>
                    <a href="#">LinkedIn</a>
                    <a href="#">Facebook</a>
                </span>
            </div>
        </div>
    </footer>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Intersection Observer for scroll animations
            const observerOptions = {
                root: null,
                rootMargin: '0px',
                threshold: 0.1
            };

            const observer = new IntersectionObserver((entries, observer) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.classList.add('active');
                        observer.unobserve(entry.target);
                    }
                });
            }, observerOptions);

            document.querySelectorAll('.reveal').forEach(element => {
                observer.observe(element);
            });

            // Sticky Navbar transparency effect
            const topbar = document.querySelector('.topbar');
            window.addEventListener('scroll', () => {
                if (window.scrollY > 50) {
                    topbar.style.background = 'rgba(255, 255, 255, 0.85)';
                    topbar.style.boxShadow = '0 10px 30px rgba(0,0,0,0.05)';
                } else {
                    topbar.style.background = 'var(--glass-bg)';
                    topbar.style.boxShadow = 'var(--glass-shadow)';
                }
            });
        });
    </script>
</body>
</html>
