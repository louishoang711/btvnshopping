<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Bảng điều khiển</title>
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
    <section class="metric-grid" aria-label="Chỉ số tổng quan">
        <article class="metric-cell primary">
            <p class="metric-label">Doanh thu · Tháng 09/2026</p>
            <p class="metric-value">₫58,9tr</p>
            <div class="metric-trend"><span class="trend-up">↑ 12,4%</span><span>so với tháng trước</span></div>
        </article>
        <article class="metric-cell">
            <p class="metric-label">Sản phẩm</p>
            <p class="metric-value">${productCount}</p>
            <div class="metric-trend"><span class="trend-up">Trong cơ sở dữ liệu</span></div>
        </article>
        <article class="metric-cell">
            <p class="metric-label">Danh mục</p>
            <p class="metric-value">${totalCount}</p>
            <div class="metric-trend"><span class="trend-up">${activeCount} hoạt động</span></div>
        </article>
    </section>

    <section class="dashboard-grid">
        <article class="panel">
            <div class="panel-body">
                <div class="panel-header" style="padding:0 0 12px;border:0;min-height:auto">
                    <div><h2 class="panel-title">Hiệu suất bán hàng</h2><p class="panel-subtitle">7 tháng gần nhất</p></div>
                    <div class="filter-tabs"><button class="filter-button active" type="button">Doanh thu</button><button class="filter-button" type="button">Đơn hàng</button></div>
                </div>
                <div class="chart-wrap" aria-label="Biểu đồ doanh thu từ tháng 3 đến tháng 9">
                    <svg viewBox="0 0 760 190" preserveAspectRatio="none" role="img">
                        <defs><linearGradient id="revenueGradient" x1="0" y1="0" x2="0" y2="1"><stop offset="0%" stop-color="#f59e0b" stop-opacity=".2"/><stop offset="100%" stop-color="#f59e0b" stop-opacity="0"/></linearGradient></defs>
                        <line class="chart-grid-line" x1="38" y1="22" x2="750" y2="22"/><line class="chart-grid-line" x1="38" y1="68" x2="750" y2="68"/><line class="chart-grid-line" x1="38" y1="114" x2="750" y2="114"/><line class="chart-grid-line" x1="38" y1="160" x2="750" y2="160"/>
                        <text class="chart-label" x="0" y="25">75tr</text><text class="chart-label" x="5" y="71">50tr</text><text class="chart-label" x="5" y="117">25tr</text><text class="chart-label" x="22" y="163">0</text>
                        <path class="chart-area" d="M40 137 C95 132 115 112 158 116 S235 127 276 102 S355 84 395 94 S475 108 515 72 S600 42 635 56 S705 48 748 61 L748 160 L40 160Z"/>
                        <path class="chart-line" d="M40 137 C95 132 115 112 158 116 S235 127 276 102 S355 84 395 94 S475 108 515 72 S600 42 635 56 S705 48 748 61"/>
                        <circle class="chart-point" cx="40" cy="137" r="4"/><circle class="chart-point" cx="158" cy="116" r="4"/><circle class="chart-point" cx="276" cy="102" r="4"/><circle class="chart-point" cx="395" cy="94" r="4"/><circle class="chart-point" cx="515" cy="72" r="4"/><circle class="chart-point" cx="635" cy="56" r="4"/><circle class="chart-point" cx="748" cy="61" r="4"/>
                        <text class="chart-label" x="32" y="184">T3</text><text class="chart-label" x="150" y="184">T4</text><text class="chart-label" x="268" y="184">T5</text><text class="chart-label" x="387" y="184">T6</text><text class="chart-label" x="507" y="184">T7</text><text class="chart-label" x="627" y="184">T8</text><text class="chart-label" x="738" y="184">T9</text>
                    </svg>
                </div>
            </div>
        </article>

        <article class="panel desktop-only">
            <div class="panel-body">
                <h2 class="panel-title">Theo nhóm</h2><p class="panel-subtitle">Tỷ trọng doanh thu</p>
                <div class="donut-row"><div class="donut" aria-label="Biểu đồ tỷ trọng doanh thu"></div></div>
                <div class="legend">
                    <div class="legend-item"><span class="legend-name"><i class="legend-dot" style="background:#f59e0b"></i>Điện tử</span><span class="mono">42%</span></div>
                    <div class="legend-item"><span class="legend-name"><i class="legend-dot" style="background:#fbbf24"></i>Thời trang</span><span class="mono">25%</span></div>
                    <div class="legend-item"><span class="legend-name"><i class="legend-dot" style="background:#27272a"></i>Gia dụng</span><span class="mono">16%</span></div>
                    <div class="legend-item"><span class="legend-name"><i class="legend-dot" style="background:#3f3f46"></i>Thể thao</span><span class="mono">11%</span></div>
                    <div class="legend-item"><span class="legend-name"><i class="legend-dot" style="background:#52525b"></i>Khác</span><span class="mono">6%</span></div>
                </div>
            </div>
        </article>
    </section>

    <section class="dashboard-bottom">
        <article class="panel">
            <div class="panel-header"><div><h2 class="panel-title">Danh mục gần đây</h2><p class="panel-subtitle">Dữ liệu được lấy trực tiếp từ hệ thống</p></div><a class="panel-action" href="${pageContext.request.contextPath}/admin/categories">Xem tất cả →</a></div>
            <div class="table-scroll">
                <table class="data-table">
                    <thead><tr><th>ID</th><th>Danh mục</th><th>Trạng thái</th><th style="text-align:right">Thao tác</th></tr></thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${empty listcate}"><tr><td colspan="4" class="empty-state">Chưa có danh mục nào trong hệ thống.</td></tr></c:when>
                        <c:otherwise>
                            <c:forEach items="${listcate}" var="cate" begin="0" end="4">
                                <tr>
                                    <td class="table-id">#${cate.categoryId}</td>
                                    <td class="table-primary">${cate.categoryname}</td>
                                    <td><span class="status ${cate.status == 1 ? 'status-active' : 'status-paused'}">${cate.status == 1 ? 'Hoạt động' : 'Tạm khóa'}</span></td>
                                    <td><div class="cell-actions"><a class="btn btn-sm" href="${pageContext.request.contextPath}/admin/category/edit?id=${cate.categoryId}">Chỉnh sửa</a></div></td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </div>
        </article>

        <article class="panel">
            <div class="panel-header"><div><h2 class="panel-title">Hoạt động</h2><p class="panel-subtitle">Cập nhật mới nhất</p></div></div>
            <div class="activity-list">
                <div class="activity-item"><div class="activity-marker"><span style="background:#22c55e"></span></div><div class="activity-text">${productCount} sản phẩm và ${activeCount} danh mục đang được quản lý</div><div class="activity-time">vừa xong</div></div>
                <div class="activity-item"><div class="activity-marker"><span></span></div><div class="activity-text">Báo cáo tháng 09 đã được cập nhật</div><div class="activity-time">14p</div></div>
                <div class="activity-item"><div class="activity-marker"><span style="background:#a78bfa"></span></div><div class="activity-text">Hệ thống quản trị đã đồng bộ dữ liệu</div><div class="activity-time">38p</div></div>
                <c:if test="${pausedCount > 0}"><div class="activity-item"><div class="activity-marker"><span style="background:#ef4444"></span></div><div class="activity-text">${pausedCount} danh mục đang tạm khóa</div><div class="activity-time">1g</div></div></c:if>
            </div>
        </article>
    </section>
</div>
</body>
</html>
