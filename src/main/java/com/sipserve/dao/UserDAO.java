package com.sipserve.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.sipserve.util.DBConnection;
import java.util.ArrayList;
import java.util.List;

import com.sipserve.model.User;

public class UserDAO {

    // =========================
    // REGISTER USER
    // =========================
    public boolean registerUser(String fullname, String email, String password) {
        boolean result = false;

        String sql = "INSERT INTO users(full_name, email, password,role) VALUES (?, ?, ?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, fullname);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, "CUSTOMER");

            result = ps.executeUpdate() > 0;
        }catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    // =========================
    // LOGIN USER (NEW)
    // =========================
    public String validateLogin(String email, String password, String loginType) {
        String role = null;
        String sql = "SELECT role FROM users WHERE email=? AND password=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                role = rs.getString("role");
                if(loginType.equals("admin")) {
                    if(!role.equalsIgnoreCase("admin")) {
                        return null;
                    }
                }
                else {
                    if(role.equalsIgnoreCase("admin")) {
                        return null;
                    }
                }
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

    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                users.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return users;
    }

    // =========================
   // TOTAL USERS
   // =========================
    public int getTotalUsers() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM users";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }


    // =========================
    // TOTAL CUSTOMERS
    // =========================
    public int getTotalCustomers() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM users WHERE role='CUSTOMER'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }


    // =========================
// TOTAL ADMINS
// =========================
    public int getTotalAdmins() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM users WHERE role='ADMIN'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    public User getUserByEmail(String email) {
        User user = null;
        String sql = "SELECT * FROM users WHERE email=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                user.setAddress(rs.getString("address"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

     // =========================
    // UPDATE USER PROFILE
    // =========================
    public boolean updateUser(int id, String fullName, String email,String address) {
        boolean result = false;
        String sql = "UPDATE users SET full_name=?, email=?, address=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, fullName);
            ps.setString(2, email);
            ps.setString(3, address);
            ps.setInt(4, id);
            result = ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public boolean checkOldPassword(String email, String password) {
        boolean exists = false;
        String sql = "SELECT * FROM users WHERE email=? AND password=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            exists = rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return exists;
    }

    public void updatePassword(String email, String newPassword) {
        String sql = "UPDATE users SET password=? WHERE email=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newPassword);
            ps.setString(2, email);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


}