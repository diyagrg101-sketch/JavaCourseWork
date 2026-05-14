<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<body>

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="confirm-page">

    <!-- SUCCESS -->
    <div class="confirm-check">✓</div>

    <h1 class="confirm-title">
        Order Confirmed!
    </h1>

    <p class="confirm-sub">
        Your order
        <span>#SS-882910</span>
        has been received and is being prepared by our baristas.
    </p>

    <!-- RECEIPT -->
    <div class="confirm-receipt">

        <!-- HEADER -->
        <div class="cr-header">

            <div class="cr-icon">☕</div>

            <div class="cr-brand">
                SIP AND SERVE
            </div>

            <div class="cr-addr">
                Pokhara, Nepal • +977 1-4XXXXXX
            </div>

            <div class="cr-order-id">
                SS-882910
            </div>

            <div class="cr-date">
                October 24, 2024 at 2:45 PM
            </div>

        </div>

        <!-- DELIVERY -->
        <div class="cr-delivery">

            <span class="cr-delivery-ico">📍</span>

            <div>

                <strong>HOME DELIVERY</strong>

                <p>
                   Ward 1, Bindhbasini, Pokhara
                </p>

                <div class="cr-eta">
                    ⏱ Est. Delivery: 25–30 mins
                </div>

            </div>

        </div>

        <!-- ORDER DETAILS -->
        <div class="cr-items">

            <div class="cr-items-label">
                ORDER DETAILS
            </div>

            <!-- ITEM -->
            <div class="cr-item">

                <div>

                    <span>
                        Himalayan Arabica Latte
                    </span>

                    <span class="tag tag-gray"
                          style="margin-left:6px;font-size:.68rem">
                        ×2
                    </span>

                    <div class="cr-item-note">
                        + Extra Shot, Oat Milk
                    </div>

                </div>

                <span style="font-weight:700">
                    NPR 760
                </span>

            </div>

            <!-- ITEM -->
            <div class="cr-item">

                <div>

                    <span>
                        Classic Butter Croissant
                    </span>

                    <span class="tag tag-gray"
                          style="margin-left:6px;font-size:.68rem">
                        ×1
                    </span>

                </div>

                <span style="font-weight:700">
                    NPR 250
                </span>

            </div>

            <!-- ITEM -->
            <div class="cr-item">

                <div>

                    <span>
                        Avocado Sourdough Toast
                    </span>

                    <span class="tag tag-gray"
                          style="margin-left:6px;font-size:.68rem">
                        ×1
                    </span>

                    <div class="cr-item-note">
                        + Poached Egg
                    </div>

                </div>

                <span style="font-weight:700">
                    NPR 550
                </span>

            </div>

            <!-- ITEM -->
            <div class="cr-item">

                <div>

                    <span>
                        Blueberry Cheesecake Slice
                    </span>

                    <span class="tag tag-gray"
                          style="margin-left:6px;font-size:.68rem">
                        ×1
                    </span>

                </div>

                <span style="font-weight:700">
                    NPR 420
                </span>

            </div>

        </div>

        <!-- BILL -->
        <div class="cr-bill">

            <div class="cr-bill-label">
                BILL SUMMARY
            </div>

            <div class="cr-bill-row">
                <span>Subtotal</span>
                <span>NPR 1,980</span>
            </div>

            <div class="cr-bill-row">
                <span>VAT (13%)</span>
                <span>NPR 257</span>
            </div>

            <div class="cr-bill-row">
                <span>Service Charge</span>
                <span>NPR 100</span>
            </div>

            <div class="cr-bill-row discount">
                <span>Discount Applied</span>
                <span>– NPR 150</span>
            </div>

            <div class="cr-total">
                <span>Grand Total</span>
                <span>NPR 2,187</span>
            </div>

        </div>

        <!-- POINTS -->
        <div class="cr-points"
             style="margin-bottom:0;border-radius:0 0 var(--r) var(--r)">

            <span style="font-size:1rem">⭐</span>

            <div>

                <div style="font-size:.82rem;font-weight:700;color:var(--orange)">
                    Points Earned
                </div>

                <div style="font-size:.76rem;color:var(--text-muted)">
                    Added to your Sip &amp; Serve wallet
                </div>

            </div>

            <span class="cr-points-val">
                +45
            </span>

        </div>

    </div>

    <!-- ACTION BUTTONS -->
    <div class="confirm-actions">

        <button class="btn btn-outline">
            <span>🖨️</span>
            Print
        </button>

        <button class="btn btn-outline">
            <span>⬇️</span>
            PDF
        </button>

        <button class="btn btn-outline">
            ↗
        </button>

        <a href="${ctx}/dashboard"
           class="btn btn-outline">

            ‹ Dashboard

        </a>
    </div>

    <!-- META -->
    <p class="confirm-meta">
        📄 A copy of this receipt has been sent to your email.
    </p>

    <!-- HELP -->
    <div class="confirm-help">
        Need help with your order?
        Reach out to us at
        <br/>
        <a style="color:var(--orange);font-weight:600">
            sipandserve@gmail.com
        </a>
    </div>

</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

</body>
</html>
