(function () {
    const storageKey = 'hcmute-shop-theme';
    const root = document.documentElement;

    function systemTheme() {
        return window.matchMedia('(prefers-color-scheme: light)').matches ? 'light' : 'dark';
    }

    function savedTheme() {
        try {
            const value = localStorage.getItem(storageKey);
            return value === 'light' || value === 'dark' ? value : null;
        } catch (error) {
            return null;
        }
    }

    function requestedTheme() {
        const value = new URLSearchParams(window.location.search).get('theme');
        return value === 'light' || value === 'dark' ? value : null;
    }

    function applyTheme(theme) {
        root.dataset.theme = theme;
        root.style.colorScheme = theme;
        document.querySelectorAll('[data-theme-toggle]').forEach(function (button) {
            const nextTheme = theme === 'dark' ? 'sáng' : 'tối';
            button.setAttribute('aria-label', 'Chuyển sang chế độ ' + nextTheme);
            button.setAttribute('title', 'Chuyển sang chế độ ' + nextTheme);
        });
    }

    const initialTheme = requestedTheme() || savedTheme() || systemTheme();
    applyTheme(initialTheme);

    document.addEventListener('DOMContentLoaded', function () {
        applyTheme(root.dataset.theme || systemTheme());
        document.querySelectorAll('[data-theme-toggle]').forEach(function (button) {
            button.addEventListener('click', function () {
                const nextTheme = root.dataset.theme === 'dark' ? 'light' : 'dark';
                try {
                    localStorage.setItem(storageKey, nextTheme);
                } catch (error) {
                    // Theme still works for this page when storage is unavailable.
                }
                applyTheme(nextTheme);
            });
        });
    });
})();
