<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>404 - Page Not Found | NagarSewa</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: Arial, sans-serif;
            background-color: #ffffff;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        .container {
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            padding: 40px 20px;
            max-width: 600px;
        }

        .illustration {
            margin-bottom: 40px;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50%       { transform: translateY(-14px); }
        }
        @keyframes beam-pulse {
            0%, 100% { opacity: 0.65; }
            50%       { opacity: 1; }
        }
        @keyframes ring-spin {
            from { transform: rotate(0deg); }
            to   { transform: rotate(360deg); }
        }

        .ufo-group { animation: float 3s ease-in-out infinite; }
        .beam      { animation: beam-pulse 2s ease-in-out infinite; }
        .ring      { transform-origin: 210px 143px; animation: ring-spin 8s linear infinite; }

        h1 {
            font-size: 48px;
            font-weight: bold;
            color: #1a1a1a;
            margin-bottom: 16px;
            letter-spacing: -0.5px;
        }

        p {
            font-size: 16px;
            color: #777777;
            line-height: 1.7;
            margin-bottom: 36px;
            max-width: 420px;
        }

        .btn-home {
            background-color: #6abf3a;
            color: #ffffff;
            padding: 13px 40px;
            border-radius: 50px;
            text-decoration: none;
            font-size: 15px;
            font-weight: bold;
            display: inline-block;
            transition: opacity 0.2s ease, transform 0.1s ease;
        }

        .btn-home:hover  { opacity: 0.88; }
        .btn-home:active { transform: scale(0.97); }
    </style>
</head>
<body>

<div class="container">

    <!-- SVG Illustration -->
    <div class="illustration">
        <svg width="420" height="240" viewBox="0 0 420 240" fill="none" xmlns="http://www.w3.org/2000/svg">

            <!-- Left "4" shadow -->
            <ellipse cx="100" cy="218" rx="50" ry="8" fill="#c8f5a0" opacity="0.55"/>
            <!-- Left "4" body -->
            <path d="M68 58 L68 155 L132 155 L132 185 L68 185 L68 218 L38 218 L38 185 L16 185 L16 155 L38 155 L38 58 Z" fill="#6abf3a"/>
            <path d="M68 58 L68 155 L38 155 L38 58 Z" fill="#4e9926"/>
            <path d="M38 218 L68 218 L68 207 L38 207 Z" fill="#4e9926"/>
            <path d="M132 185 L102 185 L102 174 L132 174 Z" fill="#4e9926"/>
            <path d="M132 155 L162 140 L162 170 L132 185 Z" fill="#8dd64e"/>
            <path d="M68 218 L98 203 L68 203 Z" fill="#8dd64e"/>

            <!-- Right "4" shadow -->
            <ellipse cx="322" cy="218" rx="50" ry="8" fill="#c8f5a0" opacity="0.55"/>
            <!-- Right "4" body -->
            <path d="M290 58 L290 155 L354 155 L354 185 L290 185 L290 218 L260 218 L260 185 L238 185 L238 155 L260 155 L260 58 Z" fill="#6abf3a"/>
            <path d="M290 58 L290 155 L260 155 L260 58 Z" fill="#4e9926"/>
            <path d="M260 218 L290 218 L290 207 L260 207 Z" fill="#4e9926"/>
            <path d="M354 185 L324 185 L324 174 L354 174 Z" fill="#4e9926"/>
            <path d="M354 155 L384 140 L384 170 L354 185 Z" fill="#8dd64e"/>
            <path d="M290 218 L320 203 L290 203 Z" fill="#8dd64e"/>

            <!-- UFO group (floating) -->
            <g class="ufo-group">

                <!-- Beam -->
                <g class="beam">
                    <path d="M173 148 L210 226 L248 148 Z" fill="url(#beamGrad)" opacity="0.55"/>
                    <line x1="193" y1="160" x2="200" y2="218" stroke="#fffbaa" stroke-width="1.4" opacity="0.5"/>
                    <line x1="210" y1="156" x2="210" y2="222" stroke="#fffbaa" stroke-width="1.4" opacity="0.5"/>
                    <line x1="227" y1="160" x2="220" y2="218" stroke="#fffbaa" stroke-width="1.4" opacity="0.5"/>
                </g>

                <!-- Beam ground glow -->
                <ellipse cx="210" cy="225" rx="36" ry="8" fill="#a8e96c" opacity="0.45"/>

                <!-- Saucer -->
                <ellipse cx="210" cy="148" rx="70" ry="20" fill="#3d5f96"/>
                <ellipse cx="210" cy="143" rx="70" ry="20" fill="#5b82bd"/>

                <!-- Spinning ring -->
                <ellipse class="ring" cx="210" cy="143" rx="70" ry="20"
                         fill="none" stroke="#7aa3d4" stroke-width="1.8" stroke-dasharray="9 6"/>

                <!-- Dome -->
                <ellipse cx="210" cy="128" rx="35" ry="15" fill="#c8f5a0"/>
                <ellipse cx="210" cy="124" rx="35" ry="15" fill="#d6f9b0"/>
                <ellipse cx="200" cy="118" rx="10" ry="5" fill="white" opacity="0.35"
                         transform="rotate(-15 200 118)"/>

                <!-- Window lights -->
                <circle cx="167" cy="143" r="4.5" fill="#f9e55a"/>
                <circle cx="183" cy="149" r="4.5" fill="#f9e55a"/>
                <circle cx="200" cy="152" r="4.5" fill="#f9e55a"/>
                <circle cx="220" cy="152" r="4.5" fill="#f9e55a"/>
                <circle cx="237" cy="149" r="4.5" fill="#f9e55a"/>
                <circle cx="253" cy="143" r="4.5" fill="#f9e55a"/>

            </g>

            <defs>
                <linearGradient id="beamGrad" x1="210" y1="148" x2="210" y2="226" gradientUnits="userSpaceOnUse">
                    <stop offset="0%"   stop-color="#d4f77c" stop-opacity="0.9"/>
                    <stop offset="100%" stop-color="#d4f77c" stop-opacity="0"/>
                </linearGradient>
            </defs>
        </svg>
    </div>

    <!-- Heading -->
    <h1>Page Not Found</h1>

    <!-- Description -->
    <p>The page you are looking for might have been removed, had its name changed or is temporarily unavailable.</p>

    <!-- Button -->
    <a href="home" class="btn-home">Home Page</a>

</div>

</body>
</html>
