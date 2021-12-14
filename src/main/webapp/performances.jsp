<%@ page import="com.example.demo5.DataBase" %>
<%@ page import="com.example.demo5.Theatre" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.demo5.Performance" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.servlet.http.Cookie" %>
<%--<%@ page import="javax.servlet.http.Cookie" %>--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page session="false" %>

<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="res/styles.css">
    <title>Предстваления</title>
</head>
<body>

<%@ include file = "include/shapka.jsp" %>
<%
//    request.setCharacterEncoding("UTF-8");
    boolean admin = false;
    Cookie[] cookies = request.getCookies(); //проверка на логин
    if (cookies != null) {
        for (Cookie cookie : request.getCookies()) {
            if (cookie.getName().equals("status") && cookie.getValue().equals("admin")) {
                admin = true;
                break;
            }
        }
    }
    Theatre theatre = null;
    if (request.getParameter("id") != null) {
        int id = Integer.parseInt(request.getParameter("id"));
        theatre = DataBase.getTheatre(id);

    }

    if (request.getParameter("saveid") != null) {
        Performance temp = theatre.GetPerformanceById(Integer.parseInt(request.getParameter("saveid")));
        Map<String, String[]> param = request.getParameterMap();
        temp.setName(request.getParameter("name"));
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd'T'H:mm");
        temp.setDate(format.parse(request.getParameter("date")));
        temp.getProducer().clear();
        if(param.get("producers") != null)
            for (String producer : param.get("producers")) {
                temp.getProducer().add(producer);
            }
        else
            temp.getProducer().add("");
        temp.getActors().clear();
        if(param.get("actors") != null)
            for (String producer : param.get("actors")) {
                temp.getActors().add(producer);
            }
        else
            temp.getActors().add("");
        temp.setFree_parter( Integer.parseInt(request.getParameter("freeparter")) < theatre.getNum_parter() ?  Integer.parseInt(request.getParameter("freeparter")):  theatre.getNum_parter());
        temp.setFree_balcony(Integer.parseInt(request.getParameter("freebalcony")) < theatre.getNum_balcon() ?  Integer.parseInt(request.getParameter("freebalcony")):  theatre.getNum_balcon());
        temp.setFree_beletage(Integer.parseInt(request.getParameter("freebeletage")) < theatre.getNum_beletage() ?  Integer.parseInt(request.getParameter("freebeletage")):  theatre.getNum_beletage());
        temp.setPrice_balcony(Integer.parseInt(request.getParameter("balcony")));
        temp.setPrice_beletage(Integer.parseInt(request.getParameter("beletage")));
        temp.setLength(Integer.parseInt(request.getParameter("len")));
        temp.setPrice_parter(Integer.parseInt(request.getParameter("parter")));
    }

    if (request.getParameter("add") != null) {
        Performance temp = new Performance(theatre);
        Map<String, String[]> param = request.getParameterMap();
        temp.setName(request.getParameter("name"));
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd'T'H:mm");
        temp.setDate(format.parse(request.getParameter("date")));
        temp.getProducer().clear();
        if(param.get("producers") != null)
            for (String producer : param.get("producers")) {
                temp.getProducer().add(producer);
            }
        else
            temp.getProducer().add("");
        temp.getActors().clear();
        if(param.get("actors") != null)
            for (String producer : param.get("actors")) {
                temp.getActors().add(producer);
            }
        else
            temp.getActors().add("");
        temp.setFree_parter( Integer.parseInt(request.getParameter("freeparter")) < theatre.getNum_parter() ?  Integer.parseInt(request.getParameter("freeparter")):  theatre.getNum_parter());
        temp.setFree_balcony(Integer.parseInt(request.getParameter("freebalcony")) < theatre.getNum_balcon() ?  Integer.parseInt(request.getParameter("freebalcony")):  theatre.getNum_balcon());
        temp.setFree_beletage(Integer.parseInt(request.getParameter("freebeletage")) < theatre.getNum_beletage() ?  Integer.parseInt(request.getParameter("freebeletage")):  theatre.getNum_beletage());
        temp.setPrice_balcony(Integer.parseInt(request.getParameter("balcony")));
        temp.setPrice_beletage(Integer.parseInt(request.getParameter("beletage")));
        temp.setLength(Integer.parseInt(request.getParameter("len")));
        temp.setPrice_parter(Integer.parseInt(request.getParameter("parter")));
        temp.setTheatre(theatre);
        theatre.getPerformances().add(temp);
    }

    if (request.getParameter("delid") != null) {
        for (Performance performance : theatre.getPerformances()) {
            if (performance.getId() == Integer.parseInt(request.getParameter("delid"))) {
                theatre.getPerformances().remove(performance);
                break;
            }
        }
    }
%>
<%-- Тут вывод в таблицу--%>

<%
    if (admin) {%>
<form action="Performance.jsp" method="post">
    <button type="submit" name="id" value="-1" class="jbtn">Добавить представление</button>
    <input type="hidden" name="theatre" value="<%=theatre.getId()%>">
</form>
<% }
    ArrayList<Performance> performancesToShow = null;
    if (DataBase.theatres != null) {
        if (performancesToShow == null) {
            performancesToShow = theatre.getPerformances();
        }%>
<table class="iksweb">
    <tr>
        <th>Название</th>
        <th>Дата</th>
        <th>Режиссер</th>
        <th>Длительность</th>
        <th>Партер ₽</th>
        <th>Балкон ₽</th>
        <th>Бельэтаж ₽</th>
        <%
            if (admin) {
        %>
        <th>Ред.</th>
        <%
            }%>
    </tr>

    <%
        if (performancesToShow.size() != 0)
            for (Performance performance : performancesToShow) {
    %>
    <tr>
        <td onclick="window.location = 'performancdetails.jsp?id=<%=performance.getId()%>&theatre=<%=theatre.getId()%>'">
            <%=performance.getName()%>
        </td>
        <td onclick="window.location = 'performancdetails.jsp?id=<%=performance.getId()%>&theatre=<%=theatre.getId()%>'">
            <%=performance.getDate().toString()%>
        </td>
        <td onclick="window.location = 'performancdetails.jsp?id=<%=performance.getId()%>&theatre=<%=theatre.getId()%>'" style="text-align: right">
            <%=performance.PrintProducers()%>
        </td>
        <td onclick="window.location = 'performancdetails.jsp?id=<%=performance.getId()%>&theatre=<%=theatre.getId()%>'">
            <%=performance.getLength()%> мин.
        </td>
        <td onclick="window.location = 'performancdetails.jsp?id=<%=performance.getId()%>&theatre=<%=theatre.getId()%>'">
            <%=performance.getPrice_parter()%>
        </td>
        <td onclick="window.location = 'performancdetails.jsp?id=<%=performance.getId()%>&theatre=<%=theatre.getId()%>'">
            <%=performance.getPrice_balcony()%>
        </td>
        <td onclick="window.location = 'performancdetails.jsp?id=<%=performance.getId()%>&theatre=<%=theatre.getId()%>'">
            <%=performance.getPrice_beletage()%>
        </td>
        <%

            if (admin) {
        %>
        <td class="Superb"
            onclick="window.location = 'Performance.jsp?id=<%=performance.getId()%>&theatre=<%=theatre.getId()%>'">
            &#9998;
        </td>

        <%
            }
        %>
    </tr>
    <%
        }
    else {%>
    <tr>
        <td colspan="6"> Предствалений не найдено</td>
    </tr>
    <%
        }
    %>

</table>
<%
    }

%>

</body>
</html>
