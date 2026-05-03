<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<header class="navbar" id="navbar">
    <div class="container nav-container">

        <a href="${ctx}/home" class="brand">
            <span class="brand-logo"><i class="fa-solid fa-mug-saucer"></i></span>
            <span class="brand-name">Sip and Serve</span>
        </a>

        <nav class="nav-links" id="navLinks">
            <a href="${ctx}/home" class="nav-link ${uri.contains('/home') ? 'active' : ''}">Home</a>

            <a href="${ctx}/manageProducts" class="nav-link ${uri.contains('/manageProducts') ? 'active' : ''}">Menu</a>

            <a href="${ctx}/about" class="nav-link ${uri.contains('/about') ? 'active' : ''}">About Us</a>

            <a href="${ctx}/contact" class="nav-link ${uri.contains('/contact') ? 'active' : ''}">Contact Us</a>

            <div class="nav-actions">
                <a href="${ctx}/login" class="btn-link">Login</a>
                <a href="${ctx}/login" class="btn btn-primary">Sign In</a>
            </div>
        </nav>

    </div>
</header>