<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<body>
<!-- LOGOUT PAGE -->
<div class="logout-page">

    <!-- BG DECOR -->
    <div class="logout-bg-circle logout-bg-circle-1"></div>
    <div class="logout-bg-circle logout-bg-circle-2"></div>

    <div class="logout-card">
        <!-- ICON -->
        <div class="logout-icon-wrap">🚪</div>

        <!-- HEADING -->
        <h2>Ready to leave?</h2>

        <p class="logout-sub">
            You're about to sign out of your Sip and Serve account.
            Any unsaved changes will be lost.
        </p>

        <!-- SESSION INFO -->
        <div class="logout-session-info">

            <h4>Current Session</h4>

            <div class="session-row">
                <span>Signed in as</span>
                <span>${sessionScope.username}</span>
            </div>

            <div class="session-row">
                <span>Role</span>
                <span>User</span>
            </div>

            <div class="session-row">
                <span>Status</span>
                <span>Active</span>
            </div>

        </div>

        <div class="logout-divider">or</div>

        <!-- ACTIONS -->
        <div class="logout-actions">

            <a href="${ctx}/logout?action=confirm"
               class="btn-logout-confirm">

                🚪 Sign Me Out
            </a>

            <button class="btn-stay">
                <a href="${ctx}/profile">
                    ← Stay Signed In
                </a>
            </button>

        </div>
    </div>
</div>
</body>
</html>