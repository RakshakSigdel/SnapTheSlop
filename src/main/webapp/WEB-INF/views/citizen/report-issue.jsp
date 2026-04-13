<%--
  Report an Issue - SnapTheSlop Smart Municipality
  Design: NagarSewa UI (Google Stitch)
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setAttribute("activePage", "issue-reports"); %>
<jsp:include page="../common/header.jsp"/>

<body class="bg-gray-50" style="font-family:'Inter',sans-serif;">
<div class="flex min-h-screen">

  <!-- Sidebar -->
  <jsp:include page="../common/citizen-sidebar.jsp"/>

  <!-- Main Content -->
  <div class="flex-1 flex flex-col min-h-screen" style="margin-left:200px;">

    <!-- Top Nav Bar -->
    <div class="bg-white border-b border-gray-100 px-8 py-4 flex items-center justify-between sticky top-0 z-10">
      <h1 class="text-sm font-bold text-gray-400 tracking-widest uppercase">Create New Report</h1>
      <div class="flex items-center gap-4">
        <button class="text-gray-400 hover:text-gray-600">
          <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6 6 0 10-12 0v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"/>
          </svg>
        </button>
        <div class="flex items-center gap-2.5">
          <div class="text-right">
            <p class="text-xs font-semibold text-gray-700"><%= session.getAttribute("userName") != null ? session.getAttribute("userName") : "Aditya Sharma" %></p>
            <p class="text-xs text-gray-400">Citizen ID: #0001</p>
          </div>
          <div class="w-9 h-9 rounded-full bg-blue-600 flex items-center justify-center text-white text-sm font-bold">
            <%= session.getAttribute("userInitials") != null ? session.getAttribute("userInitials") : "AS" %>
          </div>
        </div>
      </div>
    </div>

    <!-- Breadcrumb -->
    <div class="px-8 pt-5 pb-1">
      <nav class="flex items-center gap-2 text-xs text-gray-400 font-bold tracking-widest uppercase">
        <a href="<%= request.getContextPath() %>/citizen/dashboard" class="hover:text-blue-600 transition-colors">Dashboard</a>
        <span class="text-gray-300">&rsaquo;</span>
        <a href="<%= request.getContextPath() %>/citizen/my-issues" class="hover:text-blue-600 transition-colors">Issue Reports</a>
        <span class="text-gray-300">&rsaquo;</span>
        <span class="text-blue-600">New Report</span>
      </nav>
    </div>

    <!-- Error Messages -->
    <% if (request.getAttribute("errorMessage") != null) { %>
    <div class="mx-8 mt-4 bg-red-50 border border-red-100 text-red-600 px-5 py-3 rounded-xl text-sm flex items-center gap-2">
      <svg class="w-4 h-4 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z" clip-rule="evenodd"/></svg>
      <%= request.getAttribute("errorMessage") %>
    </div>
    <% } %>

    <div class="p-8 flex-1">
      <div class="grid grid-cols-3 gap-8 max-w-6xl">

        <!-- Form Card (2 cols) -->
        <div class="col-span-2">
          <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-8">
            <h2 class="text-lg font-bold text-gray-800 mb-6">Report Details</h2>

            <form action="<%= request.getContextPath() %>/issue/create" method="post" enctype="multipart/form-data" id="reportForm">

              <!-- Title -->
              <div class="mb-5">
                <label class="block text-xs font-bold text-gray-400 tracking-widest uppercase mb-2">Title of the Issue</label>
                <input type="text" name="title" id="title" required
                       placeholder="Briefly describe the problem (e.g. Broken streetlight)"
                       class="w-full border border-gray-200 rounded-xl px-4 py-3 text-sm text-gray-800 placeholder-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition bg-gray-50"/>
              </div>

              <!-- Category & Ward -->
              <div class="grid grid-cols-2 gap-5 mb-5">
                <div>
                  <label class="block text-xs font-bold text-gray-400 tracking-widest uppercase mb-2">Category</label>
                  <div class="relative">
                    <select name="category" id="category" required
                            class="w-full border border-gray-200 rounded-xl px-4 py-3 text-sm text-gray-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition bg-gray-50 appearance-none cursor-pointer">
                      <option value="" disabled selected>Select category</option>
                      <option value="Roads Potholes">Roads &amp; Potholes</option>
                      <option value="Waste Management">Waste Management</option>
                      <option value="Water Supply">Water Supply Issues</option>
                      <option value="Electricity">Electricity Problems</option>
                      <option value="Drainage">Drainage &amp; Sewage</option>
                      <option value="Street Lighting">Street Lighting</option>
                      <option value="Public Safety">Public Safety</option>
                      <option value="Parks Recreation">Parks &amp; Recreation</option>
                      <option value="Road Infrastructure">Road &amp; Infrastructure</option>
                      <option value="Sanitation">Sanitation</option>
                      <option value="Other">Other</option>
                    </select>
                    <div class="pointer-events-none absolute inset-y-0 right-3 flex items-center">
                      <svg class="w-4 h-4 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"/></svg>
                    </div>
                  </div>
                </div>
                <div>
                  <label class="block text-xs font-bold text-gray-400 tracking-widest uppercase mb-2">Ward Number</label>
                  <div class="relative">
                    <select name="ward" id="ward" required
                            class="w-full border border-gray-200 rounded-xl px-4 py-3 text-sm text-gray-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition bg-gray-50 appearance-none cursor-pointer">
                      <option value="" disabled selected>Select ward</option>
                      <option value="Ward 01">Ward 01</option>
                      <option value="Ward 02">Ward 02</option>
                      <option value="Ward 03">Ward 03</option>
                      <option value="Ward 04 (Central)">Ward 04 (Central)</option>
                      <option value="Ward 05">Ward 05</option>
                      <option value="Ward 06">Ward 06</option>
                      <option value="Ward 07">Ward 07</option>
                      <option value="Ward 08">Ward 08</option>
                      <option value="Ward 09">Ward 09</option>
                      <option value="Ward 10">Ward 10</option>
                      <option value="Ward 11">Ward 11</option>
                      <option value="Ward 12">Ward 12</option>
                      <option value="Ward 13">Ward 13</option>
                      <option value="Ward 14 (Central)" selected>Ward 14 (Central)</option>
                      <option value="Ward 15">Ward 15</option>
                    </select>
                    <div class="pointer-events-none absolute inset-y-0 right-3 flex items-center">
                      <svg class="w-4 h-4 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"/></svg>
                    </div>
                  </div>
                </div>
              </div>

              <!-- Specific Address/Location -->
              <div class="mb-5">
                <label class="block text-xs font-bold text-gray-400 tracking-widest uppercase mb-2">Specific Address / Location</label>
                <div class="relative">
                  <input type="text" name="location" id="location" required
                         placeholder="Enter landmark or street name"
                         class="w-full border border-gray-200 rounded-xl px-4 py-3 pr-10 text-sm text-gray-800 placeholder-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition bg-gray-50"/>
                  <span class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"/><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"/></svg>
                  </span>
                </div>
              </div>

              <!-- Detailed Description -->
              <div class="mb-7">
                <label class="block text-xs font-bold text-gray-400 tracking-widest uppercase mb-2">Detailed Description</label>
                <textarea name="description" id="description" rows="5" required
                          placeholder="Provide as much detail as possible about the issue..."
                          class="w-full border border-gray-200 rounded-xl px-4 py-3 text-sm text-gray-800 placeholder-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition resize-none bg-gray-50"></textarea>
              </div>

              <!-- Buttons -->
              <div class="flex items-center gap-4">
                <button type="submit"
                        class="bg-blue-600 hover:bg-blue-700 text-white font-bold text-sm px-8 py-3 rounded-xl transition-colors duration-200">
                  Submit Report
                </button>
                <a href="<%= request.getContextPath() %>/citizen/dashboard"
                   class="text-sm font-semibold text-gray-400 hover:text-gray-600 transition-colors">
                  Cancel
                </a>
              </div>

            </form>
          </div>
        </div>

        <!-- Right Panel -->
        <div class="space-y-5">

          <!-- Visual Evidence Upload -->
          <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6">
            <div class="flex items-center justify-between mb-4">
              <h3 class="text-xs font-bold text-gray-400 tracking-widest uppercase">Visual Evidence</h3>
              <span class="text-xs text-gray-300 font-semibold">Optional</span>
            </div>
            <div class="border-2 border-dashed border-gray-200 rounded-xl p-6 text-center hover:border-blue-400 hover:bg-blue-50 transition-colors cursor-pointer" id="dropZone">
              <div class="w-12 h-12 bg-gray-100 rounded-xl flex items-center justify-center mx-auto mb-3">
                <svg class="w-6 h-6 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 9a2 2 0 012-2h.93a2 2 0 001.664-.89l.812-1.22A2 2 0 0110.07 4h3.86a2 2 0 011.664.89l.812 1.22A2 2 0 0018.07 7H19a2 2 0 012 2v9a2 2 0 01-2 2H5a2 2 0 01-2-2V9z"/><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 13a3 3 0 11-6 0 3 3 0 016 0z"/></svg>
              </div>
              <p class="text-xs font-semibold text-gray-500 mb-1">Drag &amp; drop photos here</p>
              <p class="text-xs text-gray-400 mb-4">Support JPEG, PNG up to 10MB</p>
              <input type="file" name="image" id="imageInput" accept="image/*" class="hidden" form="reportForm"/>
              <button type="button" onclick="document.getElementById('imageInput').click()"
                      class="bg-gray-100 hover:bg-gray-200 text-gray-600 text-xs font-bold px-4 py-2 rounded-lg transition-colors">
                BROWSE FILES
              </button>
            </div>
            <div id="imagePreview" class="mt-3 hidden">
              <img id="previewImg" src="#" alt="Preview" class="w-full h-28 object-cover rounded-xl"/>
              <p id="fileName" class="text-xs text-gray-400 mt-2 text-center truncate"></p>
            </div>
          </div>

          <!-- Location Map -->
          <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
            <div class="relative" style="height:160px; background: #e8edf1;">
              <!-- Simple map placeholder -->
              <div class="absolute inset-0" style="background: linear-gradient(135deg, #dde3e8 0%, #c8d0d9 100%);">
                <div class="absolute inset-0 opacity-20" style="background-image: repeating-linear-gradient(0deg, transparent, transparent 20px, rgba(0,0,0,0.05) 20px, rgba(0,0,0,0.05) 21px), repeating-linear-gradient(90deg, transparent, transparent 20px, rgba(0,0,0,0.05) 20px, rgba(0,0,0,0.05) 21px);"></div>
              </div>
              <div class="absolute inset-0 flex items-center justify-center">
                <div class="w-8 h-8 bg-blue-600 rounded-full border-4 border-white shadow-lg flex items-center justify-center">
                  <svg class="w-4 h-4 text-white" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M5.05 4.05a7 7 0 119.9 9.9L10 18.9l-4.95-4.95a7 7 0 010-9.9zM10 11a2 2 0 100-4 2 2 0 000 4z" clip-rule="evenodd"/></svg>
                </div>
              </div>
            </div>
            <div class="px-4 py-3 flex items-start gap-3">
              <div class="w-8 h-8 bg-blue-50 rounded-lg flex items-center justify-center flex-shrink-0 mt-0.5">
                <svg class="w-4 h-4 text-blue-600" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M4 4a2 2 0 012-2h8a2 2 0 012 2v2h2a2 2 0 012 2v8a2 2 0 01-2 2H4a2 2 0 01-2-2V6a2 2 0 012-2h2V4zm8 0H8v2h4V4zm-4 8a1 1 0 011-1h2a1 1 0 110 2h-2a1 1 0 01-1-1zm-2-1a1 1 0 100 2H5a1 1 0 100-2h1z" clip-rule="evenodd"/></svg>
              </div>
              <div>
                <p class="text-xs font-bold text-gray-400 tracking-widest uppercase mb-0.5">Selected Jurisdiction</p>
                <p class="text-sm font-semibold text-gray-800">Municipal Ward 14</p>
                <p class="text-xs text-gray-400">Sub-district, Central North</p>
              </div>
            </div>
          </div>

          <!-- Processing Time -->
          <div class="px-1">
            <div class="flex items-start gap-2">
              <svg class="w-4 h-4 text-blue-500 mt-0.5 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd"/></svg>
              <div>
                <p class="text-xs font-bold text-blue-600 mb-1">Processing Time</p>
                <p class="text-xs text-gray-500 leading-relaxed">Most reports in Ward 14 are acknowledged within 4 hours. You will receive a tracking ID via SMS once submitted.</p>
              </div>
            </div>
          </div>
        </div>

      </div>
    </div>
  </div>
</div>

<script>
  const dropZone = document.getElementById('dropZone');
  const imageInput = document.getElementById('imageInput');
  const imagePreview = document.getElementById('imagePreview');
  const previewImg = document.getElementById('previewImg');
  const fileName = document.getElementById('fileName');

  dropZone.addEventListener('dragover', (e) => { e.preventDefault(); dropZone.classList.add('border-blue-400','bg-blue-50'); });
  dropZone.addEventListener('dragleave', () => { dropZone.classList.remove('border-blue-400','bg-blue-50'); });
  dropZone.addEventListener('drop', (e) => {
    e.preventDefault();
    dropZone.classList.remove('border-blue-400','bg-blue-50');
    const file = e.dataTransfer.files[0];
    if (file && file.type.startsWith('image/')) showPreview(file);
  });

  imageInput.addEventListener('change', () => {
    if (imageInput.files[0]) showPreview(imageInput.files[0]);
  });

  function showPreview(file) {
    const reader = new FileReader();
    reader.onload = (e) => { previewImg.src = e.target.result; };
    reader.readAsDataURL(file);
    fileName.textContent = file.name;
    imagePreview.classList.remove('hidden');
  }

  document.getElementById('reportForm').addEventListener('submit', function(e) {
    const title = document.getElementById('title').value.trim();
    const desc = document.getElementById('description').value.trim();
    if (title.length < 5) { e.preventDefault(); alert('Please enter a more descriptive title (at least 5 characters).'); return; }
    if (desc.length < 10) { e.preventDefault(); alert('Please provide more detail in the description (at least 10 characters).'); return; }
  });
</script>
</body>
</html>
