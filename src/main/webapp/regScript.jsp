<%@ page import="com.example.demo5.Account" %>
<%@ page import="com.example.demo5.DataBase" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    if (request.getParameter("llogin") != null && request.getParameter("lpass")!=null) {
        String value1 = request.getParameter("llogin");
        String value2 = request.getParameter("lpass");
        Account account = new Account(value1, value2, "123");
        DataBase.accounts.add(account);
        response.sendRedirect("index.jsp");
    }
%>