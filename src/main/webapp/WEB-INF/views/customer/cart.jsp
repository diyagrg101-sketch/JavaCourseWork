<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<body>

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div style="padding:20px 48px 0">
    <a href="${ctx}/manageProducts" style="font-size:.84rem;color:var(--text-muted);display:flex;align-items:center;gap:5px">‹ Back to Menu</a>
</div>


<div class="cart-layout">

    <div>
        <div class="cart-title">Your Cart<span class="cart-count">3 Items</span></div>


        <div class="cart-item">
            <img src="${ctx}/assets/images/hazelhut.jpg" alt="Hazelnut Cappuccino"/>
            <div class="cart-item-body">
                <div class="cart-item-name">
                    Hazelnut Cappuccino
                </div>
                <div class="cart-item-desc">
                    House special with organic milk and cinnamon powder.
                </div>
                <div style="display:flex;gap:6px;flex-wrap:wrap">
                    <span class="tag tag-orange">Extra Shot</span>
                </div>
                <div style="display:flex;align-items:center;justify-content:space-between;margin-top:8px">
                    <span class="cart-item-price">
                        NPR 450
                    </span>
                    <div class="cart-qty">
                        <button class="cart-qty-btn">−</button>
                        <span class="cart-qty-val">1</span>
                        <button class="cart-qty-btn">+</button>
                    </div>
                </div>
            </div>
            <button class="cart-delete">🗑</button>
        </div>


        <div class="cart-item">
            <img src="${ctx}/assets/images/blueberryCheesecake.jpg" alt="Blueberry Cheesecake"/>
            <div class="cart-item-body">
                <div class="cart-item-name">
                    Blueberry Cheesecake
                </div>
                <div class="cart-item-desc">
                    Rich creamy cheesecake with fresh local blueberry.
                </div>
                <div style="display:flex;align-items:center;justify-content:space-between;margin-top:8px">
                    <span class="cart-item-price">
                        NPR 650
                    </span>
                    <div class="cart-qty">
                        <button class="cart-qty-btn">−</button>
                        <span class="cart-qty-val">2</span>
                        <button class="cart-qty-btn">+</button>
                    </div>
                </div>
            </div>
            <button class="cart-delete">🗑</button>
        </div>


        <div class="cart-item">
            <img src="${ctx}/assets/images/avocadoTaost.jpg" alt="Avocado Toast"/>
            <div class="cart-item-body">
                <div class="cart-item-name">
                    Avocado Toast
                </div>
                <div class="cart-item-desc">
                    Sourdough bread, mashed avocado, poached egg, and chili flakes.
                </div>
                <div>
                    <span class="tag tag-green">
                        Gluten-Free Bread
                    </span>
                </div>
                <div style="display:flex;align-items:center;justify-content:space-between;margin-top:8px">
                    <span class="cart-item-price">
                        NPR 400
                    </span>
                    <div class="cart-qty">
                        <button class="cart-qty-btn">−</button>
                        <span class="cart-qty-val">1</span>
                        <button class="cart-qty-btn">+</button>
                    </div>
                </div>
            </div>
            <button class="cart-delete">🗑</button>
        </div>


        <div class="special-note">
            <span style="font-size:1rem;color:var(--orange)">ℹ️</span>
            <div>
                <strong>Special Instructions?</strong><br/>You can add dietary requirements or special requests at the next step.
            </div>
        </div>
    </div>


    <div class="order-summary">
        <h3>Order Summary</h3>
        <div class="promo-row">
            <input class="promo-input" type="text" placeholder="Enter code"/>
            <button class="btn-apply">Apply</button>
        </div>

        <div class="summary-row">
            <span>Subtotal</span>
            <span>NPR 2,600</span>
        </div>

        <div class="summary-row">
            <span>VAT (13%) ℹ</span>
            <span>NPR 338</span>
        </div>

        <div class="summary-row">
            <span>Service Charge (10%) ℹ</span>
            <span>NPR 260</span>
        </div>

        <div class="summary-total">
            <span>Total Amount<br/>
                <span style="font-size:.74rem;color:var(--text-muted);font-weight:400">(All taxes included)</span></span>
            <span>NPR 3,198</span>
        </div>

        <a href="${ctx}/checkout" class="btn btn-primary btn-full cart-btn-lg cart-checkout-btn" style="margin-bottom:8px">Proceed to Checkout ›</a>

        <p style="font-size:.74rem;color:var(--text-muted);text-align:center">By proceeding, you agree to our Terms of Service.</p>

        <div class="trust-row">
            <div class="trust-badge">🔒<br/>SAFE PAYMENTS</div>
            <div class="trust-badge">🍽️<br/>FRESHLY SERVED</div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

</body>
</html>