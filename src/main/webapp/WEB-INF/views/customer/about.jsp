<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<body>

<!-- ================= NAVBAR ================= -->
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

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
            <a href="${ctx}/contact" class="btn-ghost">Get in Touch</a>
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

            <div class="team-avatar">
                <img src="${ctx}/assets/images/Member%201.jpg"
                     alt="Diya Gurung">
            </div>

            <p>Diya Gurung</p>

        </div>

        <div class="team-member">

            <div class="team-avatar">
                <img src="${ctx}/assets/images/Member%202.jpg"
                     alt="Rachana Thapa">
            </div>

            <p>Rachana Thapa</p>

        </div>

        <div class="team-member">

            <div class="team-avatar">
                <img src="${ctx}/assets/images/Member%203.jpg"
                     alt="Resma Majhi">
            </div>

            <p>Resma Majhi</p>

        </div>

        <div class="team-member">

            <div class="team-avatar">
                <img src="${ctx}/assets/images/Member%204.jpg"
                     alt="Aayushika Bataju">
            </div>

            <p>Aayushika Bataju</p>

        </div>

    </div>
</section>

<!-- ================= FOOTER ================= -->
<%@ include file="/WEB-INF/views/common/footer.jsp" %>

</body>
</html>