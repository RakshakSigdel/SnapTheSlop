<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>NagarSewa - Sign In</title>
    <style>
      :root {
        --page-bg: #efefef;
        --card-bg: #f6f6f6;
        --panel-bg: #ffffff;
        --text-main: #2c3338;
        --text-muted: #7b8188;
        --border-soft: #e4e7eb;
        --primary: #1f63de;
        --primary-dark: #1553c4;
      }

      * {
        box-sizing: border-box;
      }

      body {
        margin: 0;
        min-height: 100vh;
        font-family: "Segoe UI", Arial, sans-serif;
        background: var(--page-bg);
        color: var(--text-main);
        display: flex;
        justify-content: center;
      }

      .auth-shell {
        width: 100%;
        max-width: 720px;
        min-height: 100vh;
        padding: 52px 20px 28px;
        display: flex;
        flex-direction: column;
        align-items: center;
      }

      .brand-icon {
        width: 40px;
        height: 40px;
        border-radius: 8px;
        background: var(--primary);
        display: grid;
        place-items: center;
        box-shadow: 0 10px 22px rgba(31, 99, 222, 0.26);
        margin-bottom: 12px;
      }

      .brand-icon svg {
        width: 22px;
        height: 22px;
        fill: #ffffff;
      }

      .brand-title {
        margin: 0;
        font-size: 52px;
        font-weight: 700;
        letter-spacing: -0.8px;
      }

      .brand-subtitle {
        margin: 7px 0 28px;
        color: #80858c;
        font-size: 16px;
        letter-spacing: 2.1px;
        font-weight: 600;
        text-transform: uppercase;
      }

      .login-card {
        width: 100%;
        max-width: 480px;
        border-radius: 12px;
        background: var(--card-bg);
        padding: 34px 34px 30px;
        box-shadow: 0 18px 42px rgba(30, 45, 78, 0.08);
      }

      .card-title {
        margin: 0;
        font-size: 30px;
        font-weight: 700;
      }

      .card-subtitle {
        margin: 6px 0 24px;
        color: var(--text-muted);
        font-size: 20px;
        line-height: 1.45;
      }

      .form-row {
        margin-bottom: 16px;
      }

      .label {
        display: block;
        margin-bottom: 8px;
        color: #7d8288;
        font-size: 12px;
        font-weight: 700;
        letter-spacing: 0.8px;
        text-transform: uppercase;
      }

      .field-wrap {
        position: relative;
      }

      .field-icon {
        position: absolute;
        top: 50%;
        left: 12px;
        transform: translateY(-50%);
        color: #9098a2;
        font-size: 14px;
        line-height: 1;
      }

      .field-input {
        width: 100%;
        height: 50px;
        border: 1px solid var(--border-soft);
        border-radius: 9px;
        background: #eceef1;
        padding: 0 12px 0 34px;
        font-size: 15px;
        color: #2f353a;
        outline: none;
      }

      .field-input:focus {
        border-color: #b8c8e8;
        box-shadow: 0 0 0 3px rgba(31, 99, 222, 0.12);
        background: #f5f8ff;
      }

      .password-head {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-bottom: 8px;
      }

      .forgot-link {
        color: var(--primary);
        font-size: 13px;
        font-weight: 600;
        text-decoration: none;
      }

      .remember {
        margin: 2px 0 18px;
        display: flex;
        align-items: center;
        gap: 8px;
        color: #7d8288;
        font-size: 14px;
      }

      .remember input {
        width: 14px;
        height: 14px;
        margin: 0;
        accent-color: var(--primary);
      }

      .signin-btn {
        width: 100%;
        height: 50px;
        border: 0;
        border-radius: 9px;
        background: var(--primary);
        color: #ffffff;
        font-size: 24px;
        font-weight: 600;
        cursor: pointer;
        transition: background 0.2s ease;
      }

      .signin-btn:hover {
        background: var(--primary-dark);
      }

      .card-divider {
        margin: 24px 0 18px;
        border: 0;
        border-top: 1px solid #dddfe3;
      }

      .register-row {
        margin: 0;
        text-align: center;
        color: #666d76;
        font-size: 20px;
      }

      .register-row a {
        margin-left: 6px;
        color: var(--primary);
        font-weight: 600;
        text-decoration: none;
      }

      .footer-links {
        margin-top: auto;
        display: flex;
        gap: 22px;
        flex-wrap: wrap;
        justify-content: center;
        color: #8c929a;
        font-size: 12px;
        text-transform: uppercase;
        font-weight: 600;
        letter-spacing: 0.3px;
        padding-top: 26px;
      }

      .footer-links a {
        color: inherit;
        text-decoration: none;
      }

      @media (max-width: 620px) {
        .auth-shell {
          padding-top: 28px;
        }

        .brand-title {
          font-size: 42px;
        }

        .brand-subtitle {
          font-size: 13px;
          letter-spacing: 1.4px;
          margin-bottom: 20px;
        }

        .login-card {
          padding: 24px 20px;
        }

        .card-title {
          font-size: 24px;
        }

        .card-subtitle {
          font-size: 17px;
          margin-bottom: 18px;
        }

        .signin-btn,
        .register-row {
          font-size: 20px;
        }
      }
    </style>
  </head>
  <body>
    <main class="auth-shell">
      <div class="brand-icon" aria-hidden="true">
        <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
          <path
            d="M12 3L3 7v2h18V7l-9-4zm-7 8v6H3v2h18v-2h-2v-6h-2v6h-2v-6h-2v6h-2v-6H9v6H7v-6H5z"
          ></path>
        </svg>
      </div>

      <h1 class="brand-title">NagarSewa</h1>
      <p class="brand-subtitle">Municipal Governance Portal</p>

      <section class="login-card">
        <h2 class="card-title">Welcome back</h2>
        <p class="card-subtitle">Access your municipal dashboard</p>

        <% if (request.getAttribute("error") != null) { %>
        <div style="background: #fff1f1; color: #b3261e; padding: 10px 12px; border-radius: 8px; margin-bottom: 16px; font-size: 13px; border: 1px solid #ffd4d1;">
          <%= request.getAttribute("error") %>
        </div>
        <% } %>

        <form action="<%= request.getContextPath() %>/login" method="post" novalidate>
          <div class="form-row">
            <label class="label" for="email">Email Address</label>
            <div class="field-wrap">
              <span class="field-icon" aria-hidden="true">@</span>
              <input
                class="field-input"
                id="email"
                name="email"
                type="email"
                placeholder="name@municipality.gov"
              />
            </div>
          </div>

          <div class="form-row">
            <div class="password-head">
              <label class="label" for="password">Password</label>
              <a class="forgot-link" href="#">Forgot?</a>
            </div>
            <div class="field-wrap">
              <span class="field-icon" aria-hidden="true">*</span>
              <input
                class="field-input"
                id="password"
                name="password"
                type="password"
                placeholder="........"
              />
            </div>
          </div>

          <label class="remember" for="remember-device">
            <input id="remember-device" type="checkbox" />
            Remember this device
          </label>

          <button class="signin-btn" type="submit">Sign in</button>
        </form>

        <hr class="card-divider" />
        <p class="register-row">
          Citizen?<a href="<%= request.getContextPath() %>/register"
            >Register here</a
          >
        </p>
      </section>

      <footer class="footer-links">
        <a href="#">Privacy Policy</a>
        <a href="#">Terms of Service</a>
        <a href="#">Help Center</a>
      </footer>
    </main>
  </body>
</html>
