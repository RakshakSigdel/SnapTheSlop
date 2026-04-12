<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.snaptheslop.snaptheslop.user.model.UserDTO" %>
<%
    UserDTO profileUser = (UserDTO) request.getAttribute("profileUser");
    String profileInitials = (String) request.getAttribute("profileInitials");
    if (profileInitials == null) {
        profileInitials = "RY";
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>NagarSewa - My Profile</title>
    <style>
        :root {
            --bg: #f1f2f4;
            --surface: #ffffff;
            --surface-muted: #f7f8fa;
            --border: #d8dde4;
            --text-main: #1f2937;
            --text-muted: #6b7280;
            --primary: #1f63de;
            --primary-soft: #e8f0ff;
            --success: #2fa772;
        }

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            background: var(--bg);
            color: var(--text-main);
            font-family: "Segoe UI", Arial, sans-serif;
        }

        .topbar {
            height: 62px;
            background: var(--surface);
            border-bottom: 1px solid var(--border);
            padding: 0 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .brand-badge {
            width: 22px;
            height: 22px;
            border-radius: 6px;
            background: var(--primary);
            position: relative;
        }

        .brand-badge::after {
            content: "";
            width: 10px;
            height: 10px;
            border-radius: 50%;
            background: #fff;
            position: absolute;
            inset: 6px;
            margin: auto;
        }

        .brand-text {
            line-height: 1.1;
        }

        .brand-title {
            margin: 0;
            font-weight: 700;
            font-size: 15px;
        }

        .brand-subtitle {
            margin: 0;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 1px;
            font-size: 9px;
            font-weight: 600;
        }

        .user-chip {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            border: 1px solid var(--primary);
            color: var(--primary);
            background: #f4f8ff;
            display: grid;
            place-items: center;
            font-size: 11px;
            font-weight: 700;
        }

        .page {
            max-width: 980px;
            margin: 0 auto;
            padding: 18px 16px 24px;
        }

        .breadcrumb {
            margin: 0 0 8px;
            font-size: 12px;
            color: #8a9099;
        }

        .breadcrumb a {
            color: var(--primary);
            text-decoration: none;
        }

        .page-title {
            margin: 0;
            font-size: 40px;
            font-weight: 700;
            letter-spacing: -0.5px;
        }

        .page-subtitle {
            margin: 2px 0 14px;
            color: var(--text-muted);
            font-size: 14px;
        }

        .profile-layout {
            display: grid;
            grid-template-columns: 300px 1fr;
            gap: 16px;
            align-items: start;
        }

        .card {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 12px;
            overflow: visible;
        }

        .left-card {
            padding: 22px 18px;
        }

        .avatar-wrap {
            text-align: center;
            padding-bottom: 12px;
            border-bottom: 1px solid #e6e8ec;
        }

        .avatar {
            width: 96px;
            height: 96px;
            border-radius: 50%;
            border: 2px solid var(--primary);
            margin: 0 auto 10px;
            display: grid;
            place-items: center;
            color: var(--primary);
            font-size: 42px;
            font-weight: 700;
            background: #eff5ff;
            position: relative;
        }

        .avatar-edit {
            position: absolute;
            right: 0;
            bottom: 6px;
            width: 24px;
            height: 24px;
            border-radius: 50%;
            border: 1px solid var(--surface);
            background: var(--primary);
            color: #fff;
            font-size: 12px;
            display: grid;
            place-items: center;
        }

        .name {
            margin: 0;
            font-size: 28px;
            font-weight: 700;
        }

        .role {
            margin: 2px 0 10px;
            color: var(--text-muted);
            font-size: 13px;
        }

        .status {
            display: inline-block;
            border-radius: 999px;
            padding: 6px 12px;
            color: var(--success);
            background: #e6f7ef;
            font-size: 12px;
            font-weight: 700;
        }

        .left-meta {
            margin-top: 14px;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px 18px;
            font-size: 12px;
        }

        .meta-label {
            color: #7d848d;
            margin: 0 0 2px;
        }

        .meta-value {
            margin: 0;
            font-weight: 600;
            white-space: normal;
            overflow-wrap: anywhere;
        }

        .right-card {
            padding: 0;
        }

        .section-head {
            padding: 16px 16px 12px;
            border-bottom: 1px solid #e6e8ec;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 10px;
        }

        .section-head h2 {
            margin: 0;
            font-size: 24px;
        }

        .section-head p {
            margin: 3px 0 0;
            color: var(--text-muted);
            font-size: 12px;
        }

        .edit-btn {
            border: 1px solid #dfe3e9;
            border-radius: 8px;
            padding: 8px 18px;
            background: var(--surface-muted);
            color: #3d4753;
            font-weight: 700;
            cursor: pointer;
        }

        .edit-btn.active {
            background: var(--primary);
            border-color: var(--primary);
            color: #fff;
        }

        .save-btn {
            border: 1px solid var(--primary);
            border-radius: 8px;
            padding: 8px 18px;
            background: var(--primary);
            color: #fff;
            font-weight: 700;
            cursor: pointer;
        }

        .save-btn:disabled {
            background: #b9c7de;
            border-color: #b9c7de;
            cursor: not-allowed;
        }

        .action-buttons {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        .section-body {
            padding: 14px 16px 16px;
        }

        .group-title {
            margin: 0 0 10px;
            color: #8b929a;
            font-size: 11px;
            font-weight: 700;
            letter-spacing: 0.7px;
            text-transform: uppercase;
        }

        .fields-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 12px;
        }

        .field {
            min-width: 0;
        }

        .field label {
            display: block;
            margin-bottom: 6px;
            color: #88909a;
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.7px;
        }

        .input {
            width: 100%;
            min-height: 42px;
            border: 1px solid #d7dbe2;
            border-radius: 7px;
            background: #eceff3;
            padding: 8px 11px;
            display: flex;
            align-items: center;
            gap: 8px;
            color: #2d3640;
            font-size: 14px;
            line-height: 1.3;
            white-space: normal;
            overflow-wrap: anywhere;
        }

        .input svg {
            width: 14px;
            height: 14px;
            flex-shrink: 0;
            fill: #8f97a1;
        }

        .editable-field {
            outline: none;
            border-radius: 4px;
            padding: 0 2px;
        }

        .editable-field.is-placeholder {
            color: #8b929a;
        }

        .edit-mode .editable-field[contenteditable="true"] {
            background: #fff;
            box-shadow: inset 0 0 0 1px #bfd2f8;
        }

        .single-line-row {
            grid-column: 1 / -1;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
        }

        .divider {
            margin: 14px 0;
            border: 0;
            border-top: 1px solid #e5e8ec;
        }

        @media (max-width: 920px) {
            .profile-layout {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 640px) {
            .page-title {
                font-size: 32px;
            }

            .fields-grid {
                grid-template-columns: 1fr;
            }

            .single-line-row {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<header class="topbar">
    <div class="brand">
        <div class="brand-badge" aria-hidden="true"></div>
        <div class="brand-text">
            <p class="brand-title">NagarSewa</p>
            <p class="brand-subtitle">Municipal Governance Portal</p>
        </div>
    </div>
    <div class="user-chip editable-field" contenteditable="false" data-field="initials" aria-label="Current user initials"><%= profileInitials %></div>
</header>

<main class="page">
    <p class="breadcrumb"><a href="#">Dashboard</a> / My Profile</p>
    <h1 class="page-title">My Profile</h1>
    <p class="page-subtitle">Manage your personal information and municipal details</p>

    <section class="profile-layout">
        <aside class="card left-card">
            <div class="avatar-wrap">
                <div class="avatar" aria-hidden="true">
                    <span class="editable-field" contenteditable="false" data-field="initials"><%= profileInitials %></span>
                    <span class="avatar-edit">e</span>
                </div>
                <h2 class="name editable-field" contenteditable="false" data-field="fullName"><%= profileUser != null ? profileUser.getFirstName() + " " + profileUser.getLastName() : "User Name" %></h2>
                <p class="role editable-field" contenteditable="false" data-field="role"><%= profileUser != null ? profileUser.getRole() : "Registered Citizen" %></p>
                <span class="status editable-field" contenteditable="false" data-field="accountStatus"><%= profileUser != null ? profileUser.getAccountStatus() : "Verified Account" %></span>
            </div>

            <div class="left-meta">
                <div>
                    <p class="meta-label">Municipality</p>
                    <p class="meta-value editable-field" contenteditable="false" data-field="municipality"><%= profileUser != null ? profileUser.getMunicipality() : "Janakpur Sub-Metropolitan City" %></p>
                </div>
                <div>
                    <p class="meta-label">Ward No.</p>
                    <p class="meta-value editable-field" contenteditable="false" data-field="wardNo"><%= profileUser != null ? profileUser.getWardNo() : "Ward No. 7" %></p>
                </div>
                <div>
                    <p class="meta-label">Member Since</p>
                    <p class="meta-value editable-field" contenteditable="false" data-field="memberSince"><%= profileUser != null ? profileUser.getMemberSince() : "Jan 2023" %></p>
                </div>
                <div>
                    <p class="meta-label">User ID</p>
                    <p class="meta-value editable-field" contenteditable="false" data-field="userId"><%= profileUser != null ? profileUser.getUserId() : "NS-2024-007841" %></p>
                </div>
            </div>
        </aside>

        <article class="card right-card">
            <div class="section-head">
                <div>
                    <h2>Personal Information</h2>
                    <p>Your registered details with the municipality</p>
                </div>
                <div class="action-buttons">
                    <button type="button" class="edit-btn" id="editToggleBtn" aria-pressed="false">Edit</button>
                    <button type="button" class="save-btn" id="saveProfileBtn" disabled>Save</button>
                </div>
            </div>

            <div class="section-body">
                <p class="group-title">Personal Details</p>
                <div class="fields-grid">
                    <div class="field">
                        <label>First Name</label>
                        <div class="input"><span class="editable-field" contenteditable="false" data-field="firstName"><%= profileUser != null ? profileUser.getFirstName() : "Ramesh" %></span></div>
                    </div>

                    <div class="single-line-row">
                        <div class="field">
                            <label>Last Name</label>
                            <div class="input"><span class="editable-field" contenteditable="false" data-field="lastName"><%= profileUser != null ? profileUser.getLastName() : "Yadav" %></span></div>
                        </div>
                        <div class="field">
                            <label>Phone Number</label>
                            <div class="input">
                                <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                                    <path d="M6.62 10.79a15.53 15.53 0 006.59 6.59l2.2-2.2a1 1 0 011-.24 11.36 11.36 0 003.57.57 1 1 0 011 1V20a1 1 0 01-1 1A17 17 0 013 6a1 1 0 011-1h3.5a1 1 0 011 1c0 1.23.2 2.42.57 3.57a1 1 0 01-.25 1.02l-2.2 2.2z"></path>
                                </svg>
                                <span class="editable-field" contenteditable="false" data-field="phoneNumber"><%= profileUser != null ? profileUser.getPhoneNumber() : "+977 9841123456" %></span>
                            </div>
                        </div>
                    </div>

                    <div class="field">
                        <label>Email Address</label>
                        <div class="input">
                            <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                                <path d="M20 4H4a2 2 0 00-2 2v12a2 2 0 002 2h16a2 2 0 002-2V6a2 2 0 00-2-2zm0 4l-8 5L4 8V6l8 5 8-5v2z"></path>
                            </svg>
                            <span class="editable-field" contenteditable="false" data-field="email"><%= profileUser != null ? profileUser.getEmail() : "ramesh.yadav@municipality.gov.np" %></span>
                        </div>
                    </div>
                </div>

                <hr class="divider" />

                <p class="group-title">Municipal Details</p>
                <div class="fields-grid">
                    <div class="field" style="grid-column: 1 / -1;">
                        <label>Allocated Municipality</label>
                        <div class="input">
                            <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                                <path d="M12 2l9 4v2H3V6l9-4zm7 8v9h2v2H3v-2h2v-9h2v9h2v-9h2v9h2v-9h2v9h2v-9h2z"></path>
                            </svg>
                            <span class="editable-field" contenteditable="false" data-field="municipality"><%= profileUser != null ? profileUser.getMunicipality() : "Janakpur Sub-Metropolitan City" %></span>
                        </div>
                    </div>
                    <div class="field">
                        <label>Ward No.</label>
                        <div class="input">
                            <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                                <path d="M12 2a8 8 0 00-8 8c0 5.25 8 12 8 12s8-6.75 8-12a8 8 0 00-8-8zm0 11a3 3 0 110-6 3 3 0 010 6z"></path>
                            </svg>
                            <span class="editable-field" contenteditable="false" data-field="wardNo"><%= profileUser != null ? profileUser.getWardNo() : "Ward No. 7" %></span>
                        </div>
                    </div>
                    <div class="field">
                        <label>Province</label>
                        <div class="input"><span class="editable-field" contenteditable="false" data-field="province"><%= profileUser != null ? profileUser.getProvince() : "Madhesh Province" %></span></div>
                    </div>
                </div>
            </div>
        </article>
    </section>
</main>
<script>
    (function () {
        var editButton = document.getElementById("editToggleBtn");
        var saveButton = document.getElementById("saveProfileBtn");
        var editableFields = document.querySelectorAll(".editable-field");
        var isEditMode = false;
        var STORAGE_KEY = "snaptheslop.profileDraft";

        if (!editButton || !saveButton || editableFields.length === 0) {
            return;
        }

        function getFieldsByKey(key) {
            return document.querySelectorAll('[data-field="' + key + '"]');
        }

        function setFieldText(key, value) {
            var nodes = getFieldsByKey(key);
            Array.prototype.forEach.call(nodes, function (node) {
                node.textContent = value;
                node.classList.toggle("is-placeholder", !value || !value.trim());
            });
        }

        function collectProfileData() {
            var data = {};
            var seen = {};

            Array.prototype.forEach.call(editableFields, function (field) {
                var key = field.getAttribute("data-field");
                if (!key || seen[key]) {
                    return;
                }

                seen[key] = true;
                data[key] = getFieldsByKey(key)[0].textContent.trim();
            });

            return data;
        }

        function applySavedProfile() {
            try {
                var saved = JSON.parse(localStorage.getItem(STORAGE_KEY) || "{}");
                Object.keys(saved).forEach(function (key) {
                    setFieldText(key, saved[key]);
                });
            } catch (e) {
                // ignore invalid localStorage data
            }
        }

        function setEditMode(enabled) {
            isEditMode = enabled;
            document.body.classList.toggle("edit-mode", enabled);
            editButton.classList.toggle("active", enabled);
            editButton.textContent = enabled ? "Done" : "Edit";
            editButton.setAttribute("aria-pressed", String(enabled));
            saveButton.disabled = !enabled;

            Array.prototype.forEach.call(editableFields, function (field) {
                field.setAttribute("contenteditable", String(enabled));
            });
        }

        function saveProfile() {
            if (!isEditMode) {
                return;
            }

            var data = collectProfileData();
            localStorage.setItem(STORAGE_KEY, JSON.stringify(data));
            setEditMode(false);
            saveButton.textContent = "Saved";

            window.setTimeout(function () {
                saveButton.textContent = "Save";
            }, 1000);
        }

        applySavedProfile();
        setEditMode(false);

        editButton.addEventListener("click", function () {
            setEditMode(!isEditMode);
        });

        saveButton.addEventListener("click", function () {
            saveProfile();
        });
    })();
</script>
</body>
</html>
