<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<body>
<%@ include file="/WEB-INF/views/common/adminNavbar.jsp" %>

<%--
    ADMIN-ONLY PAGE
    ReportServlet must verify session role == "ADMIN" before forwarding here.
    If not, redirect to /login. Never rely on the JSP alone to restrict access.
--%>

<div class="sidebar-layout">

    <!-- SIDEBAR -->
    <%@ include file="/WEB-INF/views/common/admin-sidebar.jsp" %>

    <!-- MAIN CONTENT -->
    <div class="main-content">

        <!-- TOPBAR -->
        <div class="admin-topbar">
            <div class="admin-topbar-left">
                <h1>Reports &amp; Analytics</h1>
                <p>Track performance, revenue and customer insights.</p>
            </div>
            <div class="admin-topbar-right">
                <div class="report-export-row">
                    <button class="btn btn-outline">⬇️ Export PDF</button>
                    <button class="btn btn-outline">📊 Export CSV</button>
                    <button class="btn btn-primary">🖨️ Print</button>
                </div>
            </div>
        </div>

        <!-- FLASH MESSAGE — escaped to prevent XSS -->
        <c:if test="${not empty successMsg}">
            <div style="background:#d1fae5;color:#065f46;padding:10px 18px;border-radius:8px;margin-bottom:16px;font-size:.88rem;">
                    ${fn:escapeXml(successMsg)}
            </div>
        </c:if>

        <!-- DATE RANGE -->
        <div class="report-controls">
            <span style="font-size:.82rem;font-weight:600;color:var(--text-muted)">Date Range:</span>
            <input type="date" class="date-input" value="2024-10-01"/>
            <span style="color:var(--text-muted);font-size:.85rem">→</span>
            <input type="date" class="date-input" value="2024-10-31"/>
            <div style="display:flex;gap:6px;margin-left:4px">
                <button class="btn btn-outline" onclick="setRange(event)">Today</button>
                <button class="btn btn-outline" onclick="setRange(event)">This Week</button>
                <button class="btn btn-primary"  onclick="setRange(event)">This Month</button>
                <button class="btn btn-outline" onclick="setRange(event)">This Year</button>
            </div>
        </div>

        <!-- KPI STAT ROW -->
        <div class="stat-summary-row" style="margin-bottom:20px">
            <div class="stat-sum-card">
                <div class="stat-sum-ico">💰</div>
                <div>
                    <div class="stat-sum-val">NPR 42,850</div>
                    <div class="stat-sum-label">Total Revenue</div>
                    <div class="stat-sum-trend">↗ +8% vs last month</div>
                </div>
            </div>
            <div class="stat-sum-card">
                <div class="stat-sum-ico" style="background:#e3f2fd">📦</div>
                <div>
                    <div class="stat-sum-val">156</div>
                    <div class="stat-sum-label">Total Orders</div>
                    <div class="stat-sum-trend">↗ +12%</div>
                </div>
            </div>
            <div class="stat-sum-card">
                <div class="stat-sum-ico" style="background:#e8f5e9">👥</div>
                <div>
                    <div class="stat-sum-val">1,240</div>
                    <div class="stat-sum-label">Total Customers</div>
                    <div class="stat-sum-trend">↗ +18%</div>
                </div>
            </div>
            <div class="stat-sum-card">
                <div class="stat-sum-ico" style="background:#fce4ec">🧾</div>
                <div>
                    <div class="stat-sum-val">NPR 275</div>
                    <div class="stat-sum-label">Avg. Order Value</div>
                    <div class="stat-sum-trend">↗ +5%</div>
                </div>
            </div>
        </div>

        <!-- REVENUE LINE CHART + DONUT -->
        <div class="report-grid">
            <div class="chart-card">
                <div style="display:flex;justify-content:space-between;align-items:flex-start;margin-bottom:16px">
                    <div>
                        <div class="chart-card-title">Revenue Over Time</div>
                        <div class="chart-card-sub">Daily revenue for October 2024</div>
                    </div>
                    <select class="filter-select" style="font-size:.76rem;padding:5px 10px">
                        <option>Daily</option><option>Weekly</option><option>Monthly</option>
                    </select>
                </div>
                <div class="line-chart">
                    <svg viewBox="0 0 560 160" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="none">
                        <line x1="0" y1="20"  x2="560" y2="20"  stroke="#F0EDE8" stroke-width="1"/>
                        <line x1="0" y1="60"  x2="560" y2="60"  stroke="#F0EDE8" stroke-width="1"/>
                        <line x1="0" y1="100" x2="560" y2="100" stroke="#F0EDE8" stroke-width="1"/>
                        <line x1="0" y1="140" x2="560" y2="140" stroke="#F0EDE8" stroke-width="1"/>
                        <defs>
                            <linearGradient id="areaGrad" x1="0" y1="0" x2="0" y2="1">
                                <stop offset="0%"   stop-color="#C8680A" stop-opacity="0.18"/>
                                <stop offset="100%" stop-color="#C8680A" stop-opacity="0"/>
                            </linearGradient>
                        </defs>
                        <path d="M0,120 C30,110 50,90 80,95 C110,100 130,60 160,50 C190,40 210,70 240,55 C270,40 290,30 320,35 C350,40 370,25 400,20 C430,15 450,40 480,38 C510,36 540,50 560,45 L560,160 L0,160 Z" fill="url(#areaGrad)"/>
                        <path d="M0,120 C30,110 50,90 80,95 C110,100 130,60 160,50 C190,40 210,70 240,55 C270,40 290,30 320,35 C350,40 370,25 400,20 C430,15 450,40 480,38 C510,36 540,50 560,45" fill="none" stroke="#C8680A" stroke-width="2.5" stroke-linejoin="round"/>
                        <circle cx="160" cy="50" r="4" fill="#C8680A"/>
                        <circle cx="320" cy="35" r="4" fill="#C8680A"/>
                        <circle cx="400" cy="20" r="5" fill="#C8680A" stroke="#fff" stroke-width="2"/>
                        <circle cx="560" cy="45" r="4" fill="#C8680A"/>
                    </svg>
                </div>
                <div style="display:flex;justify-content:space-between;padding:6px 2px 0;font-size:.7rem;color:var(--text-muted)">
                    <span>Oct 1</span><span>Oct 5</span><span>Oct 10</span><span>Oct 15</span><span>Oct 20</span><span>Oct 25</span><span>Oct 31</span>
                </div>
            </div>

            <div class="chart-card">
                <div class="chart-card-title">Revenue by Category</div>
                <div class="chart-card-sub">October 2024 breakdown</div>
                <div class="donut-wrap">
                    <svg class="donut-svg" viewBox="0 0 42 42" xmlns="http://www.w3.org/2000/svg">
                        <circle cx="21" cy="21" r="15.9" fill="transparent" stroke="#E5E5E5"  stroke-width="4"/>
                        <circle cx="21" cy="21" r="15.9" fill="transparent" stroke="#C8680A"  stroke-width="4" stroke-dasharray="35 65" stroke-dashoffset="25"  transform="rotate(-90 21 21)"/>
                        <circle cx="21" cy="21" r="15.9" fill="transparent" stroke="#F0A84A"  stroke-width="4" stroke-dasharray="25 75" stroke-dashoffset="-10" transform="rotate(-90 21 21)"/>
                        <circle cx="21" cy="21" r="15.9" fill="transparent" stroke="#1565C0"  stroke-width="4" stroke-dasharray="18 82" stroke-dashoffset="-35" transform="rotate(-90 21 21)"/>
                        <circle cx="21" cy="21" r="15.9" fill="transparent" stroke="#2E7D32"  stroke-width="4" stroke-dasharray="12 88" stroke-dashoffset="-53" transform="rotate(-90 21 21)"/>
                        <circle cx="21" cy="21" r="15.9" fill="transparent" stroke="#9C27B0"  stroke-width="4" stroke-dasharray="10 90" stroke-dashoffset="-65" transform="rotate(-90 21 21)"/>
                        <text x="21" y="23" text-anchor="middle" font-size="5" font-weight="bold" fill="#1A1A1A">Revenue</text>
                    </svg>
                    <div class="donut-legend">
                        <div class="donut-legend-item"><div class="donut-dot" style="background:#C8680A"></div><span>Hot Beverages</span><span class="donut-legend-val">35%</span></div>
                        <div class="donut-legend-item"><div class="donut-dot" style="background:#F0A84A"></div><span>Cold Beverages</span><span class="donut-legend-val">25%</span></div>
                        <div class="donut-legend-item"><div class="donut-dot" style="background:#1565C0"></div><span>Bakery</span><span class="donut-legend-val">18%</span></div>
                        <div class="donut-legend-item"><div class="donut-dot" style="background:#2E7D32"></div><span>Mains</span><span class="donut-legend-val">12%</span></div>
                        <div class="donut-legend-item"><div class="donut-dot" style="background:#9C27B0"></div><span>Desserts</span><span class="donut-legend-val">10%</span></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- ORDERS BAR + TOP PRODUCTS TABLE -->
        <div class="report-grid" style="margin-bottom:18px">
            <div class="chart-card">
                <div class="chart-card-title">Top Selling Products</div>
                <div class="chart-card-sub">By number of orders this month</div>
                <div class="h-bars">
                    <div class="h-bar-row"><span class="h-bar-label">Hazelnut Cappuccino</span><div class="h-bar-track"><div class="h-bar-fill" style="width:85%"></div></div><span class="h-bar-val">248 orders</span></div>
                    <div class="h-bar-row"><span class="h-bar-label">Butter Croissant</span><div class="h-bar-track"><div class="h-bar-fill" style="width:75%;background:#F0A84A"></div></div><span class="h-bar-val">312 orders</span></div>
                    <div class="h-bar-row"><span class="h-bar-label">Himalayan Salt Tea</span><div class="h-bar-track"><div class="h-bar-fill" style="width:65%;background:#1565C0"></div></div><span class="h-bar-val">184 orders</span></div>
                    <div class="h-bar-row"><span class="h-bar-label">Paneer Tikka Wrap</span><div class="h-bar-track"><div class="h-bar-fill" style="width:55%;background:#2E7D32"></div></div><span class="h-bar-val">142 orders</span></div>
                    <div class="h-bar-row"><span class="h-bar-label">Blueberry Cheesecake</span><div class="h-bar-track"><div class="h-bar-fill" style="width:40%;background:#9C27B0"></div></div><span class="h-bar-val">96 orders</span></div>
                    <div class="h-bar-row"><span class="h-bar-label">Avocado Toast</span><div class="h-bar-track"><div class="h-bar-fill" style="width:30%;background:#E65100"></div></div><span class="h-bar-val">74 orders</span></div>
                </div>
            </div>

            <div class="chart-card">
                <div class="chart-card-title">Order Status Breakdown</div>
                <div class="chart-card-sub">This month's order distribution</div>
                <div class="donut-wrap" style="margin-top:10px">
                    <svg class="donut-svg" viewBox="0 0 42 42" xmlns="http://www.w3.org/2000/svg">
                        <circle cx="21" cy="21" r="15.9" fill="transparent" stroke="#E5E5E5" stroke-width="4"/>
                        <circle cx="21" cy="21" r="15.9" fill="transparent" stroke="#2E7D32" stroke-width="4" stroke-dasharray="71 29" stroke-dashoffset="25"  transform="rotate(-90 21 21)"/>
                        <circle cx="21" cy="21" r="15.9" fill="transparent" stroke="#E65100" stroke-width="4" stroke-dasharray="18 82" stroke-dashoffset="-46" transform="rotate(-90 21 21)"/>
                        <circle cx="21" cy="21" r="15.9" fill="transparent" stroke="#C8680A" stroke-width="4" stroke-dasharray="8 92"  stroke-dashoffset="-64" transform="rotate(-90 21 21)"/>
                        <circle cx="21" cy="21" r="15.9" fill="transparent" stroke="#C62828" stroke-width="4" stroke-dasharray="3 97"  stroke-dashoffset="-72" transform="rotate(-90 21 21)"/>
                        <text x="21" y="22" text-anchor="middle" font-size="4.5" font-weight="bold" fill="#1A1A1A">Orders</text>
                    </svg>
                    <div class="donut-legend">
                        <div class="donut-legend-item"><div class="donut-dot" style="background:#2E7D32"></div><span>Delivered</span><span class="donut-legend-val">71%</span></div>
                        <div class="donut-legend-item"><div class="donut-dot" style="background:#E65100"></div><span>Preparing</span><span class="donut-legend-val">18%</span></div>
                        <div class="donut-legend-item"><div class="donut-dot" style="background:#C8680A"></div><span>Ready</span><span class="donut-legend-val">8%</span></div>
                        <div class="donut-legend-item"><div class="donut-dot" style="background:#C62828"></div><span>Cancelled</span><span class="donut-legend-val">3%</span></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- DETAILED REVENUE TABLE -->
        <div class="admin-table-card" style="margin-bottom:18px">
            <div style="padding:16px 18px;border-bottom:1px solid var(--border);display:flex;justify-content:space-between;align-items:center">
                <div>
                    <div style="font-size:.92rem;font-weight:700">Detailed Revenue Report</div>
                    <div style="font-size:.76rem;color:var(--text-muted)">Day-by-day breakdown for October 2024</div>
                </div>
                <button class="btn btn-outline" style="font-size:.78rem;padding:7px 13px">⬇️ Download CSV</button>
            </div>
            <table>
                <thead>
                <tr>
                    <th>Date</th><th>Orders</th><th>New Customers</th>
                    <th>Revenue</th><th>Avg. Order Value</th><th>Top Item</th><th>vs Prev Day</th>
                </tr>
                </thead>
                <tbody>
                <tr><td style="font-weight:600">Oct 24, 2024</td><td>18</td><td>4</td><td style="font-weight:700">NPR 5,240</td><td>NPR 291</td><td>Hazelnut Cappuccino</td><td><span style="color:var(--green);font-weight:600">↗ +14%</span></td></tr>
                <tr><td style="font-weight:600">Oct 23, 2024</td><td>15</td><td>2</td><td style="font-weight:700">NPR 4,590</td><td>NPR 306</td><td>Butter Croissant</td><td><span style="color:var(--red);font-weight:600">↘ -5%</span></td></tr>
                <tr><td style="font-weight:600">Oct 22, 2024</td><td>21</td><td>7</td><td style="font-weight:700">NPR 6,120</td><td>NPR 291</td><td>Himalayan Pink Salt Tea</td><td><span style="color:var(--green);font-weight:600">↗ +22%</span></td></tr>
                <tr><td style="font-weight:600">Oct 21, 2024</td><td>14</td><td>3</td><td style="font-weight:700">NPR 3,850</td><td>NPR 275</td><td>Hazelnut Cappuccino</td><td><span style="color:var(--red);font-weight:600">↘ -8%</span></td></tr>
                <tr><td style="font-weight:600">Oct 20, 2024</td><td>19</td><td>5</td><td style="font-weight:700">NPR 5,560</td><td>NPR 293</td><td>Blueberry Cheesecake</td><td><span style="color:var(--green);font-weight:600">↗ +9%</span></td></tr>
                <tr><td style="font-weight:600">Oct 19, 2024</td><td>16</td><td>1</td><td style="font-weight:700">NPR 4,240</td><td>NPR 265</td><td>Paneer Tikka Wrap</td><td><span style="color:var(--green);font-weight:600">↗ +3%</span></td></tr>
                </tbody>
            </table>
            <div class="pagination">
                <span>Showing 6 of 31 days</span>
                <div class="page-btns">
                    <button class="page-btn">‹</button>
                    <button class="page-btn active">1</button>
                    <button class="page-btn">2</button>
                    <button class="page-btn">3</button>
                    <button class="page-btn">›</button>
                </div>
            </div>
        </div>

        <!-- CUSTOMER INSIGHTS + PAYMENT METHODS -->
        <div style="display:grid;grid-template-columns:1fr 1fr;gap:18px;margin-bottom:18px">
            <div class="chart-card">
                <div class="chart-card-title">Customer Insights</div>
                <div class="chart-card-sub">New vs returning customers this month</div>
                <div style="display:grid;grid-template-columns:1fr 1fr;gap:10px;margin-top:12px">
                    <div style="background:var(--orange-bg);border-radius:var(--r-sm);padding:14px;text-align:center">
                        <div style="font-size:1.6rem;font-weight:800;color:var(--orange)">68%</div>
                        <div style="font-size:.76rem;color:var(--text-muted);margin-top:3px">Returning Customers</div>
                        <div style="font-size:.72rem;font-weight:700;color:var(--green);margin-top:4px">↗ +5% vs last month</div>
                    </div>
                    <div style="background:#e3f2fd;border-radius:var(--r-sm);padding:14px;text-align:center">
                        <div style="font-size:1.6rem;font-weight:800;color:#1565C0">32%</div>
                        <div style="font-size:.76rem;color:var(--text-muted);margin-top:3px">New Customers</div>
                        <div style="font-size:.72rem;font-weight:700;color:var(--green);margin-top:4px">↗ +18% this month</div>
                    </div>
                </div>
                <div style="margin-top:16px">
                    <div style="font-size:.78rem;font-weight:700;color:var(--text-muted);text-transform:uppercase;letter-spacing:.06em;margin-bottom:10px">Top Locations</div>
                    <div class="h-bars">
                        <div class="h-bar-row"><span class="h-bar-label" style="width:90px">Kathmandu</span><div class="h-bar-track"><div class="h-bar-fill" style="width:72%"></div></div><span class="h-bar-val">72%</span></div>
                        <div class="h-bar-row"><span class="h-bar-label" style="width:90px">Lalitpur</span><div class="h-bar-track"><div class="h-bar-fill" style="width:18%;background:#F0A84A"></div></div><span class="h-bar-val">18%</span></div>
                        <div class="h-bar-row"><span class="h-bar-label" style="width:90px">Bhaktapur</span><div class="h-bar-track"><div class="h-bar-fill" style="width:10%;background:#1565C0"></div></div><span class="h-bar-val">10%</span></div>
                    </div>
                </div>
            </div>

            <div class="chart-card">
                <div class="chart-card-title">Payment Methods</div>
                <div class="chart-card-sub">Transaction method breakdown</div>
                <div class="h-bars" style="margin-top:16px">
                    <div class="h-bar-row"><span class="h-bar-label">eSewa</span><div class="h-bar-track"><div class="h-bar-fill" style="width:52%"></div></div><span class="h-bar-val">52% &nbsp; (81)</span></div>
                    <div class="h-bar-row"><span class="h-bar-label">Khalti</span><div class="h-bar-track"><div class="h-bar-fill" style="width:28%;background:#9C27B0"></div></div><span class="h-bar-val">28% &nbsp; (44)</span></div>
                    <div class="h-bar-row"><span class="h-bar-label">Credit Card</span><div class="h-bar-track"><div class="h-bar-fill" style="width:13%;background:#1565C0"></div></div><span class="h-bar-val">13% &nbsp; (20)</span></div>
                    <div class="h-bar-row"><span class="h-bar-label">Cash on Del.</span><div class="h-bar-track"><div class="h-bar-fill" style="width:7%;background:#888"></div></div><span class="h-bar-val">7% &nbsp;&nbsp; (11)</span></div>
                </div>
                <div style="background:var(--orange-bg);border-radius:var(--r-sm);padding:12px 14px;margin-top:16px;font-size:.8rem;color:var(--text-mid)">
                    <strong style="color:var(--orange)">💡 Insight:</strong> eSewa continues to be the dominant payment method.
                </div>
            </div>
        </div>

        <!-- PEAK HOURS -->
        <div class="chart-card" style="margin-bottom:18px">
            <div style="display:flex;justify-content:space-between;align-items:flex-start;margin-bottom:16px">
                <div>
                    <div class="chart-card-title">Peak Order Hours</div>
                    <div class="chart-card-sub">Average orders by hour of day (October 2024)</div>
                </div>
            </div>
            <div style="display:flex;align-items:flex-end;gap:8px;height:100px;padding:0 4px">
                <div style="flex:1;display:flex;flex-direction:column;align-items:center;gap:4px"><div style="background:#E5E5E5;border-radius:3px 3px 0 0;width:100%;height:15px"></div><span style="font-size:.62rem;color:var(--text-muted)">6am</span></div>
                <div style="flex:1;display:flex;flex-direction:column;align-items:center;gap:4px"><div style="background:var(--orange);opacity:.4;border-radius:3px 3px 0 0;width:100%;height:35px"></div><span style="font-size:.62rem;color:var(--text-muted)">7am</span></div>
                <div style="flex:1;display:flex;flex-direction:column;align-items:center;gap:4px"><div style="background:var(--orange);opacity:.6;border-radius:3px 3px 0 0;width:100%;height:60px"></div><span style="font-size:.62rem;color:var(--text-muted)">8am</span></div>
                <div style="flex:1;display:flex;flex-direction:column;align-items:center;gap:4px"><div style="background:var(--orange);opacity:.9;border-radius:3px 3px 0 0;width:100%;height:90px"></div><span style="font-size:.62rem;color:var(--text-muted)">9am</span></div>
                <div style="flex:1;display:flex;flex-direction:column;align-items:center;gap:4px"><div style="background:var(--orange);border-radius:3px 3px 0 0;width:100%;height:80px"></div><span style="font-size:.62rem;color:var(--text-muted)">10am</span></div>
                <div style="flex:1;display:flex;flex-direction:column;align-items:center;gap:4px"><div style="background:var(--orange);opacity:.7;border-radius:3px 3px 0 0;width:100%;height:55px"></div><span style="font-size:.62rem;color:var(--text-muted)">11am</span></div>
                <div style="flex:1;display:flex;flex-direction:column;align-items:center;gap:4px"><div style="background:var(--orange);opacity:.9;border-radius:3px 3px 0 0;width:100%;height:85px"></div><span style="font-size:.62rem;color:var(--text-muted)">12pm</span></div>
                <div style="flex:1;display:flex;flex-direction:column;align-items:center;gap:4px"><div style="background:var(--orange);opacity:.6;border-radius:3px 3px 0 0;width:100%;height:50px"></div><span style="font-size:.62rem;color:var(--text-muted)">1pm</span></div>
                <div style="flex:1;display:flex;flex-direction:column;align-items:center;gap:4px"><div style="background:var(--orange);opacity:.45;border-radius:3px 3px 0 0;width:100%;height:40px"></div><span style="font-size:.62rem;color:var(--text-muted)">2pm</span></div>
                <div style="flex:1;display:flex;flex-direction:column;align-items:center;gap:4px"><div style="background:var(--orange);opacity:.35;border-radius:3px 3px 0 0;width:100%;height:30px"></div><span style="font-size:.62rem;color:var(--text-muted)">3pm</span></div>
                <div style="flex:1;display:flex;flex-direction:column;align-items:center;gap:4px"><div style="background:var(--orange);opacity:.5;border-radius:3px 3px 0 0;width:100%;height:45px"></div><span style="font-size:.62rem;color:var(--text-muted)">4pm</span></div>
                <div style="flex:1;display:flex;flex-direction:column;align-items:center;gap:4px"><div style="background:var(--orange);opacity:.65;border-radius:3px 3px 0 0;width:100%;height:55px"></div><span style="font-size:.62rem;color:var(--text-muted)">5pm</span></div>
                <div style="flex:1;display:flex;flex-direction:column;align-items:center;gap:4px"><div style="background:var(--orange);opacity:.85;border-radius:3px 3px 0 0;width:100%;height:75px"></div><span style="font-size:.62rem;color:var(--text-muted)">6pm</span></div>
                <div style="flex:1;display:flex;flex-direction:column;align-items:center;gap:4px"><div style="background:var(--orange);border-radius:3px 3px 0 0;width:100%;height:95px"></div><span style="font-size:.62rem;color:var(--text-muted)">7pm</span></div>
                <div style="flex:1;display:flex;flex-direction:column;align-items:center;gap:4px"><div style="background:var(--orange);opacity:.75;border-radius:3px 3px 0 0;width:100%;height:65px"></div><span style="font-size:.62rem;color:var(--text-muted)">8pm</span></div>
                <div style="flex:1;display:flex;flex-direction:column;align-items:center;gap:4px"><div style="background:var(--orange);opacity:.4;border-radius:3px 3px 0 0;width:100%;height:35px"></div><span style="font-size:.62rem;color:var(--text-muted)">9pm</span></div>
            </div>
            <div style="margin-top:10px;font-size:.78rem;color:var(--text-muted);text-align:center">
                Peak hours: <strong style="color:var(--orange)">9–10 AM</strong> and <strong style="color:var(--orange)">7–8 PM</strong>.
            </div>
        </div>

        <!-- ═══════════════════════════════════════════════════════════════════
             CUSTOMER REVIEWS — live from DB via ReportServlet + FeedbackDAO
             ═══════════════════════════════════════════════════════════════════ -->
        <div class="chart-card review-card">

            <div class="review-header">
                <div>
                    <div class="chart-card-title">Customer Reviews</div>
                    <div class="chart-card-sub">
                        <c:choose>
                            <c:when test="${totalReviews > 0}">
                                <%-- totalReviews and avgRating are numeric — no escaping needed --%>
                                ${totalReviews} review${totalReviews != 1 ? 's' : ''} &nbsp;·&nbsp;
                                Avg rating: <strong style="color:var(--orange)">${avgRating} ⭐</strong>
                            </c:when>
                            <c:otherwise>No reviews yet</c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <button class="btn btn-outline review-btn" onclick="toggleAll()">View All</button>
            </div>

            <c:choose>
                <c:when test="${empty allFeedbacks}">
                    <div style="text-align:center;padding:32px;color:var(--text-muted);font-size:.9rem;">
                        No customer reviews received yet.
                    </div>
                </c:when>

                <c:otherwise>
                    <c:forEach var="fb" items="${allFeedbacks}" varStatus="loop">

                        <div class="review-item ${loop.index >= 3 ? 'extra-review' : ''} ${loop.last ? 'last-review' : ''}"
                             style="${loop.index >= 3 ? 'display:none;' : ''}">

                            <div style="flex:1">
                                    <%-- All user-supplied fields escaped with fn:escapeXml --%>
                                <div class="review-name">${fn:escapeXml(fb.userName)}</div>

                                <div class="review-stars" style="color:#C8680A;font-size:.95rem;margin:3px 0">
                                    <c:forEach begin="1" end="${fb.rating}"   var="i">★</c:forEach>
                                    <c:forEach begin="${fb.rating+1}" end="5" var="i">☆</c:forEach>
                                </div>

                                <div class="review-text">${fn:escapeXml(fb.message)}</div>

                                <c:if test="${not empty fb.userEmail}">
                                    <div style="font-size:.74rem;color:var(--text-muted);margin-top:4px">
                                            ${fn:escapeXml(fb.userEmail)}
                                    </div>
                                </c:if>
                            </div>

                            <div style="display:flex;flex-direction:column;align-items:flex-end;gap:8px;flex-shrink:0">
                                    <%-- relativeTime is computed from a DB timestamp — safe, but escaping is cheap --%>
                                <span class="review-time">${fn:escapeXml(fb.relativeTime)}</span>

                                    <%--
                                        DELETE FORM
                                        • CSRF token required — ReportServlet must validate it.
                                        • feedbackId is an int from the DB — no injection risk,
                                          but we keep it as a hidden field (never render into JS).
                                    --%>
                                <form action="${ctx}/report" method="post"
                                      onsubmit="return confirm('Delete this review?')">
                                    <input type="hidden" name="csrfToken"  value="${fn:escapeXml(csrfToken)}"/>
                                    <input type="hidden" name="action"     value="deleteFeedback"/>
                                    <input type="hidden" name="feedbackId" value="${fb.id}"/>
                                    <button type="submit"
                                            style="background:none;border:1px solid #feb2b2;color:#c53030;
                                                   border-radius:5px;padding:3px 10px;font-size:.76rem;cursor:pointer;">
                                        🗑 Delete
                                    </button>
                                </form>
                            </div>

                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>

        </div><%-- /review-card --%>

    </div><%-- /main-content --%>
</div><%-- /sidebar-layout --%>

<script>
    function setRange(event) {
        document.querySelectorAll('.report-controls .btn').forEach(b => {
            b.classList.remove('btn-primary');
            b.classList.add('btn-outline');
        });
        event.target.classList.remove('btn-outline');
        event.target.classList.add('btn-primary');
    }

    function toggleAll() {
        const extras = document.querySelectorAll('.extra-review');
        const btn    = document.querySelector('.review-btn');
        const hidden = extras.length > 0 && extras[0].style.display === 'none';
        extras.forEach(el => el.style.display = hidden ? 'flex' : 'none');
        btn.textContent = hidden ? 'Show Less' : 'View All';
    }
</script>

</body>
</html>