<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang chủ</title>
</head>
<body>
<c:if test="${not empty sessionScope.storeMessage}">
    <div class="store-container storefront-alert">
        <div class="alert alert-error"><c:out value="${sessionScope.storeMessage}"/></div>
    </div>
    <c:remove var="storeMessage" scope="session"/>
</c:if>

<section class="hero-carousel" aria-label="Bộ sưu tập nổi bật">
    <article class="hero-slide is-active">
        <img class="hero-slide-bg" src="https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=1400&amp;h=700&amp;fit=crop&amp;auto=format" alt="Tai nghe cao cấp">
        <div class="hero-slide-overlay"></div>
        <div class="store-container hero-slide-content">
            <p class="hero-slide-tag">New Collection 2026</p>
            <h1 class="hero-slide-title">Sound.<br>Perfected.</h1>
            <p class="hero-slide-copy">Industry-leading noise cancellation with up to 30 hours of battery. For those who demand more.</p>
            <div class="hero-slide-actions">
                <a class="hero-btn hero-btn-light" href="#store-products">Shop Now</a>
                <a class="hero-btn hero-btn-outline" href="${pageContext.request.contextPath}/product">Learn More</a>
            </div>
            <div class="hero-slide-stats">
                <div><strong>4.8★</strong><span>Customer Rating</span></div>
                <div><strong>30hr</strong><span>Battery Life</span></div>
                <div><strong>1,200+</strong><span>Reviews</span></div>
                <div><strong>Free</strong><span>Shipping</span></div>
            </div>
        </div>
    </article>
    <article class="hero-slide">
        <img class="hero-slide-bg" src="https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=1400&amp;h=700&amp;fit=crop&amp;auto=format" alt="Giày thể thao">
        <div class="hero-slide-overlay"></div>
        <div class="store-container hero-slide-content">
            <p class="hero-slide-tag">Best Seller</p>
            <h2 class="hero-slide-title">Run<br>Further.</h2>
            <p class="hero-slide-copy">Advanced GPS tracking and health monitoring for athletes who refuse to compromise.</p>
            <div class="hero-slide-actions"><a class="hero-btn hero-btn-light" href="#store-products">Shop Now</a><a class="hero-btn hero-btn-outline" href="${pageContext.request.contextPath}/product">Learn More</a></div>
            <div class="hero-slide-stats"><div><strong>4.6★</strong><span>Customer Rating</span></div><div><strong>934</strong><span>Units Sold</span></div><div><strong>GPS</strong><span>Tracking</span></div><div><strong>Free</strong><span>Shipping</span></div></div>
        </div>
    </article>
    <article class="hero-slide">
        <img class="hero-slide-bg" src="https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=1400&amp;h=700&amp;fit=crop&amp;auto=format" alt="Không gian bếp cao cấp">
        <div class="hero-slide-overlay"></div>
        <div class="store-container hero-slide-content">
            <p class="hero-slide-tag">Premium Kitchen</p>
            <h2 class="hero-slide-title">Cook<br>Better.</h2>
            <p class="hero-slide-copy">Professional-grade performance in your kitchen. Built for home chefs who take quality seriously.</p>
            <div class="hero-slide-actions"><a class="hero-btn hero-btn-light" href="#store-products">Shop Now</a><a class="hero-btn hero-btn-outline" href="${pageContext.request.contextPath}/product">Learn More</a></div>
            <div class="hero-slide-stats"><div><strong>4.9★</strong><span>Customer Rating</span></div><div><strong>189</strong><span>Units Sold</span></div><div><strong>7-in-1</strong><span>Functions</span></div><div><strong>2yr</strong><span>Warranty</span></div></div>
        </div>
    </article>
    <article class="hero-slide">
        <img class="hero-slide-bg" src="https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=1400&amp;h=700&amp;fit=crop&amp;auto=format" alt="Thiết bị làm sạch">
        <div class="hero-slide-overlay"></div>
        <div class="store-container hero-slide-content">
            <p class="hero-slide-tag">Clean Power</p>
            <h2 class="hero-slide-title">Deep<br>Clean.</h2>
            <p class="hero-slide-copy">Whole-home cleaning with laser dust detection technology. Never miss a particle again.</p>
            <div class="hero-slide-actions"><a class="hero-btn hero-btn-light" href="#store-products">Shop Now</a><a class="hero-btn hero-btn-outline" href="${pageContext.request.contextPath}/product">Learn More</a></div>
            <div class="hero-slide-stats"><div><strong>4.9★</strong><span>Customer Rating</span></div><div><strong>278</strong><span>Units Sold</span></div><div><strong>60min</strong><span>Runtime</span></div><div><strong>HEPA</strong><span>Filter</span></div></div>
        </div>
    </article>
    <button class="hero-slide-arrow hero-arrow-prev" type="button" aria-label="Slide trước">‹</button>
    <button class="hero-slide-arrow hero-arrow-next" type="button" aria-label="Slide tiếp theo">›</button>
    <div class="hero-dots" aria-label="Chọn slide">
        <button class="hero-dot is-active" type="button" aria-label="Slide 1"></button>
        <button class="hero-dot" type="button" aria-label="Slide 2"></button>
        <button class="hero-dot" type="button" aria-label="Slide 3"></button>
        <button class="hero-dot" type="button" aria-label="Slide 4"></button>
    </div>
    <span class="hero-counter">01 / 04</span>
</section>

<div class="store-container features-wrap">
    <section class="features-strip" id="services" aria-label="Dịch vụ HCMUTE Shop">
        <div class="feature-item"><span class="feature-icon">🚚</span><div><strong>Free Shipping</strong><small>On all orders over $99</small></div></div>
        <div class="feature-item"><span class="feature-icon">↩</span><div><strong>Easy Returns</strong><small>30-day hassle-free returns</small></div></div>
        <div class="feature-item"><span class="feature-icon">🔒</span><div><strong>Secure Payment</strong><small>256-bit SSL encryption</small></div></div>
        <div class="feature-item"><span class="feature-icon">💬</span><div><strong>24/7 Support</strong><small>Chat, email and phone</small></div></div>
    </section>
</div>

<section class="store-catalog" id="store-products">
    <div class="store-container">
        <header class="catalog-heading">
            <p>Our Collection</p>
            <h2>Shop All Products</h2>
        </header>
        <nav class="category-pills" aria-label="Danh mục sản phẩm">
            <a class="category-pill is-active" href="${pageContext.request.contextPath}/product">Tất cả</a>
            <c:forEach items="${categories}" var="category">
                <a class="category-pill" href="${pageContext.request.contextPath}/product?category=${category.categoryId}"><c:out value="${category.categoryname}"/></a>
            </c:forEach>
        </nav>

        <div class="storefront-product-grid">
            <c:choose>
                <c:when test="${empty latestProducts}">
                    <div class="storefront-empty">
                        <span>Bag</span>
                        <h3>Chưa có sản phẩm</h3>
                        <p>Đăng nhập quản trị để thêm sản phẩm vào cửa hàng.</p>
                        <c:if test="${sessionScope.account.role == 1}"><a class="hero-btn catalog-cta" href="${pageContext.request.contextPath}/admin/product/add">Thêm sản phẩm</a></c:if>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${latestProducts}" var="product">
                        <article class="storefront-product-card">
                            <a href="${pageContext.request.contextPath}/product/detail?id=${product.productId}">
                                <div class="storefront-product-media">
                                    <c:choose>
                                        <c:when test="${not empty product.images && product.images.startsWith('http')}"><img src="${product.images}" alt="${product.productName}" loading="lazy"></c:when>
                                        <c:when test="${not empty product.images}"><img src="${pageContext.request.contextPath}/image?fname=${product.images}" alt="${product.productName}" loading="lazy"></c:when>
                                        <c:otherwise><span class="product-placeholder">P-${product.productId}</span></c:otherwise>
                                    </c:choose>
                                    <c:if test="${product.quantity == 0}"><span class="sold-out-badge">Sold Out</span></c:if>
                                </div>
                                <div class="storefront-product-info">
                                    <p class="storefront-product-category"><c:out value="${product.category.categoryname}"/></p>
                                    <h3><c:out value="${product.productName}"/></h3>
                                    <div class="storefront-rating"><span>★★★★★</span><small>(${product.quantity})</small></div>
                                    <div class="storefront-product-bottom">
                                        <strong><fmt:formatNumber value="${product.price}" type="number" maxFractionDigits="0"/>₫</strong>
                                        <span class="product-view-btn">${product.quantity > 0 ? 'Xem' : 'Hết hàng'}</span>
                                    </div>
                                </div>
                            </a>
                        </article>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="catalog-more"><a href="${pageContext.request.contextPath}/product">Xem tất cả sản phẩm →</a></div>
    </div>
</section>

<script>
(function () {
    var root = document.querySelector('.hero-carousel');
    if (!root) return;
    var slides = Array.prototype.slice.call(root.querySelectorAll('.hero-slide'));
    var dots = Array.prototype.slice.call(root.querySelectorAll('.hero-dot'));
    var counter = root.querySelector('.hero-counter');
    var index = 0;
    var timer;
    var startX = null;

    function show(next) {
        index = (next + slides.length) % slides.length;
        slides.forEach(function (slide, i) { slide.classList.toggle('is-active', i === index); });
        dots.forEach(function (dot, i) { dot.classList.toggle('is-active', i === index); });
        counter.textContent = String(index + 1).padStart(2, '0') + ' / ' + String(slides.length).padStart(2, '0');
    }
    function restart() {
        window.clearInterval(timer);
        timer = window.setInterval(function () { show(index + 1); }, 5000);
    }
    root.querySelector('.hero-arrow-prev').addEventListener('click', function () { show(index - 1); restart(); });
    root.querySelector('.hero-arrow-next').addEventListener('click', function () { show(index + 1); restart(); });
    dots.forEach(function (dot, i) { dot.addEventListener('click', function () { show(i); restart(); }); });
    root.addEventListener('pointerdown', function (event) { startX = event.clientX; });
    root.addEventListener('pointerup', function (event) {
        if (startX === null) return;
        var distance = event.clientX - startX;
        if (Math.abs(distance) > 40) { show(index + (distance < 0 ? 1 : -1)); restart(); }
        startX = null;
    });
    restart();
}());
</script>
</body>
</html>
