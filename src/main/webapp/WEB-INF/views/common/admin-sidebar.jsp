<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="uri" value="${pageContext.request.requestURI}" />

<!-- ADMIN SIDEBAR -->
<nav class="admin-sidebar">

    <!-- MAIN -->
    <div class="sidebar-section-label">Main</div>

    <a href="${ctx}/adminDashboard"
       class="${uri.contains('adminDashboard') ? 'active' : ''}">
        <span class="sidebar-ico">📊</span>
        Dashboard
    </a>

    <a href="${ctx}/manageOrder"
       class="${uri.contains('manageOrder') ? 'active' : ''}">
        <span class="sidebar-ico">📋</span>
        Manage Orders
    </a>

    <!-- CATALOGUE -->
    <div class="sidebar-section-label">Catalogue</div>

    <a href="${ctx}/manageProduct"
       class="${uri.contains('manageProduct') ? 'active' : ''}">
        <span class="sidebar-ico">🍴</span>
        Manage Products
    </a>

    <a href="${ctx}/manageCategories"
       class="${uri.contains('manageCategories') ? 'active' : ''}">
        <span class="sidebar-ico">🗂️</span>
        Categories
    </a>

    <!-- PEOPLE -->
    <div class="sidebar-section-label">People</div>

    <a href="${ctx}/manageUser"
       class="${uri.contains('manageUser') ? 'active' : ''}">
        <span class="sidebar-ico">👥</span>
        Manage Users
    </a>

    <!-- ANALYTICS -->
    <div class="sidebar-section-label">Analytics</div>

    <a href="${ctx}/report"
       class="${uri.contains('report') ? 'active' : ''}">
        <span class="sidebar-ico">📈</span>
        Reports
    </a>

    <!-- SIGN OUT -->
    <div class="sidebar-bottom">
        <a href="${ctx}/logout" class="signout">
            <span class="sidebar-ico">↩</span>
            Logout
        </a>
    </div>

</nav>