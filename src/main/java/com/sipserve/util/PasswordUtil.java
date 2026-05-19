package com.sipserve.util;

import java.security.MessageDigest;

public class PasswordUtil {

    // Converts plain text into hash password
    public static String hashPassword(String password) {

        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");

            byte[] hash = md.digest(password.getBytes()); // Convert password string into hashed byte array

            StringBuilder sb = new StringBuilder();  // Convert byte array into hexadecimal string

            for(byte b : hash) {sb.append(String.format("%02x", b)
                );
            }

            return sb.toString();  // Return final hashed password as string

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

        String newHash = hashPassword(plainPassword);// Hash the entered password again

        return newHash.equals(hashedPassword);// Compare new hash with stored hash
    }
}