<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<body>
<!-- ================= NAVBAR ================= -->
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<!-- ══════════════ PAGE HEADER ══════════════ -->
<div class="mo-page-header">
    <div class="mo-header-inner">
        <div class="mo-header-left">
            <a href="index.jsp" class="mo-back-link">← Back to Home</a>
            <h1 class="mo-page-title">My Orders</h1>
            <p class="mo-page-sub">Track and manage all your Sip &amp; Serve orders.</p>
        </div>
        <div class="mo-header-stats">
            <div class="mo-stat-pill">
                <span class="mo-stat-icon">📦</span>
                <div>
                    <div class="mo-stat-val">24</div>
                    <div class="mo-stat-label">Total Orders</div>
                </div>
            </div>
            <div class="mo-stat-pill">
                <span class="mo-stat-icon">⭐</span>
                <div>
                    <div class="mo-stat-val">850</div>
                    <div class="mo-stat-label">Reward Points</div>
                </div>
            </div>
            <div class="mo-stat-pill">
                <span class="mo-stat-icon">💰</span>
                <div>
                    <div class="mo-stat-val">NPR 12,450</div>
                    <div class="mo-stat-label">Wallet Balance</div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- ══════════════ FILTER TABS ══════════════ -->
<div class="mo-filters-wrap">
    <div class="mo-filters-inner">
        <div class="mo-tabs">
            <button class="mo-tab active" onclick="switchTab(this,'all')">All Orders</button>
            <button class="mo-tab" onclick="switchTab(this,'active')">
                Active <span class="mo-tab-badge">2</span>
            </button>
            <button class="mo-tab" onclick="switchTab(this,'delivered')">Delivered</button>
            <button class="mo-tab" onclick="switchTab(this,'cancelled')">Cancelled</button>
        </div>
        <div class="mo-filter-right">
            <div class="mo-search-box">
                <span class="mo-search-icon">🔍</span>
                <input type="text" placeholder="Search orders..." class="mo-search-input"
                       onkeyup="filterOrders(this.value)"/>
            </div>
            <select class="mo-sort-select">
                <option>Newest First</option>
                <option>Oldest First</option>
                <option>Highest Amount</option>
                <option>Lowest Amount</option>
            </select>
        </div>
    </div>
</div>

<div class="mo-content-wrap">

    <!-- ══════════════ ORDERS LIST ══════════════ -->
    <div class="mo-orders-list" id="ordersList">

        <!-- ORDER CARD 1 — OUT FOR DELIVERY -->
        <div class="mo-order-card" data-status="active" data-id="8821">
            <div class="mo-order-card-header">
                <div class="mo-order-id-row">
                    <span class="mo-order-id">#SS-8821</span>
                    <span class="mo-order-status status-delivery">🚴 Out for Delivery</span>
                </div>
                <div class="mo-order-date">Today, 10:38 AM &nbsp;•&nbsp; Dine-in</div>
            </div>

            <div class="mo-order-body">
                <div class="mo-order-items">
                    <div class="mo-item-thumb-row">
                        <img src="https://images.unsplash.com/photo-1572490122747-3968b75cc699?w=80&q=80"
                             class="mo-item-thumb" alt="Latte"/>
                        <img src="https://images.unsplash.com/photo-1555507036-ab1f4038808a?w=80&q=80"
                             class="mo-item-thumb" alt="Croissant"/>
                        <div class="mo-item-count-more">+1</div>
                    </div>
                    <div class="mo-items-text">
                        <div class="mo-items-names">Himalayan Arabica Latte ×2, Butter Croissant ×1</div>
                        <div class="mo-items-note">Extra Shot · Oat Milk</div>
                    </div>
                </div>

                <div class="mo-order-summary-col">
                    <div class="mo-order-total">NPR 1,045</div>
                    <div class="mo-order-type-badge">🚴 Home Delivery</div>
                </div>
            </div>

            <div class="mo-order-actions">

                <button class="mo-btn-outline" onclick="openOrderDetail('8821')">View Details</button>
                <button class="mo-btn-outline mo-btn-help">🎧 Help</button>
            </div>
        </div>

        <!-- ORDER CARD 2 — DELIVERED -->
        <div class="mo-order-card" data-status="delivered" data-id="8815">
            <div class="mo-order-card-header">
                <div class="mo-order-id-row">
                    <span class="mo-order-id">#SS-8815</span>
                    <span class="mo-order-status status-delivered">✅ Delivered</span>
                </div>
                <div class="mo-order-date">May 12, 2024 · 4:30 PM &nbsp;•&nbsp; Takeaway</div>
            </div>

            <div class="mo-order-body">
                <div class="mo-order-items">
                    <div class="mo-item-thumb-row">
                        <img src="https://images.unsplash.com/photo-1561882468-9110e03e0f78?w=80&q=80"
                             class="mo-item-thumb" alt="Latte"/>
                        <img src="https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=80&q=80"
                             class="mo-item-thumb" alt="Muffin"/>
                    </div>
                    <div class="mo-items-text">
                        <div class="mo-items-names">Vanilla Latte ×1, Blueberry Muffin ×2</div>
                        <div class="mo-items-note">Payment via eSewa</div>
                    </div>
                </div>
                <div class="mo-order-summary-col">
                    <div class="mo-order-total">NPR 850</div>
                    <div class="mo-order-type-badge">🛍️ Takeaway</div>
                </div>
            </div>

            <div class="mo-order-actions">
                <button class="mo-btn-primary" onclick="reorder('8815')">🔄 Reorder</button>
                <button class="mo-btn-outline" onclick="openOrderDetail('8815')">View Details</button>
                <a href="feedback.jsp" class="mo-btn-outline mo-btn-review">⭐ Leave Review</a>
            </div>
        </div>

        <!-- ORDER CARD 3 — DELIVERED -->
        <div class="mo-order-card" data-status="delivered" data-id="8802">
            <div class="mo-order-card-header">
                <div class="mo-order-id-row">
                    <span class="mo-order-id">#SS-8802</span>
                    <span class="mo-order-status status-delivered">✅ Delivered</span>
                </div>
                <div class="mo-order-date">May 08, 2024 · 1:15 PM &nbsp;•&nbsp; Dine-in · Table #5</div>
            </div>

            <div class="mo-order-body">
                <div class="mo-order-items">
                    <div class="mo-item-thumb-row">
                        <img src="https://images.unsplash.com/photo-1484723091739-30a097e8f929?w=80&q=80"
                             class="mo-item-thumb" alt="Toast"/>
                        <img src="https://images.unsplash.com/photo-1544787219-7f47ccb76574?w=80&q=80"
                             class="mo-item-thumb" alt="Tea"/>
                        <div class="mo-item-count-more">+2</div>
                    </div>
                    <div class="mo-items-text">
                        <div class="mo-items-names">Avocado Toast ×1, Masala Tea ×1, Jam Toast ×1, Sandwich ×1</div>
                        <div class="mo-items-note">Payment via Khalti &nbsp;•&nbsp; <span style="color:var(--orange);font-weight:600">+28 pts earned</span></div>
                    </div>
                </div>
                <div class="mo-order-summary-col">
                    <div class="mo-order-total">NPR 1,380</div>
                    <div class="mo-order-type-badge">🍽️ Dine-in</div>
                </div>
            </div>

            <div class="mo-order-actions">
                <button class="mo-btn-primary" onclick="reorder('8802')">🔄 Reorder</button>
                <button class="mo-btn-outline" onclick="openOrderDetail('8802')">View Details</button>
                <a href="feedback.jsp" class="mo-btn-outline mo-btn-review">⭐ Leave Review</a>
            </div>
        </div>

        <!-- ORDER CARD 4 — PREPARING (ACTIVE) -->
        <div class="mo-order-card" data-status="active" data-id="8820">
            <div class="mo-order-card-header">
                <div class="mo-order-id-row">
                    <span class="mo-order-id">#SS-8820</span>
                    <span class="mo-order-status status-preparing">🔥 Preparing</span>
                </div>
                <div class="mo-order-date">Today, 9:55 AM &nbsp;•&nbsp; Takeaway</div>
            </div>

            <div class="mo-order-body">
                <div class="mo-order-items">
                    <div class="mo-item-thumb-row">
                        <img src="https://images.unsplash.com/photo-1572490122747-3968b75cc699?w=80&q=80"
                             class="mo-item-thumb" alt="Coffee"/>
                        <img src="https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=80&q=80"
                             class="mo-item-thumb" alt="Cake"/>
                    </div>
                    <div class="mo-items-text">
                        <div class="mo-items-names">Hazelnut Cappuccino ×1, Chocolate Cake ×1</div>
                        <div class="mo-items-note">Kitchen is preparing your brew…</div>
                    </div>
                </div>
                <div class="mo-order-summary-col">
                    <div class="mo-order-total">NPR 650</div>
                    <div class="mo-order-type-badge">🛍️ Takeaway</div>
                </div>
            </div>


            <div class="mo-order-actions">
                <button class="mo-btn-outline" onclick="openOrderDetail('8820')">View Details</button>
                <button class="mo-btn-outline mo-btn-cancel" onclick="confirmCancel('8820')">✕ Cancel</button>
            </div>
        </div>

        <!-- ORDER CARD 5 — CANCELLED -->
        <div class="mo-order-card" data-status="cancelled" data-id="8790">
            <div class="mo-order-card-header">
                <div class="mo-order-id-row">
                    <span class="mo-order-id">#SS-8790</span>
                    <span class="mo-order-status status-cancelled">❌ Cancelled</span>
                </div>
                <div class="mo-order-date">May 03, 2024 · 7:20 PM &nbsp;•&nbsp; Home Delivery</div>
            </div>

            <div class="mo-order-body">
                <div class="mo-order-items">
                    <div class="mo-item-thumb-row">
                        <img src="https://images.unsplash.com/photo-1558857563-c1cd1b13c4e0?w=80&q=80"
                             class="mo-item-thumb" alt="Tea" style="filter:grayscale(60%)"/>
                    </div>
                    <div class="mo-items-text">
                        <div class="mo-items-names" style="color:var(--text-muted)">Milk Tea ×2, Masala Tea ×1</div>
                        <div class="mo-items-note">Cancelled by customer &nbsp;•&nbsp; <span style="color:var(--green,#2e7d32);font-weight:600">Refund processed</span></div>
                    </div>
                </div>
                <div class="mo-order-summary-col">
                    <div class="mo-order-total" style="color:var(--text-muted);text-decoration:line-through">NPR 480</div>
                    <div class="mo-order-type-badge" style="opacity:.6">🚚 Delivery</div>
                </div>
            </div>

            <div class="mo-order-actions">
                <button class="mo-btn-primary" onclick="reorder('8790')">🔄 Reorder</button>
                <button class="mo-btn-outline" onclick="openOrderDetail('8790')">View Details</button>
            </div>
        </div>

        <!-- EMPTY STATE (hidden by default) -->
        <div class="mo-empty-state" id="emptyState" style="display:none">
            <div class="mo-empty-icon">🍵</div>
            <h3>No orders found</h3>
            <p>Looks like you haven't placed any orders in this category yet.</p>
            <a href="menu.jsp" class="mo-btn-primary" style="display:inline-block;margin-top:4px">Browse Menu</a>
        </div>

    </div><!-- /mo-orders-list -->
</div><!-- /mo-content-wrap -->

<!-- ══════════════ ORDER DETAIL MODAL ══════════════ -->
<div class="mo-modal-overlay" id="orderDetailModal" style="display:none">
    <div class="mo-modal">
        <div class="mo-modal-header">
            <div>
                <div class="mo-modal-title">Order <span id="modalOrderId">#SS-8821</span></div>
                <div class="mo-modal-sub">Full order receipt &amp; details</div>
            </div>
            <button class="mo-modal-close" onclick="closeModal()">✕</button>
        </div>

        <div class="mo-modal-receipt">
            <!-- receipt header -->
            <div class="mo-receipt-header">
                <div class="mo-receipt-icon">☕</div>
                <div class="mo-receipt-brand">SIP AND SERVE</div>
                <div class="mo-receipt-addr">Newroad, Pokhara · +977 (984) 123-4567</div>
                <div class="mo-receipt-date">October 24, 2024 at 10:15 AM</div>
            </div>

            <!-- delivery info -->
            <div class="mo-receipt-delivery">
                <span>📍</span>
                <div>
                    <strong>Home Delivery</strong>
                    <p>House 42, Ward 3, Jhamsikhel, Lalitpur</p>
                    <span class="mo-eta">⏱ Est. Delivery: 25–30 mins</span>
                </div>
            </div>

            <!-- items -->
            <div class="mo-receipt-items">
                <div class="mo-receipt-items-label">ORDER DETAILS</div>
                <div class="mo-receipt-item">
                    <div>
                        <span>Himalayan Arabica Latte ×2</span>
                        <span class="mo-receipt-item-note">Extra Shot · Oat Milk</span>
                    </div>
                    <span>NPR 760</span>
                </div>
                <div class="mo-receipt-item">
                    <span>Butter Croissant ×1</span>
                    <span>NPR 285</span>
                </div>
            </div>

            <!-- bill -->
            <div class="mo-receipt-bill">
                <div class="mo-bill-label">BILL SUMMARY</div>
                <div class="mo-bill-row"><span>Subtotal</span><span>NPR 1,045</span></div>
                <div class="mo-bill-row"><span>Delivery Fee</span><span>NPR 50</span></div>
                <div class="mo-bill-row discount"><span>Discount (FIRSTSIP)</span><span>– NPR 100</span></div>
                <div class="mo-bill-total"><span>Total Paid</span><span>NPR 995</span></div>
            </div>

            <!-- points -->
            <div class="mo-receipt-points">
                <span>⭐</span>
                <div>
                    <div class="mo-pts-label">Points Earned</div>
                    <div class="mo-pts-sub">Added to your Sip &amp; Serve wallet</div>
                </div>
                <span class="mo-pts-val">+20</span>
            </div>
        </div>

        <div class="mo-modal-footer">
            <button class="mo-btn-outline" onclick="closeModal()">Close</button>
            <button class="mo-btn-outline" onclick="printReceipt()">🖨️ Print</button>
            <button class="mo-btn-primary" onclick="reorder('8821')">🔄 Reorder</button>
        </div>
    </div>
</div>

<!-- ══════════════ CANCEL CONFIRM MODAL ══════════════ -->
<div class="mo-modal-overlay" id="cancelModal" style="display:none">
    <div class="mo-modal" style="max-width:400px;text-align:center">
        <div style="font-size:2.5rem;margin-bottom:12px">⚠️</div>
        <div class="mo-modal-title" style="text-align:center">Cancel this order?</div>
        <p style="font-size:.85rem;color:var(--text-muted);margin:10px 0 22px;text-align:center">
            Are you sure you want to cancel order <strong id="cancelOrderId">#SS-8820</strong>?<br/>
            This action cannot be undone.
        </p>
        <div style="display:flex;gap:10px;justify-content:center">
            <button class="mo-btn-outline" onclick="closeCancelModal()">Keep Order</button>
            <button class="mo-btn-cancel-confirm" onclick="doCancel()">Yes, Cancel It</button>
        </div>
    </div>
</div>


<script>
    function switchTab(btn, status) {
        document.querySelectorAll('.mo-tab').forEach(t => t.classList.remove('active'));
        btn.classList.add('active');
        filterByStatus(status);
    }

    function filterByStatus(status) {
        const cards = document.querySelectorAll('.mo-order-card');
        let shown = 0;
        cards.forEach(c => {
            const match = status === 'all' || c.dataset.status === status;
            c.style.display = match ? 'block' : 'none';
            if (match) shown++;
        });
        document.getElementById('activeBanner').style.display =
            (status === 'all' || status === 'active') ? 'flex' : 'none';
        document.getElementById('emptyState').style.display = shown === 0 ? 'flex' : 'none';
    }

    /* ── SEARCH FILTER ── */
    function filterOrders(query) {
        const q = query.toLowerCase();
        document.querySelectorAll('.mo-order-card').forEach(c => {
            const text = c.textContent.toLowerCase();
            c.style.display = text.includes(q) ? 'block' : 'none';
        });
    }

    /* ── ORDER DETAIL MODAL ── */
    function openOrderDetail(id) {
        document.getElementById('modalOrderId').textContent = '#SS-' + id;
        document.getElementById('orderDetailModal').style.display = 'flex';
        document.body.style.overflow = 'hidden';
    }
    function closeModal() {
        document.getElementById('orderDetailModal').style.display = 'none';
        document.body.style.overflow = '';
    }

    /* ── CANCEL MODAL ── */
    function confirmCancel(id) {
        document.getElementById('cancelOrderId').textContent = '#SS-' + id;
        document.getElementById('cancelModal').style.display = 'flex';
        document.body.style.overflow = 'hidden';
    }
    function closeCancelModal() {
        document.getElementById('cancelModal').style.display = 'none';
        document.body.style.overflow = '';
    }
    function doCancel() {
        closeCancelModal();
        alert('Order cancelled. Refund will be processed within 2–3 business days.');
    }

    /* ── REORDER ── */
    function reorder(id) {
        alert('Items from order #SS-' + id + ' added to your cart!');
    }

    /* ── PRINT ── */
    function printReceipt() { window.print(); }

    /* ── CLOSE MODALS ON BACKDROP CLICK ── */
    document.querySelectorAll('.mo-modal-overlay').forEach(overlay => {
        overlay.addEventListener('click', function(e) {
            if (e.target === this) {
                this.style.display = 'none';
                document.body.style.overflow = '';
            }
        });
    });
</script>
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>