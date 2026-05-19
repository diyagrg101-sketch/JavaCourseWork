package com.sipserve.model;


public class PaymentStat {

    private String method;
    private int total;

    public PaymentStat() {}

    public PaymentStat(String method, int total) {
        this.method = method;
        this.total = total;
    }

    public String getMethod() {
        return method;
    }

    public int getTotal() {
        return total;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    public void setTotal(int total) {
        this.total = total;
    }
}