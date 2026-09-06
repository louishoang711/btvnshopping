<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh mục sản phẩm</title>
</head>
<body>
<c:set var="totalCount" value="${empty listcate ? 0 : listcate.size()}"/>
<c:set var="activeCount" value="0"/>
<c:set var="pausedCount" value="0"/>
<c:forEach items="${listcate}" var="item">
    <c:choose>
        <c:when test="${item.status == 1}"><c:set var="activeCount" value="${activeCount + 1}"/></c:when>
        <c:otherwise><c:set var="pausedCount" value="${pausedCount + 1}"/></c:otherwise>
    </c:choose>
</c:forEach>

<div class="page-stack">
    <c:if test="${not empty sessionScope.adminMessage}"><div class="alert alert-success"><c:out value="${sessionScope.adminMessage}"/></div><c:remove var="adminMessage" scope="session"/></c:if>
    <c:if test="${not empty sessionScope.adminError}"><div class="alert alert-error"><c:out value="${sessionScope.adminError}"/></div><c:remove var="adminError" scope="session"/></c:if>
    <div class="page-heading">
        <div>
            <p class="page-kicker">Quản lý kho hàng</p>
            <h1 class="page-title">Danh mục sản phẩm</h1>
            <p class="page-subtitle">Theo dõi, cập nhật và sắp xếp các nhóm sản phẩm trong cửa hàng.</p>
        </div>
        <a class="btn btn-primary" href="${pageContext.request.contextPath}/admin/category/add">
            <svg width="13" height="13" viewBox="0 0 16 16" fill="none"><path d="M8 3v10M3 8h10" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"/></svg>
            Thêm danh mục
        </a>
    </div>

    <section class="metric-grid equal" aria-label="Thống kê danh mục">
        <article class="metric-cell"><p class="metric-label">Tổng danh mục</p><p class="metric-value">${totalCount}</p></article>
        <article class="metric-cell"><p class="metric-label">Đang hoạt động</p><p class="metric-value">${activeCount}</p><div class="metric-trend"><span class="trend-up">Sẵn sàng bán</span></div></article>
        <article class="metric-cell"><p class="metric-label">Tạm khóa</p><p class="metric-value">${pausedCount}</p><div class="metric-trend"><span class="trend-down">Cần kiểm tra</span></div></article>
        <article class="metric-cell"><p class="metric-label">Tỷ lệ hoạt động</p><p class="metric-value"><c:choose><c:when test="${totalCount > 0}"><fmt:formatNumber value="${activeCount * 100 / totalCount}" maxFractionDigits="0"/>%</c:when><c:otherwise>0%</c:otherwise></c:choose></p></article>
    </section>

    <section class="panel">
        <div class="toolbar">
            <div class="filter-tabs" role="group" aria-label="Lọc theo trạng thái">
                <button class="filter-button active" type="button" data-filter="all">Tất cả <span class="mono">${totalCount}</span></button>
                <button class="filter-button" type="button" data-filter="active">Hoạt động <span class="mono">${activeCount}</span></button>
                <button class="filter-button" type="button" data-filter="paused">Tạm khóa <span class="mono">${pausedCount}</span></button>
            </div>
            <div class="toolbar-actions">
                <div class="search-field">
                    <svg width="12" height="12" viewBox="0 0 16 16" fill="none"><circle cx="7" cy="7" r="5" stroke="currentColor" stroke-width="1.5"/><path d="m11 11 3 3" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/></svg>
                    <input id="tableSearch" type="search" placeholder="Tìm tên danh mục..." autocomplete="off">
                </div>
            </div>
        </div>

        <div class="table-scroll">
            <table class="data-table" id="categoryTable">
                <thead>
                    <tr><th>ID</th><th>Danh mục</th><th>Hình ảnh</th><th>Trạng thái</th><th style="text-align:right">Thao tác</th></tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty listcate}">
                            <tr id="emptyDatabase"><td colspan="5" class="empty-state">
                                <svg width="28" height="28" viewBox="0 0 32 32" fill="none"><rect x="5" y="7" width="22" height="19" rx="3" stroke="currentColor"/><path d="M5 13h22M12 18h8" stroke="currentColor" stroke-linecap="round"/></svg>
                                Chưa có danh mục nào.<br><a style="color:var(--accent)" href="${pageContext.request.contextPath}/admin/category/add">Tạo danh mục đầu tiên →</a>
                            </td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${listcate}" var="cate">
                                <tr class="category-row" data-status="${cate.status == 1 ? 'active' : 'paused'}" data-name="<c:out value='${cate.categoryname}'/>">
                                    <td class="table-id">#${cate.categoryId}</td>
                                    <td>
                                        <div class="name-cell">
                                            <span class="thumb thumb-placeholder">C${cate.categoryId}</span>
                                            <span><span class="table-primary category-name"><c:out value="${cate.categoryname}"/></span><span class="name-detail">Mã danh mục · CAT-${cate.categoryId}</span></span>
                                        </div>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty cate.images && cate.images.startsWith('http')}"><img class="thumb thumb-lg previewable" src="${cate.images}" alt="Ảnh danh mục" loading="lazy"></c:when>
                                            <c:otherwise><img class="thumb thumb-lg previewable" src="${pageContext.request.contextPath}/image?fname=${cate.images}" alt="Ảnh danh mục" loading="lazy" onerror="this.style.display='none'"></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><span class="status ${cate.status == 1 ? 'status-active' : 'status-paused'}">${cate.status == 1 ? 'Hoạt động' : 'Tạm khóa'}</span></td>
                                    <td>
                                        <div class="cell-actions">
                                            <a class="btn btn-sm" href="${pageContext.request.contextPath}/admin/category/edit?id=${cate.categoryId}">Sửa</a>
                                            <a class="btn btn-sm btn-danger" href="${pageContext.request.contextPath}/admin/category/delete?id=${cate.categoryId}" onclick="return confirm('Bạn có chắc muốn xóa danh mục này?')">Xóa</a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    <tr id="noSearchResult" style="display:none"><td colspan="5" class="empty-state">Không tìm thấy danh mục phù hợp.</td></tr>
                </tbody>
            </table>
        </div>
    </section>
</div>

<div class="modal-backdrop-custom" id="imageModal" role="dialog" aria-modal="true" aria-label="Xem ảnh danh mục">
    <div class="image-modal">
        <button class="icon-button modal-close" id="imageModalClose" type="button" aria-label="Đóng">×</button>
        <img id="modalImage" src="" alt="Ảnh danh mục phóng lớn">
        <div class="image-modal-caption" id="modalCaption">Ảnh danh mục</div>
    </div>
</div>

<script>
(function () {
    const rows = Array.from(document.querySelectorAll('.category-row'));
    const search = document.getElementById('tableSearch');
    const noResult = document.getElementById('noSearchResult');
    let statusFilter = 'all';

    function applyFilter() {
        const query = (search ? search.value : '').trim().toLocaleLowerCase('vi');
        let visible = 0;
        rows.forEach(function (row) {
            const name = (row.dataset.name || '').toLocaleLowerCase('vi');
            const matches = (statusFilter === 'all' || row.dataset.status === statusFilter) && name.includes(query);
            row.style.display = matches ? '' : 'none';
            if (matches) visible++;
        });
        if (noResult) noResult.style.display = rows.length && visible === 0 ? '' : 'none';
    }

    if (search) search.addEventListener('input', applyFilter);
    document.querySelectorAll('[data-filter]').forEach(function (button) {
        button.addEventListener('click', function () {
            document.querySelectorAll('[data-filter]').forEach(function (item) { item.classList.remove('active'); });
            button.classList.add('active');
            statusFilter = button.dataset.filter;
            applyFilter();
        });
    });

    const modal = document.getElementById('imageModal');
    const modalImage = document.getElementById('modalImage');
    const modalCaption = document.getElementById('modalCaption');
    function closeModal() { modal.classList.remove('open'); }
    document.querySelectorAll('.previewable').forEach(function (img) {
        img.addEventListener('click', function () {
            modalImage.src = img.src;
            modalCaption.textContent = img.closest('tr').querySelector('.category-name').textContent;
            modal.classList.add('open');
        });
    });
    document.getElementById('imageModalClose').addEventListener('click', closeModal);
    modal.addEventListener('click', function (event) { if (event.target === modal) closeModal(); });
    document.addEventListener('keydown', function (event) { if (event.key === 'Escape') closeModal(); });
})();
</script>
</body>
</html>
