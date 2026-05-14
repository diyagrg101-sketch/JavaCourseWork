<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<body>

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="dashboard-layout">
    <!-- LEFT SIDEBAR -->
    <div class="dashboard-sidebar">
        <div class="wallet-card">
            <div class="wallet-label">Wallet Balance</div>
            <div class="wallet-amount">NPR 12,450</div>
            <div class="wallet-points">⭐ <span>850 Reward Points</span></div>
            <button class="btn btn-primary btn-full" style="margin-top:6px">+ &nbsp;Top Up Wallet</button>
        </div>

        <div class="quick-actions" style="margin-top:16px">
            <div class="qa-label">Quick Actions</div>
            <div class="qa-grid">
                <button class="qa-btn"><span class="ico">🍴</span>View Menu</button>
                <button class="qa-btn"><span class="ico">🕐</span>History</button>
                <button class="qa-btn"><span class="ico">⚡</span>Hot Deals</button>
                <button class="qa-btn"><span class="ico">📦</span>Orders</button>
            </div>
        </div>

        <div class="order-confirmation-card">
            <div style="display:flex;align-items:center;gap:8px;margin-bottom:8px">
                <span style="font-size:1rem">☕</span>
                <div>
                    <div class="occ-label">Confirmed Order</div>
                </div>
            </div>
            <div class="occ-status">Your order is confirmed...</div>
            <a href="${ctx}/orderConfirmation" class="order-confirmation-link">Order Confirmation ›</a>
        </div>

        <div class="sidebar-bottom">

            <a href="${ctx}/logout" class="signout">
                <span class="sidebar-ico">↩</span>
                Logout
            </a>

        </div>

    </div>

    <!-- MAIN -->
    <div class="dashboard-main">
        <div class="greet-row">
            <div>
                <div class="greet-h">Namaste !!</div>
                <div class="greet-sub">What are you craving today?</div>
            </div>
            <div class="popular-chip">📈 Popular right now: <strong>Masala Tea</strong></div>
        </div>

        <!-- REORDER -->
        <div class="section-head">
            <div class="section-title">🔄 Reorder Your Favorites</div>
            <a href="${ctx}/manageProducts" class="see-all">See All ›</a>
        </div>
        <div class="reorder-grid" style="margin-bottom:28px">
            <div class="reorder-card">
                <img src="${ctx}/assets/images/vanilla latte.jpg" alt="Vanilla latte"/>
                <div class="reorder-body">
                    <div class="reorder-name">Vanilla Latte</div>
                    <div class="reorder-price">NPR 350</div>
                    <button class="btn-reorder">Order Again</button>
                </div>
            </div>
            <div class="reorder-card">
                <img src="${ctx}/assets/images/Chicken Sandwich.jpg" alt="Chicken Sandwich"/>
                <div class="reorder-body">
                    <div class="reorder-name">Chicken Sandwich</div>
                    <div class="reorder-price">NPR 580</div>
                    <button class="btn-reorder">Order Again</button>
                </div>
            </div>
            <div class="reorder-card">
                <img src="${ctx}/assets/images/IcedAmericano.jpg" alt="Iced Americano"/>
                <div class="reorder-body">
                    <div class="reorder-name">Iced Americano</div>
                    <div class="reorder-price">NPR 280</div>
                    <button class="btn-reorder">Order Again</button>
                </div>
            </div>
            <div class="reorder-card">
                <img src="${ctx}/assets/images/crossiant.jpg" alt="Croissant"/>
                <div class="reorder-body">
                    <div class="reorder-name">Croissant</div>
                    <div class="reorder-price">NPR 200</div>
                    <button class="btn-reorder">Order Again</button>
                </div>
            </div>
        </div>

        <!-- RECOMMENDED SECTION-->
        <div class="section-head">
            <div>
                <div class="section-title">⭐ Recommended for You</div>
                <div style="font-size:.78rem;color:var(--text-muted);margin-top:2px">Based on your recent cravings and popular picks.</div>
            </div>
        </div>
        <div class="rec-grid" style="margin-bottom:24px">
            <div class="rec-card">
                <div class="rec-img-wrap">
                    <img class="rec-img" src="${ctx}/assets/images/hazelhut.jpg" alt="Hazelnut Cappuccino"/>
                    <div class="rec-rating">⭐ 4.8</div>
                </div>
                <div class="rec-body">
                    <div class="rec-name-row"><span class="rec-name">Hazelnut Cappuccino</span><span class="rec-price">NPR 450</span></div>
                    <p class="rec-desc">Rich espresso blended with silky steamed milk and a hint of premium hazelnut syrup.</p>
                    <button class="btn btn-primary btn-full">Add to Cart</button>
                </div>
            </div>
            <div class="rec-card">
                <div class="rec-img-wrap">
                    <img class="rec-img" src="${ctx}/assets/images/cheesecake.jpg" alt="CheeseCake"/>
                    <div class="rec-rating">⭐ 4.9</div>
                </div>
                <div class="rec-body">
                    <div class="rec-name-row"><span class="rec-name">Cheese Cake</span><span class="rec-price">NPR 250</span></div>
                    <p class="rec-desc">Cheesecake is a creamy, tangy dessert layered on a buttery biscuit crust.</p>
                    <button class="btn btn-primary btn-full">Add to Cart</button>
                </div>
            </div>
            <div class="rec-card">
                <div class="rec-img-wrap">
                    <img class="rec-img" src="${ctx}/assets/images/paneer tikka.jpg" alt="Paneer Tikka"/>
                </div>
                <div class="rec-body">
                    <div class="rec-name-row"><span class="rec-name">Paneer Tikka Wrap</span><span class="rec-price">NPR 300</span></div>
                    <p class="rec-desc">Paneer Tikka Wrap is a smoky, spiced paneer roll.</p>
                    <button class="btn btn-primary btn-full">Add to Cart</button>
                </div>
            </div>
        </div>

        <div class="promo-banner">
            <img class="promo-bg" src="${ctx}/assets/images/promo.jpg" alt="Promo"/>
            <div class="promo-overlay"></div>
            <div class="promo-content">
                <div class="promo-badge">Limited Offer</div>
                <h3>Get 20% Off on Your First Order Above<br/>NPR 1000!</h3>
                <button class="btn btn-primary">Claim Discount</button>
            </div>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>