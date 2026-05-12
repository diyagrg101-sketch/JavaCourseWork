<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<body>

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>


<div class="feedback-page">
    <!-- HEADER -->
    <div class="fb-badge">Voice of the Community</div>
    <h1 class="fb-title">Share Your Experience</h1>
    <p class="fb-sub">
        Your reviews help us brew better coffee and serve warmer memories.
    </p>

    <!-- STATS -->
    <div class="fb-stats-row">
        <div class="fb-stat">
            <div class="fb-stat-val">4.8 ⭐</div>
            <div class="fb-stat-label">Overall Rating</div>
        </div>
        <div class="fb-divider"></div>
        <div class="fb-stat">
            <div class="fb-stat-val">1.2k+</div>
            <div class="fb-stat-label">Happy Sips</div>
        </div>
    </div>

    <!-- WRITE REVIEW -->
    <div class="write-review-card">

        <div class="wr-title">⭐ Write a Review</div>

        <div class="rating-question">How was your order?</div>

        <div class="stars-row">
            <span class="star active" onclick="setStars(1)">★</span>
            <span class="star active" onclick="setStars(2)">★</span>
            <span class="star active" onclick="setStars(3)">★</span>
            <span class="star active" onclick="setStars(4)">★</span>
            <span class="star active" onclick="setStars(5)">★</span>
        </div>

        <div class="rating-label" id="rating-label">Exceptional!</div>

        <div class="review-textarea-wrap">
      <textarea class="form-control" rows="5"
                placeholder="Share your experience..."
                oninput="updateCount(this)"></textarea>

            <span class="review-count" id="char-count">0/500</span>
        </div>

        <button class="btn btn-submit-review btn-full">Submit Review ✈️</button>
    </div>

    <div class="community-section">
        <h3 class="cs-title">💬 Community Feed</h3>
        <p>No review till now!</p>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

<script>
    const labels = ['','Terrible','Poor','Okay','Good','Exceptional!'];

    function setStars(n){
        document.querySelectorAll('.star').forEach((s,i)=>{
            s.classList.toggle('active', i < n);
        });
        document.getElementById('rating-label').textContent = labels[n];
    }

    function updateCount(el){
        document.getElementById('char-count').textContent =
            el.value.length + '/500';
    }
</script>

</body>
</html>