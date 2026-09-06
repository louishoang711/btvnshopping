<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm danh mục</title>
</head>
<body>
<div class="page-stack">
    <div class="page-heading">
        <div>
            <p class="page-kicker">Quản lý danh mục</p>
            <h1 class="page-title">Tạo danh mục mới</h1>
            <p class="page-subtitle">Thêm một nhóm sản phẩm mới vào hệ thống cửa hàng.</p>
        </div>
    </div>

    <c:if test="${not empty error}"><div class="alert alert-error"><c:out value="${error}"/></div></c:if>

    <form id="categoryForm" action="${pageContext.request.contextPath}/admin/category/insert" method="post" enctype="multipart/form-data" novalidate>
        <div class="form-layout">
            <section class="panel">
                <div class="panel-header"><div><h2 class="panel-title">Thông tin danh mục</h2><p class="panel-subtitle">Các trường có dấu * là bắt buộc.</p></div><span class="status status-warning">Bản nháp mới</span></div>
                <div class="form-section">
                    <div class="form-grid">
                        <div class="field full">
                            <label for="categoryname">Tên danh mục * <span class="field-hint" id="charCount">0/200 ký tự</span></label>
                            <input class="form-control" id="categoryname" name="categoryname" type="text" value="<c:out value='${categoryname}'/>" minlength="3" maxlength="200" placeholder="Ví dụ: Thiết bị điện tử" required autocomplete="off">
                            <span class="field-hint">Tên rõ ràng giúp khách hàng tìm sản phẩm nhanh hơn.</span>
                        </div>
                        <div class="field full">
                            <label>Trạng thái *</label>
                            <div class="choice-grid">
                                <div><input class="choice-input" type="radio" name="status" id="statusActive" value="1" checked><label class="choice-card" for="statusActive"><span class="choice-radio"></span><span><span class="choice-title">Đang hoạt động</span><span class="choice-help">Hiển thị danh mục trong hệ thống</span></span></label></div>
                                <div><input class="choice-input" type="radio" name="status" id="statusPaused" value="0"><label class="choice-card" for="statusPaused"><span class="choice-radio"></span><span><span class="choice-title">Tạm khóa</span><span class="choice-help">Ẩn danh mục để hoàn thiện sau</span></span></label></div>
                            </div>
                        </div>
                        <div class="field full">
                            <label for="images1">Tải ảnh từ máy <span class="field-hint">JPG, PNG hoặc WEBP</span></label>
                            <input class="form-control" id="images1" name="images1" type="file" accept="image/jpeg,image/png,image/webp,image/gif">
                        </div>
                        <div class="field full">
                            <label for="images">Hoặc liên kết ảnh</label>
                            <input class="form-control" id="images" name="images" type="url" placeholder="https://example.com/image.jpg">
                        </div>
                    </div>
                </div>
                <div class="form-footer">
                    <a class="btn" href="${pageContext.request.contextPath}/admin/categories">← Quay lại</a>
                    <button class="btn btn-primary" type="submit">Tạo danh mục →</button>
                </div>
            </section>

            <aside class="panel preview-card">
                <h2 class="panel-title">Xem trước</h2><p class="panel-subtitle" style="margin-bottom:14px">Ảnh sẽ hiển thị theo tỷ lệ 4:3.</p>
                <div class="preview-frame">
                    <div class="preview-empty" id="previewEmpty">
                        <svg width="28" height="28" viewBox="0 0 32 32" fill="none"><rect x="4" y="6" width="24" height="20" rx="3" stroke="currentColor"/><circle cx="12" cy="13" r="2.5" stroke="currentColor"/><path d="m7 23 6-6 4 4 3-3 5 5" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/></svg>
                        Chọn tệp hoặc dán URL<br>để xem trước hình ảnh
                    </div>
                    <img id="categoryImgPreview" alt="Ảnh xem trước" hidden>
                </div>
                <p class="preview-note">Khuyến nghị ảnh tối thiểu 800×600px, dung lượng dưới 5MB để tải trang nhanh.</p>
            </aside>
        </div>
    </form>
</div>

<script>
(function () {
    const form = document.getElementById('categoryForm');
    const nameInput = document.getElementById('categoryname');
    const count = document.getElementById('charCount');
    const fileInput = document.getElementById('images1');
    const urlInput = document.getElementById('images');
    const preview = document.getElementById('categoryImgPreview');
    const empty = document.getElementById('previewEmpty');

    function updateCount() { count.textContent = nameInput.value.length + '/200 ký tự'; }
    function showPreview(src) { preview.src = src; preview.hidden = false; empty.hidden = true; }
    updateCount();
    nameInput.addEventListener('input', updateCount);
    fileInput.addEventListener('change', function () {
        if (fileInput.files && fileInput.files[0]) showPreview(URL.createObjectURL(fileInput.files[0]));
    });
    urlInput.addEventListener('input', function () { if (/^https?:\/\//i.test(urlInput.value.trim())) showPreview(urlInput.value.trim()); });
    preview.addEventListener('error', function () { preview.hidden = true; empty.hidden = false; });
    form.addEventListener('submit', function (event) {
        if (!form.checkValidity()) { event.preventDefault(); nameInput.focus(); }
    });
})();
</script>
</body>
</html>
