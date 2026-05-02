package com.zybots.mediqueue.service;

import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
import java.util.Random;
import java.util.concurrent.ConcurrentHashMap;

@Service
public class OTPService {

    // FIXED: store OTP alongside its expiry timestamp (5 minutes)
    // long[0] = OTP value, long[1] = expiry epoch milliseconds
    private final ConcurrentHashMap<String, long[]> otpStorage = new ConcurrentHashMap<>();

    @Autowired
    private org.springframework.mail.javamail.JavaMailSender mailSender;

    public void generateAndSendOTP(String email) {
        String otp = String.format("%04d", new Random().nextInt(10000));
        long expiry = System.currentTimeMillis() + (5 * 60 * 1000); // 5 minutes
        otpStorage.put(email, new long[]{Long.parseLong(otp), expiry});

        System.out.println("Generated OTP: " + otp + " for email: " + email);

        try {
            org.springframework.mail.SimpleMailMessage message =
                    new org.springframework.mail.SimpleMailMessage();
            message.setTo(email);
            message.setSubject("Your Mediqueue OTP");
            message.setText("Your verification code is: " + otp + "\n\nThis code expires in 5 minutes.");
            mailSender.send(message);
            System.out.println("SUCCESS: JavaMailSender sent OTP to " + email);
        } catch (Exception e) {
            System.err.println("CRITICAL ERROR: Failed to send email to " + email);
            System.err.println("Error details: " + e.getMessage());
            e.printStackTrace();
            System.out.println("[FALLBACK LOG] Since email failed, use this OTP to test: " + otp);
        }
    }

    public boolean verifyOTP(String email, String otp) {
        // Bypass for dev/presentation testing
        if (otp.equals("1111")) {
            System.out.println("Using Bypass code '1111' for email: " + email);
            return true;
        }

        long[] stored = otpStorage.get(email);
        if (stored == null) return false;

        // FIXED: check expiry before accepting OTP
        if (System.currentTimeMillis() > stored[1]) {
            otpStorage.remove(email);
            System.out.println("OTP expired for: " + email);
            return false;
        }

        String storedOtp = String.format("%04d", (long) stored[0]);
        if (storedOtp.equals(otp)) {
            otpStorage.remove(email);
            return true;
        }

        return false;
    }
}