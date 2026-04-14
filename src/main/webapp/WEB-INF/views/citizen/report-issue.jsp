<%--
  Report Issue — NagarSewa
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setAttribute("activePage", "issue-reports"); %>
<jsp:include page="../common/header.jsp"/>

<div class="flex min-h-screen">
  <jsp:include page="../common/citizen-sidebar.jsp"/>

  <div class="flex-1" style="margin-left:220px; background:#f8fafc; min-height:100vh;">

    <div style="padding:18px 32px; border-bottom:1px solid #e2e8f0; background:#fff;">
      <nav style="display:flex; align-items:center; gap:6px; font-size:13px; color:#94a3b8;">
        <a href="<%= request.getContextPath() %>/citizen/dashboard" style="color:#64748b; text-decoration:none;">Dashboard</a>
        <span>/</span>
        <a href="<%= request.getContextPath() %>/citizen/my-issues" style="color:#64748b; text-decoration:none;">My Issues</a>
        <span>/</span>
        <span style="color:#0f172a; font-weight:600;">New Report</span>
      </nav>
    </div>

    <div style="padding:32px; max-width:680px;">

      <h1 style="font-family:'Outfit',sans-serif; font-size:24px; font-weight:800; color:#0f172a; margin-bottom:6px;">Report an Issue</h1>
      <p style="font-size:14px; color:#64748b; margin-bottom:28px;">Tell us what needs fixing. Be as specific as you can — it helps us respond faster.</p>

      <% if (request.getAttribute("errorMessage") != null) { %>
      <div style="background:#fef2f2; color:#dc2626; padding:12px 14px; border-radius:8px; margin-bottom:20px; font-size:13px; border:1px solid #fecaca;">
        <%= request.getAttribute("errorMessage") %>
      </div>
      <% } %>

      <form action="<%= request.getContextPath() %>/issue/create" method="post" enctype="multipart/form-data" id="reportForm">

        <!-- Title -->
        <div style="margin-bottom:20px;">
          <label style="display:block; font-size:13px; font-weight:600; color:#374151; margin-bottom:6px;">What's the problem? <span style="color:#dc2626;">*</span></label>
          <input type="text" name="title" id="title" required placeholder="e.g. Broken streetlight near Ratna Park"
                 style="width:100%; height:44px; border:1.5px solid #e5e7eb; border-radius:8px; padding:0 14px; font-size:14px; color:#111827; background:#fff; outline:none; font-family:'Inter',sans-serif;"/>
        </div>

        <!-- Category + Ward -->
        <div style="display:grid; grid-template-columns:1fr 1fr; gap:14px; margin-bottom:20px;">
          <div>
            <label style="display:block; font-size:13px; font-weight:600; color:#374151; margin-bottom:6px;">Category <span style="color:#dc2626;">*</span></label>
            <select name="category" id="category" required
                    style="width:100%; height:44px; border:1.5px solid #e5e7eb; border-radius:8px; padding:0 12px; font-size:14px; color:#111827; background:#fff; outline:none; appearance:none; cursor:pointer; font-family:'Inter',sans-serif;">
              <option value="" disabled selected>Pick one</option>
              <option value="Roads Potholes">Roads & Potholes</option>
              <option value="Waste Management">Waste Management</option>
              <option value="Water Supply">Water Supply</option>
              <option value="Electricity">Electricity</option>
              <option value="Drainage">Drainage & Sewage</option>
              <option value="Street Lighting">Street Lighting</option>
              <option value="Public Safety">Public Safety</option>
              <option value="Sanitation">Sanitation</option>
              <option value="Other">Other</option>
            </select>
          </div>
          <div>
            <label style="display:block; font-size:13px; font-weight:600; color:#374151; margin-bottom:6px;">Ward <span style="color:#dc2626;">*</span></label>
            <select name="ward" id="ward" required
                    style="width:100%; height:44px; border:1.5px solid #e5e7eb; border-radius:8px; padding:0 12px; font-size:14px; color:#111827; background:#fff; outline:none; appearance:none; cursor:pointer; font-family:'Inter',sans-serif;">
              <option value="" disabled selected>Select</option>
              <option value="Ward 01">Ward 01</option>
              <option value="Ward 02">Ward 02</option>
              <option value="Ward 03">Ward 03</option>
              <option value="Ward 04">Ward 04</option>
              <option value="Ward 05">Ward 05</option>
              <option value="Ward 06">Ward 06</option>
              <option value="Ward 07">Ward 07</option>
              <option value="Ward 08">Ward 08</option>
              <option value="Ward 09">Ward 09</option>
              <option value="Ward 10">Ward 10</option>
              <option value="Ward 11">Ward 11</option>
              <option value="Ward 12">Ward 12</option>
              <option value="Ward 13">Ward 13</option>
              <option value="Ward 14">Ward 14</option>
              <option value="Ward 15">Ward 15</option>
            </select>
          </div>
        </div>

        <!-- Location -->
        <div style="margin-bottom:20px;">
          <label style="display:block; font-size:13px; font-weight:600; color:#374151; margin-bottom:6px;">Location <span style="color:#dc2626;">*</span></label>
          <input type="text" name="location" id="location" required placeholder="Landmark, street, or tole name"
                 style="width:100%; height:44px; border:1.5px solid #e5e7eb; border-radius:8px; padding:0 14px; font-size:14px; color:#111827; background:#fff; outline:none; font-family:'Inter',sans-serif;"/>
        </div>

        <!-- Description -->
        <div style="margin-bottom:20px;">
          <label style="display:block; font-size:13px; font-weight:600; color:#374151; margin-bottom:6px;">Details <span style="color:#dc2626;">*</span></label>
          <textarea name="description" id="description" rows="4" required placeholder="When did this start? How bad is it? Any danger to people?"
                    style="width:100%; border:1.5px solid #e5e7eb; border-radius:8px; padding:12px 14px; font-size:14px; color:#111827; background:#fff; outline:none; resize:vertical; font-family:'Inter',sans-serif; line-height:1.6;"></textarea>
        </div>

        <!-- Photo Upload -->
        <div style="margin-bottom:28px;">
          <label style="display:block; font-size:13px; font-weight:600; color:#374151; margin-bottom:6px;">Photo <span style="font-weight:400; color:#94a3b8;">(optional but helps a lot)</span></label>
          <div id="dropZone" style="border:1.5px dashed #d1d5db; border-radius:8px; padding:28px; text-align:center; cursor:pointer; transition:border-color 0.2s;">
            <input type="file" name="image" id="imageInput" accept="image/*" style="display:none;" form="reportForm"/>
            <svg width="28" height="28" fill="none" stroke="#94a3b8" stroke-width="1.5" viewBox="0 0 24 24" style="margin:0 auto 8px;"><path stroke-linecap="round" stroke-linejoin="round" d="M3 9a2 2 0 012-2h.93a2 2 0 001.664-.89l.812-1.22A2 2 0 0110.07 4h3.86a2 2 0 011.664.89l.812 1.22A2 2 0 0018.07 7H19a2 2 0 012 2v9a2 2 0 01-2 2H5a2 2 0 01-2-2V9z"/><path stroke-linecap="round" stroke-linejoin="round" d="M15 13a3 3 0 11-6 0 3 3 0 016 0z"/></svg>
            <p style="font-size:13px; color:#64748b; margin-bottom:4px;">Click to upload or drag & drop</p>
            <p style="font-size:12px; color:#94a3b8;">JPEG or PNG, up to 10 MB</p>
          </div>
          <div id="imagePreview" style="display:none; margin-top:10px;">
            <img id="previewImg" src="#" alt="" style="width:100%; max-height:120px; object-fit:cover; border-radius:8px; border:1px solid #e2e8f0;"/>
            <p id="fileName" style="font-size:12px; color:#64748b; margin-top:4px;"></p>
          </div>
        </div>

        <!-- Buttons -->
        <div style="display:flex; align-items:center; gap:12px;">
          <button type="submit" style="background:#4f46e5; color:#fff; border:none; font-weight:600; font-size:14px; padding:11px 24px; border-radius:8px; cursor:pointer; font-family:'Inter',sans-serif;">
            Submit Report
          </button>
          <a href="<%= request.getContextPath() %>/citizen/dashboard" style="font-size:14px; font-weight:500; color:#64748b; text-decoration:none;">Cancel</a>
        </div>
      </form>
    </div>
  </div>
</div>

<script>
  var dropZone = document.getElementById('dropZone');
  var imageInput = document.getElementById('imageInput');
  dropZone.addEventListener('click', function() { imageInput.click(); });
  dropZone.addEventListener('dragover', function(e) { e.preventDefault(); dropZone.style.borderColor='#4f46e5'; });
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
