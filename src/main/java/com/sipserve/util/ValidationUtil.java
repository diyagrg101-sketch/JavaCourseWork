package com.sipserve.util;

public class ValidationUtil {

    // Check if value is null or empty
    public static boolean isEmpty(String value) {
        return value == null ||
                value.trim().isEmpty();
    }

    // Validates email format
    public static boolean isValidEmail(
            String email
    ) {

        return email.matches(
                "^[A-Za-z0-9+_.-]+@(.+)$"
        );
    }

    // Checks if password has minimum 8 character
    public static boolean isValidPassword(
            String password
    ) {
        return password.length() >= 8;
    }
}
