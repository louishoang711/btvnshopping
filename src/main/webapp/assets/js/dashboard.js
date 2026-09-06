(function () {
    const body = document.body;
    const sidebarToggle = document.getElementById('sidebarToggle');
    const sidebarBackdrop = document.getElementById('sidebarBackdrop');

    function isMobile() {
        return window.matchMedia('(max-width: 760px)').matches;
    }

    function closeMobileSidebar() {
        body.classList.remove('sidebar-mobile-open');
    }

    if (sidebarToggle) {
        sidebarToggle.addEventListener('click', function () {
            if (isMobile()) {
                body.classList.toggle('sidebar-mobile-open');
            } else {
                body.classList.toggle('sidebar-collapsed');
                localStorage.setItem('hcmute-shop-sidebar', body.classList.contains('sidebar-collapsed') ? 'collapsed' : 'open');
            }
        });
    }

    if (sidebarBackdrop) sidebarBackdrop.addEventListener('click', closeMobileSidebar);

    if (!isMobile() && localStorage.getItem('hcmute-shop-sidebar') === 'collapsed') {
        body.classList.add('sidebar-collapsed');
    }

    window.addEventListener('resize', function () {
        if (!isMobile()) closeMobileSidebar();
    });

    const path = window.location.pathname;
    document.querySelectorAll('[data-nav]').forEach(function (item) {
        const key = item.getAttribute('data-nav');
        let active = false;
        if (key === 'dashboard') active = path.endsWith('/admin') || path.includes('/admin/dashboard');
        if (key === 'categories') active = path.includes('/admin/categories') || path.includes('/admin/category/edit');
        if (key === 'category-add') active = path.includes('/admin/category/add');
        if (key === 'products') active = path.includes('/admin/products') || path.includes('/admin/product/edit');
        if (key === 'product-add') active = path.includes('/admin/product/add');
        if (key === 'profile') active = path.includes('/profile');
        item.classList.toggle('active', active);
    });

    const globalSearch = document.getElementById('globalSearch');
    const tableSearch = document.getElementById('tableSearch');
    if (globalSearch && tableSearch) {
        globalSearch.addEventListener('input', function () {
            tableSearch.value = globalSearch.value;
            tableSearch.dispatchEvent(new Event('input'));
        });
    }
})();
