<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<body>

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<!-- SUCCESS PAGE -->
<div class="success-page">
    <!-- SUCCESS ICON -->
    <div class="success-circle">✓</div>

    <!-- TITLE -->
    <h1 class="success-title">
        Payment Successful!
    </h1>

    <!-- SUBTITLE -->
    <p class="success-sub">
        Hooray! Your order has been placed and is being
        prepared by our baristas.
    </p>

    <!-- ORDER DETAILS CARD -->
    <div class="order-detail-card">
        <div class="odc-header">
            <span class="odc-title">ORDER DETAILS</span>

            <div class="odc-icons">
                <button class="odc-icon-btn">🖨️</button>
                <button class="odc-icon-btn">⬇️</button>
            </div>
        </div>


        <div class="odc-row">
            <span class="odc-label">📋 Order Number</span>
            <span class="odc-value">#SS-2024-8912</span>
        </div>


        <div class="odc-row">
            <span class="odc-label">📅 Date & Time</span>
            <span class="odc-value">Oct 24, 2024 • 10:45 AM</span>
        </div>


        <div class="odc-row">
            <span class="odc-label">💳 Payment Method</span>
            <span class="odc-value">eSewa Mobile Wallet</span>
        </div>


        <div class="odc-row">
            <span class="odc-label">☕ Delivery Type</span>
            <span class="odc-value">Dine-in (Table #12)</span>
        </div>


        <div class="odc-total">
            <span>Total Amount Charged</span>
            <span>NPR 1,450.00</span>
        </div>
    </div>


    <div class="success-actions">
        <a href="${ctx}/feedback" class="btn btn-primary btn-lg">Feedback →</a>
        <a href="${ctx}/dashboard" class="btn btn-outline btn-lg">Continue Shopping
        </a>
    </div>


    <p class="success-meta">
        A copy of this receipt has been sent to your registered email address.
        <br/>
        Need help?
        <a href="${ctx}/contact" class="success-support-link" style="color:var(--orange);">
            Contact Support
        </a>
    </p>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

</body>
</html>