<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<body>

<!-- ================= NAVBAR ================= -->
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<!-- ================= CONTACT HERO ================= -->
<section class="contact-hero">
    <div class="contact-icon">🥐</div>
    <h2>Let's Connect over Coffee</h2>
</section>

<!-- ================= CONTACT MAIN ================= -->
<section class="contact-main">

    <!-- FORM -->
    <div class="contact-form-section">

        <h2>Get in Touch</h2>

        <div class="contact-form-card">
            <h3>Send Message</h3>
            <p>We'll get back to you within 24 hours.</p>

            <form>
                <div class="form-row">
                    <div class="form-group">
                        <label>Full Name</label>
                        <input type="text" placeholder="Enter your name"/>
                    </div>

                    <div class="form-group">
                        <label>Phone Number</label>
                        <input type="text" placeholder="Enter phone number"/>
                    </div>
                </div>

                <div class="form-group">
                    <label>Email Address</label>
                    <input type="email" placeholder="Enter email"/>
                </div>

                <div class="form-group">
                    <label>Subject</label>
                    <input type="text" placeholder="Subject"/>
                </div>

                <div class="form-group">
                    <label>Your Message</label>
                    <textarea placeholder="Write your message..."></textarea>
                </div>

                <button type="submit" class="btn-full solid">
                    🛡️ Send Message
                </button>
            </form>
        </div>

    </div>

    <!-- INFO -->
    <div class="contact-info-section">

        <h2>Visit our Cafe</h2>

        <div class="info-items">

            <div class="info-row">
                <div class="info-row-icon">📍</div>
                <div class="info-row-text">
                    <strong>Address</strong>
                    <p>Newroad, Pokhara<br/>Nepal</p>
                    <span class="info-row-tag">Direction Available</span>
                </div>
            </div>

            <div class="info-row">
                <div class="info-row-icon">📞</div>
                <div class="info-row-text">
                    <strong>Call us</strong>
                    <p>+977 9841 123 4567</p>
                    <span class="info-row-tag">Mon-Sun, 8am-8pm</span>
                </div>
            </div>

            <div class="info-row">
                <div class="info-row-icon">✉️</div>
                <div class="info-row-text">
                    <strong>Email</strong>
                    <p>sipandserve@gmail.com</p>
                    <span class="info-row-tag">Fast Response</span>
                </div>
            </div>

            <div class="info-row">
                <div class="info-row-icon">🌐</div>
                <div class="info-row-text">
                    <strong>Follow Us</strong>
                    <p>sipandserve-pkr</p>
                    <span class="info-row-tag">Stay Updated</span>
                </div>
            </div>

        </div>

    </div>

</section>

<!-- ================= FOOTER ================= -->
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>