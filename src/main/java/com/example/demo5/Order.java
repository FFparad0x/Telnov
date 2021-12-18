/*
Класс для хранения заказов
 */
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

    public void setPlaceType(String placeType) {
        this.placeType = placeType;
    }

    public Order(Performance performance){
        dateOfOrder = new Date();
        this.performance = performance;
        this.placeType = placeType;
    }
}
