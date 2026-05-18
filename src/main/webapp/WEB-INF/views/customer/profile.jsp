<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<body>

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>


<div class="main-content">
    <!-- PROFILE HEADER -->
    <div class="profile-header-card">
        <div style="width:72px; height:72px; border-radius:50%;
            background:#FF7A00FF; flex-shrink:0;
            display:flex; align-items:center;
            justify-content:center; font-size:24px; font-weight:bold; color:white;">
            ${sessionScope.user.substring(0,1).toUpperCase()}
        </div>

        <div>
            <div class="ph-name">
                ${user.fullName}
                <span class="tag tag-orange">${user.role}</span>
            </div>
            <div class="ph-email">
                ${user.email}</div>

        </div>
        <div class="ph-edit">
            <a href="${ctx}/editProfile" class="btn btn-primary">✏️ &nbsp;Edit Profile</a>
        </div>
    </div>

    <div class="profile-grid">
        <!-- LEFT -->
        <div>
            <!-- ADDRESSES -->
            <div class="addresses-card">
                <div class="ac-header">
                    <span class="ac-title">📍Saved Addresses </span>
                </div>
                <div class="addr-grid">
                    <div class="addr-card">
                        <div class="addr-text"> ${user.address}</div>
                    </div>
                </div>
            </div>

            <!-- ORDER HISTORY -->
            <div class="orders-history-card">
                <div class="ohc-header">
                    <span style="font-size:.9rem;font-weight:700;display:flex;align-items:center;gap:7px">🕐 Recent Order History</span>
                    <a href="#" style="font-size:.8rem;font-weight:700;color:var(--orange)">View All Orders</a>
                </div>
                <p class="ohc-sub">Your last three café orders and status.</p>
                <table>
                    <thead>
                    <tr><th>Order ID</th><th>Date</th><th>Items</th><th>Status</th><th>Amount</th></tr>
                    </thead>
                </table>
            </div>
        </div>

        <!-- RIGHT SIDEBAR -->
        <div>
            <!-- WALLET -->
            <div class="profile-sidebar-top">
                <div class="wallet-lbl">💳 Sip Wallet Balance</div>
                <div class="wallet-bal">NPR 1,250.5</div>
                <div class="wallet-avail">Available for your next coffee run</div>
                <button class="btn-topup">Top Up Wallet</button>
            </div>

            <!-- PAYMENTS -->
            <div class="payments-card">
                <div class="payments-title">💳 Payments</div>

                <button class="add-payment-btn">+ Add Payment Method</button>
            </div>

            <!-- LOYALTY -->
            <div class="loyalty-card">
                <div class="loyalty-title">⭐ Loyalty Status</div>
                <div class="loyalty-sub">Earn 1 cup for every order over NPR 500.</div>
            </div>

            <!-- MISC LINKS -->
            <div class="misc-links">
                <a href="${ctx}/feedback" class="misc-link-item">
                    Give us Feedback<span>›</span>
                </a>
                <a href="${ctx}/logout" class="misc-link-item logout">
                    Logout 🔴 <span>›</span>
                </a>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
