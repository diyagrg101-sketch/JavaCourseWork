<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />


<!DOCTYPE html>
<html lang="en">
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<body>

<!-- ══════════════ ERROR PAGE ══════════════ -->
<div class="err-page">

    <!-- BG DECORATIONS -->
    <div class="err-bg-circle err-bg-circle-1"></div>
    <div class="err-bg-circle err-bg-circle-2"></div>
    <div class="err-bg-circle err-bg-circle-3"></div>

    <div class="err-container">

        <!-- ── DYNAMIC ERROR DISPLAY ── -->
        <%
            /* Detect status code — works both as error page & forwarded page */
            Integer statusCode = (Integer) request.getAttribute("javax.servlet.error.status_code");
            String errorMsg    = (String)  request.getAttribute("javax.servlet.error.message");
            String requestUri  = (String)  request.getAttribute("javax.servlet.error.request_uri");

            if (statusCode == null) {
                /* fallback: read from query param e.g. error.jsp?code=500 */
                String p = request.getParameter("code");
                statusCode = (p != null) ? Integer.parseInt(p) : 500;
            }
            if (errorMsg == null || errorMsg.isEmpty()) {
                errorMsg = request.getParameter("msg");
            }
            if (requestUri == null) requestUri = request.getParameter("uri");

            /* Map code → friendly info */
            String errIcon, errTitle, errSubtitle, errHint;
            switch (statusCode) {
                case 400:
                    errIcon     = "☕";
                    errTitle    = "Bad Request";
                    errSubtitle = "Looks like your order got a little mixed up.";
                    errHint     = "Double-check the details and try again.";
                    break;
                case 401:
                    errIcon     = "🔒";
                    errTitle    = "Unauthorised";
                    errSubtitle = "You need to be signed in to access this page.";
                    errHint     = "Please log in and try again.";
                    break;
                case 403:
                    errIcon     = "🚫";
                    errTitle    = "Access Denied";
                    errSubtitle = "You don't have permission to view this page.";
                    errHint     = "If you think this is a mistake, contact our support team.";
                    break;
                case 404:
                    errIcon     = "🫗";
                    errTitle    = "Page Not Found";
                    errSubtitle = "Oops! Looks like this cup is empty.";
                    errHint     = "The page you're looking for may have moved or doesn't exist.";
                    break;
                case 408:
                    errIcon     = "⏱️";
                    errTitle    = "Request Timed Out";
                    errSubtitle = "Your request took too long — like a slow brew on a cold day.";
                    errHint     = "Please check your connection and try again.";
                    break;
                case 500:
                    errIcon     = "💥";
                    errTitle    = "Internal Server Error";
                    errSubtitle = "Our espresso machine has hiccuped. We're on it!";
                    errHint     = "Our team has been notified. Please try again in a moment.";
                    break;
                default:
                    errIcon     = "😕";
                    errTitle    = "Something Went Wrong";
                    errSubtitle = "An unexpected error occurred on our end.";
                    errHint     = "Please try again or contact support if this persists.";
                    break;
            }
        %>

        <!-- ILLUSTRATION AREA -->
        <div class="err-illustration">
            <div class="err-big-icon"><%= errIcon %></div>
            <div class="err-code-badge"><%= statusCode %></div>
        </div>

        <!-- COPY -->
        <h1 class="err-title"><%= errTitle %></h1>
        <p class="err-subtitle"><%= errSubtitle %></p>
        <p class="err-hint"><%= errHint %></p>

        <!-- SHOW TECHNICAL DETAIL (only if present) -->
        <% if (errorMsg != null && !errorMsg.trim().isEmpty()) { %>
        <div class="err-tech-box">
            <div class="err-tech-label">Technical Details</div>
            <code class="err-tech-msg"><%= errorMsg %></code>
            <% if (requestUri != null) { %>
            <code class="err-tech-uri">Path: <%= requestUri %></code>
            <% } %>
        </div>
        <% } %>

        <!-- ACTIONS -->
        <div class="err-actions">
            <a href="${ctx}/home" class="err-btn-primary">🏠 &nbsp;Go to Home</a>
            <a href="javascript:history.back()" class="err-btn-outline">← &nbsp;Go Back</a>
            <a href="${ctx}/menu" class="err-btn-outline">☕ &nbsp;Browse Menu</a>
        </div>

        <!-- HELP NOTE -->
        <div class="err-help">
            <span>Still having trouble?</span>
            <a href="${ctx}/contact">Contact our support team →</a>
        </div>

        <!-- SUGGESTIONS -->
        <div class="err-suggestions">
            <div class="err-suggestions-title">You might also like</div>
            <div class="err-suggestion-cards">
                <a href="${ctx}/menu" class="err-suggestion-card">
                    <span class="err-sugg-icon">🍽️</span>
                    <div class="err-sugg-name">Our Menu</div>
                    <div class="err-sugg-sub">Browse all items</div>
                </a>
                <a href="${ctx}/about" class="err-suggestion-card">
                    <span class="err-sugg-icon">🌿</span>
                    <div class="err-sugg-name">About Us</div>
                    <div class="err-sugg-sub">Our story</div>
                </a>
                <a href="${ctx}/contact" class="err-suggestion-card">
                    <span class="err-sugg-icon">📞</span>
                    <div class="err-sugg-name">Contact Us</div>
                    <div class="err-sugg-sub">Get in touch</div>
                </a>
                <a href="${ctx}/login" class="err-suggestion-card">
                    <span class="err-sugg-icon">🔑</span>
                    <div class="err-sugg-name">Sign In</div>
                    <div class="err-sugg-sub">Access your account</div>
                </a>
            </div>
        </div>

    </div>
</div>

</body>
</html>