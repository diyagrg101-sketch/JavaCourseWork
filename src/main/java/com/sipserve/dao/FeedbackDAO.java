package com.sipserve.dao;

import com.sipserve.model.Feedback;
import com.sipserve.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class FeedbackDAO {

    private static final Logger log = Logger.getLogger(FeedbackDAO.class.getName());

    // ── Insert ────────────────────────────────────────────────────────────────

    /**
     * Inserts a new feedback row.
     * Returns the generated id, or -1 on failure.
     * Throws RuntimeException if a duplicate (user_id, product_id) exists —
     * caller should catch and show "already reviewed" message.
     */
    public int insert(Feedback fb) {
        String sql = "INSERT INTO feedback (user_id, product_id, rating, review) " +
                "VALUES (?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt   (1, fb.getUserId());
            ps.setInt   (2, fb.getProductId());
            ps.setInt   (3, fb.getRating());
            ps.setString(4, sanitize(fb.getReview()));
            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLIntegrityConstraintViolationException e) {
            // Duplicate (user_id, product_id) — user already reviewed this product
            throw new RuntimeException("DUPLICATE", e);
        } catch (SQLException e) {
            log.log(Level.SEVERE, "insert() failed", e);
            throw new RuntimeException("Could not save feedback", e);
        }
        return -1;
    }

    // ── Read: community feed ──────────────────────────────────────────────────

    /**
     * Recent reviews joined with users and products for display names.
     */
    public List<Feedback> getRecent(int limit) {
        String sql = "SELECT f.id, f.user_id, f.product_id, f.rating, f.review, f.created_at, " +
                "       u.full_name AS user_name, p.name AS product_name " +
                "FROM feedback f " +
                "JOIN users    u ON u.id = f.user_id " +
                "JOIN products p ON p.id = f.product_id " +
                "ORDER BY f.created_at DESC LIMIT ?";
        List<Feedback> list = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapJoined(rs));
            }
        } catch (SQLException e) {
            log.log(Level.SEVERE, "getRecent() failed", e);
            throw new RuntimeException("Could not load recent feedback", e);
        }
        return list;
    }

    // ── Read: admin report ────────────────────────────────────────────────────

    /**
     * All reviews joined with users and products — for admin report page.
     */
    public List<Feedback> getAll() {
        String sql = "SELECT f.id, f.user_id, f.product_id, f.rating, f.review, f.created_at, " +
                "       u.full_name AS user_name, p.name AS product_name " +
                "FROM feedback f " +
                "JOIN users    u ON u.id = f.user_id " +
                "JOIN products p ON p.id = f.product_id " +
                "ORDER BY f.created_at DESC";
        List<Feedback> list = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) list.add(mapJoined(rs));
        } catch (SQLException e) {
            log.log(Level.SEVERE, "getAll() failed", e);
            throw new RuntimeException("Could not load all feedback", e);
        }
        return list;
    }

    // ── Stats — single round-trip ─────────────────────────────────────────────

    /**
     * Returns [totalCount, averageRating] in one DB round-trip.
     */
    public double[] getStats() {
        String sql = "SELECT COUNT(*) AS total, COALESCE(AVG(rating), 0) AS avg_rating " +
                "FROM feedback";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                int    total = rs.getInt("total");
                double avg   = Math.round(rs.getDouble("avg_rating") * 10.0) / 10.0;
                return new double[]{total, avg};
            }
        } catch (SQLException e) {
            log.log(Level.SEVERE, "getStats() failed", e);
            throw new RuntimeException("Could not load feedback stats", e);
        }
        return new double[]{0, 0.0};
    }

    // ── Products list for dropdown ────────────────────────────────────────────

    /**
     * Returns all products as [id, name] pairs for the feedback form dropdown.
     * Each element is Object[]{Integer id, String name}.
     */
    public List<Object[]> getAllProducts() {
        String sql = "SELECT id, name FROM products ORDER BY name";
        List<Object[]> list = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(new Object[]{ rs.getInt("id"), rs.getString("name") });
            }
        } catch (SQLException e) {
            log.log(Level.SEVERE, "getAllProducts() failed", e);
            throw new RuntimeException("Could not load products", e);
        }
        return list;
    }

    // ── Get user id by email ──────────────────────────────────────────────────

    /**
     * Looks up the users.id for a given email address.
     * Used by FeedbackServlet to resolve session email → user_id FK.
     * Returns -1 if not found.
     */
    public int getUserIdByEmail(String email) {
        String sql = "SELECT id FROM users WHERE email = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt("id");
            }
        } catch (SQLException e) {
            log.log(Level.SEVERE, "getUserIdByEmail() failed", e);
            throw new RuntimeException("Could not resolve user", e);
        }
        return -1;
    }

    // ── Delete ────────────────────────────────────────────────────────────────

    public boolean deleteById(int id) {
        String sql = "DELETE FROM feedback WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            log.log(Level.SEVERE, "deleteById() failed for id=" + id, e);
            throw new RuntimeException("Could not delete feedback", e);
        }
    }

    // ── Helpers ───────────────────────────────────────────────────────────────

    /** Map a joined result set row (includes user_name, product_name). */
    private Feedback mapJoined(ResultSet rs) throws SQLException {
        Feedback fb = new Feedback();
        fb.setId         (rs.getInt      ("id"));
        fb.setUserId     (rs.getInt      ("user_id"));
        fb.setProductId  (rs.getInt      ("product_id"));
        fb.setUserName   (rs.getString   ("user_name"));
        fb.setProductName(rs.getString   ("product_name"));
        fb.setRating     (rs.getInt      ("rating"));
        fb.setReview     (rs.getString   ("review"));
        fb.setCreatedAt  (rs.getTimestamp("created_at"));
        return fb;
    }

    /** Strip HTML tags — defence-in-depth; JSP uses fn:escapeXml at render. */
    private String sanitize(String s) {
        return (s == null) ? "" : s.replaceAll("<[^>]*>", "").trim();
    }
}
