package com.example.demo5;

import java.util.ArrayList;
import java.util.Random;


public class Theatre {
    String name;
    ArrayList<String> actors;
    ArrayList<String> producers;

    public ArrayList<String> getProducers() {
        return producers;
    }

    String address;
    int num_parter, num_beletage, num_balcon;
    ArrayList<Performance> performances;

    public void setPerformances(ArrayList<Performance> performances) {
        this.performances = performances;
    }

    public ArrayList<Performance> getPerformances() {
        return performances;
    }

    public Theatre(){
        name = randomString(12);
        actors = new ArrayList<>();
        producers = new ArrayList<>();
        address = randomString( 20);
        num_balcon = 10;
        num_beletage = 10;
        num_parter = 10;
        performances = new ArrayList<>();
        Init();
    }

    private void Init() {
        for(int i = 0; i<10;i++){
            producers.add(randomString(4) + " " + randomString(6));
            actors.add(randomString(4) + " " + randomString(6));
            performances.add(new Performance(this));
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
}
