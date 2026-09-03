<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm Danh Mục Mới</title>
</head>
<body>
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="mb-3">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/categories" class="text-decoration-none">Danh mục</a></li>
            <li class="breadcrumb-item active" aria-current="page">Thêm mới</li>
        </ol>
    </nav>

    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-white py-3 border-bottom d-flex align-items-center justify-content-between">
                    <div>
                        <h5 class="card-title mb-0 fw-bold text-dark">
                            <i class="bi bi-folder-plus me-2 text-primary"></i>Thêm Mới Danh Mục
                        </h5>
                        <small class="text-muted">Nhập thông tin chi tiết và tải hình ảnh đại diện cho danh mục</small>
                    </div>
                </div>
                <div class="card-body p-4">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show border-0 shadow-sm" role="alert">
                            <i class="bi bi-exclamation-circle me-2"></i>${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/admin/category/insert" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                        <!-- Tên danh mục -->
                        <div class="mb-4">
                            <div class="d-flex justify-content-between align-items-center mb-1">
                                <label for="categoryname" class="form-label fw-semibold mb-0">Tên danh mục <span class="text-danger">*</span></label>
                                <span class="text-muted small" id="charCount">0/200 ký tự</span>
                            </div>
                            <input type="text" class="form-control" id="categoryname" name="categoryname" 
                                   placeholder="Ví dụ: Thiết bị di động, Thời trang nam, Đồ gia dụng..."
                                   required minlength="3" maxlength="200" value="${categoryname}" 
                                   oninput="updateCharCount(this);" />
                            <div class="invalid-feedback">
                                Vui lòng nhập tên danh mục hợp lệ (từ 3 đến 200 ký tự).
                            </div>
                        </div>

                        <!-- Khu vực hình ảnh trực quan (Interactive Upload & Preview) -->
                        <div class="mb-4 p-3 bg-light rounded-3 border">
                            <label class="form-label fw-semibold d-block">Hình ảnh danh mục</label>
                            
                            <div class="row align-items-center g-3">
                                <!-- Hộp xem trước trực quan -->
                                <div class="col-sm-4 text-center">
                                    <div class="position-relative border rounded-3 bg-white p-2 d-inline-block shadow-2xs">
                                        <img id="categoryImgPreview" src="https://via.placeholder.com/150x110?text=Xem+tr%C6%B0%E1%BB%9Bc+%E1%BA%A3nh" 
                                             class="rounded img-fluid" style="width: 140px; height: 100px; object-fit: cover;" alt="Xem trước" />
                                    </div>
                                    <div class="small text-muted mt-1">Ảnh xem trước</div>
                                </div>

                                <!-- Các lựa chọn tải ảnh -->
                                <div class="col-sm-8">
                                    <div class="mb-2">
                                        <label for="images1" class="form-label small fw-semibold text-muted mb-1">TẢI FILE TỪ MÁY TÍNH</label>
                                        <input class="form-control" type="file" id="images1" name="images1" accept="image/*" onchange="previewUploadFile(this);" />
                                    </div>
                                    <div>
                                        <label for="images" class="form-label small fw-semibold text-muted mb-1">HOẶC DÁN LINK ẢNH ONLINE</label>
                                        <input type="url" class="form-control" id="images" name="images" 
                                               placeholder="https://..." oninput="previewUrlImage(this.value);" />
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Trạng thái (Thẻ chọn trực quan) -->
                        <div class="mb-4">
                            <label class="form-label fw-semibold d-block">Trạng thái danh mục</label>
                            <div class="row g-2">
                                <div class="col-sm-6">
                                    <input type="radio" class="btn-check" name="status" id="statusActive" value="1" checked>
                                    <label class="btn btn-outline-success w-100 py-2 d-flex align-items-center justify-content-center gap-2" for="statusActive">
                                        <i class="bi bi-check-circle-fill"></i>
                                        <span>Đang hoạt động</span>
                                    </label>
                                </div>
                                <div class="col-sm-6">
                                    <input type="radio" class="btn-check" name="status" id="statusLocked" value="0">
                                    <label class="btn btn-outline-secondary w-100 py-2 d-flex align-items-center justify-content-center gap-2" for="statusLocked">
                                        <i class="bi bi-lock-fill"></i>
                                        <span>Tạm khóa</span>
                                    </label>
                                </div>
                            </div>
                        </div>

                        <!-- Nút bấm -->
                        <div class="d-flex justify-content-between pt-3 border-top">
                            <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-light border px-3">
                                <i class="bi bi-arrow-left me-1"></i>Quay lại danh sách
                            </a>
                            <button type="submit" class="btn btn-primary px-4 fw-semibold">
                                <i class="bi bi-check2-circle me-1"></i>Lưu danh mục
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Script đếm ký tự & xem trước ảnh trực quan -->
    <script>
        function updateCharCount(input) {
            document.getElementById('charCount').textContent = input.value.length + '/200 ký tự';
        }

        function previewUploadFile(input) {
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('categoryImgPreview').src = e.target.result;
                };
                reader.readAsDataURL(input.files[0]);
            }
        }

        function previewUrlImage(url) {
            if (url && url.trim().startsWith('http')) {
                document.getElementById('categoryImgPreview').src = url.trim();
            }
        }

        // Bootstrap form validation
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