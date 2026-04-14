<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Page Not Found — SnapTheSlop</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Outfit:wght@700;800;900&display=swap" rel="stylesheet"/>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: #03120f;
            color: #ffffff;
        }

        .error-shell {
            position: relative;
            min-height: 100vh;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 24px;
            background: radial-gradient(circle at 20% 20%, #0b2b24 0, #03120f 45%),
                        radial-gradient(circle at 80% 85%, #052e2a 0, #03120f 50%);
        }

        .bg-orb {
            position: absolute;
            border-radius: 999px;
            filter: blur(70px);
            opacity: 0.32;
            pointer-events: none;
        }

        .orb-one {
            top: 70px;
            left: 50px;
            width: 210px;
            height: 210px;
            background: #10b981;
        }

        .orb-two {
            right: 40px;
            bottom: 80px;
            width: 260px;
            height: 260px;
            background: #14b8a6;
        }

        .content {
            position: relative;
            z-index: 5;
            text-align: center;
            max-width: 760px;
        }

        .code-wrap {
            position: relative;
            margin-bottom: 30px;
            font-family: 'Outfit', sans-serif;
            font-size: clamp(110px, 20vw, 180px);
            font-weight: 900;
            line-height: 0.9;
            letter-spacing: -6px;
            color: #ffffff;
        }

        .glitch {
            position: absolute;
            inset: 0;
            opacity: 0.68;
        }

        .glitch-1 {
            color: #34d399;
            animation: glitch-1 2.5s infinite;
        }

        .glitch-2 {
            color: #2dd4bf;
            animation: glitch-2 3s infinite;
        }

        .heading {
            font-family: 'Outfit', sans-serif;
            font-size: clamp(32px, 5.2vw, 54px);
            font-weight: 800;
            margin-bottom: 12px;
        }

        .desc {
            color: #a7f3d0;
            font-size: 18px;
            margin-bottom: 30px;
            line-height: 1.6;
        }

        .actions {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            flex-wrap: wrap;
        }

        .btn {
            text-decoration: none;
            font-weight: 700;
            border-radius: 10px;
            padding: 12px 22px;
            transition: transform 0.2s ease, box-shadow 0.25s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .btn-primary {
            color: #ffffff;
            background: linear-gradient(90deg, #059669, #0d9488);
            box-shadow: 0 10px 30px rgba(16, 185, 129, 0.35);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 14px 34px rgba(13, 148, 136, 0.42);
        }

        .btn-secondary {
            color: #d1fae5;
            border: 1px solid rgba(167, 243, 208, 0.35);
            background: rgba(6, 78, 59, 0.22);
        }

        .btn-secondary:hover {
            transform: translateY(-2px);
            border-color: rgba(167, 243, 208, 0.6);
        }

        .dots {
            position: absolute;
            left: 50%;
            transform: translateX(-50%);
            bottom: 22px;
            display: flex;
            gap: 12px;
        }

        .dot {
            border-radius: 999px;
            animation: float 3s ease-in-out infinite;
        }

        .dot-a {
            width: 10px;
            height: 10px;
            background: #34d399;
            animation-delay: 0.15s;
        }

        .dot-b {
            width: 8px;
            height: 8px;
            background: #2dd4bf;
            animation-delay: 0.35s;
        }

        .dot-c {
            width: 11px;
            height: 11px;
            background: #ffffff;
            animation-delay: 0.55s;
            opacity: 0.9;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-15px); }
        }

        @keyframes glitch-1 {
            0% { transform: translate(0); }
            20% { transform: translate(-5px, 5px); }
            40% { transform: translate(-5px, -5px); }
            60% { transform: translate(5px, 5px); }
            80% { transform: translate(5px, -5px); }
            100% { transform: translate(0); }
        }

        @keyframes glitch-2 {
            0% { transform: translate(0); }
            25% { transform: translate(5px, -5px); }
            50% { transform: translate(-5px, 5px); }
            75% { transform: translate(5px, 5px); }
            100% { transform: translate(0); }
        }
    </style>
</head>
<body>
    <section class="error-shell">
        <div class="bg-orb orb-one"></div>
        <div class="bg-orb orb-two"></div>

        <div class="content">
            <div class="code-wrap">
                <span class="glitch glitch-1">404</span>
                <span class="glitch glitch-2">404</span>
                <span>404</span>
            </div>

            <h1 class="heading">Page Not Found</h1>
            <p class="desc">Oops! The page you are looking for has vanished from the civic network.</p>

            <div class="actions">
                <a class="btn btn-primary" href="<%= request.getContextPath() %>/">Return to Safety</a>
                <a class="btn btn-secondary" href="javascript:history.back()">Go Back</a>
            </div>
        </div>

        <div class="dots">
            <div class="dot dot-a"></div>
            <div class="dot dot-b"></div>
            <div class="dot dot-c"></div>
        </div>
    </section>
</body>
</html>
