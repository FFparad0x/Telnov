package com.example.demo5;


public class Account {
    private String login;
    private String password;
    private boolean admin;
    public static boolean isAdmin;
    public static boolean status;
    private int id;

    public Account(String login, String password, boolean admin){
        this.login = login;
        this.password = password;
        this.admin = admin;
        this.id = IndexCounter.getIdAccount();
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
