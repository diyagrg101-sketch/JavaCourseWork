<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<body>

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<div class="checkout-layout">

    <!-- LEFT SIDE -->
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
                        <div class="cs-sub">
                            Details for order notification
                        </div>
                    </div>
                </div>
            </div>

            <div class="input-row">
                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" class="form-control" placeholder="Enter your name"></div>

                <div class="form-group"><label>Phone Number</label>
                    <input type="text" class="form-control" placeholder="+977 98XXXXXXXX">
                </div>
            </div>

            <div class="form-group">
                <label>Email Address</label>
                <input type="email"
                       class="form-control"
                       placeholder="example@email.com">
            </div>

        </div>
        <!-- DELIVERY -->
        <div class="checkout-section">
            <div class="cs-header">
                <div class="cs-header-left">
                    <div class="cs-icon">🚚</div>
                    <div>
                        <div class="cs-title">Fulfillment Method</div>
                        <div class="cs-sub">
                            How would you like to receive your order?
                        </div>
                    </div>
                </div>
            </div>

            <!-- TABS -->
            <div class="fulfill-tabs">
                <div class="fulfill-tab active" onclick="setMode('delivery', this)">
                    <span class="ico">🚚</span>Home Delivery</div>
                <div class="fulfill-tab" onclick="setMode('pickup', this)">
                    <span class="ico">🏪</span>Take Away</div>
                <div class="fulfill-tab" onclick="setMode('dinein', this)">
                    <span class="ico">☕</span>Dine-in</div>
            </div>


            <div class="pickup-box" id="pickupBox" style="display:none; margin-top:20px;">
                <div class="form-group">
                    <label>Pickup Name</label>
                    <input type="text" class="form-control" placeholder="Your name for pickup">
                </div>
            </div>

            <div class="dinein-box" id="dineinBox" style="display:none; margin-top:20px;">
                <div class="input-row">
                    <div class="form-group">
                        <label>Table Number</label>
                        <input type="text" class="form-control" placeholder="e.g. T-12"></div>
                    <div class="form-group">
                        <label>Time</label>
                        <input type="time" class="form-control">
                    </div>
                </div>
            </div>


            <!-- ADDRESS -->
            <div class="delivery-box" id="deliveryBox">
                <div class="form-group">
                    <label>Street Address</label>
                    <input type="text"
                           class="form-control">
                </div>

                <div class="input-row">
                    <div class="form-group">
                        <label>Area / City</label>
                        <input type="text"
                               class="form-control">
                    </div>

                    <div class="form-group">
                        <label>Nearby Landmark</label>
                        <input type="text"
                               class="form-control">
                    </div>
                </div>
            </div>
        </div>

        <!-- SPECIAL NOTE -->
        <div class="checkout-section">
            <div class="cs-header">
                <div class="cs-header-left">
                    <div class="cs-icon">💬</div>
                    <div>
                        <div class="cs-title">
                            Special Instructions
                        </div>
                        <div class="cs-sub">
                            Any specific requests?
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <label>Order Notes</label>
                <textarea class="form-control" placeholder="Extra sugar, no ice, etc..."></textarea>
            </div>
        </div>
    </div>

    <!-- RIGHT SIDE -->
    <div class="order-sum-sidebar">
        <div class="oss-head">
            <span class="oss-title">Order Summary</span>
            <span class="order-badge">3 Items</span>
        </div>

        <!-- ITEM -->
        <div class="oss-item">
            <img src="${ctx}/assets/images/hazelhut.jpg" alt="Hazelnut Cappuccino" class="oss-img"/>
            <div>
                <div class="oss-name">Hazelnut Cappuccino</div>
                <div class="oss-qty">Qty: 1</div>
            </div>
            <span class="oss-price">NPR 450</span>
        </div>

        <!-- ITEM -->
        <div class="oss-item">
            <img src="${ctx}/assets/images/blueberryCheesecake.jpg" alt="blueberry cheesecake" class="oss-img"/>
            <div>
                <div class="oss-name">Blueberry Cheesecake</div>
                <div class="oss-qty">Qty: 2</div>
            </div>
            <span class="oss-price">NPR 650</span>
        </div>

        <!-- ITEM -->
        <div class="oss-item">
            <img src="${ctx}/assets/images/avocadoTaost.jpg" alt="avocado toast" class="oss-img"/>
            <div>
                <div class="oss-name">Avocado Toast</div>
                <div class="oss-qty">Qty: 1</div>
            </div>
            <span class="oss-price">NPR 400</span>
        </div>

        <hr class="oss-divider">
        <div class="oss-row">
            <span>Subtotal</span>
            <span>NPR 1950</span>
        </div>

        <div class="oss-row">
            <span>VAT</span>
            <span>NPR 250</span>
        </div>

        <div class="oss-row">
            <span>Delivery Fee</span>
            <span>NPR 100</span>
        </div>

        <div class="oss-total">
            <span>Total</span>
            <span>NPR 2300</span>
        </div>
        <a href="${ctx}/payment" class="checkout-primary-btn">Proceed to Payment →</a>
        <div class="secure-note">🔒 Secure Checkout</div>
        <p style="text-align:center;font-size:.74rem;color:var(--text-muted);margin-top:10px">Need help with your order? <a href="${ctx}/contact" style="color:var(--orange);font-weight:600">Contact Support</a></p>
    </div>

</div>
<script>
    function setMode(mode, el) {

        // tab active UI
        document.querySelectorAll('.fulfill-tab')
            .forEach(t => t.classList.remove('active'));
        el.classList.add('active');

        // hide all
        document.getElementById('deliveryBox').style.display = 'none';
        document.getElementById('pickupBox').style.display = 'none';
        document.getElementById('dineinBox').style.display = 'none';

        // show selected
        if (mode === 'delivery') {
            document.getElementById('deliveryBox').style.display = 'block';
        }

        if (mode === 'pickup') {
            document.getElementById('pickupBox').style.display = 'block';
        }

        if (mode === 'dinein') {
            document.getElementById('dineinBox').style.display = 'block';
        }
    }
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>

</body>
</html>