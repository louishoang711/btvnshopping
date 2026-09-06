package vn.com.btvn.filter;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.com.btvn.entity.User;
import vn.com.btvn.util.AuthSession;

@WebFilter(urlPatterns = { "/admin/*", "/profile", "/profile/*" })
public class AuthFilter implements Filter {
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        User account = (User) request.getSession().getAttribute(AuthSession.ACCOUNT);

        if (account == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        if (request.getServletPath().startsWith("/admin") && account.getRole() != 1) {
            request.getSession().setAttribute("storeMessage", "Bạn không có quyền truy cập khu vực quản trị.");
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        chain.doFilter(request, response);
    }
}
