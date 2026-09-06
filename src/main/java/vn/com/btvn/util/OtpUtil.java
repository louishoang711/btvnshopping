package vn.com.btvn.util;

import java.security.SecureRandom;

public final class OtpUtil {
    public static final long EXPIRES_IN_MILLIS = 5 * 60 * 1000L;
    private static final SecureRandom RANDOM = new SecureRandom();

    private OtpUtil() {
    }

    public static String generate() {
        return String.format("%06d", RANDOM.nextInt(1_000_000));
    }
}
