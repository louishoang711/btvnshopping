<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hồ Sơ Cá Nhân</title>
</head>
<body>
    <div class="row justify-content-center">
        <div class="col-lg-9">
            <!-- Thông báo kết quả -->
            <c:if test="${not empty message}">
                <div class="alert alert-success alert-dismissible fade show border-0 shadow-sm" role="alert">
                    <i class="bi bi-check-circle-fill me-2"></i>${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show border-0 shadow-sm" role="alert">
                    <i class="bi bi-exclamation-circle-fill me-2"></i>${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <div class="card shadow-sm border-0">
                <div class="card-header bg-white py-3 border-bottom">
                    <div class="d-flex align-items-center">
                        <div class="me-3 text-primary fs-4">
                            <i class="bi bi-person-bounding-box"></i>
                        </div>
                        <div>
                            <h5 class="card-title mb-0 fw-bold text-dark">Hồ Sơ Của Tôi</h5>
                            <small class="text-muted">Quản lý và cập nhật thông tin tài khoản cá nhân</small>
                        </div>
                    </div>
                </div>
                <div class="card-body p-4">
                    <form action="${pageContext.request.contextPath}/profile" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                        <input type="hidden" name="id" value="${user.id}" />

                        <div class="row g-4">
                            <!-- Cột Avatar -->
                            <div class="col-md-4 text-center border-end-md pb-3 pb-md-0">
                                <div class="mb-3">
                                    <c:choose>
                                        <c:when test="${user.images.startsWith('http')}">
                                            <img id="avatarPreview" src="${user.images}" 
                                                 class="rounded-circle border p-1 shadow-sm" 
                                                 style="width: 140px; height: 140px; object-fit: cover;" alt="Avatar" />
                                        </c:when>
                                        <c:otherwise>
                                            <img id="avatarPreview" src="${pageContext.request.contextPath}/image?fname=${user.images}" 
                                                 class="rounded-circle border p-1 shadow-sm" 
                                                 style="width: 140px; height: 140px; object-fit: cover;" alt="Avatar"
                                                 onerror="this.src='https://cdn-icons-png.flaticon.com/512/3135/3135715.png'" />
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="mb-2">
                                    <label for="imageFile" class="btn btn-sm btn-outline-primary px-3">
                                        <i class="bi bi-camera me-1"></i>Chọn ảnh mới
                                    </label>
                                    <input type="file" id="imageFile" name="imageFile" class="d-none"
                                           accept="image/*" onchange="previewImage(this);" />
                                </div>
                                <div class="text-muted small mb-2">Định dạng: JPG, PNG, WEBP (tối đa 10MB)</div>
                                <span class="badge bg-primary-subtle text-primary px-3 py-2 rounded-pill">
                                    <i class="bi bi-shield-check me-1"></i>${user.role == 1 ? "Quản trị viên" : "Thành viên"}
                                </span>
                            </div>

                            <!-- Cột Form thông tin -->
                            <div class="col-md-8 ps-md-4">
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label class="form-label text-muted small fw-semibold">TÊN ĐĂNG NHẬP</label>
                                        <input type="text" class="form-control bg-light" value="${user.username}" readonly />
                                    </div>

                                    <div class="col-md-6">
                                        <label class="form-label text-muted small fw-semibold">EMAIL</label>
                                        <input type="email" class="form-control bg-light" value="${user.email}" readonly />
                                    </div>

                                    <div class="col-12">
                                        <label for="fullname" class="form-label fw-semibold">
                                            Họ và tên <span class="text-danger">*</span>
                                        </label>
                                        <input type="text" class="form-control" id="fullname" name="fullname" 
                                               value="${user.fullname}" required minlength="2" maxlength="100" 
                                               placeholder="Nhập họ và tên đầy đủ..." />
                                        <div class="invalid-feedback">
                                            Vui lòng nhập họ và tên (tối thiểu 2 ký tự).
                                        </div>
                                    </div>

                                    <div class="col-12">
                                        <label for="phone" class="form-label fw-semibold">
                                            Số điện thoại <span class="text-danger">*</span>
                                        </label>
                                        <input type="tel" class="form-control" id="phone" name="phone" 
                                               value="${user.phone}" required 
                                               pattern="^(0|\+84)[3|5|7|8|9][0-9]{8}$"
                                               placeholder="Ví dụ: 0912345678" />
                                        <div class="invalid-feedback">
                                            Vui lòng nhập số điện thoại hợp lệ (10 chữ số).
                                        </div>
                                    </div>

                                    <div class="col-12">
                                        <label for="images" class="form-label text-muted small fw-semibold">HOẶC ĐƯỜNG DẪN ẢNH ONLINE</label>
                                        <input type="url" class="form-control form-control-sm" id="images" name="images" 
                                               value="${user.images.startsWith('http') ? user.images : ''}" 
                                               placeholder="https://example.com/avatar.jpg" />
                                    </div>
                                </div>

                                <div class="mt-4 pt-3 border-top d-flex justify-content-end gap-2">
                                    <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-light border">
                                        Hủy bỏ
                                    </a>
                                    <button type="submit" class="btn btn-primary px-4">
                                        <i class="bi bi-check2 me-1"></i>Lưu thay đổi
                                    </button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

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
