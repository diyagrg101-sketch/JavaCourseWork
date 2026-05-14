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

    <!-- MAIN -->
    <div class="main-content">

        <h1 style="font-size:1.5rem;font-weight:800;margin-bottom:4px">
            Admin Dashboard
        </h1>

        <p style="font-size:.84rem;color:var(--text-muted);margin-bottom:22px">
            Welcome back! Here's what's happening at Sip and Serve today.
        </p>

        <!-- STAT CARDS -->
        <div class="admin-stats">

            <div class="stat-card">
                <div>
                    <div class="stat-label">Total Orders</div>
                    <div class="stat-val">156</div>
                    <div class="stat-trend">↗ +12% vs last month</div>
                </div>
                <div class="stat-ico">📦</div>
            </div>

            <div class="stat-card">
                <div>
                    <div class="stat-label">Total Revenue</div>
                    <div class="stat-val">NPR 42,850</div>
                    <div class="stat-trend">↗ +8% vs last month</div>
                </div>
                <div class="stat-ico">💵</div>
            </div>

            <div class="stat-card">
                <div>
                    <div class="stat-label">Total Customers</div>
                    <div class="stat-val">1,240</div>
                    <div class="stat-trend">↗ +18% vs last month</div>
                </div>
                <div class="stat-ico">👥</div>
            </div>

            <div class="stat-card">
                <div>
                    <div class="stat-label">Avg. Prep Time</div>
                    <div class="stat-val">14 mins</div>
                    <div class="stat-trend">↘ -4% vs last month</div>
                </div>
                <div class="stat-ico">⏱️</div>
            </div>

        </div>

        <!-- POPULAR + QUICK ACTIONS -->
        <div class="admin-grid">

            <div class="popular-card">
                <div class="popular-head">
                    <div>
                        <div style="font-weight:700">Popular Items</div>
                        <div style="font-size:.78rem;color:var(--text-muted)">
                            Most ordered items this week
                        </div>
                    </div>
                </div>

                <div class="chart-bars">
                    <div class="bar-wrap"><div class="bar" style="height:160px"></div><span>Caramel</span></div>
                    <div class="bar-wrap"><div class="bar" style="height:130px"></div><span>Cappuccino</span></div>
                    <div class="bar-wrap"><div class="bar" style="height:100px"></div><span>Espresso</span></div>
                    <div class="bar-wrap"><div class="bar" style="height:95px"></div><span>Mocha</span></div>
                    <div class="bar-wrap"><div class="bar" style="height:75px"></div><span>Latte</span></div>
                </div>
            </div>

            <div class="quick-actions-card">
                <div class="qa-card-title">Quick Actions</div>
                <div class="qa-card-sub">Manage your daily operations</div>

                <div class="qa-list">
                    <button class="qa-list-btn">➕ Add New Menu Item</button>
                    <button class="qa-list-btn">📋 Manage Active Orders</button>
                    <button class="qa-list-btn">📄 Generate Sales Report</button>
                    <button class="qa-list-btn">📦 Inventory Status</button>
                </div>
            </div>

        </div>

        <!-- RECENT ORDERS -->
        <div class="orders-table">

            <div class="ot-head">
                <div>
                    <div style="font-weight:700">Recent Orders</div>
                    <p class="ot-sub">You have 2 orders pending preparation.</p>
                </div>
            </div>

            <table>
                <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Customer</th>
                    <th>Items</th>
                    <th>Total</th>
                    <th>Status</th>
                    <th>Time</th>
                </tr>
                </thead>

                <tbody>

                <tr>
                    <td><span class="order-id-link">#ORD-8821</span></td>
                    <td>Anjali Sharma</td>
                    <td>3 items</td>
                    <td>NPR 1,250</td>
                    <td><span class="status-pill preparing">Preparing</span></td>
                    <td style="color:var(--text-muted);font-size:.8rem">5 mins ago</td>
                </tr>

                <tr>
                    <td><span class="order-id-link">#ORD-8820</span></td>
                    <td>Rohan Gupta</td>
                    <td>1 items</td>
                    <td>NPR 450</td>
                    <td><span class="status-pill ready">Ready</span></td>
                    <td style="color:var(--text-muted);font-size:.8rem">12 mins ago</td>
                </tr>

                </tbody>

            </table>

        </div>

    </div>
</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>