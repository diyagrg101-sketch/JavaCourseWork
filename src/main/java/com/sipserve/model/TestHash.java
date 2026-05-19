package com.sipserve.model;

import com.sipserve.util.PasswordUtil;

public class TestHash {

        public static void main(String[] args) {
            String adminPass = "admin123";
            String generatedHash = PasswordUtil.hashPassword(adminPass);
            System.out.println("Generated Hash: " + generatedHash);

    }
}
