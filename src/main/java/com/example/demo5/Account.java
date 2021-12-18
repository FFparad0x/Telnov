package com.example.demo5;


import java.util.ArrayList;
/*
Класс для пользовательского аккаунта
 */
public class Account {
    private String login;
    private String password;

    public boolean isAdmin() {
        return admin;
    }

    public ArrayList<Order> getOrders() {
        return orders;
    }

    private boolean admin;
    public static boolean isAdmin = false;
    public static boolean status;
    private ArrayList<Order> orders;

    public int getId() {
        return id;
    }

    private int id;

    public Account(String login, String password, boolean admin){
        this.login = login;
        this.password = password;
        this.admin = admin;
        this.id = IndexCounter.getIdAccount();
        this.orders = new ArrayList<>();
    }

    public void SetAdmin(){
        this.admin = true;
    }
    public String getLogin(){
        return login;
    }
    /*public void setLogin(String login){
        this.login = login;
    }
     */
    public String getPassword(){
        return password;
    }
    /*
    public void setPassword(String password){
        this.password = password;
    }

     */

}
