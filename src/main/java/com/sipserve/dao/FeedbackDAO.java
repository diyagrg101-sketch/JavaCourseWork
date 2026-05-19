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

    public int insert(Feedback fb) {
        // Columns now match the schema (user_name, user_email, rating, message)
        String sql = "INSERT INTO feedback (user_name, user_email, rating, message) " +
                "VALUES (?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, sanitize(fb.getUserName()));
            ps.setString(2, sanitize(fb.getUserEmail()));
            ps.setInt   (3, fb.getRating());
            ps.setString(4, sanitize(fb.getMessage()));
            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) {
            log.log(Level.SEVERE, "insert() failed", e);
            throw new RuntimeException("Could not save feedback", e);
        }
        return -1;
    }

    // ── Read: community feed ──────────────────────────────────────────────────

    public List<Feedback> getRecent(int limit) {
        String sql = "SELECT * FROM feedback ORDER BY created_at DESC LIMIT ?";
        List<Feedback> list = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(map(rs));
            }
        } catch (SQLException e) {
            log.log(Level.SEVERE, "getRecent() failed", e);
            throw new RuntimeException("Could not load recent feedback", e);
        }
        return list;
    }

    // ── Read: admin report ────────────────────────────────────────────────────

    public List<Feedback> getAll() {
        String sql = "SELECT * FROM feedback ORDER BY created_at DESC";
        List<Feedback> list = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) list.add(map(rs));
        } catch (SQLException e) {
            log.log(Level.SEVERE, "getAll() failed", e);
            throw new RuntimeException("Could not load all feedback", e);
        }
        return list;
    }

    // ── Combined stats — single round-trip (replaces getTotalCount + getAverageRating) ──

    /**
     * Returns [totalCount, averageRating] in one DB round-trip.
     * averageRating is rounded to 1 decimal; 0.0 when there are no rows.
     */
    public double[] getStats() {
        String sql = "SELECT COUNT(*) AS total, COALESCE(AVG(rating), 0) AS avg_rating " +
                "FROM feedback";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                int    total  = rs.getInt("total");
                double avg    = Math.round(rs.getDouble("avg_rating") * 10.0) / 10.0;
                return new double[]{total, avg};
            }
        } catch (SQLException e) {
            log.log(Level.SEVERE, "getStats() failed", e);
            throw new RuntimeException("Could not load feedback stats", e);
        }
        return new double[]{0, 0.0};
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

    private Feedback map(ResultSet rs) throws SQLException {
        Feedback fb = new Feedback();
        fb.setId       (rs.getInt      ("id"));
        fb.setUserName (rs.getString   ("user_name"));
        fb.setUserEmail(rs.getString   ("user_email"));
        fb.setRating   (rs.getInt      ("rating"));
        fb.setMessage  (rs.getString   ("message"));
        fb.setCreatedAt(rs.getTimestamp("created_at"));
        return fb;
    }

    /**
     * Strip HTML tags at write time as a defence-in-depth measure.
     * Primary XSS protection is fn:escapeXml() in the JSP at render time.
     */
    private String sanitize(String s) {
        return (s == null) ? "" : s.replaceAll("<[^>]*>", "").trim();
    }
}