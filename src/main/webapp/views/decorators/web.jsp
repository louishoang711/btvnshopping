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
<body class="store-body">
<c:set var="account" value="${sessionScope.account}"/>
<header class="store-header">
    <div class="store-container store-nav">
        <a class="store-brand" href="${pageContext.request.contextPath}/home"><img class="brand-logo" src="${pageContext.request.contextPath}/assets/images/logo.jpg" alt="Logo HCM-UTE"><span>HCMUTE Shop</span></a>
        <nav class="store-links desktop-only"><a href="${pageContext.request.contextPath}/home">Trang chủ</a><a href="${pageContext.request.contextPath}/product">Sản phẩm</a></nav>
        <div class="store-nav-actions">
            <form class="store-search desktop-only" action="${pageContext.request.contextPath}/product" method="get"><input type="search" name="q" placeholder="Tìm sản phẩm..." value="<c:out value='${param.q}'/>"><button type="submit" aria-label="Tìm kiếm">⌕</button></form>
            <button class="icon-button theme-toggle" data-theme-toggle type="button" aria-label="Chuyển chế độ giao diện"><span class="theme-symbol theme-symbol-sun" aria-hidden="true">☀</span><span class="theme-symbol theme-symbol-moon" aria-hidden="true">☾</span></button>
            <c:choose>
                <c:when test="${not empty account}">
                    <c:if test="${account.role == 1}"><a class="btn btn-sm" href="${pageContext.request.contextPath}/admin/dashboard">Quản trị</a></c:if>
                    <a class="btn btn-sm" href="${pageContext.request.contextPath}/profile"><c:out value="${account.fullname}"/></a>
                    <a class="btn btn-sm btn-primary" href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
                </c:when>
                <c:otherwise><a class="btn btn-sm" href="${pageContext.request.contextPath}/login">Đăng nhập</a><a class="btn btn-sm btn-primary" href="${pageContext.request.contextPath}/register">Đăng ký</a></c:otherwise>
            </c:choose>
        </div>
    </div>
</header>
<main class="store-main"><sitemesh:write property='body'/></main>
<footer class="store-footer"><div class="store-container"><span>© 2026 HCMUTE Shop</span><span>Servlet · JSP · JPA · SiteMesh 3</span></div></footer>
</body>
</html>
