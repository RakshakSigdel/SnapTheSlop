<%--
  Report Issue — NagarSewa
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.snaptheslop.snaptheslop.issue.model.Issue" %>
<%@ page import="com.snaptheslop.snaptheslop.user.model.User" %>
<jsp:include page="../common/header.jsp"/>

<%
  Issue editIssue = (Issue) request.getAttribute("issue");
  boolean editMode = request.getAttribute("editMode") != null && Boolean.TRUE.equals(request.getAttribute("editMode"));

  String prevTitle = (String) request.getAttribute("prevTitle");
  String prevCategory = (String) request.getAttribute("prevCategory");
  String prevLocation = (String) request.getAttribute("prevLocation");
  String prevDescription = (String) request.getAttribute("prevDescription");
  String selectedWardNo = request.getAttribute("selectedWardNo") != null ? String.valueOf(request.getAttribute("selectedWardNo")) : "";
  String existingImagePath = (String) request.getAttribute("existingImagePath");

  String reportMunicipalityName = (String) request.getAttribute("reportMunicipalityName");
  if ((reportMunicipalityName == null || reportMunicipalityName.isBlank()) && editIssue != null && editIssue.getMunicipalityName() != null) {
    reportMunicipalityName = editIssue.getMunicipalityName();
  }

  if (reportMunicipalityName == null) {
    User loggedInUser = (User) session.getAttribute("loggedInUser");
    if (loggedInUser != null) {
      reportMunicipalityName = loggedInUser.getMunicipality();
    }
  }

  String titleValue = editMode && editIssue != null && editIssue.getTitle() != null ? editIssue.getTitle() : (prevTitle != null ? prevTitle : "");
  String categoryValue = editMode && editIssue != null && editIssue.getCategory() != null ? editIssue.getCategory() : (prevCategory != null ? prevCategory : "");
  String locationValue = editMode && editIssue != null && editIssue.getLocation() != null ? editIssue.getLocation() : (prevLocation != null ? prevLocation : "");
  String descriptionValue = editMode && editIssue != null && editIssue.getDescription() != null ? editIssue.getDescription() : (prevDescription != null ? prevDescription : "");
  if (selectedWardNo == null || selectedWardNo.isBlank()) {
    selectedWardNo = editMode && editIssue != null ? String.valueOf(editIssue.getWardNo()) : "";
  }

  String formAction = editMode ? request.getContextPath() + "/citizen/issue-edit" : request.getContextPath() + "/citizen/report-issue";
  String submitLabel = editMode ? "Save Changes" : "Submit Report";
  String pageHeading = editMode ? "Edit Issue" : "Report an Issue";
  String pageDescription = editMode ? "Update the details for your report before saving changes." : "Tell us what needs fixing. Be as specific as you can — it helps us respond faster.";
%>

<div class="flex min-h-screen">
  <jsp:include page="../common/citizen-sidebar.jsp"/>

  <div class="flex-1" style="margin-left:220px; background:#f8fafc; min-height:100vh;">

    <div style="padding:18px 32px; border-bottom:1px solid #e2e8f0; background:#fff;">
      <nav style="display:flex; align-items:center; gap:6px; font-size:13px; color:#94a3b8;">
        <a href="<%= request.getContextPath() %>/citizen/dashboard" style="color:#64748b; text-decoration:none;">Dashboard</a>
        <span>/</span>
        <a href="<%= request.getContextPath() %>/citizen/my-issues" style="color:#64748b; text-decoration:none;">My Issues</a>
        <span>/</span>
        <span style="color:#0f172a; font-weight:600;"><%= editMode ? "Edit Report" : "New Report" %></span>
      </nav>
    </div>

    <div style="padding:32px; max-width:760px; margin:0 auto; width:100%;">

      <h1 style="font-family:'Outfit',sans-serif; font-size:24px; font-weight:800; color:#0f172a; margin-bottom:6px;"><%= pageHeading %></h1>
      <p style="font-size:14px; color:#64748b; margin-bottom:28px;"><%= pageDescription %></p>

      <% if (request.getAttribute("errorMessage") != null) { %>
      <div style="background:#fef2f2; color:#dc2626; padding:12px 14px; border-radius:8px; margin-bottom:20px; font-size:13px; border:1px solid #fecaca;">
        <%= request.getAttribute("errorMessage") %>
      </div>
      <% } %>

      <form action="<%= formAction %>" method="post" enctype="multipart/form-data" id="reportForm">
        <% if (editMode && editIssue != null) { %>
        <input type="hidden" name="issueId" value="<%= editIssue.getId() %>"/>
        <% } %>

        <!-- Title -->
        <div style="margin-bottom:20px;">
          <label style="display:block; font-size:13px; font-weight:600; color:#374151; margin-bottom:6px;">What's the problem? <span style="color:#dc2626;">*</span></label>
          <input type="text" name="title" id="title" required placeholder="e.g. Broken streetlight near Ratna Park" value="<%= titleValue != null ? titleValue : "" %>"
                 style="width:100%; height:44px; border:1.5px solid #e5e7eb; border-radius:8px; padding:0 14px; font-size:14px; color:#111827; background:#fff; outline:none; font-family:'Inter',sans-serif;"/>
        </div>

        <!-- Category + Municipality -->
        <div style="display:grid; grid-template-columns:1fr 1fr; gap:14px; margin-bottom:20px;">
          <div>
            <label style="display:block; font-size:13px; font-weight:600; color:#374151; margin-bottom:6px;">Category <span style="color:#dc2626;">*</span></label>
            <select name="category" id="category" required
                    style="width:100%; height:44px; border:1.5px solid #e5e7eb; border-radius:8px; padding:0 12px; font-size:14px; color:#111827; background:#fff; outline:none; appearance:none; cursor:pointer; font-family:'Inter',sans-serif;">
              <option value="" disabled <%= (categoryValue == null || categoryValue.isBlank()) ? "selected" : "" %>>Pick one</option>
              <option value="Roads Potholes" <%= "Roads Potholes".equals(categoryValue) ? "selected" : "" %>>Roads & Potholes</option>
              <option value="Waste Management" <%= "Waste Management".equals(categoryValue) ? "selected" : "" %>>Waste Management</option>
              <option value="Water Supply" <%= "Water Supply".equals(categoryValue) ? "selected" : "" %>>Water Supply</option>
              <option value="Electricity" <%= "Electricity".equals(categoryValue) ? "selected" : "" %>>Electricity</option>
              <option value="Drainage" <%= "Drainage".equals(categoryValue) ? "selected" : "" %>>Drainage & Sewage</option>
              <option value="Street Lighting" <%= "Street Lighting".equals(categoryValue) ? "selected" : "" %>>Street Lighting</option>
              <option value="Public Safety" <%= "Public Safety".equals(categoryValue) ? "selected" : "" %>>Public Safety</option>
              <option value="Sanitation" <%= "Sanitation".equals(categoryValue) ? "selected" : "" %>>Sanitation</option>
              <option value="Other" <%= "Other".equals(categoryValue) ? "selected" : "" %>>Other</option>
            </select>
          </div>
          <div>
            <label style="display:block; font-size:13px; font-weight:600; color:#374151; margin-bottom:6px;">Municipality <span style="color:#dc2626;">*</span></label>
            <input type="text" id="municipality" value="<%= reportMunicipalityName != null ? reportMunicipalityName : "" %>" readonly
                   style="width:100%; height:44px; border:1.5px solid #e5e7eb; border-radius:8px; padding:0 12px; font-size:14px; color:#111827; background:#f8fafc; outline:none; font-family:'Inter',sans-serif; cursor:not-allowed;"/>
            <input type="hidden" name="municipality" value="<%= reportMunicipalityName != null ? reportMunicipalityName : "" %>"/>
            <p style="margin-top:6px; font-size:12px; color:#64748b;">
              Municipality is taken from your profile. To change it here, update your municipality in Profile first.
            </p>
          </div>
        </div>

        <!-- Ward -->
        <div style="margin-bottom:20px;">
          <div>
            <label style="display:block; font-size:13px; font-weight:600; color:#374151; margin-bottom:6px;">Ward <span style="color:#dc2626;">*</span></label>
            <select name="ward" id="ward" required
                    style="width:100%; height:44px; border:1.5px solid #e5e7eb; border-radius:8px; padding:0 12px; font-size:14px; color:#111827; background:#fff; outline:none; appearance:none; cursor:pointer; font-family:'Inter',sans-serif;">
              <option value="" disabled <%= (selectedWardNo == null || selectedWardNo.isBlank()) ? "selected" : "" %>>Select municipality first</option>
            </select>
          </div>
        </div>

        <!-- Location -->
        <div style="margin-bottom:20px;">
          <label style="display:block; font-size:13px; font-weight:600; color:#374151; margin-bottom:6px;">Location <span style="color:#dc2626;">*</span></label>
          <input type="text" name="location" id="location" required placeholder="Landmark, street, or tole name" value="<%= locationValue != null ? locationValue : "" %>"
                 style="width:100%; height:44px; border:1.5px solid #e5e7eb; border-radius:8px; padding:0 14px; font-size:14px; color:#111827; background:#fff; outline:none; font-family:'Inter',sans-serif;"/>
        </div>

        <!-- Description -->
        <div style="margin-bottom:20px;">
          <label style="display:block; font-size:13px; font-weight:600; color:#374151; margin-bottom:6px;">Details <span style="color:#dc2626;">*</span></label>
          <textarea name="description" id="description" rows="4" required placeholder="When did this start? How bad is it? Any danger to people?"
                    style="width:100%; border:1.5px solid #e5e7eb; border-radius:8px; padding:12px 14px; font-size:14px; color:#111827; background:#fff; outline:none; resize:vertical; font-family:'Inter',sans-serif; line-height:1.6;"><%= descriptionValue != null ? descriptionValue : "" %></textarea>
        </div>

        <!-- Photo Upload -->
        <div style="margin-bottom:28px;">
          <label style="display:block; font-size:13px; font-weight:600; color:#374151; margin-bottom:6px;">Photo <span style="font-weight:400; color:#94a3b8;"><%= editMode ? "(leave blank to keep current photo)" : "(optional but helps a lot)" %></span></label>
          <div id="dropZone" style="border:1.5px dashed #d1d5db; border-radius:8px; padding:28px; text-align:center; cursor:pointer; transition:border-color 0.2s;">
            <input type="file" name="image" id="imageInput" accept="image/*" style="display:none;" form="reportForm"/>
            <svg width="28" height="28" fill="none" stroke="#94a3b8" stroke-width="1.5" viewBox="0 0 24 24" style="margin:0 auto 8px;"><path stroke-linecap="round" stroke-linejoin="round" d="M3 9a2 2 0 012-2h.93a2 2 0 001.664-.89l.812-1.22A2 2 0 0110.07 4h3.86a2 2 0 011.664.89l.812 1.22A2 2 0 0018.07 7H19a2 2 0 012 2v9a2 2 0 01-2 2H5a2 2 0 01-2-2V9z"/><path stroke-linecap="round" stroke-linejoin="round" d="M15 13a3 3 0 11-6 0 3 3 0 016 0z"/></svg>
            <p style="font-size:13px; color:#64748b; margin-bottom:4px;">Click to upload or drag & drop</p>
            <p style="font-size:12px; color:#94a3b8;">JPEG or PNG, up to 10 MB</p>
          </div>
          <% if (editMode && existingImagePath != null && !existingImagePath.isBlank()) { %>
          <div style="margin-top:10px; padding:10px; border:1px solid #e2e8f0; border-radius:8px; background:#fff;">
            <p style="font-size:12px; color:#64748b; margin:0 0 6px;">Current photo</p>
            <img src="<%= request.getContextPath() + existingImagePath %>" alt="Current issue photo" style="width:100%; max-height:140px; object-fit:cover; border-radius:6px; border:1px solid #e2e8f0;"/>
          </div>
          <% } %>
          <div id="imagePreview" style="display:none; margin-top:10px;">
            <img id="previewImg" src="#" alt="" style="width:100%; max-height:120px; object-fit:cover; border-radius:8px; border:1px solid #e2e8f0;"/>
            <p id="fileName" style="font-size:12px; color:#64748b; margin-top:4px;"></p>
          </div>
        </div>

        <!-- Buttons -->
        <div style="display:flex; align-items:center; gap:12px;">
          <button type="submit" style="background:#059669; color:#fff; border:none; font-weight:600; font-size:14px; padding:11px 24px; border-radius:8px; cursor:pointer; font-family:'Inter',sans-serif;">
            <%= submitLabel %>
          </button>
          <a href="<%= request.getContextPath() %>/citizen/dashboard" style="font-size:14px; font-weight:500; color:#64748b; text-decoration:none;">Cancel</a>
        </div>
      </form>
    </div>
  </div>
</div>

<script>
  var contextPath = '<%= request.getContextPath() %>';
  var loggedInMunicipality = '<%= reportMunicipalityName != null ? reportMunicipalityName.replace("\\", "\\\\").replace("'", "\\'") : "" %>';
  var selectedWardNo = '<%= selectedWardNo != null ? selectedWardNo.replace("\\", "\\\\").replace("'", "\\'") : "" %>';
  var dropZone = document.getElementById('dropZone');
  var imageInput = document.getElementById('imageInput');
  dropZone.addEventListener('click', function() { imageInput.click(); });
  var ward = document.getElementById('ward');

  function setWardPlaceholder(text) {
    ward.innerHTML = '';
    var defaultOption = document.createElement('option');
    defaultOption.value = '';
    defaultOption.disabled = true;
    defaultOption.selected = true;
    defaultOption.textContent = text;
    ward.appendChild(defaultOption);
  }

  function populateWards() {
    if (!loggedInMunicipality) {
      setWardPlaceholder('Your municipality is not configured');
      return;
    }

    setWardPlaceholder('Loading wards...');

    fetch(contextPath + '/wards')
      .then(function(response) {
        if (!response.ok) {
          return response.json().then(function(payload) {
            throw new Error((payload && payload.message) ? payload.message : 'Failed to load wards');
          }).catch(function() {
            throw new Error('Failed to load wards');
          });
        }
        return response.json();
      })
      .then(function(wards) {
        setWardPlaceholder(wards.length > 0 ? 'Select ward' : 'No wards available');
        wards.forEach(function(wardItem) {
          var wardLabel = 'Ward ' + String(wardItem.wardNumber).padStart(2, '0');
          var option = document.createElement('option');
          option.value = String(wardItem.wardNumber);
          option.textContent = wardLabel;
          ward.appendChild(option);
        });
        if (selectedWardNo) {
          ward.value = selectedWardNo;
        }
      })
      .catch(function(error) {
        setWardPlaceholder(error && error.message ? error.message : 'Unable to load wards');
      });
  }

  populateWards();

  dropZone.addEventListener('dragover', function(e) { e.preventDefault(); dropZone.style.borderColor='#059669'; });
  dropZone.addEventListener('dragleave', function() { dropZone.style.borderColor='#d1d5db'; });
  dropZone.addEventListener('drop', function(e) { e.preventDefault(); dropZone.style.borderColor='#d1d5db'; if(e.dataTransfer.files[0]) showPreview(e.dataTransfer.files[0]); });
  imageInput.addEventListener('change', function() { if(imageInput.files[0]) showPreview(imageInput.files[0]); });
  function showPreview(file) {
    var r = new FileReader(); r.onload = function(e) { document.getElementById('previewImg').src=e.target.result; };
    r.readAsDataURL(file); document.getElementById('fileName').textContent=file.name; document.getElementById('imagePreview').style.display='block';
  }
</script>
</body>
</html>
