<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<body>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="feedback-page">
    <a href="${ctx}/profile" class="go-dashboard-btn">← Go to Profile</a>

    <h1 class="fb-title">Share Your Experience</h1>
    <p class="fb-sub">Your reviews help us brew better coffee and serve warmer memories.</p>

    <!-- STATS -->
    <div class="fb-stats-row">
        <div class="fb-stat">
            <div class="fb-stat-val">${not empty avgRating ? avgRating : '—'} ⭐</div>
            <div class="fb-stat-label">Overall Rating</div>
        </div>
        <div class="fb-divider"></div>
        <div class="fb-stat">
            <div class="fb-stat-val">${not empty totalReviews ? totalReviews : '0'}+</div>
            <div class="fb-stat-label">Happy Sips</div>
        </div>
    </div>

    <!-- FLASH MESSAGES -->
    <c:if test="${not empty errorMsg}">
        <div class="alert alert-danger">${fn:escapeXml(errorMsg)}</div>
    </c:if>

    <!-- WRITE REVIEW FORM -->
    <div class="write-review-card">
        <div class="wr-title">⭐ Write a Review</div>

        <form action="${ctx}/feedback/submit" method="post" id="reviewForm">

            <input type="hidden" name="csrfToken" value="${fn:escapeXml(csrfToken)}" />
            <input type="hidden" name="rating"    id="ratingInput" value="0" />

            <!-- PRODUCT SELECTOR -->
            <div class="rating-question" style="margin-bottom:8px">Which product are you reviewing?</div>
            <select name="productId" id="productSelect" class="form-control" style="margin-bottom:18px;padding:10px;border-radius:8px;border:1px solid #ddd;font-size:.9rem;width:100%">
                <option value="">— Select a product —</option>
                <c:forEach var="p" items="${products}">
                    <%-- p[0] = id (Integer), p[1] = name (String) --%>
                    <option value="${p[0]}">${fn:escapeXml(p[1].toString())}</option>
                </c:forEach>
            </select>

            <!-- STAR RATING -->
            <div class="rating-question">How was your order?</div>
            <div class="stars-row">
                <span class="star" onclick="setStars(1)">★</span>
                <span class="star" onclick="setStars(2)">★</span>
                <span class="star" onclick="setStars(3)">★</span>
                <span class="star" onclick="setStars(4)">★</span>
                <span class="star" onclick="setStars(5)">★</span>
            </div>
            <div class="rating-label" id="rating-label">Click a star to rate</div>

            <!-- REVIEW TEXT -->
            <div class="review-textarea-wrap">
                <textarea class="form-control"
                          name="message"
                          id="reviewMsg"
                          rows="5"
                          maxlength="1000"
                          placeholder="Share your experience..."
                          oninput="updateCount(this)"></textarea>
                <span class="review-count" id="char-count">0/1000</span>
            </div>

            <button type="submit"
                    class="btn btn-submit-review btn-full"
                    onclick="return validateForm()">
                Submit Review ✈️
            </button>
        </form>
    </div>

    <!-- COMMUNITY FEED -->
    <div class="community-section">
        <h3 class="cs-title">💬 Community Feed</h3>

        <c:choose>
            <c:when test="${empty feedbacks}">
                <p class="no-reviews">No reviews yet — be the first to share!</p>
            </c:when>
            <c:otherwise>
                <c:forEach var="fb" items="${feedbacks}">
                    <div class="review-card">
                        <div class="review-header">
                            <span class="review-user">${fn:escapeXml(fb.userName)}</span>
                            <span class="review-stars">
                                <c:forEach begin="1" end="${fb.rating}"     var="i">★</c:forEach>
                                <c:forEach begin="${fb.rating+1}" end="5"   var="i">☆</c:forEach>
                            </span>
                            <span class="review-date">${fn:escapeXml(fb.formattedDate)}</span>
                        </div>
                        <c:if test="${not empty fb.productName}">
                            <div style="font-size:.78rem;color:var(--text-muted);margin-bottom:4px">
                                ☕ ${fn:escapeXml(fb.productName)}
                            </div>
                        </c:if>
                        <p class="review-msg">${fn:escapeXml(fb.review)}</p>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

<script>
    const labels = ['', 'Terrible 😞', 'Poor 😕', 'Okay 😐', 'Good 😊', 'Exceptional! 🤩'];
    let selectedRating = 0;

    function setStars(n) {
        selectedRating = n;
        document.getElementById('ratingInput').value = n;
        document.querySelectorAll('.star').forEach((s, i) => {
            s.classList.toggle('active', i < n);
        });
        document.getElementById('rating-label').textContent = labels[n];
    }

    function updateCount(el) {
        const len     = el.value.length;
        const counter = document.getElementById('char-count');
        counter.textContent = len + '/1000';
        counter.style.color = len > 900 ? '#e74c3c' : '';
    }

    function validateForm() {
        const product = document.getElementById('productSelect').value;
        if (!product) {
            alert('Please select a product to review.');
            return false;
        }
        if (selectedRating === 0) {
            alert('Please click a star to rate your experience.');
            return false;
        }
        if (document.getElementById('reviewMsg').value.trim().length < 5) {
            alert('Please write at least 5 characters in your review.');
            return false;
        }
        return true;
    }
</script>

<%-- Toast notification on success --%>
<c:if test="${not empty successMsg}">
    <script>
        window.addEventListener('DOMContentLoaded', function () {
            const t = document.createElement('div');
            t.innerHTML = '<span style="background:#22c55e;border-radius:4px;padding:2px 6px;margin-right:10px;">✔</span>'
                + '<strong>${fn:escapeXml(successMsg)}</strong>';
            t.style.cssText = [
                'position:fixed','bottom:28px','left:50%',
                'transform:translateX(-50%)','background:#1a1a1a','color:#fff',
                'padding:13px 22px','border-radius:999px','font-size:.88rem',
                'display:flex','align-items:center','gap:4px','z-index:9999',
                'box-shadow:0 4px 18px rgba(0,0,0,0.25)','animation:fadeIn .3s ease'
            ].join(';');
            document.body.appendChild(t);
            setTimeout(() => t.remove(), 3500);
        });
    </script>
    <style>
        @keyframes fadeIn {
            from { opacity:0; transform:translateX(-50%) translateY(12px); }
            to   { opacity:1; transform:translateX(-50%) translateY(0); }
        }
    </style>
</c:if>
</body>
</html>
