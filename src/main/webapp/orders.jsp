<%@ page import="com.example.demo5.Theatre" %>
<%@ page import="com.example.demo5.DataBase" %>
<%@ page import="com.example.demo5.Performance" %>
<%@ page import="com.example.demo5.Order" %><%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 12.12.2021
  Time: 18:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="res/styles.css">
    <title>
        Мои заказы
    </title>
</head>
<body>
<jsp:include page="include/shapka.jsp"></jsp:include>
<%
    if(request.getParameter("buy") != null){
        Theatre theatre = DataBase.getTheatre(Integer.parseInt(request.getParameter("theatre")));
        Performance performance = theatre.GetPerformanceById(Integer.parseInt(request.getParameter("perf")));
        Order order = new Order(performance);

    }
%>
</body>
</html>
