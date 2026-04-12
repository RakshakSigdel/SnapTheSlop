package com.snaptheslop.snaptheslop.security;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;

public class PasswordUtil {

    /**
     * Hash a password using SHA-256 with salt
     */
    public static String hashPassword(String password) {
        try {
            SecureRandom random = new SecureRandom();
            byte[] salt = new byte[16];
            random.nextBytes(salt);

            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(salt);
            byte[] hashedPassword = md.digest(password.getBytes());

            // Combine salt and hashed password
            byte[] saltAndHash = new byte[salt.length + hashedPassword.length];
            System.arraycopy(salt, 0, saltAndHash, 0, salt.length);
            System.arraycopy(hashedPassword, 0, saltAndHash, salt.length, hashedPassword.length);

            return Base64.getEncoder().encodeToString(saltAndHash);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("SHA-256 algorithm not found", e);
        }
    }

    /**
     * Verify a password against a hash
     */
    public static boolean verifyPassword(String password, String hash) {
        try {
            byte[] saltAndHash = Base64.getDecoder().decode(hash);
            byte[] salt = new byte[16];
            byte[] storedHash = new byte[saltAndHash.length - 16];

            System.arraycopy(saltAndHash, 0, salt, 0, 16);
            System.arraycopy(saltAndHash, 16, storedHash, 0, storedHash.length);

            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(salt);
            byte[] computedHash = md.digest(password.getBytes());

            return MessageDigest.isEqual(storedHash, computedHash);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("SHA-256 algorithm not found", e);
        }
    }
}
