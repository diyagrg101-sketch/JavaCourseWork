<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<body>
<div style="max-width:700px;margin:0 auto;padding:32px 24px 60px">

    <!-- BREADCRUMB -->
    <div class="breadcrumb" style="margin-bottom:10px">
        <a href="${ctx}/profile">Account</a>
        <span class="sep">›</span>
        <span class="current">Edit Profile</span>
    </div>
    <h1 style="font-size:1.5rem;font-weight:800;margin-bottom:4px">Update Your Profile</h1>
    <p style="font-size:.84rem;color:var(--text-muted);margin-bottom:28px">Manage your identity, contact information, and security preferences.</p>

    <!-- AVATAR -->
    <div style="text-align:center;margin-bottom:28px">
        <div style="position:relative;display:inline-block">
            <div style="width:88px;height:88px;border-radius:50%;background:linear-gradient(135deg,#6B48FF,#C850C0);margin:0 auto;overflow:hidden;display:flex;align-items:center;justify-content:center;font-size:2rem">🧑</div>
            <div style="position:absolute;bottom:0;right:0;width:28px;height:28px;background:var(--orange);border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:.75rem;cursor:pointer;border:2px solid #fff">📷</div>
        </div>
        <div style="font-size:.95rem;font-weight:700;margin-top:10px">Arjun Karki</div>
        <div style="font-size:.8rem;color:var(--text-muted)">Coffee Enthusiast • Kathmandu</div>
    </div>

    <!-- PERSONAL INFO -->
    <div class="checkout-section" style="margin-bottom:14px">
        <div class="cs-header">
            <div class="cs-header-left">
                <div class="cs-icon">👤</div>
                <div>
                    <div class="cs-title">Personal Information</div>
                    <div class="cs-sub">How you appear to the community and staff.</div>
                </div>
            </div>
        </div>
        <div class="input-row">
            <div class="form-group"><label>First Name</label><input class="form-control" value="Arjun"/></div>
            <div class="form-group"><label>Last Name</label><input class="form-control" value="Karki"/></div>
        </div>
        <div class="form-group">
            <label>Public Bio (Optional)</label>
            <textarea class="form-control" rows="3">Passionate about artisanal coffee and sustainable café culture. Frequent visitor of Sip and Serve!</textarea>
        </div>
    </div>

    <!-- CONTACT DETAILS -->
    <div class="checkout-section" style="margin-bottom:14px">
        <div class="cs-header">
            <div class="cs-header-left">
                <div class="cs-icon">📞</div>
                <div>
                    <div class="cs-title">Contact Details</div>
                    <div class="cs-sub">Keep your contact info updated for order notifications.</div>
                </div>
            </div>
        </div>
        <div class="input-row">
            <div class="form-group">
                <label>Email Address</label>
                <div style="position:relative">
                    <span style="position:absolute;left:12px;top:50%;transform:translateY(-50%);color:var(--text-muted);font-size:.85rem">✉️</span>
                    <input class="form-control" style="padding-left:34px" value="arjun.karki@example.com" type="email"/>
                </div>
            </div>
            <div class="form-group">
                <label>Phone Number</label>
                <div style="position:relative">
                    <span style="position:absolute;left:12px;top:50%;transform:translateY(-50%);color:var(--text-muted);font-size:.85rem">📞</span>
                    <input class="form-control" style="padding-left:34px" value="+977 9801234567"/>
                </div>
            </div>
        </div>
    </div>

    <!-- DELIVERY ADDRESS -->
    <div class="checkout-section" style="margin-bottom:14px">
        <div class="cs-header">
            <div class="cs-header-left">
                <div class="cs-icon">📍</div>
                <div>
                    <div class="cs-title">Default Delivery Address</div>
                    <div class="cs-sub">Your primary location for home deliveries.</div>
                </div>
            </div>
        </div>
        <div class="form-group">
            <label>Full Address</label>
            <div style="position:relative">
                <span style="position:absolute;left:12px;top:14px;color:var(--text-muted);font-size:.85rem">📍</span>
                <textarea class="form-control" style="padding-left:34px;min-height:80px">Baneshwor, Kathmandu</textarea>
            </div>
        </div>
    </div>

    <!-- SECURITY -->
    <div class="checkout-section" style="margin-bottom:28px">
        <div class="cs-header">
            <div class="cs-header-left">
                <div class="cs-icon">🛡️</div>
                <div>
                    <div class="cs-title">Security &amp; Password</div>
                    <div class="cs-sub">Update your password to keep your account safe.</div>
                </div>
            </div>
        </div>
        <div style="display:flex;align-items:center;justify-content:space-between;padding:14px 0;border-top:1px solid var(--border)">
            <div style="display:flex;align-items:center;gap:10px">
                <span style="font-size:1rem">🔒</span>
                <div>
                    <div style="font-size:.84rem;font-weight:600">Password was last changed 3 months ago</div>
                    <div style="font-size:.72rem;font-weight:700;color:var(--text-muted);text-transform:uppercase;letter-spacing:.06em">Security Score: Good</div>
                </div>
            </div>
            <a href="${ctx}/changePassword" class="btn btn-outline"
               style="font-size:.82rem;padding:7px 14px;display:inline-block;text-decoration:none;">
                Change Password
            </a>
        </div>
    </div>

    <!-- SAVE / CANCEL BAR -->
    <div style="display:flex;justify-content:flex-end;align-items:center;gap:14px;background:#fff;border:1px solid var(--border);border-radius:var(--r);padding:16px 20px">
        <button class="btn btn-outline" onclick="location.href='user-profile.html'">✕ &nbsp;Cancel Changes</button>
        <button class="btn btn-primary btn-lg">💾 &nbsp;Save Profile Changes</button>
    </div>
</div>

</body>
</html>
