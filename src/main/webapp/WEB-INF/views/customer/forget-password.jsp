<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<body>

<div class="fp-page">
    <!-- BG CIRCLES -->
    <div class="fp-bg-circle" style="width:400px;height:400px;top:-100px;left:-140px"></div>
    <div class="fp-bg-circle" style="width:300px;height:300px;bottom:-80px;right:-80px"></div>

    <!-- LOGO -->
    <div class="fp-logo">
        <div class="fp-logo-icon">☕</div>
        Sip and Serve
    </div>

    <!-- CARD -->
    <div class="fp-card">
        <div class="fp-key-icon">🔑</div>
        <h2 class="fp-title">Forgot Password?</h2>
        <p class="fp-sub">No worries! Enter your registered email or phone number and we will send you a secure link to reset your account.</p>

        <div class="form-group" style="text-align:left">
            <label>Email or Phone Number</label>
            <input class="form-control" type="text" placeholder="e.g. yourname@email.com"/>
        </div>

        <button class="btn btn-primary btn-full btn-lg" style="margin-top:4px">Send Reset Link &nbsp;›</button>

        <hr style="border:none;border-top:1px solid var(--border);margin:18px 0"/>

        <a href="${ctx}/login" class="back-login">← &nbsp;Back to Login</a>

        <p class="fp-meta">Need urgent help? <a href="${ctx}/contact">Contact Support</a></p>
        <div class="fp-secure">SIP &amp; SERVE SECURE ACCESS</div>
    </div>
</div>

</body>
</html>