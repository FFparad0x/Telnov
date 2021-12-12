package com.example.demo5;

import java.util.Date;

public class Order {
    public Performance getPerformance() {
        return performance;
    }

    public Date getDateOfOrder() {
        return dateOfOrder;
    }

    Performance performance;
    Date dateOfOrder;
    public Order(Performance performance){
        dateOfOrder = new Date();
        this.performance = performance;
    }
}
