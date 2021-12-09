package com.example.demo5;


public class Account {
    private String login;
    private String password;
    private boolean admin;
    private String email;
    public Account(String login, String password, String email){
        this.login = login;
        this.password = password;
        this.email = email;
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
