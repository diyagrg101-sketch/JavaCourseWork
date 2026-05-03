package com.sipserve.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.sipserve.util.DBConnection;

public class UserDAO {

    public boolean registerUser(String fullname, String email, String password) {

        boolean result = false;

        String sql = "INSERT INTO users(full_name, email, password) VALUES (?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, fullname);
            ps.setString(2, email);
            ps.setString(3, password);

            result = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }
}