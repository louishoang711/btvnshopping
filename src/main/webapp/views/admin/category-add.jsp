<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm Danh Mục Mới</title>
</head>
<body>
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-primary text-white py-3">
                    <h5 class="card-title mb-0">
                        <i class="bi bi-folder-plus me-2"></i>Thêm Mới Danh Mục
                    </h5>
                </div>
                <div class="card-body p-4">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i>${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/admin/category/insert" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                        <!-- Tên danh mục -->
                        <div class="mb-3">
                            <label for="categoryname" class="form-label fw-bold">Tên danh mục <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="categoryname" name="categoryname" 
                                   placeholder="Nhập tên danh mục (ví dụ: Điện thoại, Laptop...)"
                                   required minlength="3" maxlength="200" value="${categoryname}" />
                            <div class="invalid-feedback">
                                Vui lòng nhập tên danh mục từ 3 đến 200 ký tự.
                            </div>
                        </div>

                        <!-- Upload file hình ảnh -->
                        <div class="mb-3">
                            <label for="images1" class="form-label fw-bold">Upload hình ảnh (Tệp ảnh)</label>
                            <input class="form-control" type="file" id="images1" name="images1" accept="image/png, image/jpeg, image/gif, image/webp" />
                            <div class="form-text">Hỗ trợ định dạng: JPG, PNG, GIF, WEBP.</div>
                        </div>

                        <!-- Hoặc link ảnh -->
                        <div class="mb-3">
                            <label for="images" class="form-label fw-bold">Hoặc đường dẫn ảnh online (URL)</label>
                            <input type="url" class="form-control" id="images" name="images" 
                                   placeholder="https://example.com/image.jpg" />
                            <div class="invalid-feedback">
                                Vui lòng nhập đúng định dạng URL (bắt đầu bằng http:// hoặc https://).
                            </div>
                        </div>

                        <!-- Trạng thái -->
                        <div class="mb-4">
                            <label for="status" class="form-label fw-bold">Trạng thái <span class="text-danger">*</span></label>
                            <select class="form-select" id="status" name="status" required>
                                <option value="1" selected>Hoạt động</option>
                                <option value="0">Khóa</option>
                            </select>
                            <div class="invalid-feedback">
                                Vui lòng chọn trạng thái.
                            </div>
                        </div>

                        <!-- Nút bấm -->
                        <div class="d-flex justify-content-between">
                            <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-secondary">
                                <i class="bi bi-arrow-left me-1"></i>Quay lại danh sách
                            </a>
                            <button type="submit" class="btn btn-primary px-4">
                                <i class="bi bi-check-circle me-1"></i>Lưu lại
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Client-side Bootstrap Form Validation Script -->
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