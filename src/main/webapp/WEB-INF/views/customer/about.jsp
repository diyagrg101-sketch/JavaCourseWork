<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>About Us - Sip and Serve</title>

    <link rel="stylesheet" href="${ctx}/assets/css/style.css">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>
</head>

<body>

<!-- ================= NAVBAR ================= -->
<header class="navbar" id="navbar">
    <div class="container nav-container">

        <a href="${ctx}/home" class="brand">
            <span class="brand-logo"><i class="fa-solid fa-mug-saucer"></i></span>
            <span class="brand-name">Sip and Serve</span>
        </a>

        <nav class="nav-links" id="navLinks">
            <a href="${ctx}/home" class="nav-link">Home</a>
            <a href="${ctx}/manageProducts" class="nav-link">Menu</a>
            <a href="${ctx}/about" class="nav-link active">About Us</a>
            <a href="${ctx}/home#contact" class="nav-link">Contact Us</a>

            <div class="nav-actions">
                <a href="${ctx}/login" class="btn-link">Login</a>
                <a href="${ctx}/login" class="btn btn-primary">Sign In</a>
            </div>
        </nav>

    </div>
</header>

<!-- ================= ABOUT HERO ================= -->
<section class="about-hero">
    <img src="${ctx}/assets/images/about-cafe-bg.jpg" alt="Cafe Interior"/>
    <div class="about-hero-overlay"></div>

    <div class="about-hero-content">
        <span class="since-badge">Since 2019</span>

        <h1>Where Every Sip<br/>Tells a Story</h1>

        <p>Our journey has always been about the perfect blend of tradition and modernity.</p>

        <div class="about-hero-btns">
            <a href="${ctx}/manageProducts" class="btn-primary">Explore Menu</a>
            <a href="${ctx}/home#contact" class="btn-ghost">Get in Touch</a>
        </div>
    </div>
</section>

<!-- ================= ABOUT CONTENT ================= -->
<section class="about-content">

    <div class="about-content-text">
        <h2>A Decade of Crafting Memories</h2>

        <p>
            Founded in the heart of Pokhara, Sip and Serve began as a small passion project
            by a group of coffee lovers who believed that a great cup of coffee could change your day.
        </p>

        <p>
            We carefully select beans from Nepal’s high hills and ensure quality in every cup we serve.
        </p>
    </div>

    <div class="about-content-img">
        <img src="${ctx}/assets/images/beans.jpg" alt="Coffee Beans"/>
    </div>

</section>

<!-- ================= CORE VALUES ================= -->
<section class="core-values">
    <h2>Our Core Values</h2>
    <p>The pillars that hold our café together.</p>

    <div class="values-grid">

        <div class="value-card">
            <div class="value-icon">💡</div>
            <h3>Ethical Sourcing</h3>
            <p>We partner with local farmers for quality beans.</p>
        </div>

        <div class="value-card">
            <div class="value-icon">❤️</div>
            <h3>Community Heart</h3>
            <p>A space for students, artists, and dreamers.</p>
        </div>

        <div class="value-card">
            <div class="value-icon">🏆</div>
            <h3>Quality First</h3>
            <p>We never compromise on taste and service.</p>
        </div>

    </div>
</section>

<!-- ================= TEAM ================= -->
<section class="meet-team">
    <h2>Meet the Team</h2>
    <p>The people behind Sip and Serve</p>

    <div class="team-grid">

        <div class="team-member">
            <div class="team-avatar"></div>
            <p>Diya Gurung</p>
        </div>

        <div class="team-member">
            <div class="team-avatar"></div>
            <p>Rachana Thapa</p>
        </div>

        <div class="team-member">
            <div class="team-avatar"></div>
            <p>Resma Majhi</p>
        </div>

        <div class="team-member">
            <div class="team-avatar"></div>
            <p>Aayushika Bataju</p>
        </div>

    </div>
</section>

<!-- ================= FOOTER ================= -->
<footer class="footer">

    <div class="container footer-grid">

        <div class="footer-col">
            <a href="${ctx}/home" class="brand">
                <span class="brand-logo"><i class="fa-solid fa-mug-saucer"></i></span>
                <span class="brand-name">Sip and Serve</span>
            </a>

            <p class="footer-text">Crafting coffee and memories since 2030.</p>

            <p class="footer-copy">© 2026 Sip and Serve. All rights reserved.</p>
        </div>

        <div class="footer-col">
            <h4 class="footer-title">Quick Links</h4>
            <ul class="footer-links">
                <li><a href="${ctx}/home">Home</a></li>
                <li><a href="${ctx}/manageProducts">Menu</a></li>
                <li><a href="${ctx}/about">About Us</a></li>
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

</footer>

</body>
</html>