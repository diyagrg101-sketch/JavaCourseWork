<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:formatDate value="${fb.createdAt}" pattern="yyyy-MM-dd HH:mm"/>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<body>

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<!-- LOGIN CHECK (IMPORTANT) -->
<c:if test="${empty sessionScope.user}">
    <c:redirect url="${ctx}/login"/>
</c:if>

<div class="feedback-page">

    <a href="${ctx}/profile" class="go-dashboard-btn">← Go to Profile</a>

    <h1 class="fb-title">Share Your Experience</h1>
    <p class="fb-sub">Your reviews help us improve Sip & Serve ☕</p>

    <!-- STATS -->
    <div class="fb-stats-row">
        <div class="fb-stat">
            <div class="fb-stat-val">
                ${not empty avgRating ? avgRating : '—'} ⭐
            </div>
            <div class="fb-stat-label">Overall Rating</div>
        </div>

        <div class="fb-divider"></div>

        <div class="fb-stat">
            <div class="fb-stat-val">
                ${totalReviews != null ? totalReviews : 0}+
            </div>
            <div class="fb-stat-label">Happy Sips</div>
        </div>
    </div>

    <!-- FLASH MESSAGES -->
    <c:if test="${not empty successMsg}">
        <div class="alert alert-success">${fn:escapeXml(successMsg)}</div>
    </c:if>

    <c:if test="${not empty errorMsg}">
        <div class="alert alert-danger">${fn:escapeXml(errorMsg)}</div>
    </c:if>

    <!-- WRITE REVIEW -->
    <div class="write-review-card">

        <div class="wr-title">⭐ Write a Review</div>

        <form action="${ctx}/feedback/submit" method="post" id="reviewForm">

            <!-- CSRF -->
            <input type="hidden" name="csrfToken" value="${fn:escapeXml(csrfToken)}" />

            <!-- Rating -->
            <input type="hidden" name="rating" id="ratingInput" value="0" />

            <div class="rating-question">How was your experience?</div>

            <div class="stars-row">
                <span class="star" onclick="setStars(1)">★</span>
                <span class="star" onclick="setStars(2)">★</span>
                <span class="star" onclick="setStars(3)">★</span>
                <span class="star" onclick="setStars(4)">★</span>
                <span class="star" onclick="setStars(5)">★</span>
            </div>

            <div class="rating-label" id="rating-label">Click a star to rate</div>

            <!-- Message -->
            <div class="review-textarea-wrap">
                <textarea class="form-control"
                          name="message"
                          id="reviewMsg"
                          rows="5"
                          maxlength="500"
                          placeholder="Share your experience..."
                          oninput="updateCount(this)"></textarea>

                <span class="review-count" id="char-count">0/500</span>
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

        <h3 class="cs-title">💬 Community Reviews</h3>

        <c:choose>
            <c:when test="${empty feedbacks}">
                <p class="no-reviews">No reviews yet — be the first to share!</p>
            </c:when>

            <c:otherwise>

                <c:forEach var="fb" items="${feedbacks}">
                    <div class="review-card">

                        <div class="review-header">

                            <!-- USER NAME FROM JOIN -->
                            <span class="review-user">
                                    ${fn:escapeXml(fb.fullName)}
                            </span>

                            <!-- STARS -->
                            <span class="review-stars">

                                <c:set var="rate" value="${not empty fb.rating ? fb.rating : 0}" />

                                <c:forEach begin="1" end="${rate}">
                                    ★
                                </c:forEach>

                                <c:forEach begin="${rate + 1}" end="5">
                                    ☆
                                </c:forEach>

                            </span>

                            <!-- DATE -->
                            <span class="review-date">
                                <fmt:formatDate value="${fb.createdAt}" pattern="yyyy-MM-dd HH:mm"/>
                            </span>

                        </div>

                        <p class="review-msg">
                                ${fn:escapeXml(fb.review)}
                        </p>

                    </div>
                </c:forEach>

            </c:otherwise>
        </c:choose>

    </div>

</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

<!-- JS -->
<script>
    const labels = ['', 'Terrible 😞', 'Poor 😕', 'Okay 😐', 'Good 😊', 'Excellent 🤩'];
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
        const len = el.value.length;
        const counter = document.getElementById('char-count');
        counter.textContent = len + '/500';
        counter.style.color = len > 450 ? '#e74c3c' : '';
    }

    function validateForm() {
        if (selectedRating === 0) {
            alert('Please select a rating');
            return false;
        }

        if (document.getElementById('reviewMsg').value.trim().length < 5) {
            alert('Review must be at least 5 characters');
            return false;
        }

        return true;
    }
</script>

</body>
</html>