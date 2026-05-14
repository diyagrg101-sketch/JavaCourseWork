<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="uri" value="${pageContext.request.requestURI}" />

<!-- ADMIN SIDEBAR -->
<nav class="admin-sidebar">

    <!-- MAIN -->
    <div class="sidebar-section-label">Main</div>

    <a href="${ctx}/adminDashboard"
       class="${uri.contains('/admin/dashboard') ? 'active' : ''}">
        <span class="sidebar-ico">📊</span>
        Dashboard
    </a>

    <a href="${ctx}/manageOrder"
       class="${uri.contains('/admin/manage-orders') ? 'active' : ''}">
        <span class="sidebar-ico">📋</span>
        Manage Orders
    </a>

    <!-- CATALOGUE -->
    <div class="sidebar-section-label">Catalogue</div>

    <a href="${ctx}/manageProduct"
       class="${uri.contains('/admin/manage-products') ? 'active' : ''}">
        <span class="sidebar-ico">🍴</span>
        Manage Products
    </a>

    <a href="${ctx}/manageCategories"
       class="${uri.contains('/admin/manage-categories') ? 'active' : ''}">
        <span class="sidebar-ico">🗂️</span>
        Categories
    </a>

    <!-- PEOPLE -->
    <div class="sidebar-section-label">People</div>

    <a href="${ctx}/manageUser"
       class="${uri.contains('/admin/manage-users') ? 'active' : ''}">
        <span class="sidebar-ico">👥</span>
        Manage Users
    </a>

    <!-- ANALYTICS -->
    <div class="sidebar-section-label">Analytics</div>

    <a href="${ctx}/report"
       class="${uri.contains('/admin/reports') ? 'active' : ''}">
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