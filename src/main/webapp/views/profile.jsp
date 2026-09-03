<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hồ Sơ Cá Nhân</title>
    <style>
        .avatar-wrapper {
            position: relative;
            width: 140px;
            height: 140px;
            margin: 0 auto;
            border-radius: 50%;
            overflow: hidden;
            cursor: pointer;
        }
        .avatar-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: all 0.3s ease;
        }
        .avatar-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.45);
            color: #fff;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            opacity: 0;
            transition: opacity 0.3s ease;
            font-size: 0.8rem;
        }
        .avatar-wrapper:hover .avatar-overlay {
            opacity: 1;
        }
        .avatar-wrapper:hover .avatar-img {
            transform: scale(1.05);
        }
    </style>
</head>
<body>
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="mb-3">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/categories" class="text-decoration-none">Hệ thống</a></li>
            <li class="breadcrumb-item active" aria-current="page">Hồ sơ cá nhân</li>
        </ol>
    </nav>

    <div class="row justify-content-center">
        <div class="col-lg-9">
            <!-- Thông báo thành công / lỗi trực quan -->
            <c:if test="${not empty message}">
                <div class="alert alert-success alert-dismissible fade show border-0 shadow-sm d-flex align-items-center" role="alert">
                    <i class="bi bi-check-circle-fill fs-5 me-2 text-success"></i>
                    <div>${message}</div>
                    <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show border-0 shadow-sm d-flex align-items-center" role="alert">
                    <i class="bi bi-exclamation-triangle-fill fs-5 me-2 text-danger"></i>
                    <div>${error}</div>
                    <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <div class="card shadow-sm border-0">
                <div class="card-header bg-white py-3 border-bottom">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <h5 class="card-title mb-0 fw-bold text-dark">
                                <i class="bi bi-person-lines-fill me-2 text-primary"></i>Hồ Sơ Của Tôi
                            </h5>
                            <small class="text-muted">Quản lý và cập nhật thông tin tài khoản cá nhân của bạn</small>
                        </div>
                        <span class="badge bg-success-subtle text-success border border-success-subtle px-3 py-2 rounded-pill">
                            <i class="bi bi-patch-check-fill me-1"></i>Tài khoản đã kích hoạt
                        </span>
                    </div>
                </div>
                <div class="card-body p-4">
                    <form action="${pageContext.request.contextPath}/profile" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                        <input type="hidden" name="id" value="${user.id}" />

                        <div class="row g-4">
                            <!-- Cột Avatar trực quan -->
                            <div class="col-md-4 text-center border-end-md pb-3 pb-md-0">
                                <!-- Khung Avatar tương tác có Overlay -->
                                <div class="avatar-wrapper shadow-sm border border-2 border-primary-subtle mb-3" onclick="document.getElementById('imageFile').click();" title="Bấm vào đây để chọn ảnh mới từ máy tính">
                                    <c:choose>
                                        <c:when test="${user.images.startsWith('http')}">
                                            <img id="avatarPreview" src="${user.images}" class="avatar-img" alt="Avatar" />
                                        </c:when>
                                        <c:otherwise>
                                            <img id="avatarPreview" src="${pageContext.request.contextPath}/image?fname=${user.images}" 
                                                 class="avatar-img" alt="Avatar"
                                                 onerror="this.src='https://cdn-icons-png.flaticon.com/512/3135/3135715.png'" />
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="avatar-overlay">
                                        <i class="bi bi-camera-fill fs-4 mb-1"></i>
                                        <span>Đổi ảnh</span>
                                    </div>
                                </div>

                                <input type="file" id="imageFile" name="imageFile" class="d-none"
                                       accept="image/*" onchange="previewImage(this);" />

                                <button type="button" class="btn btn-sm btn-outline-primary rounded-pill px-3 mb-2" onclick="document.getElementById('imageFile').click();">
                                    <i class="bi bi-upload me-1"></i>Chọn ảnh từ máy
                                </button>
                                <div class="text-muted small mb-3">Hỗ trợ JPG, PNG, WEBP (tối đa 10MB)</div>

                                <!-- Thẻ trạng thái tài khoản -->
                                <div class="p-3 bg-light rounded-3 text-start">
                                    <div class="small text-muted mb-1">VAI TRÒ HỆ THỐNG</div>
                                    <div class="fw-bold text-dark d-flex align-items-center gap-1">
                                        <i class="bi bi-shield-lock-fill text-primary"></i>
                                        <span>${user.role == 1 ? "Quản trị viên (Admin)" : "Người dùng"}</span>
                                    </div>
                                    <hr class="my-2">
                                    <div class="small text-muted mb-1">TRẠNG THÁI</div>
                                    <div class="text-success fw-semibold small">
                                        <i class="bi bi-circle-fill text-success" style="font-size: 8px;"></i> Đang hoạt động bình thường
                                    </div>
                                </div>
                            </div>

                            <!-- Cột Form nhập liệu -->
                            <div class="col-md-8 ps-md-4">
                                <div class="row g-3">
                                    <!-- Tên đăng nhập -->
                                    <div class="col-md-6">
                                        <label class="form-label text-muted small fw-semibold">TÊN ĐĂNG NHẬP</label>
                                        <div class="input-group">
                                            <span class="input-group-text bg-light text-muted"><i class="bi bi-person"></i></span>
                                            <input type="text" class="form-control bg-light" value="${user.username}" readonly />
                                        </div>
                                    </div>

                                    <!-- Email -->
                                    <div class="col-md-6">
                                        <label class="form-label text-muted small fw-semibold">EMAIL</label>
                                        <div class="input-group">
                                            <span class="input-group-text bg-light text-muted"><i class="bi bi-envelope"></i></span>
                                            <input type="email" class="form-control bg-light" value="${user.email}" readonly />
                                        </div>
                                    </div>

                                    <!-- Họ và tên (Cho phép sửa) -->
                                    <div class="col-12">
                                        <label for="fullname" class="form-label fw-semibold">
                                            Họ và tên <span class="text-danger">*</span>
                                        </label>
                                        <div class="input-group has-validation">
                                            <span class="input-group-text"><i class="bi bi-card-text"></i></span>
                                            <input type="text" class="form-control" id="fullname" name="fullname" 
                                                   value="${user.fullname}" required minlength="2" maxlength="100" 
                                                   placeholder="Nhập họ và tên đầy đủ..." />
                                            <div class="invalid-feedback">
                                                Vui lòng nhập họ và tên (tối thiểu 2 ký tự).
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Số điện thoại (Cho phép sửa) -->
                                    <div class="col-12">
                                        <label for="phone" class="form-label fw-semibold">
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

                                    <!-- Hoặc URL ảnh online -->
                                    <div class="col-12">
                                        <label for="images" class="form-label text-muted small fw-semibold">HOẶC LIÊN KẾT ẢNH ONLINE (URL)</label>
                                        <input type="url" class="form-control form-control-sm" id="images" name="images" 
                                               value="${user.images.startsWith('http') ? user.images : ''}" 
                                               placeholder="https://example.com/avatar.jpg"
                                               oninput="if(this.value.startsWith('http')) document.getElementById('avatarPreview').src = this.value;" />
                                    </div>
                                </div>

                                <!-- Nút bấm hành động -->
                                <div class="mt-4 pt-3 border-top d-flex justify-content-end gap-2">
                                    <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-light border px-3">
                                        Quay lại
                                    </a>
                                    <button type="submit" class="btn btn-primary px-4 fw-semibold shadow-xs">
                                        <i class="bi bi-check2-circle me-1"></i>Lưu thay đổi thông tin
                                    </button>
                                </div>
                            </div>
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
