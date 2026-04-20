<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setAttribute("activePage", "ward-management"); %>
<jsp:include page="../common/header.jsp"/>

<script>
 	const contextPath = '<%= request.getContextPath() %>';
	// Get municipality ID from server-side JSP
	const municipalityId = Number('<%= request.getAttribute("municipalityId") != null ? request.getAttribute("municipalityId").toString() : "" %>');
	let currentEditingWardId = null;
	let wardsData = [];

	// Load wards on page load
	document.addEventListener('DOMContentLoaded', function() {
		loadWards();
		setupFormHandlers();
	});

	function loadWards() {
		if (!municipalityId) {
			showMessage('Municipality is not configured for this account', 'error');
			renderWardsTable([]);
			return;
		}

		fetch(contextPath + '/municipality/wards?municipalityId=' + municipalityId)
			.then(response => {
				if (!response.ok) {
					throw new Error('Failed to load wards');
				}
				return response.json();
			})
			.then(data => {
				if (!Array.isArray(data)) {
					throw new Error('Unexpected ward response');
				}
				wardsData = data;
				renderWardsTable(data);
			})
			.catch(error => {
				console.error('Error loading wards:', error);
				showMessage('Error loading wards', 'error');
			});
	}

	function renderWardsTable(wards) {
		const tbody = document.querySelector('tbody');
		tbody.innerHTML = '';

		if (wards.length === 0) {
			tbody.innerHTML = '<tr><td colspan="5" style="text-align:center; padding:20px; color:#94a3b8;">No wards found. Create your first ward.</td></tr>';
			return;
		}

		wards.forEach(ward => {
			const row = document.createElement('tr');
			row.style.borderBottom = '1px solid #f8fafc';

			const normalizedStatus = (ward.status || 'pending').toLowerCase();
			const statusClass = normalizedStatus.charAt(0).toUpperCase() + normalizedStatus.slice(1);
			const statusColor = normalizedStatus === 'active' ? '#dcfce7' : (normalizedStatus === 'inactive' ? '#e5e7eb' : '#fef3c7');
			const statusTextColor = normalizedStatus === 'active' ? '#166534' : (normalizedStatus === 'inactive' ? '#374151' : '#92400e');

			row.innerHTML =
				'<td style="padding:13px 18px; font-size:13px; font-weight:600; color:#1f2937;">Ward ' + (ward.wardNumber ?? '') + '</td>' +
				'<td style="padding:13px 18px; font-size:13px; color:#475569;">' + (ward.wardHead || '-') + '</td>' +
				'<td style="padding:13px 18px; font-size:13px; color:#475569;">' + (ward.contactNumber || '-') + '</td>' +
				'<td style="padding:13px 18px;">' +
					'<span style="font-size:11px; font-weight:600; color:' + statusTextColor + '; background:' + statusColor + '; padding:3px 9px; border-radius:99px;">' + statusClass + '</span>' +
				'</td>' +
				'<td style="padding:13px 18px; text-align:right;">' +
					'<a href="#" onclick="editWard(' + ward.id + '); return false;" style="font-size:12px; color:#059669; text-decoration:none; font-weight:600;">Edit</a>' +
					'<span style="color:#cbd5e1;">|</span>' +
					'<a href="#" onclick="deleteWard(' + ward.id + '); return false;" style="font-size:12px; color:#dc2626; text-decoration:none; font-weight:600;">Remove</a>' +
				'</td>';
			tbody.appendChild(row);
		});
	}

	function setupFormHandlers() {
		const addNewBtn = document.getElementById('addNewWardBtn');
		if (addNewBtn) {
			addNewBtn.addEventListener('click', resetForm);
		}

		const saveBtn = document.getElementById('saveWardBtn');
		if (saveBtn) {
			saveBtn.addEventListener('click', saveWard);
		}

		const removeBtn = document.getElementById('removeWardBtn');
		if (removeBtn) {
			removeBtn.addEventListener('click', function() {
				if (currentEditingWardId) {
					deleteWard(currentEditingWardId);
				} else {
					showMessage('Please select a ward to remove', 'error');
				}
			});
		}

		// Search functionality
		const searchInput = document.querySelector('input[placeholder="Search ward or head"]');
		if (searchInput) {
			searchInput.addEventListener('input', function() {
				filterWards(this.value);
			});
		}
	}

	function editWard(wardId) {
		const ward = wardsData.find(w => w.id === wardId);
		if (!ward) return;

		currentEditingWardId = wardId;
		document.getElementById('wardIdInput').value = wardId;
		document.getElementById('wardNumberInput').value = ward.wardNumber;
		document.getElementById('wardHeadInput').value = ward.wardHead;
		document.getElementById('contactNumberInput').value = ward.contactNumber;
		document.getElementById('statusSelect').value = ward.status;

		// Scroll to form
		document.querySelector('[data-form]').scrollIntoView({ behavior: 'smooth' });
	}

	function resetForm() {
		currentEditingWardId = null;
		document.getElementById('wardIdInput').value = '';
		document.getElementById('wardNumberInput').value = '';
		document.getElementById('wardHeadInput').value = '';
		document.getElementById('contactNumberInput').value = '';
		document.getElementById('statusSelect').value = 'active';
	}

	function saveWard() {
		const wardId = document.getElementById('wardIdInput').value.trim();
		const wardNumber = document.getElementById('wardNumberInput').value.trim();
		const wardHead = document.getElementById('wardHeadInput').value.trim();
		const contactNumber = document.getElementById('contactNumberInput').value.trim();
		const status = document.getElementById('statusSelect').value;

		if (!wardNumber || !wardHead || !contactNumber) {
			showMessage('Please fill all required fields', 'error');
			return;
		}

		const formData = new URLSearchParams();
		if (wardId) formData.append('wardId', wardId);
		formData.append('wardNumber', wardNumber);
		formData.append('wardHead', wardHead);
		formData.append('contactNumber', contactNumber);
		formData.append('status', status);

		fetch(contextPath + '/municipality/ward-management', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8'
			},
			body: formData
		})
		.then(response => response.json())
		.then(data => {
			if (data.success) {
				showMessage(data.message, 'success');
				resetForm();
				loadWards();
			} else {
				showMessage(data.message, 'error');
			}
		})
		.catch(error => {
			console.error('Error:', error);
			showMessage('Error saving ward', 'error');
		});
	}

	function deleteWard(wardId) {
		if (!confirm('Are you sure you want to delete this ward?')) return;

		fetch(contextPath + '/municipality/ward-management?wardId=' + wardId, {
			method: 'DELETE'
		})
		.then(response => response.json())
		.then(data => {
			if (data.success) {
				showMessage(data.message, 'success');
				if (currentEditingWardId === wardId) {
					resetForm();
				}
				loadWards();
			} else {
				showMessage(data.message, 'error');
			}
		})
		.catch(error => {
			console.error('Error:', error);
			showMessage('Error deleting ward', 'error');
		});
	}

	function filterWards(searchTerm) {
		const filtered = wardsData.filter(ward => {
			const term = searchTerm.toLowerCase();
			return ward.wardHead.toLowerCase().includes(term) || 
				   ward.wardNumber.toString().includes(term);
		});
		renderWardsTable(filtered.length > 0 ? filtered : wardsData);
	}

	function showMessage(message, type) {
		const messageDiv = document.createElement('div');
		messageDiv.style.cssText = `
			position: fixed;
			top: 20px;
			right: 20px;
			padding: 12px 16px;
			border-radius: 7px;
			z-index: 10000;
			font-size: 13px;
			font-weight: 600;
			animation: slideIn 0.3s ease;
		`;

		if (type === 'success') {
			messageDiv.style.background = '#dcfce7';
			messageDiv.style.color = '#166534';
			messageDiv.style.border = '1px solid #bbf7d0';
		} else {
			messageDiv.style.background = '#fee2e2';
			messageDiv.style.color = '#991b1b';
			messageDiv.style.border = '1px solid #fecaca';
		}

		messageDiv.textContent = message;
		document.body.appendChild(messageDiv);

		setTimeout(() => messageDiv.remove(), 3000);
	}

	// CSS for animation
	const style = document.createElement('style');
	style.textContent = `
		@keyframes slideIn {
			from {
				transform: translateX(400px);
				opacity: 0;
			}
			to {
				transform: translateX(0);
				opacity: 1;
			}
		}
	`;
	document.head.appendChild(style);
</script>

<div class="flex min-h-screen">
	<jsp:include page="../common/municipality-sidebar.jsp"/>

	<div class="flex-1" style="margin-left:220px; background:#f8fafc; min-height:100vh;">
		<div style="padding:18px 32px; display:flex; align-items:center; justify-content:space-between; border-bottom:1px solid #e2e8f0; background:#fff;">
			<div>
				<h1 style="font-family:'Outfit',sans-serif; font-size:20px; font-weight:700; color:#0f172a; margin:0;">Ward Management</h1>
				<p style="font-size:13px; color:#64748b; margin:2px 0 0;">Add, update, or remove wards and maintain ward head contact details.</p>
			</div>
			<button id="addNewWardBtn" style="background:#059669; color:#fff; border:none; padding:9px 16px; border-radius:8px; font-size:13px; font-weight:600; cursor:pointer; font-family:'Inter',sans-serif;">Add New Ward</button>
		</div>

		<div style="padding:28px 32px;">
			<div style="display:grid; grid-template-columns:2fr 1fr; gap:16px;">
				<div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; overflow:hidden;">
					<div style="padding:14px 18px; border-bottom:1px solid #f1f5f9; display:flex; justify-content:space-between; align-items:center;">
						<h2 style="font-size:15px; font-weight:700; color:#0f172a; margin:0;">Ward Directory</h2>
						<input type="text" placeholder="Search ward or head" style="height:34px; border:1px solid #d1d5db; border-radius:7px; padding:0 10px; font-size:12px; font-family:'Inter',sans-serif;"/>
					</div>

					<table style="width:100%; border-collapse:collapse;">
						<thead>
							<tr style="border-bottom:1px solid #f1f5f9;">
								<th style="text-align:left; padding:12px 18px; font-size:11px; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Ward</th>
								<th style="text-align:left; padding:12px 18px; font-size:11px; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Ward Head</th>
								<th style="text-align:left; padding:12px 18px; font-size:11px; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Contact</th>
								<th style="text-align:left; padding:12px 18px; font-size:11px; color:#94a3b8; text-transform:uppercase; letter-spacing:1px;">Status</th>
								<th style="text-align:right; padding:12px 18px;"></th>
							</tr>
						</thead>
						<tbody>
							<!-- Dynamically populated by JavaScript -->
						</tbody>
					</table>
				</div>

				<div style="display:flex; flex-direction:column; gap:14px;">
					<div style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:16px;" data-form>
						<h3 style="font-size:14px; font-weight:700; color:#0f172a; margin:0 0 12px;">Add / Update Ward</h3>

						<input type="hidden" id="wardIdInput" value="">

						<label style="display:block; font-size:12px; color:#6b7280; margin-bottom:4px;">Ward Number</label>
						<input type="number" id="wardNumberInput" placeholder="e.g., 1, 2, 3..." style="width:100%; height:36px; border:1px solid #d1d5db; border-radius:7px; padding:0 10px; font-size:13px; margin-bottom:10px; font-family:'Inter',sans-serif;"/>

						<label style="display:block; font-size:12px; color:#6b7280; margin-bottom:4px;">Ward Head Name</label>
						<input type="text" id="wardHeadInput" placeholder="Full name" style="width:100%; height:36px; border:1px solid #d1d5db; border-radius:7px; padding:0 10px; font-size:13px; margin-bottom:10px; font-family:'Inter',sans-serif;"/>

						<label style="display:block; font-size:12px; color:#6b7280; margin-bottom:4px;">Contact Number</label>
						<input type="tel" id="contactNumberInput" placeholder="+977 ..." style="width:100%; height:36px; border:1px solid #d1d5db; border-radius:7px; padding:0 10px; font-size:13px; margin-bottom:10px; font-family:'Inter',sans-serif;"/>

						<label style="display:block; font-size:12px; color:#6b7280; margin-bottom:4px;">Status</label>
						<select id="statusSelect" style="width:100%; height:36px; border:1px solid #d1d5db; border-radius:7px; padding:0 10px; font-size:13px; margin-bottom:12px; font-family:'Inter',sans-serif;">
							<option value="active">Active</option>
							<option value="inactive">Inactive</option>
							<option value="pending">Pending</option>
						</select>

						<div style="display:flex; gap:8px;">
							<button id="saveWardBtn" style="flex:1; background:#059669; color:#fff; border:none; height:36px; border-radius:7px; font-size:12px; font-weight:600; cursor:pointer; font-family:'Inter',sans-serif;">Save</button>
							<button id="removeWardBtn" style="flex:1; background:#fff; color:#dc2626; border:1px solid #fecaca; height:36px; border-radius:7px; font-size:12px; font-weight:600; cursor:pointer; font-family:'Inter',sans-serif;">Remove</button>
						</div>
					</div>

					<div style="background:#ecfdf5; border:1px solid #bbf7d0; border-radius:10px; padding:16px;">
						<p style="font-size:12px; font-weight:700; color:#065f46; margin:0 0 4px;">Tip</p>
						<p style="font-size:12px; color:#047857; margin:0; line-height:1.5;">Keep ward contact details updated so issue escalation reaches the right ward head quickly.</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>
