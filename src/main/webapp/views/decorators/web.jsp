<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property='title'/> · HCMUTE Shop</title>
    <script src="${pageContext.request.contextPath}/assets/js/theme.js"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Mono:wght@400;500&amp;family=Inter:wght@400;500;600;700;800&amp;display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/dashboard.css">
    <sitemesh:write property='head'/>
</head>
<body class="store-body">
<c:set var="account" value="${sessionScope.account}"/>
<header class="store-header">
    <div class="store-nav">
        <a class="store-brand" href="${pageContext.request.contextPath}/home">
            <img class="brand-logo" src="${pageContext.request.contextPath}/assets/images/logo.jpg" alt="Logo HCMUTE">
            <span>HCMUTE Shop</span>
        </a>
        <nav class="store-links desktop-only" aria-label="Điều hướng chính">
            <a href="${pageContext.request.contextPath}/product">Sản phẩm</a>
            <a href="${pageContext.request.contextPath}/home#store-products">Bộ sưu tập</a>
            <a href="${pageContext.request.contextPath}/home#services">Dịch vụ</a>
            <a href="#store-footer">Hỗ trợ</a>
        </nav>
        <div class="store-nav-actions">
            <button class="icon-button theme-toggle" data-theme-toggle type="button" aria-label="Chuyển chế độ sáng tối">
                <span class="theme-symbol theme-symbol-sun" aria-hidden="true">☀</span>
                <span class="theme-symbol theme-symbol-moon" aria-hidden="true">☾</span>
            </button>
            <c:choose>
                <c:when test="${not empty account}">
                    <div class="store-account-links">
                        <c:if test="${account.role == 1}"><a class="store-signin" href="${pageContext.request.contextPath}/admin/dashboard">Quản trị</a></c:if>
                        <a class="store-account-pill" href="${pageContext.request.contextPath}/profile"><span class="account-avatar">${empty account.fullname ? 'U' : account.fullname.substring(0,1)}</span><span class="desktop-only"><c:out value="${account.fullname}"/></span></a>
                        <a class="store-signout desktop-only" href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <a class="store-signin" href="${pageContext.request.contextPath}/login">Đăng nhập</a>
                    <a class="store-register desktop-only" href="${pageContext.request.contextPath}/register">Đăng ký</a>
                </c:otherwise>
            </c:choose>
            <a class="store-bag" href="${pageContext.request.contextPath}/product" aria-label="Xem sản phẩm" title="Sản phẩm">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M6 2L3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"/><line x1="3" y1="6" x2="21" y2="6"/><path d="M16 10a4 4 0 0 1-8 0"/></svg>
            </a>
        </div>
    </div>
</header>
<main class="store-main"><sitemesh:write property='body'/></main>
<footer class="storefront-footer" id="store-footer">
    <div class="store-container storefront-footer-grid">
        <div class="footer-about">
            <a class="store-brand" href="${pageContext.request.contextPath}/home"><img class="brand-logo" src="${pageContext.request.contextPath}/assets/images/logo.jpg" alt="Logo HCMUTE"><span>HCMUTE Shop</span></a>
            <p>Sản phẩm chất lượng dành cho sinh viên và cộng đồng HCMUTE.</p>
        </div>
        <div><strong>Cửa hàng</strong><a href="${pageContext.request.contextPath}/product">Tất cả sản phẩm</a><a href="${pageContext.request.contextPath}/home#store-products">Bộ sưu tập</a></div>
        <div><strong>Tài khoản</strong><a href="${pageContext.request.contextPath}/login">Đăng nhập</a><a href="${pageContext.request.contextPath}/register">Đăng ký</a><a href="${pageContext.request.contextPath}/profile">Hồ sơ</a></div>
        <div><strong>Hỗ trợ</strong><a href="mailto:support@hcmute.edu.vn">Liên hệ</a><a href="${pageContext.request.contextPath}/home#services">Dịch vụ</a></div>
    </div>
    <div class="store-container storefront-footer-bottom"><span>© 2026 HCMUTE Shop. All rights reserved.</span><span>Servlet · JSP · JPA · SiteMesh 3</span></div>
</footer>
</body>
</html>
