<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	String fullName = request.getParameter("fullName") != null ? request.getParameter("fullName") : "";
	String email = request.getParameter("email") != null ? request.getParameter("email") : "";
	String phone = request.getParameter("phone") != null ? request.getParameter("phone") : "";
	String wardNumber = request.getParameter("wardNumber") != null ? request.getParameter("wardNumber") : "";
	String municipality = request.getParameter("municipality") != null ? request.getParameter("municipality") : "";

	String formError = (String) request.getAttribute("error");
	String formSuccess = (String) request.getAttribute("success");

	List<String> municipalityOptions = (List<String>) request.getAttribute("municipalityOptions");
	if (municipalityOptions == null || municipalityOptions.isEmpty()) {
		municipalityOptions = new ArrayList<>();
		municipalityOptions.add("Kathmandu Metropolitan City");
		municipalityOptions.add("Lalitpur Metropolitan City");
		municipalityOptions.add("Bhaktapur Municipality");
		municipalityOptions.add("Kirtipur Municipality");
	}
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<title>NagarSewa - Create Account</title>
	<style>
		:root {
			--bg: #ececec;
			--card: #ffffff;
			--text-primary: #2d2f33;
			--text-muted: #7d828a;
			--border: #e6e8ec;
			--brand: #0f5edb;
			--brand-hover: #0b50be;
			--shadow: 0 10px 26px rgba(15, 32, 62, 0.08);
			--danger-bg: #fff1f1;
			--danger-text: #b3261e;
			--success-bg: #edf9f0;
			--success-text: #1b7a38;
		}

		* {
			box-sizing: border-box;
		}

		body {
			margin: 0;
			font-family: "Segoe UI", "Helvetica Neue", Arial, sans-serif;
			background:
				radial-gradient(circle at top left, rgba(255, 255, 255, 0.9) 0%, rgba(236, 236, 236, 0) 45%),
				radial-gradient(circle at bottom right, rgba(215, 223, 236, 0.45) 0%, rgba(236, 236, 236, 0) 52%),
				var(--bg);
			color: var(--text-primary);
			min-height: 100vh;
			display: flex;
			align-items: center;
			justify-content: center;
			padding: 22px;
		}

		.page-wrap {
			width: 100%;
			max-width: 430px;
			text-align: center;
		}

		.brand {
			margin-bottom: 18px;
		}

		.brand-badge {
			width: 30px;
			height: 30px;
			margin: 0 auto 8px;
			border-radius: 7px;
			background: var(--brand);
			display: grid;
			place-items: center;
			color: #fff;
			font-weight: 700;
			box-shadow: var(--shadow);
			font-size: 13px;
		}

		.brand h1 {
			margin: 0;
			font-size: 32px;
			font-weight: 700;
			letter-spacing: -0.6px;
		}

		.brand p {
			margin: 5px 0 0;
			color: var(--text-muted);
			font-size: 13px;
		}

		.card {
			margin-top: 12px;
			background: var(--card);
			border-radius: 8px;
			box-shadow: var(--shadow);
			padding: 22px;
			text-align: left;
		}

		.card h2 {
			margin: 0;
			font-size: 30px;
			line-height: 1.2;
			letter-spacing: -0.3px;
		}

		.card .sub {
			margin: 7px 0 18px;
			font-size: 13px;
			color: var(--text-muted);
			font-weight: 600;
		}

		.alert {
			border-radius: 8px;
			padding: 10px 12px;
			font-size: 13px;
			margin-bottom: 14px;
		}

		.alert.error {
			background: var(--danger-bg);
			color: var(--danger-text);
			border: 1px solid #ffd4d1;
		}

		.alert.success {
			background: var(--success-bg);
			color: var(--success-text);
			border: 1px solid #c8e8d2;
		}

		.grid {
			display: grid;
			grid-template-columns: 1fr 1fr;
			gap: 13px;
		}

		.field {
			margin-bottom: 2px;
		}

		label {
			display: block;
			font-size: 10px;
			letter-spacing: 0.6px;
			color: #737882;
			text-transform: uppercase;
			margin-bottom: 6px;
			font-weight: 700;
		}

		input,
		select {
			width: 100%;
			border: 1px solid var(--border);
			border-radius: 6px;
			height: 40px;
			padding: 0 12px;
			font-size: 13px;
			color: var(--text-primary);
			background: #f8f9fb;
			outline: none;
			transition: border-color 0.2s ease, box-shadow 0.2s ease;
		}

		input:focus,
		select:focus {
			border-color: #9ab8f0;
			box-shadow: 0 0 0 3px rgba(15, 94, 219, 0.12);
			background: #fff;
		}

		.divider {
			border: 0;
			border-top: 1px solid var(--border);
			margin: 14px 0;
		}

		.tos {
			margin-top: 2px;
			margin-bottom: 16px;
			display: grid;
			grid-template-columns: 16px 1fr;
			gap: 9px;
			align-items: start;
			font-size: 12px;
			color: #7a8088;
			line-height: 1.4;
		}

		.tos input {
			width: 14px;
			height: 14px;
			margin-top: 2px;
			accent-color: var(--brand);
		}

		.tos a,
		.signin a {
			color: var(--brand);
			text-decoration: none;
			font-weight: 600;
		}

		.btn {
			width: 100%;
			border: 0;
			border-radius: 7px;
			height: 43px;
			background: linear-gradient(180deg, #1465e4 0%, #0f5edb 100%);
			color: #fff;
			font-size: 15px;
			font-weight: 700;
			letter-spacing: 0.2px;
			cursor: pointer;
			transition: transform 0.18s ease, box-shadow 0.18s ease, background 0.18s ease;
			box-shadow: 0 8px 14px rgba(15, 94, 219, 0.28);
		}

		.btn:hover {
			background: linear-gradient(180deg, #115cd1 0%, #0b50be 100%);
			transform: translateY(-1px);
		}

		.btn:active {
			transform: translateY(0);
		}

		.signin {
			margin-top: 13px;
			text-align: center;
			color: #7a8088;
			font-size: 13px;
		}

		.footer-links {
			text-align: center;
			margin-top: 16px;
			color: #8f959e;
			letter-spacing: 1px;
			font-size: 10px;
			text-transform: uppercase;
		}

		.footer-links span {
			padding: 0 9px;
			opacity: 0.5;
		}

		@media (max-width: 680px) {
			.brand h1,
			.card h2 {
				font-size: 28px;
			}

			.card {
				padding: 18px;
			}

			.grid {
				grid-template-columns: 1fr;
				gap: 12px;
			}

			.footer-links {
				letter-spacing: 0.6px;
				font-size: 9px;
			}
		}
	</style>
</head>
<body>
<main class="page-wrap">
	<section class="brand" aria-label="NagarSewa brand">
		<div class="brand-badge">N</div>
		<h1>NagarSewa</h1>
		<p>Join your local municipal digital network</p>
	</section>

	<section class="card" aria-label="Registration form container">
		<h2>Create Citizen Account</h2>
		<p class="sub">Provide your details to register as a verified resident.</p>

		<% if (formError != null && !formError.trim().isEmpty()) { %>
		<div class="alert error" role="alert"><%= formError %></div>
		<% } %>

		<% if (formSuccess != null && !formSuccess.trim().isEmpty()) { %>
		<div class="alert success" role="status"><%= formSuccess %></div>
		<% } %>

		<form method="post" action="<%= request.getContextPath() %>/register" novalidate>
			<div class="grid">
				<div class="field">
					<label for="fullName">Full Name</label>
					<input id="fullName" name="fullName" type="text" maxlength="100" placeholder="John Doe" value="<%= fullName %>" required />
				</div>

				<div class="field">
					<label for="email">Email</label>
					<input id="email" name="email" type="email" maxlength="120" placeholder="john@example.com" value="<%= email %>" required />
				</div>

				<div class="field">
					<label for="phone">Phone Number</label>
					<input id="phone" name="phone" type="tel" maxlength="18" placeholder="+1 (555) 000-0000" value="<%= phone %>" />
				</div>

				<div class="field">
					<label for="municipality">Municipality</label>
					<select id="municipality" name="municipality" required>
						<option value="">Select Municipality</option>
						<% for (String option : municipalityOptions) {
							String selected = option.equals(municipality) ? "selected" : "";
						%>
							<option value="<%= option %>" <%= selected %>><%= option %></option>
						<% } %>
					</select>
				</div>

				<div class="field">
					<label for="wardNumber">Ward Number</label>
					<input id="wardNumber" name="wardNumber" type="text" maxlength="2" placeholder="e.g. 05" value="<%= wardNumber %>" />
				</div>
			</div>

			<hr class="divider" />

			<div class="grid">
				<div class="field">
					<label for="password">Password</label>
					<input id="password" name="password" type="password" minlength="8" placeholder="********" required />
				</div>

				<div class="field">
					<label for="confirmPassword">Confirm Password</label>
					<input id="confirmPassword" name="confirmPassword" type="password" minlength="8" placeholder="********" required />
				</div>
			</div>

			<label class="tos" for="agreeToTerms">
				<input type="checkbox" id="agreeToTerms" name="agreeToTerms" required />
				<span>By creating an account, I agree to the <a href="#">Terms of Service</a> and <a href="#">Privacy Policy</a> of NagarSewa.</span>
			</label>

			<button type="submit" class="btn">Create Account &rarr;</button>
		</form>

		<p class="signin">Already have an account? <a href="<%= request.getContextPath() %>/login">Sign in</a></p>
	</section>

	<div class="footer-links">Help Center <span>*</span> Accessibility <span>*</span> Safety</div>
</main>

<script>
	(function () {
		var wardInput = document.getElementById("wardNumber");
		var phoneInput = document.getElementById("phone");

		if (wardInput) {
			wardInput.addEventListener("input", function () {
				var digits = this.value.replace(/\D/g, "").slice(0, 2);
				this.value = digits;
			});
		}

		if (phoneInput) {
			phoneInput.addEventListener("input", function () {
				this.value = this.value.replace(/[^0-9+()\-\s]/g, "").slice(0, 18);
			});
		}
	})();
</script>
</body>
</html>
