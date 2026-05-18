<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<body>

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<a href="${ctx}/menu" class="back-link">‹ Back to Menu</a>

<div class="item-layout">

    <!-- ================= LEFT: IMAGE ================= -->
    <div>
        <div class="item-img-wrap">

            <%-- Prefer image_data (BLOB) if present, otherwise fall back to image_url --%>
            <c:choose>
                <c:when test="${product.imageData != null}">
                    <img class="item-img"
                         src="${ctx}/product-image?id=${product.id}"
                         alt="${product.name}"/>
                </c:when>
                <c:otherwise>
                    <img class="item-img"
                         src="${ctx}/assets/images/${product.imageUrl}"
                         alt="${product.name}"/>
                </c:otherwise>
            </c:choose>

            <div class="item-img-badges">
                <c:if test="${product.signature}">
                    <span class="item-badge">⭐ Signature</span>
                </c:if>
                <c:choose>
                    <c:when test="${product.rating >= 4.7}">
                        <span class="item-badge secondary">Best Seller</span>
                    </c:when>
                    <c:when test="${product.rating >= 4.5}">
                        <span class="item-badge secondary">Popular</span>
                    </c:when>
                </c:choose>
            </div>

            <div class="item-wish" id="wishBtn">🤍</div>
        </div>

        <%-- Star rating display --%>
        <div class="item-meta-row">
            <div class="item-meta">
                ⭐ RATING
                <span><fmt:formatNumber value="${product.rating}" maxFractionDigits="1"/> / 5</span>
            </div>
            <div class="item-meta">
                🏷️ CATEGORY
                <span>
                    <c:choose>
                        <c:when test="${product.categoryId == 1}">Coffee</c:when>
                        <c:when test="${product.categoryId == 2}">Bakery</c:when>
                        <c:when test="${product.categoryId == 3}">Snacks</c:when>
                        <c:when test="${product.categoryId == 4}">Beverage</c:when>
                        <c:otherwise>Other</c:otherwise>
                    </c:choose>
                </span>
            </div>
            <div class="item-meta">
                ℹ️ STATUS
                <span>${product.active ? 'Available' : 'Unavailable'}</span>
            </div>
        </div>
    </div>

    <!-- ================= RIGHT: INFO ================= -->
    <div>
        <div class="item-series">${categoryLabel}</div>
        <div class="item-name">${product.name}</div>
        <div class="item-price">
            NPR <fmt:formatNumber value="${product.price}" maxFractionDigits="0"/>
        </div>

        <div class="item-section-label">DESCRIPTION</div>
        <p style="font-size:.85rem;color:var(--text-muted);line-height:1.7;margin-bottom:16px">
            ${product.description}
        </p>

        <%-- ── Add to Cart form ── --%>
        <form action="${ctx}/cart" method="post" id="detailCartForm">
            <input type="hidden" name="productId" value="${product.id}"/>
            <input type="hidden" name="name"      value="${product.name}"/>
            <input type="hidden" name="price"     value="${product.price}"/>
            <input type="hidden" name="image"     value="${product.imageUrl}"/>
            <input type="hidden" name="quantity"  id="hiddenQty" value="1"/>

            <div class="total-add-row">
                <div>
                    <div class="total-add-label">PRICE</div>
                    <div class="total-add-amount" id="displayTotal">
                        NPR <fmt:formatNumber value="${product.price}" maxFractionDigits="0"/>
                    </div>
                </div>

                <div class="qty-row">
                    <button type="button" class="qty-btn" id="qtyMinus">−</button>
                    <span class="qty-val" id="qtyDisplay">1</span>
                    <button type="button" class="qty-btn" id="qtyPlus">+</button>
                </div>
            </div>

            <c:choose>
                <c:when test="${product.active}">
                    <button type="submit" class="btn btn-primary btn-full btn-lg">
                        🛒 &nbsp;Add to Cart
                    </button>
                </c:when>
                <c:otherwise>
                    <button type="button" class="btn btn-primary btn-full btn-lg" disabled
                            style="opacity:.5;cursor:not-allowed;">
                        Currently Unavailable
                    </button>
                </c:otherwise>
            </c:choose>
        </form>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

<script>
    // Product base price from JSP
    const basePrice = ${product.price};
    let qty = 1;

    // DOM elements
    const qtyDisplay   = document.getElementById("qtyDisplay");
    const hiddenQty    = document.getElementById("hiddenQty");
    const displayTotal = document.getElementById("displayTotal");

    // Update quantity + total price display
    function updateDisplay() {
        qtyDisplay.textContent = qty;
        hiddenQty.value = qty;
        displayTotal.textContent =
            "NPR " + (basePrice * qty).toLocaleString("en-NP");
    }

    // Increase quantity (max 10)
    document.getElementById("qtyPlus").addEventListener("click", () => {
        if (qty < 10) { qty++; updateDisplay(); }
    });

    // Decrease quantity (min 1)
    document.getElementById("qtyMinus").addEventListener("click", () => {
        if (qty > 1) { qty--; updateDisplay(); }
    });

    const ctx = "${ctx}";

    // ✅ Login check (server session based)
    const isLoggedIn = ${not empty sessionScope.user};

    // Add to cart handler
    document.getElementById("detailCartForm").addEventListener("submit", function (e) {
        e.preventDefault();

        // If user not logged in → redirect to login page
        if (!isLoggedIn) {
            window.location.href = ctx + "/login";
            return;
        }

        const formData = new FormData(this);
        const itemName = formData.get("name");

        // Send AJAX request to cart servlet
        fetch(ctx + "/cart", {
            method: "POST",
            body: new URLSearchParams(formData),
            credentials: "same-origin"
        })
            .then(r => {

                // If backend blocks (extra safety)
                if (r.status === 401) {
                    window.location.href = ctx + "/login";
                    return;
                }

                // Success → update badge + show toast
                if (r.ok || r.redirected) {
                    updateNavBadge();
                    showToast(itemName);
                }
            })
            .catch(() => showToast(itemName));
    });

    // Update cart badge count in navbar
    function updateNavBadge() {
        fetch(ctx + "/cart?action=count", { credentials: "same-origin" })
            .then(r => r.json())
            .then(data => {
                const badge = document.getElementById("cart-badge");
                if (badge) badge.textContent = data.count;
            });
    }

    // Toast message when item added
    function showToast(itemName) {
        let toast = document.getElementById("cart-toast");

        // Create toast if not exists
        if (!toast) {
            toast = document.createElement("div");
            toast.id = "cart-toast";

            toast.style.cssText = `
                position:fixed;
                bottom:28px;
                left:50%;
                transform:translateX(-50%);
                background:#222;
                color:#fff;
                padding:12px 24px;
                border-radius:24px;
                font-size:.9rem;
                display:flex;
                align-items:center;
                gap:10px;
                box-shadow:0 4px 18px rgba(0,0,0,.18);
                z-index:9999;
                opacity:0;
                transition:opacity .3s;
                white-space:nowrap;
            `;

            document.body.appendChild(toast);
        }

        // Show message
        toast.innerHTML = "✅ <strong>" + itemName + "</strong> added to cart";
        toast.style.opacity = "1";

        // Hide after 2.5 seconds
        clearTimeout(toast._timer);
        toast._timer = setTimeout(() => {
            toast.style.opacity = "0";
        }, 2500);
    }
</script>

</body>
</html>