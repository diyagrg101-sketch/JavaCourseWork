<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Sip and Serve – Create Account</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/auth.css">

    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=DM+Sans:wght@400;500;600&display=swap"
          rel="stylesheet"/>
</head>

<body>

<div class="auth-page">
    <div class="auth-card">

        <!-- FORM START -->
        <form action="${pageContext.request.contextPath}/register" method="post">

            <div class="auth-logo">
                <div class="auth-logo-icon">☕</div>
                <span>Sip and Serve</span>
            </div>

            <h2>Create an account</h2>
            <p class="auth-subtitle">
                Join our community and enjoy a smarter cafe experience.
            </p>

            <!-- Profile section (UI only) -->
            <div class="profile-pic-area">
                <div class="profile-pic-circle">
                    <div class="circle"></div>
                    <div class="cam-btn">📷</div>
                </div>
                <div class="profile-pic-label">Profile Picture</div>
                <div class="profile-pic-sublabel">
                    Optional but we love to see your face.
                </div>
            </div>

            <!-- Full Name + Email -->
            <div class="form-row">
                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" name="fullname" required/>
                </div>

                <div class="form-group">
                    <label>Email or Phone Number</label>
                    <input type="text" name="email" required/>
                </div>
            </div>

            <!-- Password -->
            <div class="form-group">
                <label>Password</label>
                <div class="input-icon">
                    <span class="icon">🔒</span>
                    <input type="password" name="password" required/>
                </div>
            </div>

            <!-- Confirm Password -->
            <div class="form-group">
                <label>Confirm Password</label>
                <div class="input-icon">
                    <span class="icon">🛡️</span>
                    <input type="password" name="confirmPassword" required/>
                </div>
            </div>

            <!-- Terms -->
            <div class="checkbox-row">
                <input type="checkbox" id="terms" required/>
                <label for="terms">
                    I agree to the <a href="#">Terms of Services</a> and
                    <a href="#">Privacy Policy</a>.
                </label>
            </div>

            <!-- Submit -->
            <button type="submit" class="btn-full">
                Create an Account →
            </button>

        </form>
        <!-- FORM END -->

        <!-- Login link (outside form) -->
        <div class="auth-link">
            Already have an account?
            <a href="${pageContext.request.contextPath}/login">Login</a>
        </div>

    </div>
</div>

</body>
</html>