package com.sipserve.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.sipserve.util.DBConnection;

public class UserDAO {

    // =========================
    // REGISTER USER
    // =========================
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


    // =========================
    // LOGIN USER (NEW)
    // =========================
    public String validateLogin(String email, String password) {

        String role = null;

        String sql = "SELECT role FROM users WHERE email=? AND password=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                role = rs.getString("role");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return role;
    }
    // =========================
    // GET USER NAME BY EMAIL
    // =========================
    public String getUserNameByEmail(String email) {

        String fullname = null;

        String sql = "SELECT full_name FROM users WHERE email=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                fullname = rs.getString("full_name");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return fullname;
    }
}