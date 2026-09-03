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
        <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
            <h4 class="mb-0 text-primary fw-bold">
                <i class="bi bi-tags-fill me-2"></i>Quản Lý Danh Mục (JPA 3.0 &amp; Hibernate)
            </h4>
            <a href="${pageContext.request.contextPath}/admin/category/add" class="btn btn-success">
                <i class="bi bi-plus-lg me-1"></i>Thêm Danh Mục Mới
            </a>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover table-striped align-middle mb-0">
                    <thead class="table-dark">
                        <tr>
                            <th class="text-center" style="width: 80px;">ID</th>
                            <th class="text-center" style="width: 140px;">Hình ảnh</th>
                            <th>Tên danh mục</th>
                            <th class="text-center" style="width: 140px;">Trạng thái</th>
                            <th class="text-center" style="width: 160px;">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty listcate}">
                                <tr>
                                    <td colspan="5" class="text-center py-4 text-muted">
                                        <i class="bi bi-inbox fs-3 d-block mb-2"></i>
                                        Chưa có danh mục nào. Hãy nhấn "Thêm Danh Mục Mới" để tạo!
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${listcate}" var="cate">
                                    <tr>
                                        <td class="text-center fw-bold">${cate.categoryId}</td>
                                        <td class="text-center">
                                            <c:choose>
                                                <c:when test="${cate.images.startsWith('http')}">
                                                    <img src="${cate.images}" class="rounded border" style="width: 80px; height: 60px; object-fit: cover;" alt="${cate.categoryname}" />
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${pageContext.request.contextPath}/image?fname=${cate.images}" class="rounded border" style="width: 80px; height: 60px; object-fit: cover;" alt="${cate.categoryname}" onerror="this.src='https://via.placeholder.com/80x60?text=No+Img'" />
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="fw-semibold">${cate.categoryname}</td>
                                        <td class="text-center">
                                            <c:choose>
                                                <c:when test="${cate.status == 1}">
                                                    <span class="badge bg-success-subtle text-success border border-success-subtle px-3 py-2">
                                                        <i class="bi bi-check-circle me-1"></i>Hoạt động
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-danger-subtle text-danger border border-danger-subtle px-3 py-2">
                                                        <i class="bi bi-slash-circle me-1"></i>Khóa
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-center">
                                            <div class="btn-group btn-group-sm">
                                                <a href="${pageContext.request.contextPath}/admin/category/edit?id=${cate.categoryId}" class="btn btn-outline-primary" title="Chỉnh sửa">
                                                    <i class="bi bi-pencil"></i> Sửa
                                                </a>
                                                <a href="${pageContext.request.contextPath}/admin/category/delete?id=${cate.categoryId}" class="btn btn-outline-danger" title="Xóa" onclick="return confirm('Bạn có chắc muốn xóa danh mục [${cate.categoryname}]?')">
                                                    <i class="bi bi-trash"></i> Xóa
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
        </div>
    </div>
</body>
</html>