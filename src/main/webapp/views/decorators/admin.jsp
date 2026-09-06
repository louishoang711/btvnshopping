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
    <link href="https://fonts.googleapis.com/css2?family=DM+Mono:wght@400;500&family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/dashboard.css">
    <sitemesh:write property='head'/>
</head>
<body>
<c:set var="account" value="${sessionScope.account}"/>
<div class="app-shell">
    <aside class="sidebar" aria-label="Điều hướng chính">
        <a class="brand" href="${pageContext.request.contextPath}/admin/dashboard">
            <img class="brand-logo" src="${pageContext.request.contextPath}/assets/images/logo.jpg" alt="Logo HCM-UTE">
            <span class="brand-name">HCMUTE Shop</span>
        </a>
        <nav class="side-nav">
            <c:if test="${account.role == 1}">
            <div class="nav-section">
                <p class="nav-label">Tổng quan</p>
                <a class="nav-item" data-nav="dashboard" href="${pageContext.request.contextPath}/admin/dashboard"><span class="nav-dot"></span><span class="nav-text">Bảng điều khiển</span></a>
            </div>
            <div class="nav-section">
                <p class="nav-label">Quản lý</p>
                <a class="nav-item" data-nav="products" href="${pageContext.request.contextPath}/admin/products"><span class="nav-dot"></span><span class="nav-text">Sản phẩm</span></a>
                <a class="nav-item" data-nav="categories" href="${pageContext.request.contextPath}/admin/categories"><span class="nav-dot"></span><span class="nav-text">Danh mục</span></a>
                <a class="nav-item" data-nav="product-add" href="${pageContext.request.contextPath}/admin/product/add"><span class="nav-dot"></span><span class="nav-text">Thêm sản phẩm</span></a>
            </div>
            </c:if>
            <div class="nav-section">
                <p class="nav-label">Website</p>
                <a class="nav-item" href="${pageContext.request.contextPath}/home"><span class="nav-dot"></span><span class="nav-text">Xem cửa hàng</span></a>
            </div>
            <div class="nav-section">
                <p class="nav-label">Tài khoản</p>
                <a class="nav-item" data-nav="profile" href="${pageContext.request.contextPath}/profile"><span class="nav-dot"></span><span class="nav-text">Hồ sơ cá nhân</span></a>
                <a class="nav-item" href="${pageContext.request.contextPath}/logout"><span class="nav-dot"></span><span class="nav-text">Đăng xuất</span></a>
            </div>
        </nav>
        <a class="sidebar-user" href="${pageContext.request.contextPath}/profile">
            <span class="user-avatar">AD</span>
            <span class="user-meta"><span class="user-name"><c:out value="${account.fullname}"/></span><span class="user-role">${account.role == 1 ? 'Administrator' : 'User'}</span></span>
        </a>
    </aside>
    <div class="sidebar-backdrop" id="sidebarBackdrop"></div>
    <div class="app-main">
        <header class="topbar">
            <div class="topbar-left">
                <button class="icon-button" id="sidebarToggle" type="button" aria-label="Thu gọn thanh điều hướng"><svg width="15" height="12" viewBox="0 0 15 12" fill="none"><path d="M1 2h13M1 6h13M1 10h13" stroke="currentColor" stroke-width="1.3" stroke-linecap="round"/></svg></button>
                <div class="breadcrumb-line"><span class="crumb-parent desktop-only">HCMUTE Shop</span><span class="crumb-separator desktop-only">/</span><span class="crumb-current"><sitemesh:write property='title'/></span></div>
            </div>
            <div class="topbar-right">
                <div class="top-search desktop-only"><svg width="12" height="12" viewBox="0 0 16 16" fill="none"><circle cx="7" cy="7" r="5" stroke="currentColor" stroke-width="1.5"/><path d="m11 11 3 3" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/></svg><input id="globalSearch" type="search" placeholder="Tìm kiếm..." autocomplete="off"></div>
                <button class="icon-button theme-toggle" data-theme-toggle type="button" aria-label="Chuyển chế độ giao diện"><span class="theme-symbol theme-symbol-sun" aria-hidden="true">☀</span><span class="theme-symbol theme-symbol-moon" aria-hidden="true">☾</span></button>
                <a class="icon-button notification-button" href="${pageContext.request.contextPath}/home" title="Mở cửa hàng"><svg width="14" height="14" viewBox="0 0 16 16" fill="none"><path d="M3 6h10l-1 7H4L3 6Z" stroke="currentColor" stroke-width="1.3"/><path d="M6 6a2 2 0 0 1 4 0" stroke="currentColor" stroke-width="1.3"/></svg><span class="notification-dot"></span></a>
                <span class="topbar-date desktop-only">06.09.2026</span>
            </div>
        </header>
        <main class="content"><sitemesh:write property='body'/></main>
    </div>
</div>
<script src="${pageContext.request.contextPath}/assets/js/dashboard.js"></script>
</body>
</html>
