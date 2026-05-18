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
                    "       category_id, is_signature, is_active, created_at, " +
                    "       0 AS order_count " +
                    "FROM products " +
                    "ORDER BY id";

    private static final String SELECT_ACTIVE =
            "SELECT id, name, description, price, rating, image_url, " +
                    "       category_id, is_signature, is_active, created_at, " +
                    "       0 AS order_count " +
                    "FROM products " +
                    "WHERE is_active = 1 " +
                    "ORDER BY id";

    private static final String SELECT_SIGNATURES =
            "SELECT id, name, description, price, rating, image_url, " +
                    "       category_id, is_signature, is_active, created_at, " +
                    "       0 AS order_count " +
                    "FROM products " +
                    "WHERE is_active = 1 AND is_signature = 1 " +
                    "ORDER BY id";

    private static final String SELECT_BY_ID =
            "SELECT id, name, description, price, rating, image_url, " +
                    "       category_id, is_signature, is_active, created_at, " +
                    "       0 AS order_count " +
                    "FROM products " +
                    "WHERE id = ?";
    /* ---------- finders ---------- */

    public List<Product> findAll() {
        return query(SELECT_ALL);
    }

    public List<Product> findAllActive() {
        return query(SELECT_ACTIVE);
    }

    public List<Product> findSignatures() {
        return query(SELECT_SIGNATURES);
    }

    public Optional<Product> findById(int id) {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(SELECT_BY_ID)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return Optional.of(map(rs));
                return Optional.empty();
            }
        } catch (SQLException ex) {
            throw new RuntimeException("Failed to load product " + id, ex);
        }
    }

    /* ---------- image methods ---------- */

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

    /* ---------- count methods ---------- */

    //counts all products
    public int countAll() {
        String sql = "SELECT COUNT(*) FROM products";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) return rs.getInt(1);
        } catch (SQLException ex) {
            throw new RuntimeException("Failed to count products", ex);
        }
        return 0;
    }


    public int countActive() {
        String sql = "SELECT COUNT(*) FROM products WHERE is_active = 1";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) return rs.getInt(1);
        } catch (SQLException ex) {
            throw new RuntimeException("Failed to count active products", ex);
        }
        return 0;
    }

    // Out of stock
    public int countOutOfStock() {
        String sql = "SELECT COUNT(*) FROM products WHERE is_active = 0";
        // This is acceptable if you have no separate stock column
        // If you add a stock column later: WHERE stock = 0
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) return rs.getInt(1);
        } catch (SQLException ex) {
            throw new RuntimeException("Failed to count out of stock products", ex);
        }
        return 0;
    }

    //Hidden
    public int countHidden() {
        String sql = "SELECT COUNT(*) FROM products WHERE is_active = 0 AND is_signature = 0";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) return rs.getInt(1);
        } catch (SQLException ex) {
            throw new RuntimeException("Failed to count hidden products", ex);
        }
        return 0;
    }

    /* ---------- helpers ---------- */

    private List<Product> query(String sql) {
        List<Product> list = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) list.add(map(rs));
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
        p.setOrderCount(rs.getInt("order_count"));

        Timestamp ts = rs.getTimestamp("created_at");
        if (ts != null) p.setCreatedAt(ts.toLocalDateTime());

        return p;
    }
    public void addProduct(Product product) {

        String sql = "INSERT INTO products " +
                "(name, description, price, image_data, image_type, category_id, is_signature, is_active) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, product.getName());
            ps.setString(2, product.getDescription());
            ps.setBigDecimal(3, product.getPrice());
            ps.setBytes(4, product.getImageData());
            ps.setString(5, product.getImageType());
            ps.setInt(6, product.getCategoryId());
            ps.setBoolean(7, product.isSignature());
            ps.setBoolean(8, product.isActive());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Product> searchProducts(String keyword) {

        List<Product> list = new ArrayList<>();

        String sql = """
        SELECT * FROM products
        WHERE LOWER(name) LIKE ?
        OR LOWER(description) LIKE ?
    """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            String search = "%" + keyword.toLowerCase() + "%";

            ps.setString(1, search);
            ps.setString(2, search);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Product product = new Product();

                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getBigDecimal("price"));
                product.setCategoryId(rs.getInt("category_id"));
                product.setActive(rs.getBoolean("is_active"));

                list.add(product);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}