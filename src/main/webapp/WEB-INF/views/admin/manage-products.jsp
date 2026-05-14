<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />


<!DOCTYPE html>
<html lang="en">
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<body>
<%@ include file="/WEB-INF/views/common/adminNavbar.jsp" %>

<div class="sidebar-layout">

    <!-- SIDEBAR -->
    <%@ include file="/WEB-INF/views/common/admin-sidebar.jsp" %>

    <div class="main-content">

        <div class="admin-topbar">
            <div class="admin-topbar-left">
                <h1>Manage Products</h1>
                <p>Add, update or remove items from your menu.</p>
            </div>

            <div class="admin-topbar-right">
                <div class="admin-search">
                    <span>🔍</span>
                    <input type="text" placeholder="Search products..."/>
                </div>

                <button class="btn btn-primary" onclick="openModal('addProductModal')">
                    + &nbsp;Add Product
                </button>
            </div>
        </div>

        <!-- STAT ROW -->
        <div class="stat-summary-row">
            <div class="stat-sum-card">
                <div class="stat-sum-ico">🍽️</div>
                <div>
                    <div class="stat-sum-val">42</div>
                    <div class="stat-sum-label">Total Products</div>
                    <div class="stat-sum-trend">↗ +3 this week</div>
                </div>
            </div>

            <div class="stat-sum-card">
                <div class="stat-sum-ico" style="background:#e8f5e9">✅</div>
                <div>
                    <div class="stat-sum-val">38</div>
                    <div class="stat-sum-label">Active</div>
                </div>
            </div>

            <div class="stat-sum-card">
                <div class="stat-sum-ico" style="background:#fff8e1">📦</div>
                <div>
                    <div class="stat-sum-val">2</div>
                    <div class="stat-sum-label">Out of Stock</div>
                </div>
            </div>

            <div class="stat-sum-card">
                <div class="stat-sum-ico" style="background:#f5f5f5">🙈</div>
                <div>
                    <div class="stat-sum-val">2</div>
                    <div class="stat-sum-label">Hidden</div>
                </div>
            </div>
        </div>

        <!-- FILTERS -->
        <div class="filter-row">
            <select class="filter-select">
                <option>All Categories</option>
            </select>

            <select class="filter-select">
                <option>All Status</option>
            </select>

            <select class="filter-select">
                <option>Sort: Newest</option>
            </select>

            <button class="btn btn-outline" style="margin-left:auto">
                ⬇️ Export
            </button>
        </div>

        <!-- TABLE -->
        <div class="admin-table-card">
            <table>
                <thead>
                <tr>
                    <th><input type="checkbox"/></th>
                    <th>Product</th>
                    <th>Category</th>
                    <th>Price</th>
                    <th>Stock</th>
                    <th>Status</th>
                    <th>Orders</th>
                    <th>Visible</th>
                    <th>Actions</th>
                </tr>
                </thead>

                <tbody>

                <tr>
                    <td><input type="checkbox"/></td>

                    <td>
                        <div class="tbl-item-cell">
                            <img class="tbl-thumb" src="https://images.unsplash.com/photo-1572490122747-3968b75cc699?w=80&q=80"/>
                            <div>
                                <div class="tbl-item-name">Hazelnut Cappuccino</div>
                                <div class="tbl-item-sub">SKU: BEV-001</div>
                            </div>
                        </div>
                    </td>

                    <td>Hot Beverages</td>
                    <td>NPR 450</td>
                    <td>In Stock</td>
                    <td>Active</td>
                    <td>248</td>

                    <td>
                        <label class="toggle">
                            <input type="checkbox" checked/>
                            <span class="toggle-slider"></span>
                        </label>
                    </td>

                    <td>
                        <div class="tbl-actions">
                            <button class="tbl-btn" onclick="openModal('editProductModal')">✏️</button>
                            <button class="tbl-btn">📋</button>
                            <button class="tbl-btn danger">🗑️</button>
                        </div>
                    </td>
                </tr>

                </tbody>
            </table>

            <div class="pagination">
                <span>Showing 1–6 of 42 products</span>
            </div>
        </div>
    </div>
</div>

<!-- ADD MODAL -->
<div class="modal-overlay hidden" id="addProductModal">
    <div class="modal">
        <div class="modal-header">
            <div>
                <div class="modal-title">Add New Product</div>
                <div class="modal-sub">Fill in the details</div>
            </div>
            <button class="modal-close" onclick="closeModal('addProductModal')">✕</button>
        </div>

        <div class="form-group">
            <label>Product Name</label>
            <input class="form-control"/>
        </div>

        <div class="modal-footer">
            <button class="btn btn-outline" onclick="closeModal('addProductModal')">Cancel</button>
            <button class="btn btn-primary">Save</button>
        </div>
    </div>
</div>

<!-- EDIT MODAL -->
<div class="modal-overlay hidden" id="editProductModal">
    <div class="modal">
        <div class="modal-header">
            <div>
                <div class="modal-title">Edit Product</div>
                <div class="modal-sub">Update product info</div>
            </div>
            <button class="modal-close" onclick="closeModal('editProductModal')">✕</button>
        </div>

        <div class="form-group">
            <label>Product Name</label>
            <input class="form-control" value="Hazelnut Cappuccino"/>
        </div>

        <div class="modal-footer">
            <button class="btn btn-outline" onclick="closeModal('editProductModal')">Cancel</button>
            <button class="btn btn-primary">Update</button>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

<script>
    function openModal(id){
        document.getElementById(id).classList.remove('hidden');
    }
    function closeModal(id){
        document.getElementById(id).classList.add('hidden');
    }
</script>

</body>
</html>