package com.sipserve.dao;


import com.sipserve.model.*;
import com.sipserve.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ReportDAO {

    public ReportStats getDashboardStats() {

        ReportStats stats = new ReportStats();

        try (Connection conn = DBConnection.getConnection()) {

            String revenueSql =
                    "SELECT IFNULL(SUM(total_amount),0) revenue " +
                            "FROM orders WHERE status='DELIVERED'";

            PreparedStatement ps1 = conn.prepareStatement(revenueSql);
            ResultSet rs1 = ps1.executeQuery();

            if (rs1.next()) {
                stats.setTotalRevenue(rs1.getDouble("revenue"));
            }

            String orderSql =
                    "SELECT COUNT(*) totalOrders FROM orders";

            PreparedStatement ps2 = conn.prepareStatement(orderSql);
            ResultSet rs2 = ps2.executeQuery();

            if (rs2.next()) {
                stats.setTotalOrders(rs2.getInt("totalOrders"));
            }

            String customerSql =
                    "SELECT COUNT(*) totalCustomers " +
                            "FROM users WHERE role='CUSTOMER'";

            PreparedStatement ps3 = conn.prepareStatement(customerSql);
            ResultSet rs3 = ps3.executeQuery();

            if (rs3.next()) {
                stats.setTotalCustomers(rs3.getInt("totalCustomers"));
            }

            String avgSql =
                    "SELECT IFNULL(AVG(total_amount),0) avgValue FROM orders";

            PreparedStatement ps4 = conn.prepareStatement(avgSql);
            ResultSet rs4 = ps4.executeQuery();

            if (rs4.next()) {
                stats.setAvgOrderValue(rs4.getDouble("avgValue"));
            }

            String statusSql =
                    "SELECT status, COUNT(*) total " +
                            "FROM orders GROUP BY status";

            PreparedStatement ps5 = conn.prepareStatement(statusSql);
            ResultSet rs5 = ps5.executeQuery();

            while (rs5.next()) {

                String status = rs5.getString("status");
                int total = rs5.getInt("total");

                switch (status) {

                    case "DELIVERED":
                        stats.setDeliveredOrders(total);
                        break;

                    case "PREPARING":
                        stats.setPreparingOrders(total);
                        break;

                    case "READY":
                        stats.setReadyOrders(total);
                        break;

                    case "CANCELLED":
                        stats.setCancelledOrders(total);
                        break;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return stats;
    }

    public List<TopProduct> getTopProducts() {

        List<TopProduct> list = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection()) {

            String sql =
                    "SELECT p.name, SUM(oi.quantity) totalSold " +
                            "FROM order_items oi " +
                            "JOIN products p ON oi.product_id = p.id " +
                            "GROUP BY p.id " +
                            "ORDER BY totalSold DESC " +
                            "LIMIT 6";

            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                TopProduct product = new TopProduct();

                product.setName(rs.getString("name"));
                product.setTotalSold(rs.getInt("totalSold"));

                list.add(product);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<DailyRevenue> getDailyRevenue() {

        List<DailyRevenue> list = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection()) {

            String sql =
                    "SELECT DATE(created_at) orderDate, " +
                            "COUNT(*) totalOrders, " +
                            "SUM(total_amount) revenue, " +
                            "AVG(total_amount) avgValue " +
                            "FROM orders " +
                            "GROUP BY DATE(created_at) " +
                            "ORDER BY orderDate DESC " +
                            "LIMIT 10";

            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                DailyRevenue dr = new DailyRevenue();

                dr.setOrderDate(rs.getString("orderDate"));
                dr.setTotalOrders(rs.getInt("totalOrders"));
                dr.setRevenue(rs.getDouble("revenue"));
                dr.setAvgValue(rs.getDouble("avgValue"));

                list.add(dr);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<PaymentStat> getPaymentStats() {

        List<PaymentStat> list = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection()) {

            String sql =
                    "SELECT method, COUNT(*) total " +
                            "FROM payments " +
                            "GROUP BY method";

            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                PaymentStat stat = new PaymentStat();

                stat.setMethod(rs.getString("method"));
                stat.setTotal(rs.getInt("total"));

                list.add(stat);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}