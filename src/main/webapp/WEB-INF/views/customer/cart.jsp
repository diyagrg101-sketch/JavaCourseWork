<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.ArrayList" %>
<%
    /* Get cart from session
        Each item format: String[] = {name, price, image, quantity} */
    ArrayList<String[]> cart =
            (ArrayList<String[]>) session.getAttribute("cart");

    if (cart == null) {
        cart = new ArrayList<>();
        session.setAttribute("cart", cart);
    }
    double subtotal = 0;
%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<body>

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div style="padding:20px 48px 0">
    <a href="${ctx}/menu" style="font-size:.84rem;color:var(--text-muted);display:flex;align-items:center;gap:5px">‹ Back to Menu</a>
</div>


<div class="cart-layout">

    <div>
        <div class="cart-title">
            Your Cart
            <span class="cart-count"><%= cart.size() %> Items</span>
        </div>

        <%
            /* STEP 3: Check cart */
            if (cart != null && !cart.isEmpty()) {

                for (String[] item : cart) {

                    String name = item[0];
                    double price = Double.parseDouble(item[1]);
                    String image = item[2];

                    int qty = (item.length > 3) ? Integer.parseInt(item[3]) : 1;
                    /*  STEP 4: subtotal = price × quantity */
                    subtotal += price * qty;
        %>

        <div class="cart-item">

            <img src="${ctx}/assets/images/<%= image %>" alt="<%= name %>"/>
            <div class="cart-item-body">

                <div class="cart-item-name"><%= name %></div>
                <div class="cart-item-desc">Freshly prepared item.</div>
                <div style="display:flex;justify-content:space-between;margin-top:8px">

            <span class="cart-item-price">
                NPR <%= price %>
            </span>

                    <div class="cart-qty">

                        <!-- MINUS -->
                        <form action="${ctx}/cart" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="decrease"/>
                            <input type="hidden" name="name" value="<%= name %>"/>
                            <button type="submit" class="cart-qty-btn">−</button>
                        </form>

                        <!-- QUANTITY -->
                        <span class="cart-qty-val"><%= qty %></span>

                        <!-- PLUS -->
                        <form action="${ctx}/cart" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="increase"/>
                            <input type="hidden" name="name" value="<%= name %>"/>
                            <button type="submit" class="cart-qty-btn">+</button>
                        </form>

                    </div>

                </div>
            </div>

            <!-- DELETE ITEM -->
            <form action="${ctx}/cart" method="post" style="display:inline;">
                <input type="hidden" name="action" value="delete"/>
                <input type="hidden" name="name" value="<%= name %>"/>
                <button type="submit" class="cart-delete">🗑</button>
            </form>

        </div>
        <%
            }
        } else {
        %>
        <p>Your cart is empty.</p>
        <%
            }
        %>



        <div class="special-note">
            <span style="font-size:1rem;color:var(--orange)">ℹ️</span>
            <div>
                <strong>Special Instructions?</strong><br/>You can add dietary requirements or special requests at the next step.
            </div>
        </div>
    </div>


    <div class="order-summary">
        <h3>Order Summary</h3>
        <div class="promo-row">
            <input class="promo-input" type="text" placeholder="Enter code"/>
            <button class="btn-apply">Apply</button>
        </div>

        <%
            /*
                STEP: Calculate VAT, service charge and total
            */
            double vat = subtotal * 0.13;
            double service = subtotal * 0.10;
            double total = subtotal + vat + service;
        %>

        <div class="summary-row">
            <span>Subtotal</span>
            <span>NPR <%= String.format("%.2f", subtotal) %></span>
        </div>

        <div class="summary-row">
            <span>VAT (13%) ℹ</span>
            <span>NPR <%= String.format("%.2f", vat) %></span>
        </div>

        <div class="summary-row">
            <span>Service Charge (10%) ℹ</span>
            <span>NPR <%= String.format("%.2f", service) %></span>
        </div>

        <div class="summary-total">
            <span>
                Total Amount<br/>
                <span style="font-size:.74rem;color:var(--text-muted);font-weight:400">
                   (All taxes included)
                </span>
            </span>

            <span>NPR <%= String.format("%.2f", total) %></span>
        </div>


        <a href="${ctx}/checkout" class="btn btn-primary btn-full cart-btn-lg cart-checkout-btn" style="margin-bottom:8px">Proceed to Checkout ›</a>

        <p style="font-size:.74rem;color:var(--text-muted);text-align:center">By proceeding, you agree to our Terms of Service.</p>

        <div class="trust-row">
            <div class="trust-badge">🔒<br/>SAFE PAYMENTS</div>
            <div class="trust-badge">🍽️<br/>FRESHLY SERVED</div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

</body>
</html>