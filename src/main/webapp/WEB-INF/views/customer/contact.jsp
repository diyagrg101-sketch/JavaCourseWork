<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<body>

<!-- ================= NAVBAR ================= -->
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<!-- CONTACT HERO -->
<div class="contact-hero">
    <div class="contact-icon">🥐</div>
    <h2>Let's Connect over Coffee</h2>
</div>

<!-- MAIN CONTACT CONTENT -->
<div class="contact-main">

    <!-- LEFT: FORM -->
    <div class="contact-form-section">
        <h2>Get in Touch</h2>
        <div class="contact-form-card">
            <h3>Send Message</h3>
            <p>We'll get back to you within 24 hours.</p>

            <div class="form-row">
                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" placeholder=""/>
                </div>
                <div class="form-group">
                    <label>Phone Number</label>
                    <input type="text" placeholder=""/>
                </div>
            </div>

            <div class="form-group">
                <label>Email Address</label>
                <input type="email" placeholder=""/>
            </div>

            <div class="form-group">
                <label>Subject</label>
                <input type="text" placeholder=""/>
            </div>

            <div class="form-group">
                <label>Your Message</label>
                <textarea placeholder=""></textarea>
            </div>

            <button class="btn-full solid">🛡️ Send Message</button>
        </div>
    </div>

    <!-- RIGHT: INFO -->
    <div class="contact-info-section">
        <h2>Visit our Cafe</h2>

        <div class="info-items">
            <div class="info-row">
                <div class="info-row-icon">📍</div>
                <div class="info-row-text">
                    <strong>Address</strong>
                    <p>Newroad, Pokhara<br/>Gandaki Province, Nepal</p>
                    <span class="info-row-tag">Direction Available</span>
                </div>
            </div>
            <div class="info-row">
                <div class="info-row-icon">📞</div>
                <div class="info-row-text">
                    <strong>Call us Directly</strong>
                    <p>+977 (984) 123-4567</p>
                    <span class="info-row-tag">Mon-Sun, 8am-8pm</span>
                </div>
            </div>
            <div class="info-row">
                <div class="info-row-icon">✉️</div>
                <div class="info-row-text">
                    <strong>Email Address</strong>
                    <p>sipandserve@gmail.com</p>
                    <span class="info-row-tag">Fast Response</span>
                </div>
            </div>
            <div class="info-row">
                <div class="info-row-icon">🌐</div>
                <div class="info-row-text">
                    <strong>Follow Us</strong>
                    <p>sipandserve-pkr</p>
                    <span class="info-row-tag">Latest Update</span>
                </div>
            </div>
        </div>

        <div class="hours-card">
            <h4>🕐 Opening Hours</h4>
            <div class="hours-row">
                <span class="day">Monday – Friday</span>
                <span>7:00 AM – 10:00 PM</span>
            </div>
            <div class="hours-row">
                <span class="day">Saturday</span>
                <span>8:00 AM – 11:00 PM</span>
            </div>
            <div class="hours-row">
                <span class="day">Sunday</span>
                <span>9:00 AM – 9:00 PM</span>
            </div>
            <p class="hours-note">Holiday hours may vary. Please check our social media for update.</p>
        </div>
    </div>

</div>

<!-- SHARING SECTION -->
<div class="sharing-section">
    <h2>Sharing is Caring !</h2>
    <p>Tag us in your café moments for a chance to be featured</p>
    <div class="sharing-icons">
        <div class="sharing-icon-item">
            <div class="sharing-icon-circle">☕</div>
            <span>Coffee</span>
        </div>
        <div class="sharing-icon-item">
            <div class="sharing-icon-circle">👥</div>
            <span>Community</span>
        </div>
        <div class="sharing-icon-item">
            <div class="sharing-icon-circle">🌍</div>
            <span>Culture</span>
        </div>
    </div>
</div>
<!-- ================= FOOTER ================= -->
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>