package com.example.demo5;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.Random;

public class Performance {
    int id;

    public ArrayList<String> getProducers() {
        return producers;
    }

    public int getPrice_parter() {
        return price_parter;
    }

    public int getPrice_balcony() {
        return price_balcony;
    }

    public int getPrice_beletage() {
        return price_beletage;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public ArrayList<String> getProducer() {
        return producers;
    }

    public void setProducer(ArrayList<String> producer) {
        this.producers = producers;
    }

    public ArrayList<String> getActors() {
        return actors;
    }

    public void setActors(ArrayList<String> actors) {
        this.actors = actors;
    }

    public int getLength() {
        return length;
    }

    public void setLength(int length) {
        this.length = length;
    }

    public int getFree_parter() {
        return free_parter;
    }

    public void setFree_parter(int free_parter) {
        this.free_parter = free_parter;
    }

    public int getFree_balcony() {
        return free_balcony;
    }

    public void setFree_balcony(int free_balcony) {
        this.free_balcony = free_balcony;
    }

    public int getFree_beletage() {
        return free_beletage;
    }

    public void setFree_beletage(int free_beletage) {
        this.free_beletage = free_beletage;
    }

    public void setPrice_parter(int price_parter) {
        this.price_parter = price_parter;
    }

    public void setPrice_balcony(int price_balcony) {
        this.price_balcony = price_balcony;
    }

    public void setPrice_beletage(int price_beletage) {
        this.price_beletage = price_beletage;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public void setTheatre(Theatre theatre) {
        this.theatre = theatre;
    }

    Theatre theatre;
    String name;
    ArrayList<String> producers;
    ArrayList<String> actors;
    int length;
    int free_parter, free_balcony, free_beletage;
    int price_parter, price_balcony, price_beletage;
    Date date;

    public Date getDate() {
        return date;
    }

    public String PrintActors() {
        String result = "";
        for (String actor : actors) {
            result = result + actor + "\n";
        }
        return result;
    }

    public String PrintProducers() {
        String result = "";
        for (String actor : producers) {
            result = result + actor + "\n";
        }
        return result;
    }

    public int getId() {
        return id;
    }

    public Performance() {
        id = IndexCounter.getPerformanceId();
        producers = new ArrayList<>();
        actors = new ArrayList<>();
    }

    public Performance(Theatre theatre) {
        this();
        this.theatre = theatre;


    }

    public void Fill() {
        length = 140;
        free_parter = 3;
        free_balcony = 7;
        free_beletage = 2;
        price_balcony = 100;
        price_parter = 200;
        price_beletage = 300;
        date = new Date();
        name = randomString(12);
        producers = (ArrayList<String>) theatre.producers.clone();
        actors = (ArrayList<String>) theatre.actors.clone();
    }

    public Performance(Theatre theatre, Date date) {
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
