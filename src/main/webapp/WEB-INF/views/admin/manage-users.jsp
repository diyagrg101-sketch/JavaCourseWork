<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />


<!DOCTYPE html>
<html lang="en">
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<body>
<%@ include file="/WEB-INF/views/common/adminNavbar.jsp" %>

<div class="sidebar-layout">

    <!-- SIDEBAR -->
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
                    <input type="text" placeholder="Search by name, email..."/>
                </div>

                <button class="btn btn-primary" onclick="openModal('addUserModal')">
                    + &nbsp;Add User
                </button>
            </div>
        </div>

        <!-- STAT ROW -->
        <div class="stat-summary-row">
            <div class="stat-sum-card">
                <div class="stat-sum-ico">👥</div>
                <div>
                    <div class="stat-sum-val">1,240</div>
                    <div class="stat-sum-label">Total Users</div>
                    <div class="stat-sum-trend">↗ +18% this month</div>
                </div>
            </div>

            <div class="stat-sum-card">
                <div class="stat-sum-ico" style="background:#e3f2fd">👤</div>
                <div>
                    <div class="stat-sum-val">1,225</div>
                    <div class="stat-sum-label">Customers</div>
                </div>
            </div>

            <div class="stat-sum-card">
                <div class="stat-sum-ico" style="background:rgba(200,104,10,.12)">🛡️</div>
                <div>
                    <div class="stat-sum-val">8</div>
                    <div class="stat-sum-label">Staff / Admin</div>
                </div>
            </div>

            <div class="stat-sum-card">
                <div class="stat-sum-ico" style="background:#ffebee">🚫</div>
                <div>
                    <div class="stat-sum-val">7</div>
                    <div class="stat-sum-label">Suspended</div>
                </div>
            </div>
        </div>

        <!-- FILTERS -->
        <div class="filter-row">
            <select class="filter-select">
                <option>All Roles</option>
                <option>Customer</option>
                <option>Staff</option>
                <option>Admin</option>
            </select>

            <select class="filter-select">
                <option>All Status</option>
                <option>Active</option>
                <option>Suspended</option>
            </select>

            <select class="filter-select">
                <option>Sort: Newest</option>
                <option>Sort: Name A–Z</option>
                <option>Sort: Most Orders</option>
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
                    <th><input type="checkbox"/></th>
                    <th>User</th>
                    <th>Role</th>
                    <th>Phone</th>
                    <th>Total Orders</th>
                    <th>Wallet Balance</th>
                    <th>Joined</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                </thead>

                <tbody>

                <!-- Example row (static same as yours) -->
                <tr>
                    <td><input type="checkbox"/></td>

                    <td>
                        <div class="user-avatar-cell">
                            <div class="user-avatar-sm">AK</div>
                            <div>
                                <div style="font-weight:600;font-size:.85rem">Arjun Karki</div>
                                <div style="font-size:.74rem;color:var(--text-muted)">arjun.karki@example.com</div>
                            </div>
                        </div>
                    </td>

                    <td>Customer</td>
                    <td style="font-size:.82rem">+977 9801234567</td>
                    <td style="font-weight:600">24</td>
                    <td style="font-weight:600;color:var(--orange)">NPR 1,250</td>
                    <td style="font-size:.8rem;color:var(--text-muted)">Oct 2022</td>
                    <td><span class="badge badge-success">Active</span></td>

                    <td>
                        <div class="tbl-actions">
                            <button class="tbl-btn" onclick="openModal('viewUserModal')">👁️</button>
                            <button class="tbl-btn" onclick="openModal('editUserModal')">✏️</button>
                            <button class="tbl-btn danger">🚫</button>
                        </div>
                    </td>
                </tr>

                </tbody>
            </table>

            <div class="pagination">
                <span>Showing 1–6 of 1,240 users</span>
            </div>
        </div>

    </div>
</div>

<!-- VIEW USER MODAL -->
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

<!-- ADD USER MODAL -->
<div class="modal-overlay hidden" id="addUserModal">
    <div class="modal">
        <div class="modal-header">
            <div>
                <div class="modal-title">Add New User</div>
                <div class="modal-sub">Create a new customer or staff account.</div>
            </div>
            <button class="modal-close" onclick="closeModal('addUserModal')">✕</button>
        </div>

        <div class="form-group">
            <label>Full Name</label>
            <input class="form-control"/>
        </div>

        <div class="modal-footer">
            <button class="btn btn-outline" onclick="closeModal('addUserModal')">Cancel</button>
            <button class="btn btn-primary">Create User</button>
        </div>
    </div>
</div>

<!-- EDIT USER MODAL -->
<div class="modal-overlay hidden" id="editUserModal">
    <div class="modal">
        <div class="modal-header">
            <div>
                <div class="modal-title">Edit User</div>
                <div class="modal-sub">Update user information</div>
            </div>
            <button class="modal-close" onclick="closeModal('editUserModal')">✕</button>
        </div>

        <div class="form-group">
            <label>Full Name</label>
            <input class="form-control" value="Arjun Karki"/>
        </div>

        <div class="modal-footer">
            <button class="btn btn-outline" onclick="closeModal('editUserModal')">Cancel</button>
            <button class="btn btn-primary">Save Changes</button>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
<script>
    function openModal(id){
        document.getElementById(id).classList.remove('hidden');
    }
    function closeModal(id){
        document.getElementById(id).classList.add('hidden');
    }
</script>

</body>
</html>