<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<body>
<!-- ══════════════ PAGE WRAPPER ══════════════ -->
<div class="cp-page">

    <!-- BG DECORATIONS -->
    <div class="cp-bg-circle cp-bg-circle-1"></div>
    <div class="cp-bg-circle cp-bg-circle-2"></div>

    <div class="cp-wrapper">

        <!-- LEFT PANEL: INFO + TIPS -->
        <div class="cp-left">
            <div class="cp-left-logo">
                <div class="cp-left-logo-icon">☕</div>
                <span>Sip and Serve</span>
            </div>

            <h2 class="cp-left-title">Keep your account safe</h2>
            <p class="cp-left-sub">A strong password helps protect your wallet balance, order history and personal information.</p>

            <div class="cp-tips">
                <div class="cp-tip-title">Password Requirements</div>
                <ul class="cp-tip-list">
                    <li class="cp-tip-item" id="tip-length">
                        <span class="cp-tip-dot"></span>
                        At least 8 characters long
                    </li>
                    <li class="cp-tip-item" id="tip-upper">
                        <span class="cp-tip-dot"></span>
                        One uppercase letter (A–Z)
                    </li>
                    <li class="cp-tip-item" id="tip-lower">
                        <span class="cp-tip-dot"></span>
                        One lowercase letter (a–z)
                    </li>
                    <li class="cp-tip-item" id="tip-number">
                        <span class="cp-tip-dot"></span>
                        One number (0–9)
                    </li>
                    <li class="cp-tip-item" id="tip-special">
                        <span class="cp-tip-dot"></span>
                        One special character (!@#$%^&*)
                    </li>
                </ul>
            </div>

            <div class="cp-security-note">
                <span class="cp-security-icon">🛡️</span>
                <div>
                    <div class="cp-security-title">Your data is secure</div>
                    <div class="cp-security-sub">Passwords are encrypted with 256-bit SSL. We never store your plain-text password.</div>
                </div>
            </div>
        </div>

        <!-- RIGHT PANEL: FORM CARD -->
        <div class="cp-right">
            <div class="cp-card">

                <!-- CARD HEADER -->
                <div class="cp-card-header">
                    <div class="cp-card-icon-wrap">🔑</div>
                    <div>
                        <h1 class="cp-card-title">Change Password</h1>
                        <p class="cp-card-sub">Update your password to keep your account secure.</p>
                    </div>
                </div>


                <!-- SESSION INFO -->
                <div class="cp-session-info">
                    <div class="cp-session-avatar">
                        ${sessionScope.user.substring(0,1)}
                    </div>
                    <div>
                        <div class="cp-session-name">${sessionScope.user}</div>
                        <div class="cp-session-email">${sessionScope.email}</div>
                    </div>
                    <div class="cp-session-badge">🟢 Active</div>
                </div>

                <!-- ALERT (success/error — shown by JSP) -->
                <%
                    String successMsg = (String) session.getAttribute("cp_success");
                    String errorMsg   = (String) session.getAttribute("cp_error");
                    if (successMsg != null) { session.removeAttribute("cp_success"); %>
                <div class="cp-alert cp-alert-success">
                    <span>✅</span> <%= successMsg %>
                </div>
                <% } else if (errorMsg != null) { session.removeAttribute("cp_error"); %>
                <div class="cp-alert cp-alert-error">
                    <span>⚠️</span> <%= errorMsg %>
                </div>
                <% } %>

                <!-- FORM -->
                <form action="${ctx}/changePassword" method="POST" id="cpForm" novalidate>
                    <!-- CURRENT PASSWORD -->
                    <div class="cp-form-group">
                        <label class="cp-label" for="currentPassword">
                            Current Password
                            <span class="cp-required">*</span>
                        </label>
                        <div class="cp-input-wrap">
                            <span class="cp-input-icon">🔒</span>
                            <input
                                    type="password"
                                    id="currentPassword"
                                    name="currentPassword"
                                    class="cp-input"
                                    placeholder="Enter your current password"
                                    required
                                    autocomplete="current-password"
                            />
                            <button type="button" class="cp-eye-btn" onclick="togglePassword('currentPassword', this)" title="Show/hide">
                                <span class="cp-eye-icon">👁</span>
                            </button>
                        </div>
                        <div class="cp-field-error" id="err-current"></div>
                        <a href="${ctx}/forgetPassword" class="cp-forgot-link">Forgot your password?</a>
                    </div>

                    <div class="cp-divider"></div>

                    <!-- NEW PASSWORD -->
                    <div class="cp-form-group">
                        <label class="cp-label" for="newPassword">
                            New Password
                            <span class="cp-required">*</span>
                        </label>
                        <div class="cp-input-wrap">
                            <span class="cp-input-icon">🔑</span>
                            <input
                                    type="password"
                                    id="newPassword"
                                    name="newPassword"
                                    class="cp-input"
                                    placeholder="Enter a strong new password"
                                    required
                                    autocomplete="new-password"
                                    oninput="checkStrength(this.value); validateField(this)"
                            />
                            <button type="button" class="cp-eye-btn" onclick="togglePassword('newPassword', this)" title="Show/hide">
                                <span class="cp-eye-icon">👁</span>
                            </button>
                        </div>
                        <div class="cp-field-error" id="err-new"></div>

                        <!-- STRENGTH METER -->
                        <div class="cp-strength-wrap" id="strengthWrap" style="display:none">
                            <div class="cp-strength-bar">
                                <div class="cp-strength-fill" id="strengthFill"></div>
                            </div>
                            <span class="cp-strength-label" id="strengthLabel">Weak</span>
                        </div>
                    </div>

                    <!-- CONFIRM NEW PASSWORD -->
                    <div class="cp-form-group">
                        <label class="cp-label" for="confirmPassword">
                            Confirm New Password
                            <span class="cp-required">*</span>
                        </label>
                        <div class="cp-input-wrap">
                            <span class="cp-input-icon">🛡️</span>
                            <input
                                    type="password"
                                    id="confirmPassword"
                                    name="confirmPassword"
                                    class="cp-input"
                                    placeholder="Re-enter your new password"
                                    required
                                    autocomplete="new-password"
                                    oninput="checkMatch(); validateField(this)"
                            />
                            <button type="button" class="cp-eye-btn" onclick="togglePassword('confirmPassword', this)" title="Show/hide">
                                <span class="cp-eye-icon">👁</span>
                            </button>
                        </div>
                        <div class="cp-field-error" id="err-confirm"></div>
                        <div class="cp-match-ok" id="matchOk" style="display:none">✅ Passwords match</div>
                    </div>

                    <!-- LOGOUT SESSIONS CHECKBOX -->
                    <div class="cp-checkbox-row">
                        <label class="cp-checkbox-label">
                            <input type="checkbox" name="logoutOtherSessions" id="logoutSessions" class="cp-checkbox" checked/>
                            <span class="cp-checkmark"></span>
                            <span class="cp-checkbox-text">
                Sign me out of all other devices &amp; sessions
                <span class="cp-checkbox-sub">Recommended for security — you'll stay signed in here</span>
              </span>
                        </label>
                    </div>

                    <!-- SUBMIT BUTTON -->
                    <button type="submit" class="cp-submit-btn" id="submitBtn" onclick="return validateForm()">
                        <span id="submitText">Update Password →</span>
                        <span id="submitSpinner" class="cp-spinner" style="display:none"></span>
                    </button>

                    <!-- CANCEL LINK -->
                    <div class="cp-cancel-row">
                        <a href="${ctx}/editProfile" class="cp-cancel-link">← Cancel &amp; go back</a>
                    </div>

                </form>
            </div>

            <!-- FOOTER LINKS -->
            <div class="cp-page-footer-links">
                <a href="contact.jsp">Need help?</a>
                <span>·</span>
                <a href="#">Privacy Policy</a>
                <span>·</span>
                <a href="#">Terms of Service</a>
            </div>

        </div>
    </div>
</div>




<script>
    /* ── SHOW / HIDE PASSWORD ── */
    function togglePassword(fieldId, btn) {
        const input = document.getElementById(fieldId);
        const isPass = input.type === 'password';
        input.type = isPass ? 'text' : 'password';
        btn.querySelector('.cp-eye-icon').textContent = isPass ? '🙈' : '👁';
    }

    /* ── PASSWORD STRENGTH ── */
    function checkStrength(val) {
        const wrap  = document.getElementById('strengthWrap');
        const fill  = document.getElementById('strengthFill');
        const label = document.getElementById('strengthLabel');

        if (!val) { wrap.style.display = 'none'; return; }
        wrap.style.display = 'flex';

        let score = 0;
        const checks = {
            'tip-length':  val.length >= 8,
            'tip-upper':   /[A-Z]/.test(val),
            'tip-lower':   /[a-z]/.test(val),
            'tip-number':  /[0-9]/.test(val),
            'tip-special': /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/.test(val),
        };

        Object.entries(checks).forEach(([id, pass]) => {
            const el = document.getElementById(id);
            if (pass) { el.classList.add('tip-pass'); score++; }
            else       { el.classList.remove('tip-pass'); }
        });

        const levels = [
            { pct: '20%',  color: '#c62828', text: 'Very Weak' },
            { pct: '40%',  color: '#e65100', text: 'Weak'      },
            { pct: '60%',  color: '#f9a825', text: 'Fair'      },
            { pct: '80%',  color: '#2e7d32', text: 'Strong'    },
            { pct: '100%', color: '#1b5e20', text: 'Very Strong'},
        ];
        const lvl = levels[score - 1] || levels[0];
        fill.style.width      = lvl.pct;
        fill.style.background = lvl.color;
        label.textContent     = lvl.text;
        label.style.color     = lvl.color;
    }

    /* ── MATCH CHECK ── */
    function checkMatch() {
        const np  = document.getElementById('newPassword').value;
        const cp  = document.getElementById('confirmPassword').value;
        const ok  = document.getElementById('matchOk');
        const err = document.getElementById('err-confirm');
        if (!cp) { ok.style.display = 'none'; err.textContent = ''; return; }
        if (np === cp) {
            ok.style.display  = 'block';
            err.textContent   = '';
            document.getElementById('confirmPassword').classList.remove('cp-input-error');
            document.getElementById('confirmPassword').classList.add('cp-input-ok');
        } else {
            ok.style.display  = 'none';
            err.textContent   = 'Passwords do not match.';
            document.getElementById('confirmPassword').classList.add('cp-input-error');
            document.getElementById('confirmPassword').classList.remove('cp-input-ok');
        }
    }

    /* ── SINGLE FIELD VALIDATE ── */
    function validateField(input) {
        const err = document.getElementById('err-' + (
            input.id === 'currentPassword' ? 'current' :
                input.id === 'newPassword'     ? 'new'     : 'confirm'
        ));
        if (!input.value.trim()) {
            err.textContent = 'This field is required.';
            input.classList.add('cp-input-error');
            input.classList.remove('cp-input-ok');
        } else {
            err.textContent = '';
            input.classList.remove('cp-input-error');
            input.classList.add('cp-input-ok');
        }
    }

    /* ── FULL FORM VALIDATE ── */
    function validateForm() {

        const cur = document.getElementById('currentPassword').value.trim();
        const np  = document.getElementById('newPassword').value.trim();
        const cp  = document.getElementById('confirmPassword').value.trim();

        let ok = true;

        if (!cur) {
            ok = false;
        }

        if (!np || np.length < 8) {
            ok = false;
        }

        if (!cp || cp !== np) {
            ok = false;
        }

        return ok;
    }
</script>

</body>
</html>
