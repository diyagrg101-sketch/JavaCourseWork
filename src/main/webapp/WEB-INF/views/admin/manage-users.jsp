<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<body>
<%@ include file="/WEB-INF/views/common/adminNavbar.jsp" %>

<div class="sidebar-layout">

    <%@ include file="/WEB-INF/views/common/admin-sidebar.jsp" %>

    <div class="main-content">

        <div class="admin-topbar">
            <div class="admin-topbar-left">
                <h1>Manage Users</h1>
                <p>View and manage customer and staff accounts.</p>
            </div>

            <div class="admin-topbar-right">
                <div class="admin-search">
                    <span>🔍</span>
                    <input type="text" id="searchInput" onkeyup="filterUsers()" placeholder="Search by name, email..."/>
                </div>
            </div>
        </div>

        <!-- STAT ROW -->
        <div class="stat-summary-row">
            <div class="stat-sum-card">
                <div class="stat-sum-ico">👥</div>
                <div>
                    <div class="stat-sum-val">${totalUsers}</div>
                    <div class="stat-sum-label">Total Users</div>
                </div>
            </div>

            <div class="stat-sum-card">
                <div class="stat-sum-ico" style="background:#e3f2fd">👤</div>
                <div>
                    <div class="stat-sum-val">${totalCustomers}</div>
                    <div class="stat-sum-label">Customers</div>
                </div>
            </div>

            <div class="stat-sum-card">
                <div class="stat-sum-ico" style="background:rgba(200,104,10,.12)">🛡️</div>
                <div>
                    <div class="stat-sum-val">${totalAdmins}</div>
                    <div class="stat-sum-label">Staff / Admin</div>
                </div>
            </div>

            <div class="stat-sum-card">
                <div class="stat-sum-ico" style="background:#ffebee">🚫</div>
                <div>
                    <div class="stat-sum-val">0</div>
                    <div class="stat-sum-label">Suspended</div>
                </div>
            </div>
        </div>

        <!-- FILTERS -->
        <div class="filter-row">
            <select id="roleFilter" class="filter-select" onchange="filterUsers()">
                <option value="ALL">All Roles</option>
                <option value="CUSTOMER">Customer</option>
                <option value="ADMIN">Admin</option>
            </select>

            <select id="statusFilter" class="filter-select" onchange="filterUsers()">
                <option value="ALL">All Status</option>
                <option value="ACTIVE">Active</option>
                <option value="SUSPENDED">Suspended</option>
            </select>

            <select id="sortFilter" class="filter-select" onchange="sortUsers()">
                <option value="NEWEST">Sort: Newest</option>
                <option value="NAME_AZ">Sort: Name A–Z</option>
            </select>

            <div style="margin-left:auto;display:flex;gap:8px">
                <button class="btn btn-outline">⬇️ Export</button>
            </div>
        </div>

        <!-- TABLE -->
        <div class="admin-table-card">
            <table>
                <thead>
                <tr>
                    <th>User</th>
                    <th>Role</th>
                    <th>Email</th>
                    <th>Total Orders</th>
                    <th>Wallet Balance</th>
                    <th>Joined</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody id="userTableBody">

                <c:forEach var="user" items="${users}">
                    <!-- Added data attributes for filter and sort -->
                    <tr class="user-row"
                        data-role="${user.role.toUpperCase()}"
                        data-status="ACTIVE"
                        data-name="${user.fullName.toLowerCase()}"
                        data-date="${user.id}"> <!-- Using ID as a proxy for 'newest' if joinedDate is missing -->

                        <td>
                            <div class="user-avatar-cell">
                                <div class="user-avatar-sm">
                                        ${user.fullName.charAt(0)}
                                </div>
                                <div>
                                    <div style="font-weight:600;font-size:.85rem">
                                            ${user.fullName}
                                    </div>
                                </div>
                            </div>
                        </td>

                        <td>${user.role}</td>

                        <td>
                            <div class="user-email" style="font-size:.74rem;color:var(--text-muted)">
                                    ${user.email}
                            </div>
                        </td>

                        <td style="font-weight:600">0</td>

                        <td style="font-weight:600;color:var(--orange)">
                            NPR 0
                        </td>

                        <td style="font-size:.8rem;color:var(--text-muted)">-</td>

                        <td>
                            <span class="badge badge-success">Active</span>
                        </td>

                        <td>
                            <div class="tbl-actions">
                                <button class="tbl-btn">✏️</button>
                                <button class="tbl-btn danger">🗑️</button>
                            </div>
                        </td>
                    </tr>
                </c:forEach>

                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- MODALS (SAME AS BEFORE) -->
<div class="modal-overlay hidden" id="viewUserModal">
    <div class="modal">
        <div class="modal-header">
            <div>
                <div class="modal-title">User Profile</div>
                <div class="modal-sub">Detailed account information</div>
            </div>
            <button class="modal-close" onclick="closeModal('viewUserModal')">✕</button>
        </div>
        <div class="modal-footer">
            <button class="btn btn-outline" onclick="closeModal('viewUserModal')">Close</button>
            <button class="btn btn-primary">Edit User</button>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

<script>

    function filterUsers() {
        const roleVal = document.getElementById('roleFilter').value;
        const statusVal = document.getElementById('statusFilter').value;
        const searchVal = document.getElementById('searchInput').value.toLowerCase();
        const rows = document.querySelectorAll('.user-row');

        rows.forEach(row => {
            const role = row.getAttribute('data-role');
            const status = row.getAttribute('data-status');
            const name = row.getAttribute('data-name');
            const email = row.querySelector('.user-email').textContent.toLowerCase();

            const matchesRole = (roleVal === "ALL" || role === roleVal);
            const matchesStatus = (statusVal === "ALL" || status === statusVal);
            const matchesSearch = (name.includes(searchVal) || email.includes(searchVal));

            if (matchesRole && matchesStatus && matchesSearch) {
                row.style.display = "";
            } else {
                row.style.display = "none";
            }
        });
    }

    function sortUsers() {
        const sortVal = document.getElementById('sortFilter').value;
        const tbody = document.getElementById('userTableBody');
        const rows = Array.from(tbody.querySelectorAll('.user-row'));

        rows.sort((a, b) => {
            if (sortVal === "NAME_AZ") {
                return a.getAttribute('data-name').localeCompare(b.getAttribute('data-name'));
            } else if (sortVal === "NEWEST") {

                return parseInt(b.getAttribute('data-date')) - parseInt(a.getAttribute('data-date'));
            }
            return 0;
        });

        rows.forEach(row => tbody.appendChild(row));
    }

    function openModal(id){
        document.getElementById(id).classList.remove('hidden');
    }
    function closeModal(id){
        document.getElementById(id).classList.add('hidden');
    }
</script>

</body>
</html>