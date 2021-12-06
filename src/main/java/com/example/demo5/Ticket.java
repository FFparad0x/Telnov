package com.example.demo5;

import java.lang.Math;

public class Ticket {
    int row; //ряд
    int place; //место
    String type; //тип места
    boolean can_i_buy; //куплен или нет

    public void setTicket(){
        row = 1 + (int)(Math.random()*4);
        place = 1 + (int)(Math.random()*5);
    }

    public int getRow() {
        return row;
    }

    public int getPlace() {
        return place;
    }

    public void ticketSold(){
        can_i_buy = false;
    }

    public void ticketNoSold(){
        can_i_buy = true;
    }
    public Ticket(){
        for (Ticket ticket : DataBaseTicket.tickets){
        }
    }
}
