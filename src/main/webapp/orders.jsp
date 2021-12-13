 <%@ page import="jakarta.servlet.http.Cookie" %>
<%@ page import="com.example.demo5.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %><%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 12.12.2021
  Time: 18:56
  To change this template use File | Settings | File Templates.
--%>
 <%@ page contentType="text/html;charset=UTF-8" %>
<%@ page session="false" %>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="res/styles.css">
    <title>
        Мои заказы
    </title>
</head>
<body>
<%@ include file = "include/shapka.jsp" %>
<h2 style="text-align: center">История покупок</h2>

<%
    if (request.getParameter("buy") != null) {
        Theatre theatre = DataBase.getTheatre(Integer.parseInt(request.getParameter("theatre")));
        Performance performance = theatre.GetPerformanceById(Integer.parseInt(request.getParameter("perf")));
        Order order = new Order(performance);
        if(request.getParameter("place").equals("Балкон")){
            performance.setFree_balcony(performance.getFree_balcony() - 1);
        }
        if(request.getParameter("place").equals("Бельэтаж")){
            performance.setFree_beletage(performance.getFree_beletage() - 1);
        }
        if(request.getParameter("place").equals("Партер")){
            performance.setFree_parter(performance.getFree_parter() - 1);
        }
        order.setPlaceType(request.getParameter("place"));
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : request.getCookies()) {
                if (cookie.getName().equals("id")) {
                    Account account = DataBase.getAccount(Integer.parseInt(cookie.getValue()));
                    account.getOrders().add(order);

                    %>
<h3 style="color: rgba(62,190,68,0.87);text-align: center">Билет куплен</h3>
<%

                }
            }
        }
    }
    Cookie[] cookies = request.getCookies();
%>

<table class="iksweb">
    <tr>
        <th>Дата покупки</th>
        <th>Концерт</th>
        <th>Дата представления</th>
        <th>Вид места</th>
    </tr>

    <%
        if (cookies != null) {
            for (Cookie cookie : request.getCookies()) {
                if (cookie.getName().equals("id")) {
                    Account account = DataBase.getAccount(Integer.parseInt(cookie.getValue()));
                    if (account.getOrders().size() > 0) {
                        for (Order order : account.getOrders()) {
                            Date temp = order.getDateOfOrder();
                            SimpleDateFormat format = new SimpleDateFormat("dd-MM-yyyy mm:H");
    %>
    <tr>
        <td>
            <%=format.format(temp)%>
        </td>
        <td>
            <%=order.getPerformance().getName()%>
        </td>
        <td>
            <%=format.format(order.getPerformance().getDate())%>
        </td>
        <td>
            <%=order.getPlaceType()%>
        </td>
    </tr>
    <%
        }
        break;
    } else {

    %>
    <tr>
        <td colspan="4"> Вы еще не купили ни одного билета!</td>
    </tr>
    <%

                        break;
                    }
                }
            }
        } else
            response.sendRedirect("index.jsp");

    %>
</table>
</body>
</html>
