package vn.com.btvn.util;

import jakarta.servlet.http.HttpSession;
import vn.com.btvn.entity.User;

public final class AuthSession {
    public static final String ACCOUNT = "account";
    public static final String OTP_CODE = "otpCode";
    public static final String OTP_PURPOSE = "otpPurpose";
    public static final String OTP_USER_ID = "otpUserId";
    public static final String OTP_EMAIL = "otpEmail";
    public static final String OTP_EXPIRES_AT = "otpExpiresAt";
    public static final String OTP_ATTEMPTS = "otpAttempts";
    public static final String OTP_DEMO_CODE = "otpDemoCode";
    public static final String RESET_AUTHORIZED = "resetAuthorized";
    public static final String RESET_USER_ID = "resetUserId";

    private AuthSession() {
    }

    public static void beginOtp(HttpSession session, User user, String purpose, String otp, boolean emailSent) {
        session.setAttribute(OTP_CODE, otp);
        session.setAttribute(OTP_PURPOSE, purpose);
        session.setAttribute(OTP_USER_ID, user.getId());
        session.setAttribute(OTP_EMAIL, user.getEmail());
        session.setAttribute(OTP_EXPIRES_AT, System.currentTimeMillis() + OtpUtil.EXPIRES_IN_MILLIS);
        session.setAttribute(OTP_ATTEMPTS, 0);
        if (emailSent) session.removeAttribute(OTP_DEMO_CODE);
        else session.setAttribute(OTP_DEMO_CODE, otp);
    }

    public static void clearOtp(HttpSession session) {
        session.removeAttribute(OTP_CODE);
        session.removeAttribute(OTP_PURPOSE);
        session.removeAttribute(OTP_USER_ID);
        session.removeAttribute(OTP_EMAIL);
        session.removeAttribute(OTP_EXPIRES_AT);
        session.removeAttribute(OTP_ATTEMPTS);
        session.removeAttribute(OTP_DEMO_CODE);
    }
}
