<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property='title'/> - BTVN Shopping</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            background-color: #f8f9fa;
        }
        .main-content {
            flex: 1;
        }
        .navbar-brand {
            font-weight: 700;
            letter-spacing: 0.5px;
        }
        footer {
            background-color: #212529;
            color: #adb5bd;
        }
    </style>
    <sitemesh:write property='head'/>
</head>
<body>
    <!-- Navbar Header -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm sticky-top">
        <div class="container">
            <a class="navbar-brand text-warning" href="${pageContext.request.contextPath}/admin/categories">
                <i class="bi bi-shop me-2"></i>BTVN Shopping
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-ratio"></span>
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/categories">
                            <i class="bi bi-grid-fill me-1"></i>Danh mục sản phẩm
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/category/add">
                            <i class="bi bi-plus-circle-fill me-1"></i>Thêm danh mục
                        </a>
                    </li>
                </ul>
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link btn btn-outline-secondary text-white px-3 py-1 me-2" href="${pageContext.request.contextPath}/profile">
                            <i class="bi bi-person-circle me-1"></i>Hồ sơ cá nhân
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content injected by SiteMesh -->
    <main class="container my-4 main-content">
        <sitemesh:write property='body'/>
    </main>

    <!-- Footer -->
    <footer class="py-3 text-center border-top">
        <div class="container">
            <p class="mb-0">&copy; 2026 BTVN Shopping Management - JPA &amp; SiteMesh 3</p>
        </div>
    </footer>

    <!-- Bootstrap 5 Bundle JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>