<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<body>

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>


<a href="${ctx}/dashboard" class="back-link">‹ Back to Menu</a>

<div class="item-layout">
    <!-- LEFT: IMAGE -->
    <div>
        <div class="item-img-wrap">
            <img class="item-img" src="https://images.unsplash.com/photo-1572490122747-3968b75cc699?w=700&q=80" alt="Himalayan Arabica Latte"/>
            <div class="item-img-badges">
                <span class="item-badge">Best Seller</span>
                <span class="item-badge secondary">Artisanal</span>
            </div>
            <div class="item-wish">🤍</div>
        </div>
        <div class="item-meta-row">
            <div class="item-meta">🌿 TYPE <span>Vegetarian</span></div>
            <div class="item-meta">🔥 CALORIES <span>180 kcal</span></div>
            <div class="item-meta">💧 TEMPERATURE <span>Hot Serving</span></div>
        </div>
    </div>

    <!-- RIGHT: INFO -->
    <div>
        <div class="item-series">☕ PREMIUM COFFEE SERIES</div>
        <div class="item-name">Himalayan Arabica Latte</div>
        <div class="item-price">NPR 425</div>

        <div class="item-section-label">DESCRIPTION</div>
        <p style="font-size:.85rem;color:var(--text-muted);line-height:1.7;margin-bottom:16px">
            Our signature latte crafted with 100% single-origin Arabica beans sourced from the high altitudes of the Himalayas. Silky smooth steamed milk meets a bold, caramel-noted espresso finish. A warm embrace in every sip.
        </p>

        <div class="item-section-label">INGREDIENTS</div>
        <div class="ingredient-tags">
            <span class="ing-tag">Himalayan Arabica Beans</span>
            <span class="ing-tag">Whole Milk</span>
            <span class="ing-tag">Natural Cane Sugar</span>
            <span class="ing-tag">Cinnamon Dust</span>
        </div>

        <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:8px">
            <div class="item-section-label" style="margin-bottom:0">SELECT SIZE</div>
            <span class="size-required">Required</span>
        </div>
        <div class="size-row" style="margin-bottom:18px">
            <div class="size-option"><div class="size-lbl">SMALL</div><div class="size-vol">240ml</div></div>
            <div class="size-option active"><div class="size-lbl">REGULAR</div><div class="size-vol">350ml</div><div style="font-size:.9rem;margin-top:3px">✓</div></div>
            <div class="size-option"><div class="size-lbl">LARGE</div><div class="size-vol">480ml</div></div>
        </div>

        <div class="item-section-label">PERSONALIZE YOUR DRINK</div>
        <div>
            <div class="addon-row">
                <div class="addon-left"><input type="checkbox" class="addon-check"/><span class="addon-name">Extra Espresso Shot</span></div>
                <span class="addon-price">+ NPR 50</span>
            </div>
            <div class="addon-row">
                <div class="addon-left"><input type="checkbox" class="addon-check"/><span class="addon-name">Swap for Oat Milk</span></div>
                <span class="addon-price">+ NPR 80</span>
            </div>
            <div class="addon-row">
                <div class="addon-left"><input type="checkbox" class="addon-check"/><span class="addon-name">Caramel Drizzle</span></div>
                <span class="addon-price">+ NPR 30</span>
            </div>
        </div>

        <div class="total-add-row">
            <div>
                <div class="total-add-label">TOTAL AMOUNT</div>
                <div class="total-add-amount">NPR 465</div>
            </div>
            <div class="qty-row">
                <button class="qty-btn">−</button>
                <span class="qty-val">1</span>
                <button class="qty-btn">+</button>
            </div>
        </div>

        <button class="btn btn-primary btn-full btn-lg">🛒 &nbsp;Add to Cart</button>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

</body>
</html>