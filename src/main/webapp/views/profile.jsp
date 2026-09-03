<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hồ Sơ Cá Nhân - Cập Nhật Profile</title>
</head>
<body>
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <!-- Thông báo kết quả -->
            <c:if test="${not empty message}">
                <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
                    <i class="bi bi-check-circle-fill me-2"></i>${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i>${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <div class="card shadow-sm border-0">
                <div class="card-header bg-dark text-white py-3">
                    <h5 class="card-title mb-0">
                        <i class="bi bi-person-badge me-2 text-warning"></i>Thông Tin Hồ Sơ Cá Nhân (JPA &amp; Multipart)
                    </h5>
                </div>
                <div class="card-body p-4">
                    <form action="${pageContext.request.contextPath}/profile" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                        <input type="hidden" name="id" value="${user.id}" />

                        <div class="row align-items-center mb-4">
                            <!-- Khung ảnh đại diện -->
                            <div class="col-md-4 text-center border-end pe-md-4 mb-3 mb-md-0">
                                <div class="position-relative d-inline-block">
                                    <c:choose>
                                        <c:when test="${user.images.startsWith('http')}">
                                            <img id="avatarPreview" src="${user.images}" 
                                                 class="rounded-circle img-thumbnail shadow-sm border border-2 border-primary" 
                                                 style="width: 140px; height: 140px; object-fit: cover;" alt="Avatar" />
                                        </c:when>
                                        <c:otherwise>
                                            <img id="avatarPreview" src="${pageContext.request.contextPath}/image?fname=${user.images}" 
                                                 class="rounded-circle img-thumbnail shadow-sm border border-2 border-primary" 
                                                 style="width: 140px; height: 140px; object-fit: cover;" alt="Avatar"
                                                 onerror="this.src='https://cdn-icons-png.flaticon.com/512/3135/3135715.png'" />
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <h6 class="mt-2 fw-bold">${user.fullname}</h6>
                                <span class="badge bg-primary">
                                    <i class="bi bi-shield-check me-1"></i>${user.role == 1 ? "Quản trị viên" : "Người dùng"}
                                </span>
                            </div>

                            <!-- Upload ảnh -->
                            <div class="col-md-8 ps-md-4">
                                <div class="mb-3">
                                    <label for="imageFile" class="form-label fw-bold">
                                        <i class="bi bi-upload me-1 text-primary"></i>Tải lên ảnh đại diện mới (Multipart File)
                                    </label>
                                    <input class="form-control" type="file" id="imageFile" name="imageFile" 
                                           accept="image/png, image/jpeg, image/gif, image/webp" onchange="previewImage(this);" />
                                    <div class="form-text">Hỗ trợ các định dạng: JPG, PNG, GIF, WEBP.</div>
                                </div>
                                <div class="mb-2">
                                    <label for="images" class="form-label fw-bold">
                                        <i class="bi bi-link-45deg me-1 text-primary"></i>Hoặc dán đường dẫn ảnh Online (URL)
                                    </label>
                                    <input type="url" class="form-control" id="images" name="images" 
                                           value="${user.images.startsWith('http') ? user.images : ''}" 
                                           placeholder="https://example.com/avatar.jpg" />
                                </div>
                            </div>
                        </div>

                        <hr class="my-4">

                        <!-- Thông tin chi tiết -->
                        <div class="row g-3">
                            <!-- Tên đăng nhập (Readonly) -->
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Tên đăng nhập</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light"><i class="bi bi-person"></i></span>
                                    <input type="text" class="form-control bg-light" value="${user.username}" readonly />
                                </div>
                            </div>

                            <!-- Email (Readonly) -->
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Email</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light"><i class="bi bi-envelope"></i></span>
                                    <input type="email" class="form-control bg-light" value="${user.email}" readonly />
                                </div>
                            </div>

                            <!-- Họ và tên (Cho phép sửa, có Validation) -->
                            <div class="col-md-6">
                                <label for="fullname" class="form-label fw-bold">
                                    Họ và tên <span class="text-danger">*</span>
                                </label>
                                <div class="input-group has-validation">
                                    <span class="input-group-text"><i class="bi bi-card-text"></i></span>
                                    <input type="text" class="form-control" id="fullname" name="fullname" 
                                           value="${user.fullname}" required minlength="2" maxlength="100" 
                                           placeholder="Nhập họ và tên..." />
                                    <div class="invalid-feedback">
                                        Vui lòng nhập họ và tên từ 2 đến 100 ký tự.
                                    </div>
                                </div>
                            </div>

                            <!-- Số điện thoại (Cho phép sửa, có Validation) -->
                            <div class="col-md-6">
                                <label for="phone" class="form-label fw-bold">
                                    Số điện thoại <span class="text-danger">*</span>
                                </label>
                                <div class="input-group has-validation">
                                    <span class="input-group-text"><i class="bi bi-telephone"></i></span>
                                    <input type="tel" class="form-control" id="phone" name="phone" 
                                           value="${user.phone}" required 
                                           pattern="^(0|\+84)[3|5|7|8|9][0-9]{8}$"
                                           placeholder="Ví dụ: 0912345678" />
                                    <div class="invalid-feedback">
                                        Vui lòng nhập số điện thoại hợp lệ (10 số, bắt đầu bằng 03, 05, 07, 08, 09).
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Action buttons -->
                        <div class="d-flex justify-content-between mt-4 pt-3 border-top">
                            <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-outline-secondary">
                                <i class="bi bi-arrow-left me-1"></i>Quay lại danh mục
                            </a>
                            <button type="submit" class="btn btn-primary px-4 fw-bold">
                                <i class="bi bi-check2-circle me-1"></i>Lưu Thay Đổi Profile
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Script xem trước ảnh khi chọn file và Form Validation -->
    <script>
        function previewImage(input) {
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('avatarPreview').src = e.target.result;
                }
                reader.readAsDataURL(input.files[0]);
            }
        }

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
