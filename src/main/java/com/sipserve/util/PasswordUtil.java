package com.sipserve.util;

import java.security.MessageDigest;

public class PasswordUtil {

    // HASH PASSWORD
    public static String hashPassword(String password) {

        try {

            MessageDigest md =
                    MessageDigest.getInstance("SHA-256");

            byte[] hash =
                    md.digest(password.getBytes());

            StringBuilder sb =
                    new StringBuilder();

            for(byte b : hash) {
                sb.append(
                        String.format("%02x", b)
                );
            }

            return sb.toString();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // CHECK PASSWORD
    public static boolean checkPassword(
            String plainPassword,
            String hashedPassword
    ) {

        String newHash =
                hashPassword(plainPassword);

        return newHash.equals(hashedPassword);
    }
}