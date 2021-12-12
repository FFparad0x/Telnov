
<%@ page import="com.example.demo5.Account" %>
<%@ page import="com.example.demo5.DataBase" %>
<%@page import="com.example.demo5.Account" %>
<%@ page import="java.util.concurrent.TimeUnit" %>
<%@ page import="jakarta.servlet.http.Cookie" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    boolean isEqual = false;
    Account.status = false;
    for (Account account : DataBase.accounts){
        String value1 = request.getParameter("llogin");
        String value2 = request.getParameter("lpass");
        if (value1.equals(account.getLogin()) && value2.equals(account.getPassword())) {
            //response.sendRedirect("performances.jsp");
            isEqual = true;
            if (value1.equals("Admin")) {
                Account.isAdmin = true;
                Cookie cookie = new Cookie("status", "admin");
                cookie.setMaxAge(24*60*60);
                cookie.setPath("http://localhost:8080/demo5_war_exploded/index.jsp");
                response.addCookie(cookie);
                response.sendRedirect("index.jsp");
            } else {
                Account.isAdmin = false;
                Cookie cookie = new Cookie("status", "client");
                cookie.setMaxAge(24*60*60);
                cookie.setPath("http://localhost:8080/demo5_war_exploded/index.jsp");
                response.addCookie(cookie);
                response.sendRedirect("index.jsp");
            }
        }
    }
    if (!isEqual){
        Account.status = true;
        response.sendRedirect("index.jsp");
    }
%>
