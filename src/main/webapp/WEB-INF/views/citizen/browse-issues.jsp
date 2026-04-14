<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../common/header.jsp"/>

<div class="flex min-h-screen">
  <jsp:include page="../common/citizen-sidebar.jsp"/>

  <div class="flex-1" style="margin-left:220px; background:#f8fafc; min-height:100vh;">
    <div style="padding:18px 32px; display:flex; align-items:center; justify-content:space-between; border-bottom:1px solid #e2e8f0; background:#fff;">
      <div>
        <h1 style="font-family:'Outfit',sans-serif; font-size:20px; font-weight:700; color:#0f172a; margin:0;">Browse Community Issues</h1>
        <p style="font-size:13px; color:#64748b; margin:2px 0 0;">Explore reports from other citizens and track civic progress.</p>
      </div>
    </div>

    <div style="padding:28px 32px;">
      <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:16px; margin-bottom:16px; display:grid; grid-template-columns:1fr 1fr 1fr 1fr; gap:10px;">
        <select id="filterCategory" style="height:40px; border:1.5px solid #e5e7eb; border-radius:8px; padding:0 10px; font-size:13px; color:#111827; background:#fff; outline:none;">
          <option value="">All Categories</option>
          <option value="Roads">Roads</option>
          <option value="Sanitation">Sanitation</option>
          <option value="Water">Water</option>
          <option value="Electrical">Electrical</option>
          <option value="Drainage">Drainage</option>
        </select>

        <select id="filterMunicipality" style="height:40px; border:1.5px solid #e5e7eb; border-radius:8px; padding:0 10px; font-size:13px; color:#111827; background:#fff; outline:none;">
          <option value="">All Municipalities</option>
          <option value="Kathmandu Metropolitan City">Kathmandu Metropolitan City</option>
          <option value="Lalitpur Metropolitan City">Lalitpur Metropolitan City</option>
          <option value="Bhaktapur Municipality">Bhaktapur Municipality</option>
        </select>

        <select id="filterWard" style="height:40px; border:1.5px solid #e5e7eb; border-radius:8px; padding:0 10px; font-size:13px; color:#111827; background:#fff; outline:none;">
          <option value="">All Wards</option>
          <option value="Ward 01">Ward 01</option>
          <option value="Ward 04">Ward 04</option>
          <option value="Ward 07">Ward 07</option>
          <option value="Ward 09">Ward 09</option>
        </select>

        <select id="filterStatus" style="height:40px; border:1.5px solid #e5e7eb; border-radius:8px; padding:0 10px; font-size:13px; color:#111827; background:#fff; outline:none;">
          <option value="">All Statuses</option>
          <option value="Pending">Pending</option>
          <option value="In Progress">In Progress</option>
          <option value="Resolved">Resolved</option>
        </select>
      </div>

      <div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; overflow:hidden;">
        <table style="width:100%; border-collapse:collapse;">
          <thead>
            <tr style="border-bottom:1px solid #f1f5f9;">
              <th style="text-align:left; padding:12px 18px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Issue</th>
              <th style="text-align:left; padding:12px 18px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Category</th>
              <th style="text-align:left; padding:12px 18px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Municipality</th>
              <th style="text-align:left; padding:12px 18px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Ward</th>
              <th style="text-align:left; padding:12px 18px; font-size:11px; font-weight:700; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Status</th>
              <th style="text-align:right; padding:12px 18px;"></th>
            </tr>
          </thead>
          <tbody id="issueRows">
            <tr data-category="Roads" data-municipality="Kathmandu Metropolitan City" data-ward="Ward 04" data-status="Pending" style="border-bottom:1px solid #f8fafc;">
              <td style="padding:14px 18px;"><p style="font-size:13px; font-weight:600; color:#1e293b;">Pothole near Ratna Park</p><p style="font-size:11px; color:#94a3b8;">#NS-8821</p></td>
              <td style="padding:14px 18px; font-size:12px; color:#64748b;">Roads</td>
              <td style="padding:14px 18px; font-size:12px; color:#64748b;">Kathmandu Metropolitan City</td>
              <td style="padding:14px 18px; font-size:12px; color:#64748b;">Ward 04</td>
              <td style="padding:14px 18px;"><span style="padding:3px 9px; border-radius:99px; font-size:11px; font-weight:600; background:#fef3c7; color:#92400e;">Pending</span></td>
              <td style="padding:14px 18px; text-align:right;"><a href="<%= request.getContextPath() %>/citizen/issue-detail?id=1" style="font-size:12px; color:#059669; font-weight:600; text-decoration:none;">View →</a></td>
            </tr>
            <tr data-category="Electrical" data-municipality="Kathmandu Metropolitan City" data-ward="Ward 04" data-status="In Progress" style="border-bottom:1px solid #f8fafc;">
              <td style="padding:14px 18px;"><p style="font-size:13px; font-weight:600; color:#1e293b;">Streetlight out — Bagbazar</p><p style="font-size:11px; color:#94a3b8;">#NS-8815</p></td>
              <td style="padding:14px 18px; font-size:12px; color:#64748b;">Electrical</td>
              <td style="padding:14px 18px; font-size:12px; color:#64748b;">Kathmandu Metropolitan City</td>
              <td style="padding:14px 18px; font-size:12px; color:#64748b;">Ward 04</td>
              <td style="padding:14px 18px;"><span style="padding:3px 9px; border-radius:99px; font-size:11px; font-weight:600; background:#d1fae5; color:#065f46;">In Progress</span></td>
              <td style="padding:14px 18px; text-align:right;"><a href="<%= request.getContextPath() %>/citizen/issue-detail?id=2" style="font-size:12px; color:#059669; font-weight:600; text-decoration:none;">View →</a></td>
            </tr>
            <tr data-category="Sanitation" data-municipality="Lalitpur Metropolitan City" data-ward="Ward 07" data-status="Resolved">
              <td style="padding:14px 18px;"><p style="font-size:13px; font-weight:600; color:#1e293b;">Garbage pile — Thapathali bridge</p><p style="font-size:11px; color:#94a3b8;">#NS-8790</p></td>
              <td style="padding:14px 18px; font-size:12px; color:#64748b;">Sanitation</td>
              <td style="padding:14px 18px; font-size:12px; color:#64748b;">Lalitpur Metropolitan City</td>
              <td style="padding:14px 18px; font-size:12px; color:#64748b;">Ward 07</td>
              <td style="padding:14px 18px;"><span style="padding:3px 9px; border-radius:99px; font-size:11px; font-weight:600; background:#dcfce7; color:#166534;">Resolved</span></td>
              <td style="padding:14px 18px; text-align:right;"><a href="<%= request.getContextPath() %>/citizen/issue-detail?id=3" style="font-size:12px; color:#059669; font-weight:600; text-decoration:none;">View →</a></td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>

<script>
  (function() {
    var category = document.getElementById('filterCategory');
    var municipality = document.getElementById('filterMunicipality');
    var ward = document.getElementById('filterWard');
    var status = document.getElementById('filterStatus');
    var rows = Array.prototype.slice.call(document.querySelectorAll('#issueRows tr'));

    function applyFilters() {
      rows.forEach(function(row) {
        var matchCategory = !category.value || row.getAttribute('data-category') === category.value;
        var matchMunicipality = !municipality.value || row.getAttribute('data-municipality') === municipality.value;
        var matchWard = !ward.value || row.getAttribute('data-ward') === ward.value;
        var matchStatus = !status.value || row.getAttribute('data-status') === status.value;
        row.style.display = (matchCategory && matchMunicipality && matchWard && matchStatus) ? '' : 'none';
      });
    }

    [category, municipality, ward, status].forEach(function(el) {
      el.addEventListener('change', applyFilters);
    });
  })();
</script>
</body>
</html>
