<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<body>

<%@ include file="/WEB-INF/views/common/adminNavbar.jsp" %>

<div class="sidebar-layout">

    <!-- SIDEBAR -->
    <%@ include file="/WEB-INF/views/common/admin-sidebar.jsp" %>

    <!-- MAIN CONTENT -->
    <div class="main-content">

        <!-- TOPBAR -->
        <div class="admin-topbar">
            <div class="admin-topbar-left">
                <h1>Reports & Analytics</h1>
                <p>Track performance, revenue and customer insights.</p>
            </div>
        </div>

        <!-- FLASH MESSAGE -->
        <c:if test="${not empty successMsg}">
            <div style="background:#d1fae5;color:#065f46;padding:10px 18px;border-radius:8px;margin-bottom:16px;">
                    ${fn:escapeXml(successMsg)}
            </div>
        </c:if>

        <!-- CUSTOMER REVIEWS -->
        <div class="chart-card review-card">

            <div class="review-header">
                <div>
                    <div class="chart-card-title">Customer Reviews</div>
                    <div class="chart-card-sub">
                        <c:choose>
                            <c:when test="${totalReviews > 0}">
                                ${totalReviews} review(s)
                                &nbsp;·&nbsp;
                                Avg rating:
                                <strong style="color:var(--orange)">
                                        ${avgRating} ⭐
                                </strong>
                            </c:when>
                            <c:otherwise>
                                No reviews yet
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <!-- REVIEWS LIST -->
            <c:choose>
                <c:when test="${empty feedbacks}">
                    <div style="text-align:center;padding:30px;color:var(--text-muted);">
                        No customer reviews received yet.
                    </div>
                </c:when>

                <c:otherwise>

                    <c:forEach var="fb" items="${feedbacks}" varStatus="loop">

                        <div class="review-item"
                             style="${loop.index >= 5 ? 'display:none;' : ''}">

                            <div style="flex:1">

                                <!-- USER -->
                                <div class="review-name">
                                        ${fn:escapeXml(fb.userName)}
                                </div>

                                <!-- STARS -->
                                <div class="review-stars" style="color:#C8680A;margin:3px 0">
                                    <c:set var="rate" value="${empty fb.rating ? 0 : fb.rating}" />

                                    <c:forEach begin="1" end="${rate}">
                                        ★
                                    </c:forEach>

                                    <c:forEach begin="${rate + 1}" end="5">
                                        ☆
                                    </c:forEach>
                                </div>

                                <!-- MESSAGE -->
                                <div class="review-text">
                                        ${fn:escapeXml(fb.message)}
                                </div>

                                <!-- EMAIL (optional) -->
                                <c:if test="${not empty fb.userEmail}">
                                    <div style="font-size:.75rem;color:var(--text-muted);margin-top:4px">
                                            ${fn:escapeXml(fb.userEmail)}
                                    </div>
                                </c:if>

                                <!-- DATE -->
                                <div style="font-size:.75rem;color:var(--text-muted);margin-top:4px">
                                        ${fb.createdAt}
                                </div>

                            </div>

                            <!-- DELETE BUTTON -->
                            <form action="${ctx}/feedback/delete" method="post"
                                  onsubmit="return confirm('Delete this review?')">

                                <input type="hidden" name="feedbackId" value="${fb.id}" />
                                <button type="submit"
                                        style="background:none;border:1px solid #fca5a5;color:#c53030;
                                               border-radius:5px;padding:3px 10px;font-size:.75rem;cursor:pointer;">
                                    🗑 Delete
                                </button>

                            </form>

                        </div>

                    </c:forEach>

                </c:otherwise>
            </c:choose>

        </div>

    </div>
</div>

<script>
    function toggleAll() {
        const items = document.querySelectorAll('.review-item');
        let hidden = false;

        items.forEach((el, i) => {
            if (i >= 5) {
                if (el.style.display === 'none') {
                    el.style.display = 'flex';
                    hidden = false;
                } else {
                    el.style.display = 'none';
                    hidden = true;
                }
            }
        });
    }
</script>

</body>
</html>