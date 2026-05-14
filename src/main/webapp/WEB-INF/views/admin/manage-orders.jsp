<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<body>
<!-- NAVBAR -->
<%@ include file="/WEB-INF/views/common/adminNavbar.jsp" %>

<div class="sidebar-layout">

    <!-- SIDEBAR -->
    <%@ include file="/WEB-INF/views/common/admin-sidebar.jsp" %>

    <!-- MAIN CONTENT -->
    <div class="main-content">

        <!-- TOPBAR -->
        <div class="admin-topbar">

            <div class="admin-topbar-left">
                <h1>Manage Orders</h1>

                <p>
                    View, update and manage all customer orders in real-time.
                </p>
            </div>

            <div class="admin-topbar-right">

                <div class="admin-search">

                    <span>🔍</span>

                    <input type="text"
                           placeholder="Search by order ID, customer..."/>

                </div>

                <button class="btn btn-outline"
                        onclick="exportOrders()">

                    ⬇️ &nbsp;Export

                </button>

            </div>

        </div>

        <!-- STAT ROW -->
        <div class="stat-summary-row">

            <div class="stat-sum-card">

                <div class="stat-sum-ico">📋</div>

                <div>
                    <div class="stat-sum-val">156</div>
                    <div class="stat-sum-label">Total Orders Today</div>
                    <div class="stat-sum-trend">↗ +12%</div>
                </div>

            </div>

            <div class="stat-sum-card">

                <div class="stat-sum-ico"
                     style="background:#fff8e1">

                    🔥

                </div>

                <div>
                    <div class="stat-sum-val">5</div>
                    <div class="stat-sum-label">Pending / Preparing</div>
                </div>

            </div>

            <div class="stat-sum-card">

                <div class="stat-sum-ico"
                     style="background:#e8f5e9">

                    ✅

                </div>

                <div>
                    <div class="stat-sum-val">142</div>
                    <div class="stat-sum-label">Delivered</div>
                    <div class="stat-sum-trend">↗ +8%</div>
                </div>

            </div>

            <div class="stat-sum-card">

                <div class="stat-sum-ico"
                     style="background:#ffebee">

                    ❌

                </div>

                <div>
                    <div class="stat-sum-val">4</div>
                    <div class="stat-sum-label">Cancelled</div>
                    <div class="stat-sum-trend down">↗ +2</div>
                </div>

            </div>

        </div>

        <!-- FILTERS -->
        <div class="filter-row">

            <button class="btn btn-primary"
                    style="font-size:.8rem;padding:7px 14px"
                    onclick="filterStatus('all')">

                All Orders

            </button>

            <button class="btn btn-outline"
                    style="font-size:.8rem;padding:7px 14px"
                    onclick="filterStatus('preparing')">

                🔥 Preparing (5)

            </button>

            <button class="btn btn-outline"
                    style="font-size:.8rem;padding:7px 14px"
                    onclick="filterStatus('ready')">

                ✅ Ready (3)

            </button>

            <button class="btn btn-outline"
                    style="font-size:.8rem;padding:7px 14px"
                    onclick="filterStatus('delivered')">

                📦 Delivered

            </button>

            <button class="btn btn-outline"
                    style="font-size:.8rem;padding:7px 14px"
                    onclick="filterStatus('cancelled')">

                ❌ Cancelled

            </button>

            <div style="margin-left:auto;display:flex;gap:8px">

                <select class="filter-select">

                    <option>All Types</option>
                    <option>Dine-in</option>
                    <option>Takeaway</option>
                    <option>Home Delivery</option>

                </select>

                <input type="date"
                       class="date-input"
                       value="2024-10-24"/>

            </div>

        </div>

        <!-- TABLE -->
        <div class="admin-table-card">
            <table>
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" style="accent-color:var(--orange)"/>
                    </th>
                    <th>Order ID</th>
                    <th>Customer</th>
                    <th>Items</th>
                    <th>Type</th>
                    <th>Total</th>
                    <th>Status</th>
                    <th>Time</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>

                <tr>
                    <td><input type="checkbox" style="accent-color:var(--orange)"/></td>
                    <td><span class="order-id-link">#ORD-8825</span></td>
                    <td>
                        <div class="user-avatar-cell">
                            <div class="user-avatar-sm">AS</div>
                            <div><div style="font-weight:600;font-size:.84rem">Anjali Sharma</div><div style="font-size:.74rem;color:var(--text-muted)">+977 9845XXXXX</div></div>
                        </div>
                    </td>
                    <td>
                        <div style="font-size:.82rem">Himalayan Latte ×2</div>
                        <div style="font-size:.74rem;color:var(--text-muted)">+ 1 more item</div>
                    </td>
                    <td><span class="badge badge-info">🍽️ Dine-in</span></td>
                    <td style="font-weight:700">NPR 1,250</td>
                    <td><span class="badge badge-warning">🔥 Preparing</span></td>
                    <td style="font-size:.8rem;color:var(--text-muted)">5 mins ago</td>
                    <td>
                        <div class="tbl-actions">
                            <button class="tbl-btn" onclick="openModal('viewOrderModal')" title="View">👁️</button>
                            <button class="tbl-btn" onclick="openModal('updateStatusModal')" title="Update Status">🔄</button>
                            <button class="tbl-btn danger" title="Cancel">❌</button>
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>

        </div>

    </div>

</div>

<!-- VIEW ORDER MODAL -->
<div class="modal-overlay hidden"
     id="viewOrderModal">

    <div class="modal"
         style="max-width:560px">

        <div class="modal-header">

            <div>

                <div class="modal-title">
                    Order #ORD-8825
                </div>

                <div class="modal-sub">
                    Placed on Oct 24, 2024 at 10:15 AM
                </div>

            </div>

            <button class="modal-close"
                    onclick="closeModal('viewOrderModal')">

                ✕

            </button>

        </div>

        <div class="modal-footer">

            <button class="btn btn-outline"
                    onclick="closeModal('viewOrderModal')">

                Close

            </button>

            <button class="btn btn-primary">
                Update Order
            </button>

        </div>

    </div>

</div>

<!-- UPDATE STATUS MODAL -->
<div class="modal-overlay hidden"
     id="updateStatusModal">

    <div class="modal"
         style="max-width:380px">

        <div class="modal-header">

            <div>

                <div class="modal-title">
                    Update Order Status
                </div>

                <div class="modal-sub">
                    Order #ORD-8825
                </div>

            </div>

            <button class="modal-close"
                    onclick="closeModal('updateStatusModal')">

                ✕

            </button>

        </div>

        <div class="modal-footer">

            <button class="btn btn-outline"
                    onclick="closeModal('updateStatusModal')">

                Cancel

            </button>

            <button class="btn btn-primary">
                Apply Status
            </button>

        </div>

    </div>

</div>

<script>

    function openModal(id){
        document.getElementById(id).classList.remove('hidden');
    }

    function closeModal(id){
        document.getElementById(id).classList.add('hidden');
    }

    function filterStatus(s){
        console.log('filter:', s);
    }

    function exportOrders(){
        alert('Exporting orders as CSV...');
    }

    window.addEventListener('click', e => {

        document.querySelectorAll('.modal-overlay').forEach(m => {

            if(e.target === m){
                m.classList.add('hidden');
            }

        });

    });

</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

</body>
</html>
