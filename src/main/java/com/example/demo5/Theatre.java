package com.example.demo5;

import jakarta.ws.rs.PUT;

import java.util.ArrayList;
import java.util.Random;


public class Theatre {
    String name;
    ArrayList<String> actors;
    ArrayList<String> producers;
    int id;

    public ArrayList<String> getProducers() {
        return producers;
    }

    public ArrayList<String> getActors() {
        return actors;
    }

    String address;

    public void setNum_parter(int num_parter) {
        this.num_parter = num_parter;
    }

    public void setNum_beletage(int num_beletage) {
        this.num_beletage = num_beletage;
    }

    public void setNum_balcon(int num_balcon) {
        this.num_balcon = num_balcon;
    }

    int num_parter, num_beletage, num_balcon;
    ArrayList<Performance> performances;

    public void setPerformances(ArrayList<Performance> performances) {
        this.performances = performances;
    }

    public ArrayList<Performance> getPerformances() {
        return performances;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getAddress() {
        return address;
    }

    public int getNum_sum() {
        return num_balcon + num_beletage + num_parter;
    }

    public Theatre() {
        id = IndexCounter.getIdTheatre();
        actors = new ArrayList<>();
        producers = new ArrayList<>();
        performances = new ArrayList<>();
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getNum_balcon() {
        return num_balcon;
    }

    public int getNum_beletage() {
        return num_beletage;
    }

    public int getNum_parter() {
        return num_parter;
    }

    public void Fill() {
        num_balcon = 10;
        num_beletage = 10;
        num_parter = 10;
        address = randomString(12);
        name = randomString(12);
        for (int i = 0; i < 10; i++) {
            producers.add(randomString(4) + " " + randomString(6));
            actors.add(randomString(4) + " " + randomString(6));
            Performance t = new Performance(this);
            t.Fill();
            performances.add(t);
        }
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

    public Performance GetPerformanceById(int id) {
        for (Performance performance : performances) {
            if (performance.id == id) {
                return performance;
            }
        }
        return null;
    }

    public String PrintProducers() {
        String result = "";
        for (String producer : producers) {
            result = result + producer + "\n";
        }
        return result;
    }

    public String PrintActors() {
        String result = "";
        for (String actor : actors) {
            result = result + actor + "\n";
        }
        return result;
    }
}
