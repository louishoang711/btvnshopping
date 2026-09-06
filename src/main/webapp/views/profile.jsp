<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hồ sơ cá nhân</title>
</head>
<body>
<div class="page-stack">
    <div class="page-heading">
        <div>
            <p class="page-kicker">Tài khoản quản trị</p>
            <h1 class="page-title">Hồ sơ cá nhân</h1>
            <p class="page-subtitle">Quản lý thông tin liên hệ và ảnh đại diện của bạn.</p>
        </div>
    </div>

    <c:if test="${not empty message}"><div class="alert alert-success"><c:out value="${message}"/></div></c:if>
    <c:if test="${not empty error}"><div class="alert alert-error"><c:out value="${error}"/></div></c:if>

    <form id="profileForm" action="${pageContext.request.contextPath}/profile" method="post" enctype="multipart/form-data" novalidate>
        <input type="hidden" name="id" value="${user.id}">

        <section class="panel profile-hero">
            <div class="profile-summary">
                <div class="avatar-wrap" id="avatarTrigger" title="Chọn ảnh đại diện mới">
                    <div class="avatar-img avatar-fallback" id="avatarFallback">AD</div>
                    <c:choose>
                        <c:when test="${not empty user.images && user.images.startsWith('http')}"><img class="avatar-img" id="avatarPreview" src="${user.images}" alt="Ảnh đại diện"></c:when>
                        <c:when test="${not empty user.images}"><img class="avatar-img" id="avatarPreview" src="${pageContext.request.contextPath}/image?fname=${user.images}" alt="Ảnh đại diện"></c:when>
                    </c:choose>
                    <span class="avatar-edit" aria-hidden="true">
                        <svg width="11" height="11" viewBox="0 0 16 16" fill="none"><path d="M3 5h2l1-2h4l1 2h2v8H3V5Z" stroke="currentColor" stroke-width="1.4"/><circle cx="8" cy="9" r="2.3" stroke="currentColor" stroke-width="1.4"/></svg>
                    </span>
                </div>
                <div>
                    <h2 class="profile-name"><c:out value="${user.fullname}"/></h2>
                    <p class="profile-email"><c:out value="${user.email}"/></p>
                    <div class="profile-badges"><span class="status status-active">Đang hoạt động</span><span class="status status-warning">${user.role == 1 ? 'Quản trị viên' : 'Người dùng'}</span></div>
                </div>
            </div>
            <button class="btn btn-primary" type="submit">Lưu hồ sơ →</button>
        </section>

        <div class="profile-columns">
            <section class="panel">
                <div class="panel-header"><div><h2 class="panel-title">Thông tin cá nhân</h2><p class="panel-subtitle">Thông tin được sử dụng trong hệ thống quản trị.</p></div></div>
                <div class="form-section">
                    <div class="form-grid">
                        <div class="field">
                            <label for="username">Tên đăng nhập</label>
                            <input class="form-control mono" id="username" type="text" value="<c:out value='${user.username}'/>" readonly>
                        </div>
                        <div class="field">
                            <label for="email">Email</label>
                            <input class="form-control" id="email" type="email" value="<c:out value='${user.email}'/>" readonly>
                        </div>
                        <div class="field">
                            <label for="fullname">Họ và tên *</label>
                            <input class="form-control" id="fullname" name="fullname" type="text" value="<c:out value='${user.fullname}'/>" minlength="2" maxlength="100" required autocomplete="name">
                        </div>
                        <div class="field">
                            <label for="phone">Số điện thoại *</label>
                            <input class="form-control mono" id="phone" name="phone" type="tel" value="<c:out value='${user.phone}'/>" pattern="^(0|\+84)[35789][0-9]{8}$" placeholder="0912345678" required autocomplete="tel">
                        </div>
                        <div class="field full">
                            <label for="imageFile">Ảnh đại diện mới <span class="field-hint">JPG, PNG, GIF hoặc WEBP · tối đa 10MB</span></label>
                            <input class="form-control" id="imageFile" name="imageFile" type="file" accept="image/jpeg,image/png,image/gif,image/webp">
                        </div>
                        <div class="field full">
                            <label for="images">Hoặc liên kết ảnh online</label>
                            <input class="form-control" id="images" name="images" type="url" value="${not empty user.images && user.images.startsWith('http') ? user.images : ''}" placeholder="https://example.com/avatar.jpg">
                        </div>
                    </div>
                </div>
                <div class="form-footer"><span class="field-hint">Cập nhật gần nhất: hôm nay</span><button class="btn btn-primary" type="submit">Lưu thay đổi →</button></div>
            </section>

            <aside class="panel">
                <div class="panel-header"><div><h2 class="panel-title">Tài khoản</h2><p class="panel-subtitle">Quyền truy cập hiện tại.</p></div></div>
                <div class="account-list">
                    <div class="account-row"><span class="account-label">Mã người dùng</span><span class="account-value mono">USR-${user.id}</span></div>
                    <div class="account-row"><span class="account-label">Vai trò</span><span class="account-value">${user.role == 1 ? 'Administrator' : 'User'}</span></div>
                    <div class="account-row"><span class="account-label">Quản lý danh mục</span><span class="status status-active">Được cấp</span></div>
                    <div class="account-row"><span class="account-label">Quản lý hồ sơ</span><span class="status status-active">Được cấp</span></div>
                    <div class="account-row"><span class="account-label">Phiên đăng nhập</span><span class="account-value">Thiết bị hiện tại</span></div>
                </div>
            </aside>
        </div>
    </form>
</div>

<script>
(function () {
    const form = document.getElementById('profileForm');
    const file = document.getElementById('imageFile');
    const url = document.getElementById('images');
    const trigger = document.getElementById('avatarTrigger');
    const fallback = document.getElementById('avatarFallback');
    let preview = document.getElementById('avatarPreview');

    function showPreview(src) {
        if (!preview) {
            preview = document.createElement('img');
            preview.id = 'avatarPreview'; preview.className = 'avatar-img'; preview.alt = 'Ảnh đại diện';
            trigger.insertBefore(preview, trigger.querySelector('.avatar-edit'));
        }
        preview.src = src; preview.hidden = false; fallback.hidden = true;
        preview.onerror = function () { preview.hidden = true; fallback.hidden = false; };
    }

    if (preview) { fallback.hidden = true; preview.onerror = function () { preview.hidden = true; fallback.hidden = false; }; }
    trigger.addEventListener('click', function () { file.click(); });
    file.addEventListener('change', function () { if (file.files && file.files[0]) showPreview(URL.createObjectURL(file.files[0])); });
    url.addEventListener('input', function () { if (/^https?:\/\//i.test(url.value.trim())) showPreview(url.value.trim()); });
    form.addEventListener('submit', function (event) {
        if (!form.checkValidity()) { event.preventDefault(); form.querySelector(':invalid').focus(); }
    });
})();
</script>
</body>
</html>
