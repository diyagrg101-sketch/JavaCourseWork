<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Sip and Serve – Create Account</title>
    <!--<link rel="stylesheet" href="style.css"/>  -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=DM+Sans:wght@400;500;600&display=swap" rel="stylesheet"/>
</head>
<body>

<div class="auth-page">
    <div class="auth-card">

        <div class="auth-logo">
            <div class="auth-logo-icon">☕</div>
            <span>Sip and Serve</span>
        </div>

        <h2>Create an account</h2>
        <p class="auth-subtitle">Join our community and enjoy a smarter cafe experience.</p>

        <div class="profile-pic-area">
            <div class="profile-pic-circle">
                <div class="circle"></div>
                <div class="cam-btn">📷</div>
            </div>
            <div class="profile-pic-label">Profile Picture</div>
            <div class="profile-pic-sublabel">Optional but we love to see your face.</div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label>Full Name</label>
                <input type="text" placeholder=""/>
            </div>
            <div class="form-group">
                <label>Email or Phone Number</label>
                <input type="text" placeholder=""/>
            </div>
        </div>

        <div class="form-group">
            <label>Password</label>
            <div class="input-icon">
                <span class="icon">🔒</span>
                <input type="password" placeholder="• • • • • • • • • • • • • •"/>
            </div>
        </div>

        <div class="form-group">
            <label>Confirm Password</label>
            <div class="input-icon">
                <span class="icon">🛡️</span>
                <input type="password" placeholder="• • • • • • • • • • • • • •"/>
            </div>
        </div>

        <div class="checkbox-row">
            <input type="checkbox" id="terms"/>
            <label for="terms">I agree to the <a href="#">Terms of Services</a> and <a href="#">Privacy Policy</a>. I understand my data will be handled securely as per protection guidelines.</label>
        </div>

        <button class="btn-full">Create an Account →</button>

        <div class="divider">────────────────────────────────────────────</div>

        <div class="auth-link">Already have an account? <a href="${pageContext.request.contextPath}/signin">Sign in</a></div>

        <div class="divider">OR SIGN UP WITH</div>

        <div class="social-row">
            <button class="social-auth-btn">
                <i class="g-icon">G</i> Google
            </button>
            <button class="social-auth-btn">
                <i class="fb-icon">f</i> Facebook
            </button>
        </div>

    </div>
</div>

</body>
</html>