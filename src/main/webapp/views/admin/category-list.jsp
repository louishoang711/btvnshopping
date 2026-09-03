<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh Sách Danh Mục</title>
</head>
<body>
    <div class="card shadow-sm border-0">
        <div class="card-header bg-white py-3 d-flex flex-wrap justify-content-between align-items-center gap-2">
            <div>
                <h5 class="mb-0 fw-bold text-dark">
                    <i class="bi bi-folder2-open me-2 text-primary"></i>Danh Sách Danh Mục Sản Phẩm
                </h5>
                <small class="text-muted">Quản lý và cập nhật các danh mục bán hàng</small>
            </div>
            <a href="${pageContext.request.contextPath}/admin/category/add" class="btn btn-primary">
                <i class="bi bi-plus-lg me-1"></i>Thêm danh mục mới
            </a>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th class="text-center text-muted" style="width: 70px;">#</th>
                            <th class="text-center" style="width: 120px;">Hình ảnh</th>
                            <th>Tên danh mục</th>
                            <th class="text-center" style="width: 140px;">Trạng thái</th>
                            <th class="text-center" style="width: 160px;">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty listcate}">
                                <tr>
                                    <td colspan="5" class="text-center py-5 text-muted">
                                        <i class="bi bi-box-seam fs-1 d-block text-secondary mb-2"></i>
                                        Hiện chưa có danh mục nào trong hệ thống.
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${listcate}" var="cate">
                                    <tr>
                                        <td class="text-center text-muted fw-semibold">${cate.categoryId}</td>
                                        <td class="text-center">
                                            <c:choose>
                                                <c:when test="${cate.images.startsWith('http')}">
                                                    <img src="${cate.images}" class="rounded border" style="width: 65px; height: 50px; object-fit: cover;" alt="${cate.categoryname}" />
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${pageContext.request.contextPath}/image?fname=${cate.images}" class="rounded border" style="width: 65px; height: 50px; object-fit: cover;" alt="${cate.categoryname}" onerror="this.src='https://via.placeholder.com/65x50?text=No+Img'" />
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <span class="fw-semibold text-dark">${cate.categoryname}</span>
                                        </td>
                                        <td class="text-center">
                                            <c:choose>
                                                <c:when test="${cate.status == 1}">
                                                    <span class="badge bg-success-subtle text-success px-2 py-1 rounded-pill">
                                                        <i class="bi bi-dot"></i>Hoạt động
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary-subtle text-secondary px-2 py-1 rounded-pill">
                                                        <i class="bi bi-dot"></i>Tạm khóa
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-center">
                                            <a href="${pageContext.request.contextPath}/admin/category/edit?id=${cate.categoryId}" class="btn btn-sm btn-outline-primary me-1" title="Chỉnh sửa">
                                                <i class="bi bi-pencil-square me-1"></i>Sửa
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin/category/delete?id=${cate.categoryId}" class="btn btn-sm btn-outline-danger" title="Xóa" onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục [${cate.categoryname}]?')">
                                                <i class="bi bi-trash me-1"></i>Xóa
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>