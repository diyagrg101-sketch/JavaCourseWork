package com.sipserve.dao;

import com.sipserve.model.Feedback;
import com.sipserve.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FeedbackDAO {

    // ─────────────────────────────────────────────
    // INSERT
    // ─────────────────────────────────────────────
    public int insert(Feedback fb) {

        String sql = "INSERT INTO feedback (user_id, product_id, rating, review) " +
                "VALUES (?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, fb.getUserId());
            ps.setInt(2, fb.getProductId());
            ps.setInt(3, fb.getRating());
            ps.setString(4, fb.getReview());

            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }

        } catch (Exception e) {
            throw new RuntimeException("Insert feedback failed", e);
        }

        return -1;
    }

    // ─────────────────────────────────────────────
    // RECENT FEEDBACK (for customer page)
    // ─────────────────────────────────────────────
    public List<Feedback> getRecent(int limit) {

        String sql =
                "SELECT f.id, f.rating, f.review, f.created_at, " +
                        "u.full_name, u.email " +
                        "FROM feedback f " +
                        "JOIN users u ON f.user_id = u.id " +
                        "ORDER BY f.created_at DESC LIMIT ?";

        List<Feedback> list = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, limit);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    Feedback fb = new Feedback();

                    fb.setId(rs.getInt("id"));
                    fb.setRating(rs.getInt("rating"));
                    fb.setReview(rs.getString("review"));
                    fb.setCreatedAt(rs.getTimestamp("created_at"));

                    fb.setFullName(rs.getString("full_name"));
                    fb.setEmail(rs.getString("email"));

                    list.add(fb);
                }
            }

        } catch (Exception e) {
            throw new RuntimeException("getRecent failed", e);
        }

        return list;
    }

    // ─────────────────────────────────────────────
    // ADMIN: GET ALL FEEDBACK (FIXED - THIS WAS MISSING)
    // ─────────────────────────────────────────────
    public List<Feedback> getAll() {

        String sql =
                "SELECT f.id, f.rating, f.review, f.created_at, " +
                        "u.full_name, u.email " +
                        "FROM feedback f " +
                        "JOIN users u ON f.user_id = u.id " +
                        "ORDER BY f.created_at DESC";

        List<Feedback> list = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Feedback fb = new Feedback();

                fb.setId(rs.getInt("id"));
                fb.setRating(rs.getInt("rating"));
                fb.setReview(rs.getString("review"));
                fb.setCreatedAt(rs.getTimestamp("created_at"));

                fb.setFullName(rs.getString("full_name"));
                fb.setEmail(rs.getString("email"));

                list.add(fb);
            }

        } catch (Exception e) {
            throw new RuntimeException("getAll failed", e);
        }

        return list;
    }

    // ─────────────────────────────────────────────
    // STATS
    // ─────────────────────────────────────────────
    public double[] getStats() {

        String sql =
                "SELECT COUNT(*) AS total, COALESCE(AVG(rating),0) AS avg_rating " +
                        "FROM feedback";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return new double[]{
                        rs.getInt("total"),
                        Math.round(rs.getDouble("avg_rating") * 10.0) / 10.0
                };
            }

        } catch (Exception e) {
            throw new RuntimeException("getStats failed", e);
        }

        return new double[]{0, 0.0};
    }

    // ─────────────────────────────────────────────
    // DELETE
    // ─────────────────────────────────────────────
    public boolean deleteById(int id) {

        String sql = "DELETE FROM feedback WHERE id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            throw new RuntimeException("delete failed", e);
        }
    }
}