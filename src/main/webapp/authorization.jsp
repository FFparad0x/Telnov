
<%@ page import="com.example.demo5.Account" %>
<%@ page import="com.example.demo5.DataBase" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    for (Account account : DataBase.accounts){
        String value1 = request.getParameter("llogin");
        String value2 = request.getParameter("lpass");
        if (value1.equals(account.getLogin()) && value2.equals(account.getPassword())){
            //response.sendRedirect("performances.jsp");
            response.getWriter().println("hehe");
        }
        else{
            //response.sendRedirect("index.jsp");
            response.getWriter().println("что-то пошло не так");
        }
    }
%>
