<%--
  Created by IntelliJ IDEA.
  User: raksh
  Date: 4/6/2026
  Time: 3:20 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../common/header.jsp"/>
<div class="flex">
    <jsp:include page="../common/sidebar.jsp"/>
    <div class="flex-1 ml-0 md:ml-64 p-4 md:p-8 overflow-x-hidden">
        <h1 class="text-2xl font-bold">Issue Management</h1>
        <div class="mt-6 bg-white p-6 rounded-2xl shadow">
            <div class="grid grid-cols-1 md:grid-cols-5 gap-4">
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path></svg>
                    </div>
                    <input type="text" placeholder="Search ID or Title." class="w-full pl-10 pr-4 py-2 border rounded-lg text-sm">
                </div>
                <select class="w-full border rounded-lg text-sm px-4 py-2">
                    <option>All Categories</option>
                </select>
                <select class="w-full border rounded-lg text-sm px-4 py-2">
                    <option>All Statuses</option>
                </select>
                <select class="w-full border rounded-lg text-sm px-4 py-2">
                    <option>All Municipalities</option>
                </select>
                <div class="relative">
                    <input type="text" placeholder="mm/dd/yyyy" class="w-full pr-10 pl-4 py-2 border rounded-lg text-sm">
                    <div class="absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none">
                        <svg class="w-5 h-5 text-gray-400" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M6 2a1 1 0 00-1 1v1H4a2 2 0 00-2 2v10a2 2 0 002 2h12a2 2 0 002-2V6a2 2 0 00-2-2h-1V3a1 1 0 10-2 0v1H7V3a1 1 0 00-1-1zm0 5a1 1 0 000 2h8a1 1 0 100-2H6z" clip-rule="evenodd"></path></svg>
                    </div>
                </div>
            </div>
        </div>

        <div class="mt-6 bg-white rounded-2xl shadow overflow-hidden">
            <div class="overflow-hidden">
                <table class="w-full table-fixed text-left">
                    <thead class="bg-gray-50 border-b border-gray-200">
                    <tr class="text-xs font-semibold text-gray-500 uppercase tracking-wide">
                        <th class="px-6 py-4">ID</th>
                        <th class="px-6 py-4">Issue Title</th>
                        <th class="px-6 py-4">Reporter</th>
                        <th class="px-6 py-4">Municipality</th>
                        <th class="px-6 py-4">Priority</th>
                        <th class="px-6 py-4">Status</th>
                        <th class="px-6 py-4">Date</th>
                        <th class="px-6 py-4 text-center">Actions</th>
                    </tr>
                    </thead>
                    <tbody class="text-gray-700">
                    <tr class="border-b border-gray-100">
                        <td class="px-6 py-5 font-semibold text-blue-600">#ISS-8291</td>
                        <td class="px-6 py-5 font-semibold text-gray-800 break-words">Broken Main Pipeline - Ward 4</td>
                        <td class="px-6 py-5">Anita Shrestha</td>
                        <td class="px-6 py-5">Kathmandu</td>
                        <td class="px-6 py-5"><span class="px-3 py-1 text-xs font-semibold rounded-full bg-red-100 text-red-600">CRITICAL</span></td>
                        <td class="px-6 py-5"><span class="px-3 py-1 text-xs font-semibold rounded-full bg-yellow-100 text-yellow-700">PENDING</span></td>
                        <td class="px-6 py-5 text-gray-500">Oct 24, 2023</td>
                        <td class="px-6 py-5 text-center">
                            <button type="button" class="issue-toggle inline-flex items-center justify-center w-9 h-9 rounded-lg border border-gray-200 text-blue-600 hover:bg-blue-50" data-target="issue-detail-8291" aria-expanded="true" title="Toggle issue details">
                                <svg class="w-4 h-4 transform transition-transform rotate-180" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path></svg>
                            </button>
                        </td>
                    </tr>
                    <tr id="issue-detail-8291" class="issue-detail-row bg-gray-50 border-b border-gray-200">
                        <td colspan="8" class="px-6 py-6">
                            <div class="grid grid-cols-1 lg:grid-cols-12 gap-6">
                                <div class="lg:col-span-4">
                                    <div class="h-44 rounded-xl bg-gradient-to-r from-slate-700 to-slate-900 flex items-center justify-center text-gray-100 font-semibold">Issue Evidence Image</div>
                                    <div class="grid grid-cols-2 gap-4 mt-4">
                                        <div class="bg-white rounded-xl border border-gray-200 p-4 text-center">
                                            <p class="text-xs text-gray-500 uppercase font-semibold">Upvotes</p>
                                            <p class="text-2xl font-bold mt-1 text-gray-800">142</p>
                                        </div>
                                        <div class="bg-white rounded-xl border border-gray-200 p-4 text-center">
                                            <p class="text-xs text-gray-500 uppercase font-semibold">Ward No.</p>
                                            <p class="text-2xl font-bold mt-1 text-gray-800">04</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="lg:col-span-5">
                                    <h3 class="text-xs tracking-wide uppercase text-gray-500 font-semibold">Description</h3>
                                    <p class="mt-2 text-gray-700 leading-relaxed">The main supply line has ruptured near the community temple. Water has been leaking for over 6 hours, causing significant road damage and flooding in adjacent lower-ground homes. Temporary sandbagging is required immediately.</p>
                                    <h3 class="text-xs tracking-wide uppercase text-gray-500 font-semibold mt-6">Timeline Audit Trail</h3>
                                    <div class="mt-3 space-y-3">
                                        <div class="flex items-start gap-3">
                                            <div class="w-2.5 h-2.5 rounded-full bg-blue-600 mt-2"></div>
                                            <div>
                                                <p class="font-semibold text-gray-800">Issue Reported</p>
                                                <p class="text-sm text-gray-500">Oct 24, 2023 - 08:15 AM</p>
                                            </div>
                                        </div>
                                        <div class="flex items-start gap-3">
                                            <div class="w-2.5 h-2.5 rounded-full bg-gray-300 mt-2"></div>
                                            <div>
                                                <p class="font-semibold text-gray-800">Verification Pending</p>
                                                <p class="text-sm text-gray-500">System auto-assigned to Ward Inspector</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="lg:col-span-3 space-y-3">
                                    <button type="button" class="w-full bg-blue-600 text-white font-semibold rounded-xl py-3 hover:bg-blue-700">Verify Issue</button>
                                    <button type="button" class="w-full bg-gray-200 text-gray-700 font-semibold rounded-xl py-3 hover:bg-gray-300">Assign Contractor</button>
                                    <button type="button" class="w-full border border-red-200 text-red-500 font-semibold rounded-xl py-3 hover:bg-red-50">Flag as Invalid</button>
                                </div>
                            </div>
                        </td>
                    </tr>

                    <tr class="border-b border-gray-100">
                        <td class="px-6 py-5 font-semibold text-blue-600">#ISS-8290</td>
                        <td class="px-6 py-5 font-semibold text-gray-800 break-words">Street Light Outage - Ring Road</td>
                        <td class="px-6 py-5">Ramesh Bajracharya</td>
                        <td class="px-6 py-5">Lalitpur</td>
                        <td class="px-6 py-5"><span class="px-3 py-1 text-xs font-semibold rounded-full bg-orange-100 text-orange-600">HIGH</span></td>
                        <td class="px-6 py-5"><span class="px-3 py-1 text-xs font-semibold rounded-full bg-blue-100 text-blue-700">IN PROGRESS</span></td>
                        <td class="px-6 py-5 text-gray-500">Oct 23, 2023</td>
                        <td class="px-6 py-5 text-center">
                            <button type="button" class="issue-toggle inline-flex items-center justify-center w-9 h-9 rounded-lg border border-gray-200 text-blue-600 hover:bg-blue-50" data-target="issue-detail-8290" aria-expanded="false" title="Toggle issue details">
                                <svg class="w-4 h-4 transform transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path></svg>
                            </button>
                        </td>
                    </tr>
                    <tr id="issue-detail-8290" class="issue-detail-row bg-gray-50 border-b border-gray-200 hidden">
                        <td colspan="8" class="px-6 py-6">
                            <div class="grid grid-cols-1 lg:grid-cols-12 gap-6">
                                <div class="lg:col-span-4">
                                    <div class="h-44 rounded-xl bg-gradient-to-r from-amber-600 to-orange-700 flex items-center justify-center text-amber-50 font-semibold">Issue Evidence Image</div>
                                    <div class="grid grid-cols-2 gap-4 mt-4">
                                        <div class="bg-white rounded-xl border border-gray-200 p-4 text-center">
                                            <p class="text-xs text-gray-500 uppercase font-semibold">Upvotes</p>
                                            <p class="text-2xl font-bold mt-1 text-gray-800">98</p>
                                        </div>
                                        <div class="bg-white rounded-xl border border-gray-200 p-4 text-center">
                                            <p class="text-xs text-gray-500 uppercase font-semibold">Ward No.</p>
                                            <p class="text-2xl font-bold mt-1 text-gray-800">11</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="lg:col-span-5">
                                    <h3 class="text-xs tracking-wide uppercase text-gray-500 font-semibold">Description</h3>
                                    <p class="mt-2 text-gray-700 leading-relaxed">Multiple street lights on the Ring Road section near Gwarko have stopped functioning, creating unsafe visibility for pedestrians and late-night traffic movement.</p>
                                    <h3 class="text-xs tracking-wide uppercase text-gray-500 font-semibold mt-6">Timeline Audit Trail</h3>
                                    <div class="mt-3 space-y-3">
                                        <div class="flex items-start gap-3">
                                            <div class="w-2.5 h-2.5 rounded-full bg-blue-600 mt-2"></div>
                                            <div>
                                                <p class="font-semibold text-gray-800">Issue Reported</p>
                                                <p class="text-sm text-gray-500">Oct 23, 2023 - 06:40 PM</p>
                                            </div>
                                        </div>
                                        <div class="flex items-start gap-3">
                                            <div class="w-2.5 h-2.5 rounded-full bg-blue-400 mt-2"></div>
                                            <div>
                                                <p class="font-semibold text-gray-800">Contractor Assigned</p>
                                                <p class="text-sm text-gray-500">Lalitpur Electrical Unit #2</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="lg:col-span-3 space-y-3">
                                    <button type="button" class="w-full bg-blue-600 text-white font-semibold rounded-xl py-3 hover:bg-blue-700">Verify Issue</button>
                                    <button type="button" class="w-full bg-gray-200 text-gray-700 font-semibold rounded-xl py-3 hover:bg-gray-300">Reassign Team</button>
                                    <button type="button" class="w-full border border-red-200 text-red-500 font-semibold rounded-xl py-3 hover:bg-red-50">Mark Escalated</button>
                                </div>
                            </div>
                        </td>
                    </tr>

                    <tr class="border-b border-gray-100">
                        <td class="px-6 py-5 font-semibold text-blue-600">#ISS-8285</td>
                        <td class="px-6 py-5 font-semibold text-gray-800 break-words">Garbage Accumulation - Patan Durbar</td>
                        <td class="px-6 py-5">Deepak Thapa</td>
                        <td class="px-6 py-5">Lalitpur</td>
                        <td class="px-6 py-5"><span class="px-3 py-1 text-xs font-semibold rounded-full bg-yellow-100 text-yellow-700">MEDIUM</span></td>
                        <td class="px-6 py-5"><span class="px-3 py-1 text-xs font-semibold rounded-full bg-green-100 text-green-700">RESOLVED</span></td>
                        <td class="px-6 py-5 text-gray-500">Oct 22, 2023</td>
                        <td class="px-6 py-5 text-center">
                            <button type="button" class="issue-toggle inline-flex items-center justify-center w-9 h-9 rounded-lg border border-gray-200 text-blue-600 hover:bg-blue-50" data-target="issue-detail-8285" aria-expanded="false" title="Toggle issue details">
                                <svg class="w-4 h-4 transform transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path></svg>
                            </button>
                        </td>
                    </tr>
                    <tr id="issue-detail-8285" class="issue-detail-row bg-gray-50 border-b border-gray-200 hidden">
                        <td colspan="8" class="px-6 py-6">
                            <div class="grid grid-cols-1 lg:grid-cols-12 gap-6">
                                <div class="lg:col-span-4">
                                    <div class="h-44 rounded-xl bg-gradient-to-r from-emerald-700 to-green-900 flex items-center justify-center text-emerald-50 font-semibold">Issue Evidence Image</div>
                                    <div class="grid grid-cols-2 gap-4 mt-4">
                                        <div class="bg-white rounded-xl border border-gray-200 p-4 text-center">
                                            <p class="text-xs text-gray-500 uppercase font-semibold">Upvotes</p>
                                            <p class="text-2xl font-bold mt-1 text-gray-800">61</p>
                                        </div>
                                        <div class="bg-white rounded-xl border border-gray-200 p-4 text-center">
                                            <p class="text-xs text-gray-500 uppercase font-semibold">Ward No.</p>
                                            <p class="text-2xl font-bold mt-1 text-gray-800">09</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="lg:col-span-5">
                                    <h3 class="text-xs tracking-wide uppercase text-gray-500 font-semibold">Description</h3>
                                    <p class="mt-2 text-gray-700 leading-relaxed">Overflowing waste near the heritage zone caused odor issues and blocked pedestrian access. Municipal sanitation unit completed removal and deep clean on-site.</p>
                                    <h3 class="text-xs tracking-wide uppercase text-gray-500 font-semibold mt-6">Timeline Audit Trail</h3>
                                    <div class="mt-3 space-y-3">
                                        <div class="flex items-start gap-3">
                                            <div class="w-2.5 h-2.5 rounded-full bg-blue-600 mt-2"></div>
                                            <div>
                                                <p class="font-semibold text-gray-800">Issue Reported</p>
                                                <p class="text-sm text-gray-500">Oct 22, 2023 - 07:30 AM</p>
                                            </div>
                                        </div>
                                        <div class="flex items-start gap-3">
                                            <div class="w-2.5 h-2.5 rounded-full bg-green-600 mt-2"></div>
                                            <div>
                                                <p class="font-semibold text-gray-800">Issue Resolved</p>
                                                <p class="text-sm text-gray-500">Oct 22, 2023 - 04:45 PM</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="lg:col-span-3 space-y-3">
                                    <button type="button" class="w-full bg-blue-600 text-white font-semibold rounded-xl py-3 hover:bg-blue-700">View Resolution</button>
                                    <button type="button" class="w-full bg-gray-200 text-gray-700 font-semibold rounded-xl py-3 hover:bg-gray-300">Reopen Issue</button>
                                    <button type="button" class="w-full border border-red-200 text-red-500 font-semibold rounded-xl py-3 hover:bg-red-50">Archive Record</button>
                                </div>
                            </div>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script>
    document.querySelectorAll('.issue-toggle').forEach(function (button) {
        button.addEventListener('click', function () {
            var targetId = button.getAttribute('data-target');
            var detailRow = document.getElementById(targetId);
            if (!detailRow) {
                return;
            }

            var isExpanded = button.getAttribute('aria-expanded') === 'true';
            detailRow.classList.toggle('hidden', isExpanded);
            button.setAttribute('aria-expanded', isExpanded ? 'false' : 'true');

            var icon = button.querySelector('svg');
            if (icon) {
                icon.classList.toggle('rotate-180', !isExpanded);
            }
        });
    });
</script>
