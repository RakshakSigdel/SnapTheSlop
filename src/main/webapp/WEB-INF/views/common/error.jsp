<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Page Not Found — NagarSewa</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Outfit:wght@700;800;900&display=swap" rel="stylesheet">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Inter', sans-serif; background: #f8fafc; min-height: 100vh; display: flex; align-items: center; justify-content: center; }
    </style>
</head>
<body>
    <main style="text-align:center; padding:40px 20px;">
        <p style="font-family:'Outfit',sans-serif; font-size:100px; font-weight:900; color:#e2e8f0; line-height:1; margin-bottom:8px;">404</p>
        <h1 style="font-family:'Outfit',sans-serif; font-size:22px; font-weight:800; color:#0f172a; margin-bottom:8px;">Page not found</h1>
        <p style="font-size:15px; color:#64748b; max-width:400px; margin:0 auto 28px; line-height:1.6;">
            The page you're looking for doesn't exist or has been moved.
        </p>
        <div style="display:flex; gap:10px; justify-content:center;">
            <a href="<%= request.getContextPath() %>/" style="display:inline-flex; align-items:center; gap:6px; padding:10px 22px; border-radius:8px; background:#0f172a; color:#fff; font-size:14px; font-weight:600; text-decoration:none;">
                ← Go home
            </a>
            <a href="javascript:history.back()" style="display:inline-flex; align-items:center; gap:6px; padding:10px 22px; border-radius:8px; background:#fff; border:1.5px solid #e2e8f0; color:#64748b; font-size:14px; font-weight:600; text-decoration:none;">
                Go back
            </a>
        </div>
    </main>
</body>
</html>
