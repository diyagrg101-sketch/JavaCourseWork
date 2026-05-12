<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<body>

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>


<!-- PAYMENT LAYOUT -->
<div class="payment-layout">

    <div class="payment-main">
        <h1 class="payment-title">How would you like to pay?</h1>
        <p class="payment-sub">Choose a payment method to complete your order at Sip and Serve.</p>

        <!-- PAYMENT METHODS -->
        <div class="pay-methods">
            <div class="pay-method active" onclick="selectPay(this,'esewa')">
                <div class="pay-method-ico">💳</div>

                <div>
                    <div class="pay-method-name">eSewa</div>
                    <div class="pay-method-sub">Nepal's #1 Mobile Wallet</div>
                </div>
                <div class="pay-method-check">✓</div>
            </div>


            <div class="pay-method" onclick="selectPay(this,'khalti')">
                <div class="pay-method-ico">💰</div>
                <div>
                    <div class="pay-method-name">Khalti</div>
                    <div class="pay-method-sub">Fast & Secure Digital Payment</div>
                </div>
                <div class="pay-method-check"></div>
            </div>


            <div class="pay-method" onclick="selectPay(this,'card')">
                <div class="pay-method-ico">🏦</div>
                <div>
                    <div class="pay-method-name">Credit / Debit Card</div>
                    <div class="pay-method-sub">Visa, Mastercard, SCT</div>
                </div>
                <div class="pay-method-check"></div>
            </div>


            <div class="pay-method" onclick="selectPay(this,'cod')">
                <div class="pay-method-ico">💵</div>
                <div>
                    <div class="pay-method-name">Cash on Delivery</div>
                    <div class="pay-method-sub">Pay when your food arrives</div>
                </div>
                <div class="pay-method-check"></div>
            </div>
        </div>


        <div class="pay-detail-box">
            <div class="pay-info-note">
                <span>ℹ️</span>
                <span id="paymentMessage">You will be redirected to the secure eSewa login page to authorize this transaction.</span>
            </div>

            <div id="esewaForm">
                <div class="form-group">
                    <label>eSewa ID (Mobile Number / Email)</label>
                    <input type="text" class="form-control" placeholder="98XXXXXXXX / example@mail.com"/>
                </div>
            </div>

            <div id="khaltiForm" style="display:none;">
                <div class="form-group"><label>Khalti ID / Mobile Number</label>
                    <input type="text" class="form-control" placeholder="98XXXXXXXX"/>
                </div>
            </div>

            <div id="cardForm" style="display:none;">
                <div class="form-group">
                    <label>Cardholder Name</label>
                    <input type="text" class="form-control" placeholder="Enter cardholder name"/>
                </div>

                <div class="form-group">
                    <label>Card Number</label>
                    <input type="text" class="form-control" placeholder="1234 5678 9012 3456"/>
                </div>

                <div class="input-row">
                    <div class="form-group">
                        <label>Expiry Date</label>
                        <input type="text" class="form-control" placeholder="MM/YY"/>
                    </div>

                    <div class="form-group">
                        <label>CVV</label>
                        <input type="password" class="form-control" placeholder="123"/>
                    </div>
                </div>
            </div>


            <div id="codForm" style="display:none;">
                <p style="font-size:.9rem;color:#666;line-height:1.6">You can pay with cash when your order is delivered to your location.</p>
            </div>


            <div class="pay-secure">
                <div class="pay-secure-text">
                    🔒 Secure 256-bit SSL Encrypted Payment
                </div>

                <div class="card-icons">
                    <div class="card-icon">VISA</div>
                    <div class="card-icon">MC</div>
                    <div class="card-icon">SCT</div>
                </div>
            </div>
        </div>


        <div class="pay-actions">
            <a href="${ctx}/checkout" class="btn btn-outline btn-lg" style="flex:1;justify-content:center">Go Back</a>
            <a href="${ctx}/payment-success" class="btn btn-primary btn-lg" style="flex:2;justify-content:center">Pay Now</a>
        </div>
    </div>


    <div class="order-sum-sidebar">
        <div class="oss-head">
            <span class="oss-title">Order Summary</span>
            <span class="tag tag-orange">3 Items</span>
        </div>


        <div class="oss-item">
            <img class="oss-img" src="${ctx}/assets/images/hazelhut.jpg" alt="Hazelnut Cappuccino"/>
            <div>
                <div class="oss-name">Hazelnut Cappuccino</div>
                <div class="oss-qty">Qty: 2 × NPR 450</div>
            </div>
            <span class="oss-price">NPR 900</span>
        </div>


        <div class="oss-item">
            <img class="oss-img" src="${ctx}/assets/images/avocadoTaost.jpg" alt="Avocado Toast"/>
            <div>
                <div class="oss-name">Avocado Toast</div>
                <div class="oss-qty">Qty: 1 × NPR 400</div>
            </div>

            <span class="oss-price">NPR 400</span>
        </div>

        <div class="oss-item">
            <img class="oss-img" src="${ctx}/assets/images/blueberryCheesecake.jpg" alt="Blueberry Cheesecake"/>
            <div>
                <div class="oss-name">Blueberry Cheesecake</div>
                <div class="oss-qty">Qty: 1 × NPR 650</div>
            </div>
            <span class="oss-price">NPR 650</span>
        </div>

        <hr class="oss-divider"/>
        <div class="oss-row">
            <span>Subtotal</span>
            <span>NPR 1950</span>
        </div>

        <div class="oss-row">
            <span>Service Charge (10%)</span>
            <span>NPR 153</span>
        </div>

        <div class="oss-row">
            <span>VAT (13%)</span>
            <span>NPR 219</span>
        </div>

        <div class="oss-total">
            <span>Grand Total</span>
            <span>NPR 2,322</span>
        </div>


        <div style="display:flex;gap:8px;margin-bottom:12px">

            <input
                    class="promo-input"
                    type="text"
                    placeholder="Promo code"
                    style="flex:1;padding:9px 12px;border:1.5px solid var(--border);border-radius:var(--r-sm);font-size:.84rem;outline:none"
            />

            <button class="btn-apply">Apply</button>
        </div>

        <!-- SECURITY NOTE -->
        <div style="display:flex;gap:10px;background:var(--orange-bg);border-radius:var(--r-sm);padding:12px;font-size:.78rem;color:var(--text-mid)">
            <span style="font-size:1rem;flex-shrink:0">🛡️</span>

            Your payment information is processed securely.
            We do not store your full card or wallet credentials.
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

<script>
    function selectPay(el, method) {

        // active class
        document.querySelectorAll('.pay-method').forEach(m => {
            m.classList.remove('active');
            m.querySelector('.pay-method-check').textContent = '';
        });

        el.classList.add('active');
        el.querySelector('.pay-method-check').textContent = '✓';

        // hide all forms
        document.getElementById('esewaForm').style.display = 'none';
        document.getElementById('khaltiForm').style.display = 'none';
        document.getElementById('cardForm').style.display = 'none';
        document.getElementById('codForm').style.display = 'none';

        // payment message
        const message = document.getElementById('paymentMessage');

        // show selected form
        if(method === 'esewa'){
            document.getElementById('esewaForm').style.display = 'block';
            message.innerHTML =
                'You will be redirected to the secure eSewa login page to authorize this transaction.';
        }

        else if(method === 'khalti'){
            document.getElementById('khaltiForm').style.display = 'block';
            message.innerHTML =
                'Complete your payment securely using your Khalti wallet.';
        }

        else if(method === 'card'){
            document.getElementById('cardForm').style.display = 'block';
            message.innerHTML =
                'Enter your card details to complete the secure payment.';
        }

        else if(method === 'cod'){
            document.getElementById('codForm').style.display = 'block';
            message.innerHTML =
                'Cash on Delivery selected. Pay directly when your order arrives.';
        }
    }
</script>

</body>
</html>
