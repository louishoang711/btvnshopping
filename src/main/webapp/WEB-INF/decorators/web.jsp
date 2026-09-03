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
        :root {
            --primary-color: #2563eb;
            --primary-hover: #1d4ed8;
            --bg-color: #f8fafc;
            --card-border: #e2e8f0;
        }
        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background-color: var(--bg-color);
            color: #1e293b;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .main-wrapper {
            flex: 1;
        }
        .navbar-custom {
            background: #ffffff;
            border-bottom: 1px solid var(--card-border);
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.05);
        }
        .navbar-brand {
            font-weight: 700;
            color: var(--primary-color) !important;
            display: flex;
            align-items: center;
            font-size: 1.2rem;
            letter-spacing: -0.3px;
        }
        .school-logo {
            height: 42px;
            width: auto;
            object-fit: contain;
            border-radius: 6px;
            transition: transform 0.2s;
        }
        .school-logo:hover {
            transform: scale(1.05);
        }
        .nav-link {
            font-weight: 500;
            color: #64748b !important;
            padding: 0.5rem 0.9rem !important;
            border-radius: 8px;
            transition: all 0.2s ease;
        }
        .nav-link:hover, .nav-link.active {
            color: var(--primary-color) !important;
            background-color: #eff6ff;
        }
        .btn-profile-pill {
            background-color: #f1f5f9;
            color: #334155;
            font-weight: 500;
            padding: 0.4rem 0.85rem;
            border-radius: 9999px;
            border: 1px solid #e2e8f0;
            transition: all 0.2s ease;
            text-decoration: none;
        }
        .btn-profile-pill:hover {
            background-color: #e2e8f0;
            color: var(--primary-color);
        }
        .card {
            border: 1px solid var(--card-border);
            border-radius: 12px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.02), 0 1px 2px rgba(0,0,0,0.04);
            transition: box-shadow 0.2s ease;
        }
        .card:hover {
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05), 0 2px 4px -1px rgba(0,0,0,0.03);
        }
        .stat-card {
            border-radius: 12px;
            border: 1px solid #e2e8f0;
            background: #ffffff;
            transition: all 0.2s ease;
        }
        .stat-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        }
        footer {
            background-color: #ffffff;
            border-top: 1px solid var(--card-border);
            padding: 1.25rem 0;
            color: #64748b;
            font-size: 0.875rem;
        }
    </style>
    <sitemesh:write property='head'/>
</head>
<body>
    <!-- Header / Navbar -->
    <nav class="navbar navbar-expand-lg navbar-custom sticky-top">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/categories">
                <img src="${pageContext.request.contextPath}/assets/logo.jpg" alt="Logo Trường" class="school-logo me-2 border shadow-xs" onerror="this.style.display='none'" />
                <span>BTVN Shopping</span>
            </a>
            <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#mainNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="mainNav">
                <ul class="navbar-nav me-auto ms-lg-3 gap-1">
                    <li class="nav-item">
                        <a class="nav-link" id="nav-categories" href="${pageContext.request.contextPath}/admin/categories">
                            <i class="bi bi-grid-fill me-1"></i>Danh mục sản phẩm
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id="nav-category-add" href="${pageContext.request.contextPath}/admin/category/add">
                            <i class="bi bi-plus-circle-fill me-1"></i>Thêm danh mục
                        </a>
                    </li>
                </ul>
                <div class="d-flex align-items-center">
                    <a href="${pageContext.request.contextPath}/profile" class="btn-profile-pill d-flex align-items-center gap-2" title="Xem thông tin cá nhân">
                        <span class="badge bg-primary rounded-circle p-1">
                            <i class="bi bi-person-fill text-white"></i>
                        </span>
                        <span>Tài khoản Admin</span>
                    </a>
                </div>
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
            <p class="mb-0">&copy; 2026 BTVN Shopping - Hệ thống Quản trị Bán hàng trực quan</p>
        </div>
    </footer>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Tự động highlight menu item theo URL
        const currentPath = window.location.pathname;
        if (currentPath.includes('/admin/category/add')) {
            document.getElementById('nav-category-add')?.classList.add('active');
        } else if (currentPath.includes('/admin/categor')) {
            document.getElementById('nav-categories')?.classList.add('active');
        }
    </script>
</body>
</html>