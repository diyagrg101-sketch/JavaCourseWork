<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<body>

<%@ include file="/WEB-INF/views/common/adminNavbar.jsp" %>

<div class="sidebar-layout">

    <%@ include file="/WEB-INF/views/common/admin-sidebar.jsp" %>

    <div class="main-content">

        <!-- TOP BAR -->
        <div class="admin-topbar">

            <div class="admin-topbar-left">
                <h1>Manage Categories</h1>
                <p>Organise your menu into categories.</p>
            </div>

            <div class="admin-topbar-right">

                <button class="btn btn-primary"
                        onclick="openModal('addCatModal')">
                    + Add Category
                </button>

            </div>

        </div>

        <!-- CATEGORY GRID -->
        <div class="category-grid">

            <c:forEach var="cat" items="${categories}">

                <div class="category-card">

                    <div class="category-card-ico">
                        🗂️
                    </div>

                    <div class="category-card-body">

                        <div class="category-card-name">
                                ${cat.name}
                        </div>

                        <div class="category-card-count">
                            ID: ${cat.id}
                        </div>

                        <div style="font-size:.76rem;color:var(--text-muted);margin-bottom:8px">
                                ${cat.description}
                        </div>

                        <div class="category-card-actions">

                            <!-- EDIT -->
                            <a class="tbl-btn"
                               href="${ctx}/manageCategories?action=edit&id=${cat.id}">
                                ✏️
                            </a>

                            <!-- DELETE -->
                            <a class="tbl-btn danger"
                               href="${ctx}/manageCategories?action=delete&id=${cat.id}">
                                🗑️
                            </a>

                        </div>

                    </div>

                </div>

            </c:forEach>

            <!-- ADD CARD -->
            <div class="category-card"
                 style="border-style:dashed;cursor:pointer;display:flex;align-items:center;justify-content:center;flex-direction:column"
                 onclick="openModal('addCatModal')">

                <div style="font-size:1.6rem">➕</div>

                <div style="font-weight:600;color:var(--orange)">
                    Add Category
                </div>

            </div>

        </div>

    </div>

</div>

<!-- ================= ADD CATEGORY MODAL ================= -->
<form action="${ctx}/manageCategories" method="post">

    <div class="modal-overlay hidden" id="addCatModal">

        <div class="modal">

            <div class="modal-header">

                <div class="modal-title">Add Category</div>

                <button type="button"
                        class="modal-close"
                        onclick="closeModal('addCatModal')">
                    ✕
                </button>

            </div>

            <div class="form-group">
                <label>Name</label>
                <input name="name" class="form-control" required />
            </div>

            <div class="form-group">
                <label>Description</label>
                <textarea name="description" class="form-control"></textarea>
            </div>

            <div class="modal-footer">

                <button type="button"
                        class="btn btn-outline"
                        onclick="closeModal('addCatModal')">
                    Cancel
                </button>

                <button type="submit" class="btn btn-primary">
                    Save Category
                </button>

            </div>

        </div>

    </div>

</form>

<!-- ================= EDIT CATEGORY MODAL ================= -->
<c:if test="${not empty editCategory}">

    <form action="${ctx}/manageCategories" method="post">

        <div class="modal-overlay" style="display:block">

            <div class="modal">

                <div class="modal-header">

                    <div class="modal-title">Edit Category</div>

                </div>

                <!-- hidden id -->
                <input type="hidden" name="id" value="${editCategory.id}" />

                <div class="form-group">
                    <label>Name</label>
                    <input name="name"
                           class="form-control"
                           value="${editCategory.name}" />
                </div>

                <div class="form-group">
                    <label>Description</label>
                    <textarea name="description"
                              class="form-control">${editCategory.description}</textarea>
                </div>

                <div class="modal-footer">

                    <button type="submit" class="btn btn-primary">
                        Update Category
                    </button>

                </div>

            </div>

        </div>

    </form>

</c:if>

<!-- ================= JS ================= -->
<script>

    function openModal(id){
        document.getElementById(id).classList.remove('hidden');
    }

    function closeModal(id){
        document.getElementById(id).classList.add('hidden');
    }

</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

</body>
</html>