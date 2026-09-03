<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property='title'/> - BTVN Shopping</title>
    <!-- Google Fonts: Inter -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background-color: #f4f6f9;
            color: #333;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .main-wrapper {
            flex: 1;
        }
        .navbar-custom {
            background-color: #ffffff;
            border-bottom: 1px solid #e9ecef;
            box-shadow: 0 2px 4px rgba(0,0,0,0.04);
        }
        .navbar-brand {
            font-weight: 700;
            color: #0d6efd !important;
            display: flex;
            align-items: center;
            font-size: 1.15rem;
        }
        .school-logo {
            height: 42px;
            width: auto;
            object-fit: contain;
            border-radius: 4px;
        }
        .nav-link {
            font-weight: 500;
            color: #495057 !important;
            padding: 0.5rem 1rem !important;
            border-radius: 6px;
            transition: all 0.2s;
        }
        .nav-link:hover {
            color: #0d6efd !important;
            background-color: #f1f5f9;
        }
        .nav-link.btn-profile {
            background-color: #e7f1ff;
            color: #0d6efd !important;
        }
        .nav-link.btn-profile:hover {
            background-color: #d0e2ff;
        }
        .card {
            border: 1px solid #e9ecef;
            border-radius: 10px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
        }
        footer {
            background-color: #ffffff;
            border-top: 1px solid #e9ecef;
            padding: 1.25rem 0;
            color: #6c757d;
            font-size: 0.9rem;
        }
    </style>
    <sitemesh:write property='head'/>
</head>
<body>
    <!-- Header / Navbar -->
    <nav class="navbar navbar-expand-lg navbar-custom sticky-top">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/categories">
                <img src="${pageContext.request.contextPath}/assets/logo.jpg" alt="Logo Trường" class="school-logo me-2 shadow-sm" onerror="this.style.display='none'" />
                <span>BTVN Shopping</span>
            </a>
            <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#mainNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="mainNav">
                <ul class="navbar-nav me-auto ms-lg-3">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/categories">
                            <i class="bi bi-grid me-1"></i>Danh mục sản phẩm
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/category/add">
                            <i class="bi bi-plus-circle me-1"></i>Thêm danh mục
                        </a>
                    </li>
                </ul>
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link btn-profile" href="${pageContext.request.contextPath}/profile">
                            <i class="bi bi-person-circle me-1"></i>Hồ sơ cá nhân
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content injected by SiteMesh -->
    <div class="main-wrapper py-4">
        <div class="container">
            <sitemesh:write property='body'/>
        </div>
    </div>

    <!-- Footer -->
    <footer class="text-center">
        <div class="container">
            <p class="mb-0">&copy; 2026 BTVN Shopping - Hệ thống Quản lý Bán hàng</p>
        </div>
    </footer>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>