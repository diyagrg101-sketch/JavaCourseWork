<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />


<!-- NAVBAR -->
<nav class="navbar">

    <a href="${ctx}/home" class="brand">
        <img src="${ctx}/assets/images/logo.png" alt="logo"/>
        <span class="brand-name">Sip & Serve</span>
    </a>

    <div class="nav-actions">

        <!-- USER NOT LOGGED IN -->
        <c:if test="${sessionScope.user == null}">
            <a href="${ctx}/login" class="btn-link">Login</a>

            <a href="${ctx}/register"
               class="btn btn-primary">
                Sign Up
            </a>
        </c:if>

        <!-- USER LOGGED IN -->
        <c:if test="${sessionScope.user != null}">

            <a href="${ctx}/cart" class="cart-icon">
                <i class="fa-solid fa-cart-shopping"></i>
                <span class="cart-count">0</span>
            </a>

            <a href="${ctx}/dashboard" class="user-profile-nav">

                <div class="profile-circle">
                        ${sessionScope.user.substring(0,1).toUpperCase()}
                </div>

            </a>

        </c:if>
    </div>

</nav>