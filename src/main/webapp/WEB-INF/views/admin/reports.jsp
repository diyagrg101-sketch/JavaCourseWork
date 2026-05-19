<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<body>

<%@ include file="/WEB-INF/views/common/adminNavbar.jsp" %>

<div class="sidebar-layout">

    <%@ include file="/WEB-INF/views/common/admin-sidebar.jsp" %>

    <div class="main-content">

        <!-- TOPBAR -->
        <div class="admin-topbar">

            <div class="admin-topbar-left">
                <h1>Reports &amp; Analytics</h1>
                <p>Track performance, revenue and customer insights.</p>
            </div>

            <div class="admin-topbar-right">

                <div class="report-export-row">
                    <button class="btn btn-outline">⬇️ Export PDF</button>
                    <button class="btn btn-outline">📊 Export CSV</button>
                    <button class="btn btn-primary">🖨️ Print</button>
                </div>

            </div>

        </div>

        <!-- SUCCESS MESSAGE -->
        <c:if test="${not empty successMsg}">
            <div style="background:#d1fae5;
                        color:#065f46;
                        padding:10px 18px;
                        border-radius:8px;
                        margin-bottom:16px;
                        font-size:.88rem;">

                    ${fn:escapeXml(successMsg)}

            </div>
        </c:if>

        <!-- KPI SECTION -->
        <div class="stat-summary-row" style="margin-bottom:20px">

            <div class="stat-sum-card">
                <div class="stat-sum-ico">💰</div>

                <div>
                    <div class="stat-sum-val">
                        NPR ${stats.totalRevenue}
                    </div>

                    <div class="stat-sum-label">
                        Total Revenue
                    </div>
                </div>
            </div>

            <div class="stat-sum-card">

                <div class="stat-sum-ico"
                     style="background:#e3f2fd">
                    📦
                </div>

                <div>

                    <div class="stat-sum-val">
                        ${stats.totalOrders}
                    </div>

                    <div class="stat-sum-label">
                        Total Orders
                    </div>

                </div>

            </div>

            <div class="stat-sum-card">

                <div class="stat-sum-ico"
                     style="background:#e8f5e9">
                    👥
                </div>

                <div>

                    <div class="stat-sum-val">
                        ${stats.totalCustomers}
                    </div>

                    <div class="stat-sum-label">
                        Total Customers
                    </div>

                </div>

            </div>

            <div class="stat-sum-card">

                <div class="stat-sum-ico"
                     style="background:#fce4ec">
                    🧾
                </div>

                <div>

                    <div class="stat-sum-val">
                        NPR ${stats.avgOrderValue}
                    </div>

                    <div class="stat-sum-label">
                        Avg Order Value
                    </div>

                </div>

            </div>

        </div>

        <!-- TOP PRODUCTS -->
        <div class="report-grid" style="margin-bottom:18px">

            <div class="chart-card">

                <div class="chart-card-title">
                    Top Selling Products
                </div>

                <div class="chart-card-sub">
                    Best selling products
                </div>

                <div class="h-bars">

                    <c:forEach var="product"
                               items="${topProducts}">

                        <div class="h-bar-row">

                            <span class="h-bar-label">
                                    ${fn:escapeXml(product.name)}
                            </span>

                            <div class="h-bar-track">

                                <div class="h-bar-fill"
                                     style="width:${product.totalSold * 10}px">
                                </div>

                            </div>

                            <span class="h-bar-val">
                                ${product.totalSold} sold
                            </span>

                        </div>

                    </c:forEach>

                </div>

            </div>

            <!-- ORDER STATUS -->
            <div class="chart-card">

                <div class="chart-card-title">
                    Order Status Breakdown
                </div>

                <div class="chart-card-sub">
                    Current order statistics
                </div>

                <div style="margin-top:20px">

                    <div class="h-bars">

                        <div class="h-bar-row">

                            <span class="h-bar-label">
                                Delivered
                            </span>

                            <div class="h-bar-track">

                                <div class="h-bar-fill"
                                     style="width:${stats.deliveredOrders * 10}px;
                                             background:#2E7D32">
                                </div>

                            </div>

                            <span class="h-bar-val">
                                ${stats.deliveredOrders}
                            </span>

                        </div>

                        <div class="h-bar-row">

                            <span class="h-bar-label">
                                Preparing
                            </span>

                            <div class="h-bar-track">

                                <div class="h-bar-fill"
                                     style="width:${stats.preparingOrders * 10}px;
                                             background:#E65100">
                                </div>

                            </div>

                            <span class="h-bar-val">
                                ${stats.preparingOrders}
                            </span>

                        </div>

                        <div class="h-bar-row">

                            <span class="h-bar-label">
                                Ready
                            </span>

                            <div class="h-bar-track">

                                <div class="h-bar-fill"
                                     style="width:${stats.readyOrders * 10}px;
                                             background:#C8680A">
                                </div>

                            </div>

                            <span class="h-bar-val">
                                ${stats.readyOrders}
                            </span>

                        </div>

                        <div class="h-bar-row">

                            <span class="h-bar-label">
                                Cancelled
                            </span>

                            <div class="h-bar-track">

                                <div class="h-bar-fill"
                                     style="width:${stats.cancelledOrders * 10}px;
                                             background:#C62828">
                                </div>

                            </div>

                            <span class="h-bar-val">
                                ${stats.cancelledOrders}
                            </span>

                        </div>

                    </div>

                </div>

            </div>

        </div>

        <!-- REVENUE TABLE -->
        <div class="admin-table-card"
             style="margin-bottom:18px">

            <div style="padding:16px 18px;
                        border-bottom:1px solid var(--border);
                        display:flex;
                        justify-content:space-between;
                        align-items:center">

                <div>

                    <div style="font-size:.92rem;
                                font-weight:700">

                        Revenue Report

                    </div>

                    <div style="font-size:.76rem;
                                color:var(--text-muted)">

                        Latest order revenue

                    </div>

                </div>

            </div>

            <table>

                <thead>

                <tr>

                    <th>Date</th>
                    <th>Orders</th>
                    <th>Revenue</th>
                    <th>Average</th>

                </tr>

                </thead>

                <tbody>

                <c:forEach var="r"
                           items="${revenues}">

                    <tr>

                        <td style="font-weight:600">
                                ${r.orderDate}
                        </td>

                        <td>
                                ${r.totalOrders}
                        </td>

                        <td style="font-weight:700">
                            NPR ${r.revenue}
                        </td>

                        <td>
                            NPR ${r.avgValue}
                        </td>

                    </tr>

                </c:forEach>

                </tbody>

            </table>

        </div>

        <!-- PAYMENT METHODS -->
        <div class="chart-card"
             style="margin-bottom:18px">

            <div class="chart-card-title">
                Payment Methods
            </div>

            <div class="chart-card-sub">
                Payment method usage
            </div>

            <div class="h-bars"
                 style="margin-top:16px">

                <c:forEach var="pay"
                           items="${paymentStats}">

                    <div class="h-bar-row">

                        <span class="h-bar-label">
                                ${pay.method}
                        </span>

                        <div class="h-bar-track">

                            <div class="h-bar-fill"
                                 style="width:${pay.total * 10}px">
                            </div>

                        </div>

                        <span class="h-bar-val">
                                ${pay.total}
                        </span>

                    </div>

                </c:forEach>

            </div>

        </div>

        <!-- CUSTOMER REVIEWS -->
        <div class="chart-card review-card">

            <div class="review-header">

                <div>

                    <div class="chart-card-title">
                        Customer Reviews
                    </div>

                    <div class="chart-card-sub">

                        <c:choose>

                            <c:when test="${totalReviews > 0}">

                                ${totalReviews}
                                review${totalReviews != 1 ? 's' : ''}

                                · Avg Rating:
                                <strong style="color:var(--orange)">
                                        ${avgRating} ⭐
                                </strong>

                            </c:when>

                            <c:otherwise>

                                No reviews yet

                            </c:otherwise>

                        </c:choose>

                    </div>

                </div>

                <button class="btn btn-outline review-btn"
                        onclick="toggleAll()">

                    View All

                </button>

            </div>

            <c:choose>

                <c:when test="${empty allFeedbacks}">

                    <div style="text-align:center;
                                padding:32px;
                                color:var(--text-muted);
                                font-size:.9rem;">

                        No customer reviews found.

                    </div>

                </c:when>

                <c:otherwise>

                    <c:forEach var="fb"
                               items="${allFeedbacks}"
                               varStatus="loop">

                        <div class="review-item
                                    ${loop.index >= 3 ? 'extra-review' : ''}"

                             style="${loop.index >= 3 ? 'display:none;' : ''}">

                            <div style="flex:1">

                                <div class="review-name">
                                        ${fn:escapeXml(fb.userName)}
                                </div>

                                <div class="review-stars"
                                     style="color:#C8680A;
                                            font-size:.95rem;
                                            margin:3px 0">

                                    <c:forEach begin="1"
                                               end="${fb.rating}">
                                        ★
                                    </c:forEach>

                                </div>

                                <div class="review-text">

                                        ${fn:escapeXml(fb.message)}

                                </div>

                            </div>

                            <div style="display:flex;
                                        flex-direction:column;
                                        align-items:flex-end;
                                        gap:8px">

                                <span class="review-time">

                                        ${fn:escapeXml(fb.relativeTime)}

                                </span>

                            </div>

                        </div>

                    </c:forEach>

                </c:otherwise>

            </c:choose>

        </div>

    </div>

</div>

<script>

    function toggleAll() {

        const extras =
            document.querySelectorAll('.extra-review');

        const btn =
            document.querySelector('.review-btn');

        const hidden =
            extras.length > 0 &&
            extras[0].style.display === 'none';

        extras.forEach(el => {
            el.style.display = hidden ? 'flex' : 'none';
        });

        btn.textContent =
            hidden ? 'Show Less' : 'View All';
    }

</script>

</body>
</html>