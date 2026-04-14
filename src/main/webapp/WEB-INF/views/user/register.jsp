<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Create Account — SnapTheSlop</title>
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
            grid-template-columns: 1fr 1.2fr;
        }

        .left-panel {
            background: #0c1222;
            min-height: 100vh;
            min-height: 100dvh;
            display: flex;
            padding: 60px; position: relative; overflow: hidden;
        }
        .left-panel::before {
            content: ''; position: absolute; top: -10%; right: -25%;
            width: 450px; height: 450px; border-radius: 50%;
            background: radial-gradient(circle, rgba(16,185,129,0.1) 0%, transparent 65%);
        }

        .right-panel {
            background: #f8fafc;
            min-height: 100vh;
            min-height: 100dvh;
            display: flex;
            padding: 48px 64px;
            overflow-y: auto;
        }

        .left-panel-inner,
        .right-panel-inner {
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .field-label { display: block; font-size: 13px; font-weight: 600; color: #374151; margin-bottom: 5px; }
        .field-input {
            width: 100%; height: 44px; border: 1.5px solid #e5e7eb; border-radius: 8px;
            padding: 0 12px; font-size: 14px; color: #111827; background: #fff;
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

        @media (max-width: 900px) {
            body { grid-template-columns: 1fr; }
            .left-panel { display: none; }
            .right-panel {
                min-height: 100vh;
                min-height: 100dvh;
                padding: 32px 20px;
            }
        }
    </style>
</head>
<body>

    <!-- Left: Brand -->
    <div class="left-panel">
        <div class="left-panel-inner">
        <div style="position:relative; z-index:1; max-width:360px; width:100%;">
            <div style="display:flex; align-items:center; gap:10px; margin-bottom:40px;">
                <div style="width:36px; height:36px; border-radius:8px; background:#059669; display:flex; align-items:center; justify-content:center;">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="white"><path d="M12 3L3 7v2h18V7l-9-4zm-7 8v6H3v2h18v-2h-2v-6h-2v6h-2v-6h-2v6h-2v-6H9v6H7v-6H5z"/></svg>
                </div>
                <span style="font-family:'Outfit',sans-serif; font-weight:700; font-size:18px; color:#f1f5f9;">SnapTheSlop</span>
            </div>

            <h2 style="font-family:'Outfit',sans-serif; font-size:30px; font-weight:800; color:#f1f5f9; line-height:1.25; margin-bottom:14px;">
                Be the change in<br>your municipality.
            </h2>
            <p style="font-size:15px; color:#64748b; line-height:1.7; margin-bottom:32px;">
                Join thousands of active citizens who are making their wards cleaner, safer, and more responsive by snapping the slop.
            </p>

            <div style="display:flex; flex-direction:column; gap:16px;">
                <div style="display:flex; align-items:center; gap:12px;">
                    <div style="width:32px; height:32px; border-radius:6px; background:rgba(16,185,129,0.1); display:flex; align-items:center; justify-content:center; flex-shrink:0;">
                        <svg width="16" height="16" fill="#34d399" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/></svg>
                    </div>
                    <span style="font-size:14px; color:#94a3b8;">Report issues with photo evidence</span>
                </div>
                <div style="display:flex; align-items:center; gap:12px;">
                    <div style="width:32px; height:32px; border-radius:6px; background:rgba(16,185,129,0.1); display:flex; align-items:center; justify-content:center; flex-shrink:0;">
                        <svg width="16" height="16" fill="#34d399" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/></svg>
                    </div>
                    <span style="font-size:14px; color:#94a3b8;">Track real-time resolution status</span>
                </div>
                <div style="display:flex; align-items:center; gap:12px;">
                    <div style="width:32px; height:32px; border-radius:6px; background:rgba(16,185,129,0.1); display:flex; align-items:center; justify-content:center; flex-shrink:0;">
                        <svg width="16" height="16" fill="#34d399" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/></svg>
                    </div>
                    <span style="font-size:14px; color:#94a3b8;">Get instant notifications on updates</span>
                </div>
            </div>
        </div>
        </div>
    </div>

    <!-- Right: Registration Form -->
    <div class="right-panel">
        <div class="right-panel-inner">
        <div style="max-width:440px; width:100%;">
            <h1 style="font-family:'Outfit',sans-serif; font-size:24px; font-weight:800; color:#111827; margin-bottom:4px;">Create your account</h1>
            <p style="font-size:14px; color:#6b7280; margin-bottom:24px;">Takes less than 2 minutes. No paperwork needed.</p>

            <% if (request.getAttribute("error") != null) { %>
            <div style="background:#fef2f2; color:#dc2626; padding:12px 14px; border-radius:8px; margin-bottom:16px; font-size:13px; border:1px solid #fecaca;">
                <%= request.getAttribute("error") %>
            </div>
            <% } %>

            <form action="<%= request.getContextPath() %>/register" method="post" id="regForm">
                <div style="display:grid; grid-template-columns:1fr 1fr; gap:14px; margin-bottom:14px;">
                    <div>
                        <label class="field-label" for="firstName">First name</label>
                        <input class="field-input" id="firstName" name="firstName" type="text" required placeholder="Hari"/>
                    </div>
                    <div>
                        <label class="field-label" for="lastName">Last name</label>
                        <input class="field-input" id="lastName" name="lastName" type="text" required placeholder="Bahadur"/>
                    </div>
                </div>

                <div style="margin-bottom:14px;">
                    <label class="field-label" for="email">Email address</label>
                    <input class="field-input" id="email" name="email" type="email" required placeholder="hari@example.com"/>
                </div>

                <div style="margin-bottom:14px;">
                    <label class="field-label" for="phone">Phone number</label>
                    <input class="field-input" id="phone" name="phone" type="tel" required placeholder="98XXXXXXXX"/>
                </div>

                <div style="display:grid; grid-template-columns:1fr 1fr; gap:14px; margin-bottom:14px;">
                    <div>
                        <label class="field-label" for="password">Password</label>
                        <input class="field-input" id="password" name="password" type="password" required placeholder="Min 8 characters"/>
                    </div>
                    <div>
                        <label class="field-label" for="confirmPassword">Confirm</label>
                        <input class="field-input" id="confirmPassword" name="confirmPassword" type="password" required placeholder="Re-enter"/>
                    </div>
                </div>

                <div style="display:flex; align-items:flex-start; gap:8px; margin-bottom:22px;">
                    <input type="checkbox" required style="width:15px; height:15px; accent-color:#059669; margin-top:2px; cursor:pointer;"/>
                    <span style="font-size:13px; color:#6b7280; line-height:1.5;">I agree to the <a href="#" style="color:#059669; text-decoration:underline;">Terms of Service</a> and <a href="#" style="color:#059669; text-decoration:underline;">Privacy Policy</a></span>
                </div>

                <button type="submit" class="btn-primary">Create account</button>
            </form>

            <p style="text-align:center; color:#6b7280; font-size:14px; margin-top:20px;">
                Already have an account? <a href="<%= request.getContextPath() %>/login" style="color:#059669; font-weight:600; text-decoration:none;">Sign in</a>
            </p>
        </div>
        </div>
    </div>
</body>
</html>
