<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <title>Sip and Serve – Login</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/auth.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=DM+Sans:wght@400;500;600&display=swap" rel="stylesheet"/>
</head>

<body>

<div class="auth-page">
    <div class="auth-card login-card">

        <div class="auth-logo" style="margin-top:10px;">
            <div class="auth-logo-icon">☕</div>
        </div>

        <h2 style="margin-top:8px;">Welcome back!</h2>
        <p class="auth-subtitle">The aroma of fresh coffee is waiting for you.</p>

        <!-- ERROR MESSAGE (FIXED for LoginServlet) -->
        <c:if test="${not empty error}">
            <div style="color:red; margin:10px 0; font-weight:500;">
                    ${error}
            </div>
        </c:if>

        <!-- Login Type Tab-->
        <div class="login-tabs">
            <button type="button" class="login-tab active" onclick="setTab(this, 'member')">👤 Member</button>
            <button type="button" class="login-tab" onclick="setTab(this, 'admin')">🛡️ Admin</button>
        </div>

        <!-- Login Form -->
        <form action="${pageContext.request.contextPath}/login" method="post">

            <input type="hidden" name="loginType" id="loginType" value="member">

            <div class="form-group">
                <label>Email or Phone Number</label>
                <input type="text" name="email" required />
            </div>

            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" required />
            </div>

            <div style="text-align:right; margin-top:6px;">
                <a href="${pageContext.request.contextPath}/forgetPassword"
                   class="cp-forgot-link"
                   style="font-size:.62rem; color:#8b5e3c; text-decoration:none; font-weight:500;">
                    Forgot your password?
                </a>
            </div>

            <button type="submit" class="btn-full solid">
                Sign In to Your Account →
            </button>

        </form>

        <!-- Social Login -->
        <div class="divider">OR CONTINUE WITH</div>

        <div class="social-row">
            <button class="social-auth-btn"><i class="g-icon">G</i> Google</button>
            <button class="social-auth-btn"><i class="fb-icon">f</i> Facebook</button>
        </div>

        <div class="divider">──────────────────────────────────────</div>

        <!-- Register Link -->
        <div class="auth-link">
            Don't have an account yet?
            <a href="${pageContext.request.contextPath}/register">Create an account</a>
        </div>

        <div class="footer-auth-links">
            <a href="#">Privacy Policy</a>
            <a href="#">Terms of Service</a>
            <a href="#">Contact Support</a>
        </div>

    </div>
</div>

<script>
    function setTab(el, type) {

        document.querySelectorAll('.login-tab')
            .forEach(t => t.classList.remove('active'));

        el.classList.add('active');

        document.getElementById('loginType').value = type;
    }
</script>

</body>
</html>