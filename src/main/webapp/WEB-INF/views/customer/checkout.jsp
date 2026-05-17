<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<body>

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="checkout-layout">

    <!-- ================= LEFT SIDE ================= -->
    <div>

        <h1 class="checkout-title">Complete Your Order</h1>
        <p class="checkout-sub">Just a few more details to get your coffee brewing.</p>

        <!-- CONTACT -->
        <div class="checkout-section">
            <div class="cs-header">
                <div class="cs-header-left">
                    <div class="cs-icon">👤</div>
                    <div>
                        <div class="cs-title">Contact Information</div>
                        <div class="cs-sub">Details for order notification</div>
                    </div>
                </div>
            </div>

            <div class="input-row">
                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" class="form-control" placeholder="Enter your name">
                </div>
                <div class="form-group">
                    <label>Phone Number</label>
                    <input type="text" class="form-control" placeholder="+977 98XXXXXXXX">
                </div>
            </div>

            <div class="form-group">
                <label>Email Address</label>
                <input type="email" class="form-control" placeholder="example@email.com">
            </div>
        </div>

        <!-- FULFILLMENT -->
        <div class="checkout-section">
            <div class="cs-header">
                <div class="cs-header-left">
                    <div class="cs-icon">🚚</div>
                    <div>
                        <div class="cs-title">Fulfillment Method</div>
                        <div class="cs-sub">How would you like to receive your order?</div>
                    </div>
                </div>
            </div>

            <div class="fulfill-tabs">
                <div class="fulfill-tab active" onclick="setMode('delivery', this)">
                    <span class="ico">🚚</span>Home Delivery
                </div>
                <div class="fulfill-tab" onclick="setMode('pickup', this)">
                    <span class="ico">🏪</span>Take Away
                </div>
                <div class="fulfill-tab" onclick="setMode('dinein', this)">
                    <span class="ico">☕</span>Dine-in
                </div>
            </div>

            <div class="pickup-box" id="pickupBox" style="display:none;margin-top:20px;">
                <div class="form-group">
                    <label>Pickup Name</label>
                    <input type="text" class="form-control" placeholder="Your name for pickup">
                </div>
            </div>

            <div class="dinein-box" id="dineinBox" style="display:none;margin-top:20px;">
                <div class="input-row">
                    <div class="form-group">
                        <label>Table Number</label>
                        <input type="text" class="form-control" placeholder="e.g. T-12">
                    </div>
                    <div class="form-group">
                        <label>Time</label>
                        <input type="time" class="form-control">
                    </div>
                </div>
            </div>

            <div class="delivery-box" id="deliveryBox">
                <div class="form-group">
                    <label>Street Address</label>
                    <input type="text" class="form-control">
                </div>
                <div class="input-row">
                    <div class="form-group">
                        <label>Area / City</label>
                        <input type="text" class="form-control">
                    </div>
                    <div class="form-group">
                        <label>Nearby Landmark</label>
                        <input type="text" class="form-control">
                    </div>
                </div>
            </div>
        </div>

        <!-- SPECIAL INSTRUCTIONS -->
        <div class="checkout-section">
            <div class="cs-header">
                <div class="cs-header-left">
                    <div class="cs-icon">💬</div>
                    <div>
                        <div class="cs-title">Special Instructions</div>
                        <div class="cs-sub">Any specific requests?</div>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label>Order Notes</label>
                <textarea class="form-control" placeholder="Extra sugar, no ice, etc..."></textarea>
            </div>
        </div>
    </div>

    <!-- ================= RIGHT SIDE ================= -->
    <div class="order-sum-sidebar">

        <div class="oss-head">
            <span class="oss-title">Order Summary</span>
            <span class="order-badge">${totalItems} Items</span>
        </div>

        <!-- DYNAMIC CART ITEMS -->
        <c:forEach var="item" items="${cart}">
            <div class="oss-item">
                <img src="${ctx}/assets/images/${item[2]}"
                     alt="${item[0]}" class="oss-img"/>
                <div>
                    <div class="oss-name">${item[0]}</div>
                    <div class="oss-qty">Qty: ${item[3]}</div>
                </div>
                <span class="oss-price">
                    NPR <fmt:formatNumber value="${item[1]}" pattern="#,##0.00"/>
                </span>
            </div>
        </c:forEach>

        <hr class="oss-divider">

        <div class="oss-row">
            <span>Subtotal</span>
            <span>NPR <fmt:formatNumber value="${subtotal}" pattern="#,##0.00"/></span>
        </div>

        <div class="oss-row">
            <span>VAT (13%)</span>
            <span>NPR <fmt:formatNumber value="${vat}" pattern="#,##0.00"/></span>
        </div>

        <div class="oss-row">
            <span>Service Charge (10%)</span>
            <span>NPR <fmt:formatNumber value="${service}" pattern="#,##0.00"/></span>
        </div>

        <div class="oss-total">
            <span>Total</span>
            <span>NPR <fmt:formatNumber value="${total}" pattern="#,##0.00"/></span>
        </div>

        <a href="${ctx}/payment" class="checkout-primary-btn">Proceed to Payment →</a>
        <div class="secure-note">🔒 Secure Checkout</div>
        <p style="text-align:center;font-size:.74rem;color:var(--text-muted);margin-top:10px">
            Need help? <a href="${ctx}/contact" style="color:var(--orange);font-weight:600">Contact Support</a>
        </p>
    </div>

</div>

<script>
    function setMode(mode, el) {
        document.querySelectorAll('.fulfill-tab')
            .forEach(t => t.classList.remove('active'));
        el.classList.add('active');

        document.getElementById('deliveryBox').style.display = 'none';
        document.getElementById('pickupBox').style.display   = 'none';
        document.getElementById('dineinBox').style.display   = 'none';

        if (mode === 'delivery') document.getElementById('deliveryBox').style.display = 'block';
        if (mode === 'pickup')   document.getElementById('pickupBox').style.display   = 'block';
        if (mode === 'dinein')   document.getElementById('dineinBox').style.display   = 'block';
    }
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>