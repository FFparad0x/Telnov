package com.example.demo5;

import java.util.Date;

public class Order {

    Performance performance;
    Date dateOfOrder;
    String placeType;
    public Performance getPerformance() {
        return performance;
    }

    public Date getDateOfOrder() {
        return dateOfOrder;
    }

    public String getPlaceType() {
        return placeType;
    }

    public Order(Performance performance, String placeType){
        dateOfOrder = new Date();
        this.performance = performance;
        this.placeType = placeType;
    }
}
