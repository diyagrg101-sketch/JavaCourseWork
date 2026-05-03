package com.sipserve.dao;

import com.sipserve.model.Product;
import com.sipserve.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class ProductDAO {

    private static final String SELECT_ALL =
        "SELECT id, name, description, price, rating, image_url, " +
        "       category_id, is_signature, is_active, created_at " +
        "FROM products WHERE is_active = 1 ORDER BY id";

    private static final String SELECT_SIGNATURES =
        "SELECT id, name, description, price, rating, image_url, " +
        "       category_id, is_signature, is_active, created_at " +
        "FROM products " +
        "WHERE is_active = 1 AND is_signature = 1 " +
        "ORDER BY id";

    private static final String SELECT_BY_ID =
        "SELECT id, name, description, price, rating, image_url, " +
        "       category_id, is_signature, is_active, created_at " +
        "FROM products WHERE id = ?";

    public List<Product> findAll() {
        return query(SELECT_ALL);
    }

    public List<Product> findSignatures() {
        return query(SELECT_SIGNATURES);
    }

    public Optional<Product> findById(int id) {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(SELECT_BY_ID)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(map(rs));
                }
                return Optional.empty();
            }
        } catch (SQLException ex) {
            throw new RuntimeException("Failed to load product " + id, ex);
        }
    }

    /** Loads only the image bytes + MIME for a product (for streaming). */
    public Optional<Product> findImage(int id) {
        String sql = "SELECT image_data, image_type FROM products WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Product p = new Product();
                    p.setId(id);
                    p.setImageData(rs.getBytes("image_data"));
                    p.setImageType(rs.getString("image_type"));
                    return Optional.of(p);
                }
                return Optional.empty();
            }
        } catch (SQLException ex) {
            throw new RuntimeException("Failed to load image for product " + id, ex);
        }
    }

    /** Stores the image bytes + MIME type for a product. */
    public void updateImage(int id, byte[] data, String mimeType) {
        String sql = "UPDATE products SET image_data = ?, image_type = ? WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setBytes(1, data);
            ps.setString(2, mimeType);
            ps.setInt(3, id);
            ps.executeUpdate();
        } catch (SQLException ex) {
            throw new RuntimeException("Failed to store image for product " + id, ex);
        }
    }

    /** Returns ids of products whose image_data is still NULL. */
    public List<Integer> findIdsWithoutImageData() {
        List<Integer> ids = new ArrayList<>();
        String sql = "SELECT id FROM products WHERE image_data IS NULL AND image_url IS NOT NULL";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) ids.add(rs.getInt("id"));
        } catch (SQLException ex) {
            throw new RuntimeException("Failed to scan products", ex);
        }
        return ids;
    }

    /* ---------- helpers ---------- */

    private List<Product> query(String sql) {
        List<Product> list = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(map(rs));
            }
        } catch (SQLException ex) {
            throw new RuntimeException("Failed to load products", ex);
        }
        return list;
    }

    private Product map(ResultSet rs) throws SQLException {
        Product p = new Product();
        p.setId(rs.getInt("id"));
        p.setName(rs.getString("name"));
        p.setDescription(rs.getString("description"));
        p.setPrice(rs.getBigDecimal("price"));
        p.setRating(rs.getDouble("rating"));
        p.setImageUrl(rs.getString("image_url"));
        p.setCategoryId(rs.getInt("category_id"));
        p.setSignature(rs.getBoolean("is_signature"));
        p.setActive(rs.getBoolean("is_active"));

        Timestamp ts = rs.getTimestamp("created_at");
        if (ts != null) p.setCreatedAt(ts.toLocalDateTime());

        return p;
    }
}
