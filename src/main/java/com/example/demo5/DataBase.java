package com.example.demo5;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Map;

public class DataBase {
    public static ArrayList<Theatre> theatres;
    public static ArrayList<Performance> performances;
    public static ArrayList<Account> accounts;
    public static ArrayList<Ticket> tickets;

    public static void InitTheatre(int num) {
        theatres = new ArrayList<>();
        for (int i = 0; i < num; i++) {
            Theatre temp = new Theatre();
            temp.Fill();
            theatres.add(temp);
        }

    }

    public static Theatre getTheatre(int id) {
        for (Theatre theatre : theatres) {
            if (theatre.id == id) {
                return theatre;
            }
        }
        return null;
    }
    public static void InitAccounts(){
        accounts = new ArrayList<>();
        Account AdminAcc = new Account("Admin", "asdf", true);
        accounts.add(AdminAcc);
        Account.isAdmin = false;
    }
}
