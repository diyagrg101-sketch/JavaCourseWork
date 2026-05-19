package com.sipserve.model;


public class TopProduct {

    private String name;
    private int totalSold;

    public TopProduct() {}

    public TopProduct(String name, int totalSold) {
        this.name = name;
        this.totalSold = totalSold;
    }

    public String getName() {
        return name;
    }

    public int getTotalSold() {
        return totalSold;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setTotalSold(int totalSold) {
        this.totalSold = totalSold;
    }
}