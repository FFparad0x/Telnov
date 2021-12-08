package com.example.demo5;


public class Account {
    private String login;
    private String password;
    private int age;
    private String email;

    public boolean isAdmin() {
        return admin;
    }

    private boolean admin;

    public Account(String login, String password, String email){
        this.login = login;
        this.password = password;
        admin = false;
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
