<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../common/header.jsp"/>

<body class="bg-gray-50">
<div class="flex">
    <jsp:include page="../common/sidebar.jsp"/>
    <div class="flex-1 container mx-auto px-4 py-8 ml-64">
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
            <!-- Total Issues -->
            <div class="bg-white p-6 rounded-2xl shadow">
                <div class="text-sm text-gray-500">Total Issues</div>
                <div class="text-3xl font-bold mt-2">12,482 <span class="text-green-500 text-base font-semibold">+12%</span></div>
                <div class="text-xs text-gray-400 mt-3 flex items-center">
                    <svg class="w-4 h-4 mr-1 text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7l5 5m0 0l-5 5m5-5H6"></path></svg>
                    Increased from last month
                </div>
            </div>
            <!-- Total Municipalities -->
            <div class="bg-white p-6 rounded-2xl shadow">
                <div class="text-sm text-gray-500">Total Municipalities</div>
                <div class="text-3xl font-bold mt-2">284</div>
                <div class="text-xs text-gray-400 mt-3 flex items-center">
                    <svg class="w-4 h-4 mr-1 text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h6m-6 4h6m-6 4h6"></path></svg>
                    Active governing bodies
                </div>
            </div>
            <!-- Total Citizens -->
            <div class="bg-white p-6 rounded-2xl shadow">
                <div class="text-sm text-gray-500">Total Citizen</div>
                <div class="text-3xl font-bold mt-2">1.2M</div>
                <div class="text-xs text-gray-400 mt-3 flex items-center">
                    <svg class="w-4 h-4 mr-1 text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.653-.184-1.268-.5-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.653.184-1.268.5-1.857m0 0a5.002 5.002 0 019 0m-4.5-5a3 3 0 100-6 3 3 0 000 6z"></path></svg>
                    Registered portal users
                </div>
            </div>
            <!-- Resolved Rate -->
            <div class="bg-white p-6 rounded-2xl shadow">
                <div class="text-sm text-gray-500">Resolved Rate (%)</div>
                <div class="text-3xl font-bold mt-2">84.2%</div>
                <div class="text-xs text-gray-400 mt-3 flex items-center">
                    <svg class="w-4 h-4 mr-1 text-blue-500" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                    Efficiency benchmark
                </div>
            </div>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-3 gap-6 mt-8">
            <!-- Recent Issue Reports -->
            <div class="lg:col-span-2 bg-white p-6 rounded-2xl shadow">
                <div class="flex justify-between items-center mb-4">
                    <div>
                        <h2 class="text-lg font-bold">Recent Issue Reports</h2>
                        <p class="text-sm text-gray-500">LIVE STREAM OF CITY UPDATES</p>
                    </div>
                    <a href="#" class="text-sm font-semibold text-blue-600">VIEW ALL REPORTS</a>
                </div>
                <table class="w-full text-left">
                    <thead>
                    <tr class="text-xs text-gray-500 border-b">
                        <th class="py-3">ISSUE TITLE</th>
                        <th class="py-3">MUNICIPALITY</th>
                        <th class="py-3">CATEGORY</th>
                        <th class="py-3">STATUS</th>
                        <th class="py-3">DATE</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr class="border-b">
                        <td class="py-4">
                            <p class="font-semibold">Broken Water Main</p>
                            <p class="text-xs text-gray-400">#ISS-9042</p>
                        </td>
                        <td class="py-4">Kathmandu Metro</td>
                        <td class="py-4">Infrastructure</td>
                        <td class="py-4"><span class="bg-yellow-200 text-yellow-800 text-xs font-semibold px-2.5 py-0.5 rounded-full">PENDING</span></td>
                        <td class="py-4 text-sm">Oct 24, 2023</td>
                    </tr>
                    <tr class="border-b">
                        <td class="py-4">
                            <p class="font-semibold">Street Light Fault</p>
                            <p class="text-xs text-gray-400">#ISS-8812</p>
                        </td>
                        <td class="py-4">Lalitpur Sub-Metro</td>
                        <td class="py-4">Utilities</td>
                        <td class="py-4"><span class="bg-blue-200 text-blue-800 text-xs font-semibold px-2.5 py-0.5 rounded-full">ONGOING</span></td>
                        <td class="py-4 text-sm">Oct 23, 2023</td>
                    </tr>
                    <tr class="border-b">
                        <td class="py-4">
                            <p class="font-semibold">Illegal Dumping Site</p>
                            <p class="text-xs text-gray-400">#ISS-7721</p>
                        </td>
                        <td class="py-4">Pokhara City</td>
                        <td class="py-4">Environment</td>
                        <td class="py-4"><span class="bg-green-200 text-green-800 text-xs font-semibold px-2.5 py-0.5 rounded-full">FINISHED</span></td>
                        <td class="py-4 text-sm">Oct 22, 2023</td>
                    </tr>
                    <tr class="border-b">
                        <td class="py-4">
                            <p class="font-semibold">Pothole Repair</p>
                            <p class="text-xs text-gray-400">#ISS-9102</p>
                        </td>
                        <td class="py-4">Bharatpur</td>
                        <td class="py-4">Roads</td>
                        <td class="py-4"><span class="bg-yellow-200 text-yellow-800 text-xs font-semibold px-2.5 py-0.5 rounded-full">PENDING</span></td>
                        <td class="py-4 text-sm">Oct 22, 2023</td>
                    </tr>
                    <tr>
                        <td class="py-4">
                            <p class="font-semibold">Sewage Leak</p>
                            <p class="text-xs text-gray-400">#ISS-9128</p>
                        </td>
                        <td class="py-4">Biratnagar</td>
                        <td class="py-4">Sanitation</td>
                        <td class="py-4"><span class="bg-blue-200 text-blue-800 text-xs font-semibold px-2.5 py-0.5 rounded-full">ONGOING</span></td>
                        <td class="py-4 text-sm">Oct 21, 2023</td>
                    </tr>
                    </tbody>
                </table>
            </div>

            <!-- By Category & System Audit -->
            <div class="space-y-6">
                <div class="bg-white p-6 rounded-2xl shadow">
                    <div class="flex justify-between items-center mb-4">
                        <div>
                            <h2 class="text-lg font-bold">By Category</h2>
                            <p class="text-sm text-gray-500">DISTRIBUTION ANALYSIS</p>
                        </div>
                        <svg class="w-6 h-6 text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h7"></path></svg>
                    </div>
                    <div class="space-y-4">
                        <div>
                            <div class="flex justify-between text-sm mb-1">
                                <span>INFRASTRUCTURE</span>
                                <span>42%</span>
                            </div>
                            <div class="w-full bg-gray-200 rounded-full h-2">
                                <div class="bg-blue-600 h-2 rounded-full" style="width: 42%"></div>
                            </div>
                        </div>
                        <div>
                            <div class="flex justify-between text-sm mb-1">
                                <span>UTILITIES</span>
                                <span>28%</span>
                            </div>
                            <div class="w-full bg-gray-200 rounded-full h-2">
                                <div class="bg-blue-600 h-2 rounded-full" style="width: 28%"></div>
                            </div>
                        </div>
                        <div>
                            <div class="flex justify-between text-sm mb-1">
                                <span>SANITATION</span>
                                <span>15%</span>
                            </div>
                            <div class="w-full bg-gray-200 rounded-full h-2">
                                <div class="bg-blue-600 h-2 rounded-full" style="width: 15%"></div>
                            </div>
                        </div>
                        <div>
                            <div class="flex justify-between text-sm mb-1">
                                <span>ENVIRONMENT</span>
                                <span>10%</span>
                            </div>
                            <div class="w-full bg-gray-200 rounded-full h-2">
                                <div class="bg-blue-600 h-2 rounded-full" style="width: 10%"></div>
                            </div>
                        </div>
                        <div>
                            <div class="flex justify-between text-sm mb-1">
                                <span>OTHER</span>
                                <span>5%</span>
                            </div>
                            <div class="w-full bg-gray-200 rounded-full h-2">
                                <div class="bg-gray-300 h-2 rounded-full" style="width: 5%"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="bg-blue-600 text-white p-6 rounded-2xl shadow-lg">
                    <h2 class="text-lg font-bold">System Audit</h2>
                    <p class="text-sm mt-2">Review all municipal activity logs and performance benchmarks for the current fiscal quarter.</p>
                    <button class="mt-4 bg-white text-blue-600 font-semibold py-2 px-4 rounded-lg">GENERATE REPORT</button>
                </div>
            </div>
        </div>

        <!-- Global System Events -->
        <div class="mt-8 bg-white p-6 rounded-2xl shadow">
            <h2 class="text-lg font-bold">Global System Events</h2>
            <p class="text-sm text-gray-500">REAL-TIME INFRASTRUCTURE ACTIVITY</p>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mt-6">
                <!-- System Sync -->
                <div class="bg-gray-50 p-4 rounded-lg border-l-4 border-blue-500">
                    <div class="flex justify-between items-center">
                        <span class="text-sm font-semibold text-blue-500">SYSTEM SYNC</span>
                        <span class="text-xs text-gray-400">2 min ago</span>
                    </div>
                    <h3 class="font-bold mt-2">Data Integrity Check Complete</h3>
                    <p class="text-sm text-gray-600 mt-1">All municipal databases successfully synchronized with the central repository.</p>
                </div>
                <!-- Alert -->
                <div class="bg-gray-50 p-4 rounded-lg border-l-4 border-yellow-500">
                    <div class="flex justify-between items-center">
                        <span class="text-sm font-semibold text-yellow-500">ALERT</span>
                        <span class="text-xs text-gray-400">14 min ago</span>
                    </div>
                    <h3 class="font-bold mt-2">Service Outage Detected</h3>
                    <p class="text-sm text-gray-600 mt-1">Minor disruption reported in Bharatpur payment gateway. Maintenance team notified.</p>
                </div>
                <!-- New Unit -->
                <div class="bg-gray-50 p-4 rounded-lg border-l-4 border-green-500">
                    <div class="flex justify-between items-center">
                        <span class="text-sm font-semibold text-green-500">NEW UNIT</span>
                        <span class="text-xs text-gray-400">1 hour ago</span>
                    </div>
                    <h3 class="font-bold mt-2">Dharan Municipality Onboarded</h3>
                    <p class="text-sm text-gray-600 mt-1">Successfully integrated Dharan Sub-Metro into the NagarSewa governance network.</p>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
