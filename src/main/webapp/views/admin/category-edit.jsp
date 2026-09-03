<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Cập Nhật Danh Mục</title>
</head>
<body>
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-white py-3 border-bottom">
                    <h5 class="card-title mb-0 fw-bold text-dark">
                        <i class="bi bi-pencil-square me-2 text-primary"></i>Cập Nhật Danh Mục
                    </h5>
                </div>
                <div class="card-body p-4">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="bi bi-exclamation-circle me-2"></i>${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/admin/category/update" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                        <input type="hidden" name="categoryid" value="${cate.categoryId}" />

                        <!-- Tên danh mục -->
                        <div class="mb-3">
                            <label for="categoryname" class="form-label fw-semibold">Tên danh mục <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="categoryname" name="categoryname" 
                                   value="${cate.categoryname}" required minlength="3" maxlength="200" />
                            <div class="invalid-feedback">
                                Vui lòng nhập tên danh mục (từ 3 đến 200 ký tự).
                            </div>
                        </div>

                        <!-- Ảnh hiện tại -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Ảnh hiện tại</label>
                            <div class="p-2 border rounded bg-light text-center">
                                <c:choose>
                                    <c:when test="${cate.images.startsWith('http')}">
                                        <img src="${cate.images}" class="rounded border" style="max-height: 100px; object-fit: cover;" alt="${cate.categoryname}" />
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/image?fname=${cate.images}" class="rounded border" style="max-height: 100px; object-fit: cover;" alt="${cate.categoryname}" onerror="this.src='https://via.placeholder.com/100?text=No+Image'" />
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <!-- Tải ảnh mới -->
                        <div class="mb-3">
                            <label for="images1" class="form-label fw-semibold">Tải ảnh mới thay thế</label>
                            <input class="form-control" type="file" id="images1" name="images1" accept="image/*" />
                            <div class="form-text text-muted">Bỏ trống nếu muốn giữ nguyên ảnh hiện tại.</div>
                        </div>

                        <!-- Hoặc link ảnh -->
                        <div class="mb-3">
                            <label for="images" class="form-label fw-semibold">Hoặc đường dẫn ảnh mới</label>
                            <input type="url" class="form-control" id="images" name="images" 
                                   value="${cate.images}" placeholder="https://example.com/anh.jpg" />
                        </div>

                        <!-- Trạng thái -->
                        <div class="mb-4">
                            <label for="status" class="form-label fw-semibold">Trạng thái</label>
                            <select class="form-select" id="status" name="status">
                                <option value="1" ${cate.status == 1 ? "selected" : ""}>Đang hoạt động</option>
                                <option value="0" ${cate.status == 0 ? "selected" : ""}>Tạm khóa</option>
                            </select>
                        </div>

                        <!-- Nút bấm -->
                        <div class="d-flex justify-content-between pt-2 border-top">
                            <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-light border">
                                <i class="bi bi-arrow-left me-1"></i>Quay lại
                            </a>
                            <button type="submit" class="btn btn-primary px-4">
                                <i class="bi bi-check2 me-1"></i>Cập nhật
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        (() => {
            'use strict';
            const forms = document.querySelectorAll('.needs-validation');
            Array.from(forms).forEach(form => {
                form.addEventListener('submit', event => {
                    if (!form.checkValidity()) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    form.classList.add('was-validated');
                }, false);
            });
        })();
    </script>
</body>
</html>