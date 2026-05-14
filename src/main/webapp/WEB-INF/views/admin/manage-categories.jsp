<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<body>
<!-- NAVBAR -->
<%@ include file="/WEB-INF/views/common/adminNavbar.jsp" %>

<div class="sidebar-layout">

    <!-- ADMIN SIDEBAR -->
    <%@ include file="/WEB-INF/views/common/admin-sidebar.jsp" %>

    <!-- MAIN CONTENT -->
    <div class="main-content">

        <!-- TOPBAR -->
        <div class="admin-topbar">

            <div class="admin-topbar-left">
                <h1>Manage Categories</h1>
                <p>
                    Organise your menu into categories for easier navigation.
                </p>
            </div>

            <div class="admin-topbar-right">

                <div class="admin-search">
                    <span>🔍</span>

                    <input type="text"
                           placeholder="Search categories..." />
                </div>

                <button class="btn btn-primary"
                        onclick="openModal('addCatModal')">

                    + &nbsp;Add Category

                </button>

            </div>

        </div>

        <!-- STAT ROW -->
        <div class="stat-summary-row">

            <div class="stat-sum-card">

                <div class="stat-sum-ico">🗂️</div>

                <div>
                    <div class="stat-sum-val">8</div>
                    <div class="stat-sum-label">Total Categories</div>
                    <div class="stat-sum-trend">↗ +2 this month</div>
                </div>

            </div>

            <div class="stat-sum-card">

                <div class="stat-sum-ico">✅</div>

                <div>
                    <div class="stat-sum-val">7</div>
                    <div class="stat-sum-label">Active</div>
                </div>

            </div>

            <div class="stat-sum-card">

                <div class="stat-sum-ico">🍽️</div>

                <div>
                    <div class="stat-sum-val">42</div>
                    <div class="stat-sum-label">Total Products</div>
                </div>

            </div>

            <div class="stat-sum-card">

                <div class="stat-sum-ico">📦</div>

                <div>
                    <div class="stat-sum-val">1</div>
                    <div class="stat-sum-label">Hidden</div>
                </div>

            </div>

        </div>

        <!-- CATEGORY HEADER -->
        <div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:14px">

            <h3 style="font-size:.95rem;font-weight:700">
                All Categories
            </h3>

            <div class="filter-row" style="margin-bottom:0">

                <select class="filter-select">
                    <option>All Status</option>
                    <option>Active</option>
                    <option>Hidden</option>
                </select>

                <select class="filter-select">
                    <option>Sort: Name A–Z</option>
                    <option>Sort: Most Products</option>
                    <option>Sort: Newest</option>
                </select>

            </div>

        </div>

        <!-- CATEGORY GRID -->
        <div class="category-grid">

            <!-- CARD 1 -->
            <div class="category-card">

                <div class="category-card-ico"
                     style="background:#FFF3E0">

                    ☕

                </div>

                <div class="category-card-body">

                    <div class="category-card-name">
                        Hot Beverages
                    </div>

                    <div class="category-card-count">

                        12 products &nbsp;•&nbsp;

                        <span class="badge badge-success">
                            Active
                        </span>

                    </div>

                    <div style="font-size:.76rem;color:var(--text-muted);margin-bottom:8px">

                        Coffees, teas &amp; warm drinks

                    </div>

                    <div class="category-card-actions">

                        <button class="tbl-btn"
                                onclick="openModal('editCatModal')"
                                title="Edit">

                            ✏️

                        </button>

                        <button class="tbl-btn danger"
                                title="Delete">

                            🗑️

                        </button>

                        <label class="toggle">

                            <input type="checkbox" checked />

                            <span class="toggle-slider"></span>

                        </label>

                    </div>

                </div>

            </div>

            <!-- CARD 2 -->
            <div class="category-card">

                <div class="category-card-ico"
                     style="background:#E3F2FD">

                    🧊

                </div>

                <div class="category-card-body">

                    <div class="category-card-name">
                        Cold Beverages
                    </div>

                    <div class="category-card-count">

                        8 products &nbsp;•&nbsp;

                        <span class="badge badge-success">
                            Active
                        </span>

                    </div>

                    <div style="font-size:.76rem;color:var(--text-muted);margin-bottom:8px">

                        Iced coffees, cold brews &amp; shakes

                    </div>

                    <div class="category-card-actions">

                        <button class="tbl-btn"
                                onclick="openModal('editCatModal')">

                            ✏️

                        </button>

                        <button class="tbl-btn danger">
                            🗑️
                        </button>

                        <label class="toggle">

                            <input type="checkbox" checked />

                            <span class="toggle-slider"></span>

                        </label>

                    </div>

                </div>

            </div>

            <!-- CARD 3 -->
            <div class="category-card">

                <div class="category-card-ico"
                     style="background:#FFF8E1">

                    🥐

                </div>

                <div class="category-card-body">

                    <div class="category-card-name">
                        Bakery &amp; Pastries
                    </div>

                    <div class="category-card-count">

                        9 products &nbsp;•&nbsp;

                        <span class="badge badge-success">
                            Active
                        </span>

                    </div>

                    <div style="font-size:.76rem;color:var(--text-muted);margin-bottom:8px">

                        Croissants, muffins &amp; fresh bakes

                    </div>

                    <div class="category-card-actions">

                        <button class="tbl-btn"
                                onclick="openModal('editCatModal')">

                            ✏️

                        </button>

                        <button class="tbl-btn danger">
                            🗑️
                        </button>

                        <label class="toggle">

                            <input type="checkbox" checked />

                            <span class="toggle-slider"></span>

                        </label>

                    </div>

                </div>

            </div>

            <!-- CARD 4 -->
            <div class="category-card">

                <div class="category-card-ico"
                     style="background:#FCE4EC">

                    🍰

                </div>

                <div class="category-card-body">

                    <div class="category-card-name">
                        Desserts
                    </div>

                    <div class="category-card-count">

                        6 products &nbsp;•&nbsp;

                        <span class="badge badge-success">
                            Active
                        </span>

                    </div>

                    <div style="font-size:.76rem;color:var(--text-muted);margin-bottom:8px">

                        Cakes, cheesecakes &amp; sweets

                    </div>

                    <div class="category-card-actions">

                        <button class="tbl-btn"
                                onclick="openModal('editCatModal')">

                            ✏️

                        </button>

                        <button class="tbl-btn danger">
                            🗑️
                        </button>

                        <label class="toggle">

                            <input type="checkbox" checked />

                            <span class="toggle-slider"></span>

                        </label>

                    </div>

                </div>

            </div>

            <!-- ADD NEW CARD -->
            <div class="category-card"
                 style="border-style:dashed;justify-content:center;cursor:pointer;min-height:120px;flex-direction:column;align-items:center;text-align:center;gap:8px"
                 onclick="openModal('addCatModal')">

                <div style="font-size:1.6rem">
                    ➕
                </div>

                <div style="font-size:.85rem;font-weight:600;color:var(--orange)">
                    Add New Category
                </div>

                <div style="font-size:.76rem;color:var(--text-muted)">
                    Click to create
                </div>

            </div>

        </div>

    </div>

</div>


<!-- ═════════════ ADD CATEGORY MODAL ═════════════ -->
<div class="modal-overlay hidden"
     id="addCatModal">

    <div class="modal">

        <div class="modal-header">

            <div>

                <div class="modal-title">
                    Add New Category
                </div>

                <div class="modal-sub">
                    Fill in details to create a new menu category.
                </div>

            </div>

            <button class="modal-close"
                    onclick="closeModal('addCatModal')">

                ✕

            </button>

        </div>

        <div class="img-upload-box">

            <div class="ico">🖼️</div>

            <p>Upload category icon or image</p>

            <span>
                Click to browse or drag &amp; drop
            </span>

        </div>

        <div class="form-group">

            <label>Category Name *</label>

            <input class="form-control"
                   placeholder="e.g. Hot Beverages" />

        </div>

        <div class="form-group">

            <label>Description</label>

            <textarea class="form-control"
                      rows="2"
                      placeholder="Short description of this category..."></textarea>

        </div>

        <div class="input-row">

            <div class="form-group">

                <label>Icon / Emoji</label>

                <input class="form-control"
                       placeholder="e.g. ☕" />

            </div>

            <div class="form-group">

                <label>Display Order</label>

                <input class="form-control"
                       type="number"
                       placeholder="1"
                       min="1" />

            </div>

        </div>

        <div class="form-group">

            <label>Status</label>

            <select class="form-control">
                <option>Active</option>
                <option>Hidden</option>
            </select>

        </div>

        <div class="modal-footer">

            <button class="btn btn-outline"
                    onclick="closeModal('addCatModal')">

                Cancel

            </button>

            <button class="btn btn-primary">
                Save Category
            </button>

        </div>

    </div>

</div>

<!-- ═════════════ EDIT CATEGORY MODAL ═════════════ -->
<div class="modal-overlay hidden"
     id="editCatModal">

    <div class="modal">

        <div class="modal-header">

            <div>

                <div class="modal-title">
                    Edit Category
                </div>

                <div class="modal-sub">
                    Update category information.
                </div>

            </div>

            <button class="modal-close"
                    onclick="closeModal('editCatModal')">

                ✕

            </button>

        </div>

        <div class="img-upload-box"
             style="display:flex;align-items:center;gap:14px;padding:16px;text-align:left">

            <div style="width:56px;height:56px;background:#FFF3E0;border-radius:var(--r-sm);display:flex;align-items:center;justify-content:center;font-size:1.5rem;flex-shrink:0">

                ☕

            </div>

            <div>

                <p style="font-size:.82rem;font-weight:600;margin-bottom:3px">

                    Hot Beverages

                </p>

                <span>Click to change image</span>

            </div>

        </div>

        <div class="form-group">

            <label>Category Name *</label>

            <input class="form-control"
                   value="Hot Beverages" />

        </div>

        <div class="form-group">

            <label>Description</label>

            <textarea class="form-control"
                      rows="2">Coffees, teas &amp; warm drinks</textarea>

        </div>

        <div class="input-row">

            <div class="form-group">

                <label>Icon / Emoji</label>

                <input class="form-control"
                       value="☕" />

            </div>

            <div class="form-group">

                <label>Display Order</label>

                <input class="form-control"
                       type="number"
                       value="1" />

            </div>

        </div>

        <div class="form-group">

            <label>Status</label>

            <select class="form-control">
                <option selected>Active</option>
                <option>Hidden</option>
            </select>

        </div>

        <div class="modal-footer">

            <button class="btn btn-outline"
                    onclick="closeModal('editCatModal')">

                Cancel

            </button>

            <button class="btn btn-primary">
                Update Category
            </button>

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

    window.addEventListener('click', e => {

        document.querySelectorAll('.modal-overlay').forEach(m => {

            if(e.target === m){
                m.classList.add('hidden');
            }

        });

    });

</script>
</body>
</html>