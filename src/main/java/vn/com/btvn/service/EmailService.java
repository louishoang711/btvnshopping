package vn.com.btvn.service;

import java.util.Properties;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class EmailService {
    private final String host = env("SMTP_HOST", "smtp.gmail.com");
    private final String port = env("SMTP_PORT", "587");
    private final String username = System.getenv("SMTP_USERNAME");
    private final String password = System.getenv("SMTP_PASSWORD");
    private final String from = env("SMTP_FROM", username);

    public boolean isConfigured() {
        return username != null && !username.isBlank() && password != null && !password.isBlank();
    }

    public void sendOtp(String recipient, String otp, String purpose) throws MessagingException {
        if (!isConfigured()) {
            throw new MessagingException("Chưa cấu hình SMTP_USERNAME và SMTP_PASSWORD.");
        }

        Properties properties = new Properties();
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", port);
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.connectiontimeout", "10000");
        properties.put("mail.smtp.timeout", "10000");

        Session session = Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        String action = "register".equals(purpose) ? "kích hoạt tài khoản" : "đặt lại mật khẩu";
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(from));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipient));
        message.setSubject("HCMUTE Shop - Mã OTP " + action);
        message.setText("Mã OTP để " + action + " của bạn là: " + otp
                + "\n\nMã có hiệu lực trong 5 phút. Không chia sẻ mã này với bất kỳ ai.");
        Transport.send(message);
    }

    private static String env(String name, String fallback) {
        String value = System.getenv(name);
        return value == null || value.isBlank() ? fallback : value;
    }
}
