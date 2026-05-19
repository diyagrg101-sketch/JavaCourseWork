
package com.sipserve.model;

public class ReportStats {

    private double totalRevenue;
    private int totalOrders;
    private int totalCustomers;
    private double avgOrderValue;

    private int deliveredOrders;
    private int preparingOrders;
    private int readyOrders;
    private int cancelledOrders;

    public double getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(double totalRevenue) {
        this.totalRevenue = totalRevenue;
    }

    public int getTotalOrders() {
        return totalOrders;
    }

    public void setTotalOrders(int totalOrders) {
        this.totalOrders = totalOrders;
    }

    public int getTotalCustomers() {
        return totalCustomers;
    }

    public void setTotalCustomers(int totalCustomers) {
        this.totalCustomers = totalCustomers;
    }

    public double getAvgOrderValue() {
        return avgOrderValue;
    }

    public void setAvgOrderValue(double avgOrderValue) {
        this.avgOrderValue = avgOrderValue;
    }

    public int getDeliveredOrders() {
        return deliveredOrders;
    }

    public void setDeliveredOrders(int deliveredOrders) {
        this.deliveredOrders = deliveredOrders;
    }

    public int getPreparingOrders() {
        return preparingOrders;
    }

    public void setPreparingOrders(int preparingOrders) {
        this.preparingOrders = preparingOrders;
    }

    public int getReadyOrders() {
        return readyOrders;
    }

    public void setReadyOrders(int readyOrders) {
        this.readyOrders = readyOrders;
    }

    public int getCancelledOrders() {
        return cancelledOrders;
    }

    public void setCancelledOrders(int cancelledOrders) {
        this.cancelledOrders = cancelledOrders;
    }
}