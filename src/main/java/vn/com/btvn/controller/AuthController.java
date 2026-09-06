package vn.com.btvn.controller;

import java.io.IOException;
import java.util.regex.Pattern;

import jakarta.mail.MessagingException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.com.btvn.entity.User;
import vn.com.btvn.service.EmailService;
import vn.com.btvn.service.IUserService;
import vn.com.btvn.service.impl.UserServiceImpl;
import vn.com.btvn.util.AuthSession;
import vn.com.btvn.util.OtpUtil;

@WebServlet(urlPatterns = { "/login", "/logout", "/register", "/forgot-password", "/reset-password" })
public class AuthController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$");
    private static final Pattern USERNAME_PATTERN = Pattern.compile("^[A-Za-z0-9_]{4,50}$");
    private static final Pattern PHONE_PATTERN = Pattern.compile("^(0|\\+84)[35789][0-9]{8}$");

    private final IUserService userService = new UserServiceImpl();
    private final EmailService emailService = new EmailService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        if ("/logout".equals(path)) {
            logout(request, response);
            return;
        }
        if ("/reset-password".equals(path)) {
            if (!Boolean.TRUE.equals(request.getSession().getAttribute(AuthSession.RESET_AUTHORIZED))) {
                response.sendRedirect(request.getContextPath() + "/forgot-password");
                return;
            }
            request.getRequestDispatcher("/views/auth/reset-password.jsp").forward(request, response);
            return;
        }
        if ("/login".equals(path)) {
            userService.getOrCreateDefaultUser();
            User account = (User) request.getSession().getAttribute(AuthSession.ACCOUNT);
            if (account != null) {
                redirectAfterLogin(request, response, account);
                return;
            }
            request.setAttribute("rememberedUsername", readCookie(request, "remember_user"));
            request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
            return;
        }
        if ("/register".equals(path)) {
            request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
            return;
        }
        request.getRequestDispatcher("/views/auth/forgot-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        switch (request.getServletPath()) {
            case "/login" -> login(request, response);
            case "/register" -> register(request, response);
            case "/forgot-password" -> forgotPassword(request, response);
            case "/reset-password" -> resetPassword(request, response);
            default -> response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void login(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = trim(request.getParameter("username"));
        String password = request.getParameter("password");
        User user = userService.authenticate(username, password);
        if (user == null) {
            forwardError(request, response, "/views/auth/login.jsp", "Tên đăng nhập hoặc mật khẩu không đúng.");
            return;
        }
        if (user.getActive() != 1) {
            createAndSendOtp(request.getSession(), user, "register");
            response.sendRedirect(request.getContextPath() + "/verify-otp");
            return;
        }

        HttpSession session = request.getSession();
        request.changeSessionId();
        session.setMaxInactiveInterval(30 * 60);
        session.setAttribute(AuthSession.ACCOUNT, user);

        boolean remember = "on".equals(request.getParameter("remember"));
        Cookie cookie = new Cookie("remember_user", remember ? user.getUsername() : "");
        cookie.setHttpOnly(true);
        cookie.setSecure(request.isSecure());
        cookie.setMaxAge(remember ? 30 * 24 * 60 * 60 : 0);
        cookie.setPath(request.getContextPath().isEmpty() ? "/" : request.getContextPath());
        response.addCookie(cookie);
        redirectAfterLogin(request, response, user);
    }

    private void register(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = trim(request.getParameter("username"));
        String email = trim(request.getParameter("email")).toLowerCase();
        String fullname = trim(request.getParameter("fullname"));
        String phone = trim(request.getParameter("phone"));
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        request.setAttribute("username", username);
        request.setAttribute("email", email);
        request.setAttribute("fullname", fullname);
        request.setAttribute("phone", phone);

        String error = validateRegistration(username, email, fullname, phone, password, confirmPassword);
        if (error != null) {
            forwardError(request, response, "/views/auth/register.jsp", error);
            return;
        }

        User user = new User();
        user.setUsername(username);
        user.setEmail(email);
        user.setFullname(fullname);
        user.setPhone(phone);
        user.setPassword(password);
        user.setImages(null);
        try {
            userService.register(user);
            createAndSendOtp(request.getSession(), user, "register");
            response.sendRedirect(request.getContextPath() + "/verify-otp");
        } catch (IllegalArgumentException exception) {
            forwardError(request, response, "/views/auth/register.jsp", exception.getMessage());
        }
    }

    private void forgotPassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = trim(request.getParameter("email")).toLowerCase();
        request.setAttribute("email", email);
        if (!EMAIL_PATTERN.matcher(email).matches()) {
            forwardError(request, response, "/views/auth/forgot-password.jsp", "Email không hợp lệ.");
            return;
        }
        User user = userService.findByEmail(email);
        if (user == null || user.getActive() != 1) {
            forwardError(request, response, "/views/auth/forgot-password.jsp", "Không tìm thấy tài khoản đã kích hoạt với email này.");
            return;
        }
        createAndSendOtp(request.getSession(), user, "reset");
        response.sendRedirect(request.getContextPath() + "/verify-otp");
    }

    private void resetPassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (!Boolean.TRUE.equals(session.getAttribute(AuthSession.RESET_AUTHORIZED))) {
            response.sendRedirect(request.getContextPath() + "/forgot-password");
            return;
        }
        String password = request.getParameter("password");
        String confirm = request.getParameter("confirmPassword");
        if (password == null || password.length() < 6 || !password.equals(confirm)) {
            forwardError(request, response, "/views/auth/reset-password.jsp",
                    "Mật khẩu phải có ít nhất 6 ký tự và hai lần nhập phải trùng nhau.");
            return;
        }
        int userId = (Integer) session.getAttribute(AuthSession.RESET_USER_ID);
        userService.changePassword(userId, password);
        session.removeAttribute(AuthSession.RESET_AUTHORIZED);
        session.removeAttribute(AuthSession.RESET_USER_ID);
        session.setAttribute("authMessage", "Đặt lại mật khẩu thành công. Bạn có thể đăng nhập ngay.");
        response.sendRedirect(request.getContextPath() + "/login");
    }

    private void logout(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) session.invalidate();
        response.sendRedirect(request.getContextPath() + "/login");
    }

    private void createAndSendOtp(HttpSession session, User user, String purpose) {
        String otp = OtpUtil.generate();
        boolean sent = false;
        try {
            emailService.sendOtp(user.getEmail(), otp, purpose);
            sent = true;
        } catch (MessagingException exception) {
            getServletContext().log("Không thể gửi OTP qua email; bật chế độ OTP demo.", exception);
        }
        AuthSession.beginOtp(session, user, purpose, otp, sent);
    }

    private String validateRegistration(String username, String email, String fullname, String phone,
            String password, String confirmPassword) {
        if (!USERNAME_PATTERN.matcher(username).matches()) return "Tên đăng nhập gồm 4–50 ký tự chữ, số hoặc dấu gạch dưới.";
        if (!EMAIL_PATTERN.matcher(email).matches()) return "Email không hợp lệ.";
        if (fullname.length() < 2 || fullname.length() > 100) return "Họ tên phải có từ 2 đến 100 ký tự.";
        if (!PHONE_PATTERN.matcher(phone).matches()) return "Số điện thoại Việt Nam không hợp lệ.";
        if (password == null || password.length() < 6) return "Mật khẩu phải có ít nhất 6 ký tự.";
        if (!password.equals(confirmPassword)) return "Mật khẩu xác nhận không trùng khớp.";
        return null;
    }

    private void redirectAfterLogin(HttpServletRequest request, HttpServletResponse response, User user) throws IOException {
        String target = user.getRole() == 1 ? "/admin/dashboard" : "/home";
        response.sendRedirect(request.getContextPath() + target);
    }

    private void forwardError(HttpServletRequest request, HttpServletResponse response, String view, String error)
            throws ServletException, IOException {
        request.setAttribute("error", error);
        request.getRequestDispatcher(view).forward(request, response);
    }

    private String readCookie(HttpServletRequest request, String name) {
        if (request.getCookies() == null) return "";
        for (Cookie cookie : request.getCookies()) if (name.equals(cookie.getName())) return cookie.getValue();
        return "";
    }

    private String trim(String value) { return value == null ? "" : value.trim(); }
}
