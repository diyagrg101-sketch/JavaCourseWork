<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<body>

<!-- ================= NAVBAR ================= -->
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>


<!-- ================= PAGE HEADER ================= -->
<div class="page-header">
    <div class="page-header-top">

        <div>
            <h1>Our Menu</h1>
            <p>Deliciously crafted, warm hospitality served fresh every day</p>
        </div>

        <div class="order-info">
            <div class="order-badge">
                <span class="label">Active Orders</span>
                <span class="value">02</span>
            </div>

            <div class="order-badge">
                <span class="label">Table No.</span>
                <span class="value">12</span>
            </div>
        </div>

    </div>
</div>


<!-- ================= CONTROLS ================= -->
<div class="menu-controls">

    <div class="sort-dropdown">
        <select class="sort-btn">
            <option value="all">⚙️ Sort By</option>
            <option value="snacks">Snacks</option>
            <option value="desserts">Desserts</option>
            <option value="drinks">Drinks</option>
        </select>
    </div>

    <div class="search-box">
        <span>🔍</span>
        <input type="text" placeholder="Search"/>
    </div>

</div>


<!-- ================= MENU GRID ================= -->
<div class="menu-full-grid">

    <div class="menu-full-card">
        <img src="${ctx}/assets/images/caramel-frappe.jpg" alt="Caramel Frappe"/>
        <div class="menu-full-info">
            <div class="menu-full-top">
                <span class="menu-full-name">Caramel Macchiato Frappe</span>
                <span class="menu-full-price">NRs 250</span>
            </div>
            <p class="menu-full-desc">A sweet, blended iced coffee with caramel.</p>
            <div class="freshly-label">ℹ️ Freshly Made</div>
            <button class="btn-cart">Add to Cart +</button>
        </div>
    </div>

    <div class="menu-full-card">
        <img src="${ctx}/assets/images/chocolate-cake.jpg" alt="Chocolate Cake"/>
        <div class="menu-full-info">
            <div class="menu-full-top">
                <span class="menu-full-name">Chocolate Cake</span>
                <span class="menu-full-price">NRs 200</span>
            </div>
            <p class="menu-full-desc">Moist dessert made with cocoa.</p>
            <div class="freshly-label">ℹ️ Freshly Made</div>
            <button class="btn-cart">Add to Cart +</button>
        </div>
    </div>

    <div class="menu-full-card">
        <img src="${ctx}/assets/images/sandwich.jpg" alt="Sandwich"/>
        <div class="menu-full-info">
            <div class="menu-full-top">
                <span class="menu-full-name">Sandwich</span>
                <span class="menu-full-price">NRs 200</span>
            </div>
            <p class="menu-full-desc">Freshly prepared sandwich.</p>
            <div class="freshly-label">ℹ️ Freshly Made</div>
            <button class="btn-cart">Add to Cart +</button>
        </div>
    </div>

    <div class="menu-full-card">
        <img src="${ctx}/assets/images/latte.jpg" alt="Latte"/>
        <div class="menu-full-info">
            <div class="menu-full-top">
                <span class="menu-full-name">Latte</span>
                <span class="menu-full-price">NRs 350</span>
            </div>
            <p class="menu-full-desc">Smooth espresso with milk.</p>
            <div class="freshly-label">ℹ️ Freshly Made</div>
            <button class="btn-cart">Add to Cart +</button>
        </div>
    </div>

</div>


<!-- ================= FOOTER ================= -->

    <%@ include file="/WEB-INF/views/common/footer.jsp" %>

</body>
</html>