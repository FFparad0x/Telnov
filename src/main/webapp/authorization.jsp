
<%@ page import="com.example.demo5.Account" %>
<%@ page import="com.example.demo5.DataBase" %>
<%@page import="com.example.demo5.Account" %>
<%@ page import="java.util.concurrent.TimeUnit" %>
<%@ page import="javax.servlet.http.Cookie" %>
<%@ page session="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    boolean isEqual = false;
    if(request.getParameter("exit") != null){
        Cookie[] cookie = request.getCookies();
        for (Cookie o : cookie) {
            o.setMaxAge(0);
            o.setValue(null);
            response.addCookie(o);
        }
    }

    String value1 = request.getParameter("llogin");
    String value2 = request.getParameter("lpass");
    if(value1 != null) {
        Account.status = false;
        for (Account account : DataBase.accounts) {

            if (value1.equals(account.getLogin()) && value2.equals(account.getPassword())) {
                //response.sendRedirect("performances.jsp");
                isEqual = true;
                if (account.isAdmin()) {
                    Account.isAdmin = true;
                    Cookie cookie = new Cookie("status", "admin");
                    Cookie cookie1 = new Cookie("id", String.valueOf(account.getId()));
                    cookie.setMaxAge(24 * 60 * 60);
                    cookie1.setMaxAge(24 * 60 * 60);
//                cookie.setPath("http://localhost:8080/demo5_war_exploded/");
                    response.addCookie(cookie);
                    response.addCookie(cookie1);
                } else {
                    Account.isAdmin = false;
                    Cookie cookie = new Cookie("status", "client");
                    cookie.setMaxAge(24 * 60 * 60);
                    Cookie cookie1 = new Cookie("id", String.valueOf(account.getId()));
                    cookie1.setMaxAge(24 * 60 * 60);
//                cookie.setPath("http://localhost:8080/demo5_war_exploded/");
                    response.addCookie(cookie);
                    response.addCookie(cookie1);

                }
            }
        }
    }


    if (!isEqual) {
        Account.status = true;
    }
        response.sendRedirect("index.jsp");

%>
