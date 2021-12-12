package com.example.demo5;

public class IndexCounter {
    private static int idPerformance = 0;
    private static int idTheatre = 0;
    private static int idAccount = 1;
    public static int getPerformanceId() {
        idPerformance++;
        return idPerformance;
    }

    public static int getIdTheatre() {
        idTheatre++;
        return idTheatre;
    }
    public static int getIdAccount() {
        idTheatre++;
        return idTheatre;
    }
}
