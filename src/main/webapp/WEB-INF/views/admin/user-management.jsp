<%--
  Created by IntelliJ IDEA.
  User: raksh
  Date: 4/6/2026
  Time: 3:20 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../common/header.jsp"/>
<div class="flex min-h-screen bg-gray-100">
  <jsp:include page="../common/sidebar.jsp"/>
  <div class="flex-1 ml-0 md:ml-64 p-4 md:p-8 overflow-x-hidden">
    <div class="max-w-[1200px] mx-auto">
      <div class="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
        <div class="flex items-center gap-6 border-b border-gray-200">
          <button id="tab-municipal" type="button" class="tab-btn py-3 text-sm font-semibold border-b-2 border-blue-600 text-blue-600" data-target="municipal-section">Municipal Heads</button>
          <button id="tab-citizen" type="button" class="tab-btn py-3 text-sm font-semibold border-b-2 border-transparent text-gray-500 hover:text-gray-700" data-target="citizen-section">Citizens</button>
        </div>
        <button id="open-municipal-form" type="button" class="inline-flex items-center justify-center gap-2 bg-blue-600 text-white px-5 py-2.5 rounded-xl font-semibold hover:bg-blue-700">
          <span class="text-lg leading-none">+</span>
          Add Municipal Head
        </button>
      </div>

      <section id="municipal-section" class="tab-section mt-6">
        <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div class="bg-white rounded-2xl shadow-sm border border-gray-200 p-5">
            <p class="text-xs font-semibold uppercase tracking-wide text-gray-400">Total Heads</p>
            <p class="mt-2 text-4xl font-bold text-gray-800">42</p>
          </div>
          <div class="bg-white rounded-2xl shadow-sm border border-gray-200 p-5">
            <p class="text-xs font-semibold uppercase tracking-wide text-gray-400">Active</p>
            <p class="mt-2 text-4xl font-bold text-gray-800">38</p>
          </div>
          <div class="bg-blue-50 rounded-2xl shadow-sm border border-blue-200 p-5 flex items-center justify-between">
            <div>
              <p class="text-xs font-semibold uppercase tracking-wide text-blue-600">System Status</p>
              <p class="mt-2 font-semibold text-gray-700">All municipalities reporting</p>
            </div>
            <div class="w-10 h-10 rounded-full bg-blue-600 text-white flex items-center justify-center font-bold">✓</div>
          </div>
        </div>

        <div class="mt-5 bg-white rounded-2xl shadow-sm border border-gray-200 overflow-hidden">
          <div class="overflow-x-auto">
            <table class="w-full text-left">
              <thead class="bg-gray-50 border-b border-gray-200">
              <tr class="text-xs font-semibold text-gray-500 uppercase tracking-wide">
                <th class="px-6 py-4">Name & Role</th>
                <th class="px-6 py-4">Email</th>
                <th class="px-6 py-4">Municipality</th>
                <th class="px-6 py-4">Status</th>
                <th class="px-6 py-4 text-center">Actions</th>
              </tr>
              </thead>
              <tbody class="text-sm text-gray-700">
              <tr class="border-b border-gray-100">
                <td class="px-6 py-4">
                  <p class="font-semibold text-gray-800">Arjun Sharma</p>
                  <p class="text-xs text-gray-500 uppercase">Commissioner</p>
                </td>
                <td class="px-6 py-4 break-all">arjun.s@nagarsewa.gov</td>
                <td class="px-6 py-4">Kathmandu Metro</td>
                <td class="px-6 py-4"><span class="px-3 py-1 rounded-full text-xs font-semibold bg-blue-100 text-blue-700">Active</span></td>
                <td class="px-6 py-4 text-center text-gray-400">•••</td>
              </tr>
              <tr class="border-b border-gray-100">
                <td class="px-6 py-4">
                  <p class="font-semibold text-gray-800">Sunita Rajbhandari</p>
                  <p class="text-xs text-gray-500 uppercase">Lead Architect</p>
                </td>
                <td class="px-6 py-4 break-all">sunita.r@nagarsewa.gov</td>
                <td class="px-6 py-4">Lalitpur Sub-Metro</td>
                <td class="px-6 py-4"><span class="px-3 py-1 rounded-full text-xs font-semibold bg-blue-100 text-blue-700">Active</span></td>
                <td class="px-6 py-4 text-center text-gray-400">•••</td>
              </tr>
              <tr>
                <td class="px-6 py-4">
                  <p class="font-semibold text-gray-800">Binod Pradhan</p>
                  <p class="text-xs text-gray-500 uppercase">Urban Planner</p>
                </td>
                <td class="px-6 py-4 break-all">binod.p@nagarsewa.gov</td>
                <td class="px-6 py-4">Pokhara City</td>
                <td class="px-6 py-4"><span class="px-3 py-1 rounded-full text-xs font-semibold bg-red-100 text-red-600">Suspended</span></td>
                <td class="px-6 py-4 text-center text-gray-400">•••</td>
              </tr>
              </tbody>
            </table>
          </div>
          <div class="px-6 py-4 border-t border-gray-100 text-xs text-gray-500">Showing 3 of 42 municipal heads</div>
        </div>
      </section>

      <section id="citizen-section" class="tab-section mt-6 hidden">
        <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div class="bg-white rounded-2xl shadow-sm border border-gray-200 p-5">
            <p class="text-xs font-semibold uppercase tracking-wide text-gray-400">Total Citizens</p>
            <p class="mt-2 text-4xl font-bold text-gray-800">12,884</p>
          </div>
          <div class="bg-white rounded-2xl shadow-sm border border-gray-200 p-5">
            <p class="text-xs font-semibold uppercase tracking-wide text-gray-400">Verified Accounts</p>
            <p class="mt-2 text-4xl font-bold text-gray-800">11,109</p>
          </div>
          <div class="bg-emerald-50 rounded-2xl shadow-sm border border-emerald-200 p-5">
            <p class="text-xs font-semibold uppercase tracking-wide text-emerald-700">Self Registration</p>
            <p class="mt-2 font-semibold text-gray-700">Citizens onboard themselves through the public portal</p>
          </div>
        </div>

        <div class="mt-5 bg-white rounded-2xl shadow-sm border border-gray-200 overflow-hidden">
          <div class="overflow-x-auto">
            <table class="w-full text-left">
              <thead class="bg-gray-50 border-b border-gray-200">
              <tr class="text-xs font-semibold text-gray-500 uppercase tracking-wide">
                <th class="px-6 py-4">Citizen</th>
                <th class="px-6 py-4">Email</th>
                <th class="px-6 py-4">Municipality</th>
                <th class="px-6 py-4">Issues Reported</th>
                <th class="px-6 py-4">Status</th>
              </tr>
              </thead>
              <tbody class="text-sm text-gray-700">
              <tr class="border-b border-gray-100">
                <td class="px-6 py-4 font-semibold text-gray-800">Nisha Karki</td>
                <td class="px-6 py-4 break-all">nisha.karki@mail.com</td>
                <td class="px-6 py-4">Kathmandu Metro</td>
                <td class="px-6 py-4">13</td>
                <td class="px-6 py-4"><span class="px-3 py-1 rounded-full text-xs font-semibold bg-green-100 text-green-700">Verified</span></td>
              </tr>
              <tr class="border-b border-gray-100">
                <td class="px-6 py-4 font-semibold text-gray-800">Pratik KC</td>
                <td class="px-6 py-4 break-all">pratik.kc@mail.com</td>
                <td class="px-6 py-4">Bhaktapur</td>
                <td class="px-6 py-4">6</td>
                <td class="px-6 py-4"><span class="px-3 py-1 rounded-full text-xs font-semibold bg-green-100 text-green-700">Verified</span></td>
              </tr>
              <tr>
                <td class="px-6 py-4 font-semibold text-gray-800">Mina Gautam</td>
                <td class="px-6 py-4 break-all">mina.gautam@mail.com</td>
                <td class="px-6 py-4">Lalitpur</td>
                <td class="px-6 py-4">1</td>
                <td class="px-6 py-4"><span class="px-3 py-1 rounded-full text-xs font-semibold bg-yellow-100 text-yellow-700">Pending Verification</span></td>
              </tr>
              </tbody>
            </table>
          </div>
          <div class="px-6 py-4 border-t border-gray-100 text-xs text-gray-500">Citizen profiles are system-generated from self registration. No manual add option available.</div>
        </div>
      </section>
    </div>

    <div id="form-overlay" class="fixed inset-0 bg-black/30 z-30 hidden"></div>

    <aside id="municipal-form-panel" class="fixed top-0 right-0 h-full w-full max-w-md bg-white shadow-2xl border-l border-gray-200 z-40 translate-x-full transition-transform duration-300 ease-out overflow-y-auto">
      <div class="p-6 border-b border-gray-200 flex items-center justify-between">
        <h2 class="text-2xl font-bold text-gray-800">Add Municipal Head</h2>
        <button id="close-municipal-form" type="button" class="w-9 h-9 rounded-lg text-gray-500 hover:bg-gray-100">✕</button>
      </div>
      <form class="p-6 space-y-4">
        <div>
          <label class="block text-xs font-semibold uppercase tracking-wide text-gray-500 mb-2">Full Name</label>
          <input type="text" placeholder="e.g. Rajesh Hamal" class="w-full border border-gray-300 rounded-lg px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500">
        </div>
        <div>
          <label class="block text-xs font-semibold uppercase tracking-wide text-gray-500 mb-2">Email Address</label>
          <input type="email" placeholder="name@nagarsewa.gov" class="w-full border border-gray-300 rounded-lg px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500">
        </div>
        <div>
          <label class="block text-xs font-semibold uppercase tracking-wide text-gray-500 mb-2">Password</label>
          <input type="password" placeholder="Set initial password" class="w-full border border-gray-300 rounded-lg px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500">
        </div>
        <div>
          <label class="block text-xs font-semibold uppercase tracking-wide text-gray-500 mb-2">Municipality Name</label>
          <select class="w-full border border-gray-300 rounded-lg px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500">
            <option>Choose Municipality</option>
            <option>Kathmandu Metro</option>
            <option>Lalitpur Sub-Metro</option>
            <option>Pokhara City</option>
            <option>Bhaktapur Municipality</option>
          </select>
        </div>
        <div>
          <label class="block text-xs font-semibold uppercase tracking-wide text-gray-500 mb-2">Role</label>
          <select class="w-full border border-gray-300 rounded-lg px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500">
            <option>Select Role</option>
            <option>Commissioner</option>
            <option>Lead Architect</option>
            <option>Urban Planner</option>
            <option>Operations Lead</option>
          </select>
        </div>

        <button type="submit" class="w-full mt-3 bg-blue-600 text-white rounded-xl py-3 font-semibold hover:bg-blue-700">Create Municipal Head</button>
        <p class="text-xs text-gray-500">An activation email will be sent immediately to the added municipal head.</p>
      </form>
    </aside>
    </div>
</div>

<script>
  (function () {
    var tabButtons = document.querySelectorAll('.tab-btn');
    var tabSections = document.querySelectorAll('.tab-section');
    var municipalButton = document.getElementById('open-municipal-form');

    function setActiveTab(targetId) {
      tabSections.forEach(function (section) {
        section.classList.toggle('hidden', section.id !== targetId);
      });

      tabButtons.forEach(function (button) {
        var active = button.getAttribute('data-target') === targetId;
        button.classList.toggle('text-blue-600', active);
        button.classList.toggle('border-blue-600', active);
        button.classList.toggle('text-gray-500', !active);
        button.classList.toggle('border-transparent', !active);
      });

      if (municipalButton) {
        municipalButton.classList.toggle('hidden', targetId !== 'municipal-section');
      }
    }

    tabButtons.forEach(function (button) {
      button.addEventListener('click', function () {
        setActiveTab(button.getAttribute('data-target'));
      });
    });

    var formPanel = document.getElementById('municipal-form-panel');
    var formOverlay = document.getElementById('form-overlay');
    var closeFormButton = document.getElementById('close-municipal-form');
    var openFormButton = document.getElementById('open-municipal-form');

    function openForm() {
      if (!formPanel || !formOverlay) {
        return;
      }
      formPanel.classList.remove('translate-x-full');
      formOverlay.classList.remove('hidden');
      document.body.classList.add('overflow-hidden');
    }

    function closeForm() {
      if (!formPanel || !formOverlay) {
        return;
      }
      formPanel.classList.add('translate-x-full');
      formOverlay.classList.add('hidden');
      document.body.classList.remove('overflow-hidden');
    }

    if (openFormButton) {
      openFormButton.addEventListener('click', openForm);
    }
    if (closeFormButton) {
      closeFormButton.addEventListener('click', closeForm);
    }
    if (formOverlay) {
      formOverlay.addEventListener('click', closeForm);
    }

    setActiveTab('municipal-section');
  })();
</script>
