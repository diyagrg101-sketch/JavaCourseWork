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
<footer class="footer" id="contact">

    <div class="container footer-grid">

        <div class="footer-col">
            <a href="${ctx}/home" class="brand">
                <span class="brand-logo"><i class="fa-solid fa-mug-saucer"></i></span>
                <span class="brand-name">Sip and Serve</span>
            </a>

            <p class="footer-text">
                Crafting coffee and memories since 2030.
            </p>

            <p class="footer-copy">
                © 2026 Sip and Serve. All rights reserved.
            </p>
        </div>

        <div class="footer-col">
            <h4 class="footer-title">Quick Links</h4>
            <ul class="footer-links">
                <li><a href="${ctx}/home">Home</a></li>
                <li><a href="${ctx}/manageProducts">Menu</a></li>
                <li><a href="${ctx}/home#about">About Us</a></li>
                <li><a href="${ctx}/home#contact">Contact</a></li>
            </ul>
        </div>

        <div class="footer-col">
            <h4 class="footer-title">Contact</h4>
            <ul class="footer-links">
                <li><i class="fa-solid fa-phone"></i> +977 9841 123 4567</li>
                <li><i class="fa-solid fa-envelope"></i> sipandserve@gmail.com</li>
            </ul>
        </div>

        <div class="footer-col">
            <h4 class="footer-title">Follow Us</h4>
            <div class="social-links">
                <a href="#"><i class="fa-brands fa-facebook-f"></i></a>
                <a href="#"><i class="fa-brands fa-instagram"></i></a>
                <a href="#"><i class="fa-brands fa-tiktok"></i></a>
            </div>
        </div>

    </div>

    <%@ include file="/WEB-INF/views/common/footer.jsp" %>

</body>
</html>