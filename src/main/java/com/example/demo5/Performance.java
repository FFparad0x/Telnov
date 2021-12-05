package com.example.demo5;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.Random;

public class Performance {
    int id;
    Theatre theatre;
    String name;
    String producer;
    ArrayList<String> actors;
    String length;
    int free_parter, free_balcony, free_beletage;
    int price_parter, price_balcony, price_beletage;
    Date date;

    public Date getDate() {
        return date;
    }

    public int getId() {
        return id;
    }

    public Performance(){
        id = IndexCounter.getPerformanceId();
    }
    public Performance(Theatre theatre){
        this();
        this.theatre = theatre;
        name = randomString(12);
        producer = randomString(4) + " " + randomString(6);
        actors = (ArrayList<String>) theatre.actors.clone();
        length = "1h 4m";
        free_parter = 3;
        free_balcony = 7;
        free_beletage = 2;
        price_balcony = 100;
        price_parter = 200;
        price_beletage = 300;
        date = new Date();
    }
    public Performance(Theatre theatre, Date date){
       this(theatre);
       this.date = date;
    }


    public String randomString(int size) {
        int leftLimit = 97; // letter 'a'
        int rightLimit = 122; // letter 'z'
        int targetStringLength = size;
        Random random = new Random();

        String generatedString = random.ints(leftLimit, rightLimit + 1)
                .limit(targetStringLength)
                .collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append)
                .toString();

        return generatedString;
    }
}
