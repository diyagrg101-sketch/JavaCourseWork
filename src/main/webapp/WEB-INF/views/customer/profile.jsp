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
        <div class="profile-avatar"></div>
        <div>
            <div class="ph-name">
                Arjun Karki
                <span class="tag tag-orange">⭐ Gold Member</span>
            </div>
            <div class="ph-email">arjun.karki@example.com</div>
            <div class="ph-since">Member since October 2022 • Kathmandu, NP</div>
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
                    <span class="ac-title">📍 Saved Addresses</span>
                    <button class="btn btn-outline" style="font-size:.78rem;padding:6px 12px">Add New</button>
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
                <div class="misc-link-item" onclick="location.href='feedback.html'">Give us Feedback <span>›</span></div>
                <div class="misc-link-item">Privacy Preferences <span>›</span></div>
                <a href="${ctx}/logout" class="misc-link-item logout">
                    Logout 🔴 <span></span>
                </a>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
