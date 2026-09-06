package vn.com.btvn.controller;

import java.io.IOException;

import jakarta.mail.MessagingException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
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

@WebServlet(urlPatterns = { "/verify-otp", "/resend-otp" })
public class OtpController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final IUserService userService = new UserServiceImpl();
    private final EmailService emailService = new EmailService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute(AuthSession.OTP_USER_ID) == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        request.getRequestDispatcher("/views/auth/verify-otp.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        if ("/resend-otp".equals(request.getServletPath())) {
            resend(request, response);
            return;
        }
        verify(request, response);
    }

    private void verify(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String expected = (String) session.getAttribute(AuthSession.OTP_CODE);
        Long expiresAt = (Long) session.getAttribute(AuthSession.OTP_EXPIRES_AT);
        Integer userId = (Integer) session.getAttribute(AuthSession.OTP_USER_ID);
        String purpose = (String) session.getAttribute(AuthSession.OTP_PURPOSE);
        int attempts = session.getAttribute(AuthSession.OTP_ATTEMPTS) instanceof Integer value ? value : 0;

        if (expected == null || expiresAt == null || userId == null || purpose == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        if (System.currentTimeMillis() > expiresAt) {
            request.setAttribute("error", "Mã OTP đã hết hạn. Vui lòng yêu cầu gửi lại.");
            request.getRequestDispatcher("/views/auth/verify-otp.jsp").forward(request, response);
            return;
        }
        if (attempts >= 5) {
            request.setAttribute("error", "Bạn đã nhập sai quá nhiều lần. Vui lòng gửi lại mã OTP.");
            request.getRequestDispatcher("/views/auth/verify-otp.jsp").forward(request, response);
            return;
        }

        String entered = request.getParameter("otp");
        if (entered == null || !expected.equals(entered.trim())) {
            session.setAttribute(AuthSession.OTP_ATTEMPTS, attempts + 1);
            request.setAttribute("error", "Mã OTP không đúng. Bạn còn " + (4 - attempts) + " lần thử.");
            request.getRequestDispatcher("/views/auth/verify-otp.jsp").forward(request, response);
            return;
        }

        if ("register".equals(purpose)) {
            userService.activate(userId);
            AuthSession.clearOtp(session);
            session.setAttribute("authMessage", "Kích hoạt tài khoản thành công. Hãy đăng nhập.");
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            AuthSession.clearOtp(session);
            session.setAttribute(AuthSession.RESET_AUTHORIZED, true);
            session.setAttribute(AuthSession.RESET_USER_ID, userId);
            response.sendRedirect(request.getContextPath() + "/reset-password");
        }
    }

    private void resend(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute(AuthSession.OTP_USER_ID);
        String purpose = (String) session.getAttribute(AuthSession.OTP_PURPOSE);
        if (userId == null || purpose == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        User user = userService.findById(userId);
        if (user == null) {
            AuthSession.clearOtp(session);
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String otp = OtpUtil.generate();
        boolean sent = false;
        try {
            emailService.sendOtp(user.getEmail(), otp, purpose);
            sent = true;
        } catch (MessagingException exception) {
            getServletContext().log("Không thể gửi lại OTP qua email; bật chế độ OTP demo.", exception);
        }
        AuthSession.beginOtp(session, user, purpose, otp, sent);
        session.setAttribute("otpMessage", "Mã OTP mới đã được tạo.");
        response.sendRedirect(request.getContextPath() + "/verify-otp");
    }
}
