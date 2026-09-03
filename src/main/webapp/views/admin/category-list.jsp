<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh Sách Danh Mục</title>
</head>
<body>
    <!-- Breadcrumb điều hướng -->
    <nav aria-label="breadcrumb" class="mb-3">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/categories" class="text-decoration-none">Hệ thống</a></li>
            <li class="breadcrumb-item active" aria-current="page">Danh mục sản phẩm</li>
        </ol>
    </nav>

    <!-- Tính toán thống kê dữ liệu trực quan -->
    <c:set var="totalCount" value="${empty listcate ? 0 : listcate.size()}" />
    <c:set var="activeCount" value="0" />
    <c:set var="lockedCount" value="0" />
    <c:forEach items="${listcate}" var="cItem">
        <c:if test="${cItem.status == 1}">
            <c:set var="activeCount" value="${activeCount + 1}" />
        </c:if>
        <c:if test="${cItem.status == 0}">
            <c:set var="lockedCount" value="${lockedCount + 1}" />
        </c:if>
    </c:forEach>

    <!-- Thẻ thống kê trực quan (Stats Cards) -->
    <div class="row g-3 mb-4">
        <div class="col-md-4">
            <div class="stat-card p-3 d-flex align-items-center justify-content-between">
                <div>
                    <div class="text-muted small fw-semibold text-uppercase">TỔNG SỐ DANH MỤC</div>
                    <div class="fs-2 fw-bold text-dark mt-1">${totalCount}</div>
                </div>
                <div class="rounded-circle bg-primary-subtle p-3 text-primary fs-3">
                    <i class="bi bi-grid-fill"></i>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="stat-card p-3 d-flex align-items-center justify-content-between">
                <div>
                    <div class="text-muted small fw-semibold text-uppercase">ĐANG HOẠT ĐỘNG</div>
                    <div class="fs-2 fw-bold text-success mt-1">${activeCount}</div>
                </div>
                <div class="rounded-circle bg-success-subtle p-3 text-success fs-3">
                    <i class="bi bi-check-circle-fill"></i>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="stat-card p-3 d-flex align-items-center justify-content-between">
                <div>
                    <div class="text-muted small fw-semibold text-uppercase">TẠM KHÓA</div>
                    <div class="fs-2 fw-bold text-warning mt-1">${lockedCount}</div>
                </div>
                <div class="rounded-circle bg-warning-subtle p-3 text-warning fs-3">
                    <i class="bi bi-lock-fill"></i>
                </div>
            </div>
        </div>
    </div>

    <!-- Bảng danh sách & Công cụ tìm kiếm nhanh -->
    <div class="card shadow-sm border-0">
        <div class="card-header bg-white py-3">
            <div class="row g-2 align-items-center justify-content-between">
                <div class="col-md-4">
                    <!-- Ô tìm kiếm trực tiếp (Live Search) -->
                    <div class="input-group">
                        <span class="input-group-text bg-light border-end-0 text-muted">
                            <i class="bi bi-search"></i>
                        </span>
                        <input type="text" id="liveSearchInput" class="form-control bg-light border-start-0 ps-0" 
                               placeholder="Tìm nhanh tên danh mục..." onkeyup="filterCategoryTable();" />
                    </div>
                </div>
                <div class="col-md-auto d-flex gap-2">
                    <a href="${pageContext.request.contextPath}/admin/category/add" class="btn btn-primary px-3 shadow-xs">
                        <i class="bi bi-plus-lg me-1"></i>Thêm danh mục mới
                    </a>
                </div>
            </div>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0" id="categoryTable">
                    <thead class="table-light text-secondary">
                        <tr>
                            <th class="text-center" style="width: 70px;">ID</th>
                            <th class="text-center" style="width: 110px;">Hình ảnh</th>
                            <th>Tên danh mục</th>
                            <th class="text-center" style="width: 150px;">Trạng thái</th>
                            <th class="text-center" style="width: 160px;">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody id="categoryTableBody">
                        <c:choose>
                            <c:when test="${empty listcate}">
                                <tr>
                                    <td colspan="5" class="text-center py-5 text-muted">
                                        <i class="bi bi-inbox fs-1 d-block mb-2 text-secondary"></i>
                                        Hiện chưa có danh mục nào. Hãy bấm <strong>Thêm danh mục mới</strong> để tạo!
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${listcate}" var="cate">
                                    <tr class="category-row">
                                        <td class="text-center text-muted fw-bold">#${cate.categoryId}</td>
                                        <td class="text-center">
                                            <c:choose>
                                                <c:when test="${cate.images.startsWith('http')}">
                                                    <img src="${cate.images}" class="rounded border shadow-2xs previewable-img" 
                                                         style="width: 60px; height: 48px; object-fit: cover; cursor: pointer;" 
                                                         alt="${cate.categoryname}" onclick="showImageModal(this.src, '${cate.categoryname}')" 
                                                         title="Bấm để xem ảnh phóng to" />
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${pageContext.request.contextPath}/image?fname=${cate.images}" 
                                                         class="rounded border shadow-2xs previewable-img" 
                                                         style="width: 60px; height: 48px; object-fit: cover; cursor: pointer;" 
                                                         alt="${cate.categoryname}" 
                                                         onclick="showImageModal(this.src, '${cate.categoryname}')" 
                                                         title="Bấm để xem ảnh phóng to"
                                                         onerror="this.src='https://via.placeholder.com/60x48?text=No+Img'" />
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <span class="fw-semibold text-dark cat-name">${cate.categoryname}</span>
                                        </td>
                                        <td class="text-center">
                                            <c:choose>
                                                <c:when test="${cate.status == 1}">
                                                    <span class="badge bg-success-subtle text-success border border-success-subtle px-3 py-1 rounded-pill">
                                                        <i class="bi bi-check-circle me-1"></i>Đang hoạt động
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary-subtle text-secondary border border-secondary-subtle px-3 py-1 rounded-pill">
                                                        <i class="bi bi-slash-circle me-1"></i>Tạm khóa
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-center">
                                            <div class="btn-group btn-group-sm">
                                                <a href="${pageContext.request.contextPath}/admin/category/edit?id=${cate.categoryId}" 
                                                   class="btn btn-outline-primary" title="Chỉnh sửa">
                                                    <i class="bi bi-pencil-square me-1"></i>Sửa
                                                </a>
                                                <a href="${pageContext.request.contextPath}/admin/category/delete?id=${cate.categoryId}" 
                                                   class="btn btn-outline-danger" title="Xóa" 
                                                   onclick="return confirm('Bạn có chắc muốn xóa danh mục [${cate.categoryname}]?')">
                                                    <i class="bi bi-trash me-1"></i>Xóa
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
            <!-- Thông báo khi không tìm thấy kết quả từ live search -->
            <div id="noSearchMatch" class="text-center py-4 text-muted d-none">
                <i class="bi bi-search fs-3 d-block mb-1"></i>
                Không tìm thấy danh mục nào khớp với từ khóa tìm kiếm.
            </div>
        </div>
    </div>

    <!-- Modal Xem ảnh phóng to trực quan -->
    <div class="modal fade" id="imageModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content border-0 shadow">
                <div class="modal-header py-2">
                    <h6 class="modal-title fw-bold" id="imageModalTitle">Xem hình ảnh</h6>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body text-center p-3">
                    <img id="modalImgTag" src="" class="img-fluid rounded shadow-sm" style="max-height: 400px;" alt="Hình ảnh lớn" />
                </div>
            </div>
        </div>
    </div>

    <!-- Script tìm kiếm nhanh và phóng to ảnh -->
    <script>
        function filterCategoryTable() {
            const query = document.getElementById('liveSearchInput').value.toLowerCase().trim();
            const rows = document.querySelectorAll('#categoryTableBody tr.category-row');
            let matchCount = 0;

            rows.forEach(row => {
                const nameText = row.querySelector('.cat-name')?.textContent.toLowerCase() || '';
                if (nameText.includes(query)) {
                    row.style.display = '';
                    matchCount++;
                } else {
                    row.style.display = 'none';
                }
            });

            const noMatchDiv = document.getElementById('noSearchMatch');
            if (matchCount === 0 && rows.length > 0) {
                noMatchDiv.classList.remove('d-none');
            } else {
                noMatchDiv.classList.add('d-none');
            }
        }

        function showImageModal(src, title) {
            document.getElementById('modalImgTag').src = src;
            document.getElementById('imageModalTitle').textContent = title;
            const modal = new bootstrap.Modal(document.getElementById('imageModal'));
            modal.show();
        }
    </script>
</body>
</html>