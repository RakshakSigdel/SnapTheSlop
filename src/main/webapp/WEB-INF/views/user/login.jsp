<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Sign In — SnapTheSlop</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&family=Outfit:wght@500;600;700;800&display=swap" rel="stylesheet">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        html, body { height: 100%; }
        body {
            font-family: 'Inter', sans-serif;
            min-height: 100vh;
            min-height: 100dvh;
            display: grid;
            grid-template-columns: 1fr 1fr;
        }

        .left-panel {
            background: #0c1222;
            display: flex; flex-direction: column; justify-content: center; align-items: center;
            padding: 60px; position: relative; overflow: hidden;
        }
        .left-panel::before {
            content: ''; position: absolute; top: -20%; right: -30%;
            width: 500px; height: 500px; border-radius: 50%;
            background: radial-gradient(circle, rgba(5,150,105,0.12) 0%, transparent 65%);
        }
        .left-panel::after {
            content: ''; position: absolute; bottom: -15%; left: -20%;
            width: 400px; height: 400px; border-radius: 50%;
            background: radial-gradient(circle, rgba(16,185,129,0.08) 0%, transparent 65%);
        }

        .right-panel {
            background: #f8fafc;
            min-height: 100vh;
            min-height: 100dvh;
            display: flex;
            padding: 60px 80px;
        }

        .right-panel-inner {
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .field-group { margin-bottom: 20px; }
        .field-label { display: block; font-size: 13px; font-weight: 600; color: #374151; margin-bottom: 6px; }
        .field-input {
            width: 100%; height: 46px; border: 1.5px solid #e5e7eb; border-radius: 8px;
            padding: 0 14px; font-size: 14px; color: #111827; background: #fff;
            outline: none; transition: border-color 0.2s, box-shadow 0.2s; font-family: 'Inter', sans-serif;
        }
        .field-input:focus { border-color: #059669; box-shadow: 0 0 0 3px rgba(5,150,105,0.08); }
        .field-input::placeholder { color: #9ca3af; }

        .btn-primary {
            width: 100%; height: 46px; border: none; border-radius: 8px;
            background: #059669; color: #fff; font-size: 14px; font-weight: 600;
            cursor: pointer; transition: background 0.2s; font-family: 'Inter', sans-serif;
        }
        .btn-primary:hover { background: #047857; }

        .stat-pill {
            display: inline-flex; align-items: center; gap: 6px;
            padding: 8px 16px; border-radius: 8px;
            background: rgba(255,255,255,0.06); border: 1px solid rgba(255,255,255,0.08);
            color: #94a3b8; font-size: 12px; font-weight: 500;
        }

        @media (max-width: 900px) {
            body { grid-template-columns: 1fr; }
            .left-panel { display: none; }
            .right-panel {
                min-height: 100vh;
                min-height: 100dvh;
                padding: 40px 24px;
            }
        }
    </style>
</head>
<body>

    <!-- Left: Brand Panel -->
    <div class="left-panel">
        <div style="position:relative; z-index:1; max-width:380px;">
            <div style="display:flex; align-items:center; gap:10px; margin-bottom:40px;">
                <div style="width:36px; height:36px; border-radius:8px; background:#059669; display:flex; align-items:center; justify-content:center;">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="white"><path d="M12 3L3 7v2h18V7l-9-4zm-7 8v6H3v2h18v-2h-2v-6h-2v6h-2v-6h-2v6h-2v-6H9v6H7v-6H5z"/></svg>
                </div>
                <span style="font-family:'Outfit',sans-serif; font-weight:700; font-size:18px; color:#f1f5f9;">SnapTheSlop</span>
            </div>

            <h2 style="font-family:'Outfit',sans-serif; font-size:32px; font-weight:800; color:#f1f5f9; line-height:1.2; margin-bottom:14px; letter-spacing:-0.5px;">
                Your city,<br>your voice.
            </h2>
            <p style="font-size:15px; color:#64748b; line-height:1.7; margin-bottom:36px;">
                Report infrastructure problems, track municipal responses, and help build a better neighborhood — one issue at a time.
            </p>

            <div style="display:flex; flex-wrap:wrap; gap:8px;">
                <div class="stat-pill">
                    <span style="color:#34d399; font-weight:700;">2,847</span> registered citizens
                </div>
                <div class="stat-pill">
                    <span style="color:#34d399; font-weight:700;">89%</span> issues resolved
                </div>
                <div class="stat-pill">
                    <span style="color:#fbbf24; font-weight:700;">15</span> wards covered
                </div>
            </div>

            <div style="margin-top:48px; padding-top:24px; border-top:1px solid rgba(148,163,184,0.08);">
                <p style="font-size:12px; color:#475569; font-style:italic; line-height:1.6;">
                    "NagarSewa helped us get the broken pipeline on our street fixed in 3 days. Finally a system that actually works."
                </p>
                <p style="font-size:12px; color:#64748b; margin-top:8px;">— Sita Devi, Ward 7 Resident</p>
            </div>
        </div>
    </div>

    <!-- Right: Login Form -->
    <div class="right-panel">
        <div class="right-panel-inner">
        <div style="max-width:380px; width:100%;">
            <h1 style="font-family:'Outfit',sans-serif; font-size:26px; font-weight:800; color:#111827; margin-bottom:4px;">Welcome back</h1>
            <p style="font-size:14px; color:#6b7280; margin-bottom:28px;">Enter your credentials to access your dashboard.</p>

            <% if (request.getAttribute("error") != null) { %>
            <div style="background:#fef2f2; color:#dc2626; padding:12px 14px; border-radius:8px; margin-bottom:20px; font-size:13px; border:1px solid #fecaca;">
                <%= request.getAttribute("error") %>
            </div>
            <% } %>

            <form action="<%= request.getContextPath() %>/login" method="post" novalidate>
                <div class="field-group">
                    <label class="field-label" for="email">Email</label>
                    <input class="field-input" id="email" name="email" type="email" placeholder="you@example.com" required/>
                </div>

                <div class="field-group">
                    <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:6px;">
                        <label class="field-label" for="password" style="margin:0;">Password</label>
                        <a href="#" style="font-size:12px; color:#059669; text-decoration:none; font-weight:500;">Forgot password?</a>
                    </div>
                    <input class="field-input" id="password" name="password" type="password" placeholder="Enter your password" required/>
                </div>

                <div style="display:flex; align-items:center; gap:8px; margin-bottom:24px;">
                    <input id="remember" type="checkbox" style="width:15px; height:15px; accent-color:#059669; cursor:pointer;"/>
                    <label for="remember" style="font-size:13px; color:#6b7280; cursor:pointer;">Keep me signed in</label>
                </div>

                <button type="submit" class="btn-primary">Sign in</button>
            </form>

            <p style="text-align:center; color:#6b7280; font-size:14px; margin-top:24px;">
                New here? <a href="<%= request.getContextPath() %>/register" style="color:#059669; font-weight:600; text-decoration:none;">Create an account</a>
            </p>

            <div style="margin-top:40px; padding-top:20px; border-top:1px solid #e5e7eb;">
                <p style="font-size:11px; color:#9ca3af; text-align:center;">
                    By signing in you agree to our <a href="#" style="color:#6b7280; text-decoration:underline;">Terms</a> and <a href="#" style="color:#6b7280; text-decoration:underline;">Privacy Policy</a>
                </p>
            </div>
        </div>
        </div>
    </div>
</body>
</html>
