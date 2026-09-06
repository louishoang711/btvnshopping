<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa danh mục</title>
</head>
<body>
<div class="page-stack">
    <div class="page-heading">
        <div>
            <p class="page-kicker">Danh mục · CAT-${cate.categoryId}</p>
            <h1 class="page-title">Chỉnh sửa danh mục</h1>
            <p class="page-subtitle">Cập nhật tên, trạng thái và hình ảnh hiển thị.</p>
        </div>
    </div>

    <c:if test="${not empty error}"><div class="alert alert-error"><c:out value="${error}"/></div></c:if>

    <form id="categoryForm" action="${pageContext.request.contextPath}/admin/category/update" method="post" enctype="multipart/form-data" novalidate>
        <input type="hidden" name="categoryid" value="${cate.categoryId}">
        <div class="form-layout">
            <section class="panel">
                <div class="panel-header">
                    <div><h2 class="panel-title">Thông tin danh mục</h2><p class="panel-subtitle">Thay đổi sẽ có hiệu lực ngay sau khi lưu.</p></div>
                    <span class="status ${cate.status == 1 ? 'status-active' : 'status-paused'}">${cate.status == 1 ? 'Đang hoạt động' : 'Tạm khóa'}</span>
                </div>
                <div class="form-section">
                    <div class="form-grid">
                        <div class="field full">
                            <label for="categoryname">Tên danh mục * <span class="field-hint" id="charCount">0/200 ký tự</span></label>
                            <input class="form-control" id="categoryname" name="categoryname" type="text" value="<c:out value='${cate.categoryname}'/>" minlength="3" maxlength="200" required autocomplete="off">
                        </div>
                        <div class="field full">
                            <label>Trạng thái *</label>
                            <div class="choice-grid">
                                <div><input class="choice-input" type="radio" name="status" id="statusActive" value="1" ${cate.status == 1 ? 'checked' : ''}><label class="choice-card" for="statusActive"><span class="choice-radio"></span><span><span class="choice-title">Đang hoạt động</span><span class="choice-help">Hiển thị danh mục trong hệ thống</span></span></label></div>
                                <div><input class="choice-input" type="radio" name="status" id="statusPaused" value="0" ${cate.status == 0 ? 'checked' : ''}><label class="choice-card" for="statusPaused"><span class="choice-radio"></span><span><span class="choice-title">Tạm khóa</span><span class="choice-help">Ẩn danh mục để chỉnh sửa sau</span></span></label></div>
                            </div>
                        </div>
                        <div class="field full">
                            <label for="images1">Thay ảnh từ máy <span class="field-hint">Để trống nếu muốn giữ ảnh cũ</span></label>
                            <input class="form-control" id="images1" name="images1" type="file" accept="image/jpeg,image/png,image/webp,image/gif">
                        </div>
                        <div class="field full">
                            <label for="images">Hoặc thay bằng liên kết ảnh</label>
                            <input class="form-control" id="images" name="images" type="url" value="${not empty cate.images && cate.images.startsWith('http') ? cate.images : ''}" placeholder="https://example.com/image.jpg">
                        </div>
                    </div>
                </div>
                <div class="form-footer">
                    <a class="btn" href="${pageContext.request.contextPath}/admin/categories">← Quay lại</a>
                    <button class="btn btn-primary" type="submit">Lưu thay đổi →</button>
                </div>
            </section>

            <aside class="panel preview-card">
                <h2 class="panel-title">Ảnh danh mục</h2><p class="panel-subtitle" style="margin-bottom:14px">Ảnh hiện tại hoặc ảnh mới được chọn.</p>
                <div class="preview-frame">
                    <div class="preview-empty" id="previewEmpty" hidden>Không thể tải ảnh xem trước</div>
                    <c:choose>
                        <c:when test="${not empty cate.images && cate.images.startsWith('http')}"><img id="categoryImgPreview" src="${cate.images}" alt="Ảnh danh mục hiện tại"></c:when>
                        <c:otherwise><img id="categoryImgPreview" src="${pageContext.request.contextPath}/image?fname=${cate.images}" alt="Ảnh danh mục hiện tại"></c:otherwise>
                    </c:choose>
                </div>
                <p class="preview-note">Mã danh mục: <span class="mono">CAT-${cate.categoryId}</span><br>Khuyến nghị ảnh tỷ lệ 4:3, tối thiểu 800×600px.</p>
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
    fileInput.addEventListener('change', function () { if (fileInput.files && fileInput.files[0]) showPreview(URL.createObjectURL(fileInput.files[0])); });
    urlInput.addEventListener('input', function () { if (/^https?:\/\//i.test(urlInput.value.trim())) showPreview(urlInput.value.trim()); });
    preview.addEventListener('error', function () { preview.hidden = true; empty.hidden = false; });
    form.addEventListener('submit', function (event) { if (!form.checkValidity()) { event.preventDefault(); nameInput.focus(); } });
})();
</script>
</body>
</html>
