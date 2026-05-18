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
                <form action="${ctx}/manageProduct"
                      method="get"
                      class="admin-search"
                      id="searchForm">

                    <span>🔍</span>

                    <input type="text"
                           name="search"
                           id="searchInput"
                           placeholder="Search products..."
                           value="${param.search}"
                           oninput="handleSearch(this.value)" />
                </form>

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
                    <div class="stat-sum-val">${totalProducts}</div>
                    <div class="stat-sum-label">Total Products</div>
                    <div class="stat-sum-trend">↗ +3 this week</div>
                </div>
            </div>

            <div class="stat-sum-card">
                <div class="stat-sum-ico" style="background:#e8f5e9">✅</div>
                <div>
                    <div class="stat-sum-val">${activeCount}</div>
                    <div class="stat-sum-label">active count</div>
                </div>
            </div>

            <div class="stat-sum-card">
                <div class="stat-sum-ico" style="background:#fff8e1">📦</div>
                <div>
                    <div class="stat-sum-val">${outOfStock}</div>
                    <div class="stat-sum-label">Out of stock</div>
                </div>
            </div>

            <div class="stat-sum-card">
                <div class="stat-sum-ico" style="background:#f5f5f5">🙈</div>
                <div>
                    <div class="stat-sum-val">${hiddenCount}</div>
                    <div class="stat-sum-label">Hidden count</div>
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
                <c:forEach var="product" items="${products}">
                    <tr>
                        <td><input type="checkbox"/></td>

                        <td>
                            <div class="tbl-item-cell">
                                <img class="tbl-thumb" src="${ctx}/image?id=${product.id}" alt="${product.name}"/>
                                <div>
                                    <div class="tbl-item-name">${product.name}</div>
                                    <div class="tbl-item-sub">ID: ${product.id}</div>
                                </div>
                            </div>
                        </td>

                        <td>${product.categoryId}</td>
                        <td>NPR ${product.price}</td>
                        <td>${product.active ? 'In Stock' : 'Out of Stock'}</td>
                        <td>
        <span class="${product.active ? 'badge-active' : 'badge-inactive'}">
                ${product.active ? 'Active' : 'Inactive'}
        </span>
                        </td>
                        <td>${product.orderCount}</td>

                        <td>
                            <label class="toggle">
                                <input type="checkbox" ${product.active ? 'checked' : ''}/>
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
                </c:forEach>

                <c:if test="${empty products}">
                    <tr>
                        <td colspan="9" style="text-align:center; padding: 2rem; color: #999;">
                            No products found.
                        </td>
                    </tr>
                </c:if>
                </tbody>
            </table>


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
    let timeout = null;

    function handleSearch(value) {

        clearTimeout(timeout);

        timeout = setTimeout(() => {

            // if empty → show full list again
            if (value.trim() === "") {

                window.location.href =
                    "${ctx}/manageProduct";

                return;
            }

            // auto submit while typing
            document.getElementById("searchForm")
                .submit();

        }, 300);
    }
</script>

</body>
</html>