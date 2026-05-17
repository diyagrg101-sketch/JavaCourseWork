<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<header class="navbar" id="navbar">
    <div class="container nav-container">

        <a href="${ctx}/home" class="brand">
            <img src="${ctx}/assets/images/logo.png" alt="logo"/>
            <span class="brand-name">Sip & Serve</span>
        </a>

        <nav class="nav-links" id="navLinks">

            <a href="${ctx}/home"
               class="nav-link ${uri.contains('/home') ? 'active' : ''}">
                Home
            </a>

            <a href="${ctx}/menu"
               class="nav-link ${uri.contains('/menu') ? 'active' : ''}">
                Menu
            </a>

            <a href="${ctx}/about"
               class="nav-link ${uri.contains('/about') ? 'active' : ''}">
                About Us
            </a>

            <a href="${ctx}/contact"
               class="nav-link ${uri.contains('/contact') ? 'active' : ''}">
                Contact Us
            </a>

            <div class="nav-actions">

                <!-- USER NOT LOGGED IN -->
                <c:if test="${sessionScope.user == null}">
                    <a href="${ctx}/login" class="btn-link">Login</a>

                    <a href="${ctx}/register"
                       class="btn btn-primary" style="background:var(--orange);color:#fff;padding:13px 22px;">
                        Sign Up
                    </a>
                </c:if>

                <!-- USER LOGGED IN -->
                <c:if test="${sessionScope.user != null}">

                    <a href="${ctx}/cart" class="cart-icon">
                        <i class="fa-solid fa-cart-shopping"></i>
                        <span class="cart-count">0</span>
                    </a>

                    <a href="${ctx}/profile" class="user-profile-nav">

                        <div class="profile-circle">
                                ${sessionScope.user.substring(0,1).toUpperCase()}
                        </div>

                    </a>

                </c:if>
            </div>
        </nav>

    </div>
</header>