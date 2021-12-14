<%--suppress CheckTagEmptyBody --%>
<%@ page import="com.example.demo5.Theatre" %>
<%@ page import="com.example.demo5.Performance" %>
<%@ page import="com.example.demo5.DataBase" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.GregorianCalendar" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page session="false" %>
<html>
<head>
    <link rel="stylesheet" href="res/styles.css">
    <title>
        Информация о представлении
    </title>
</head>
<body>
<%@ include file="include/shapka.jsp" %>
<%
    Theatre theatre;
    Performance performance;
    boolean logged = false;
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : request.getCookies()) {
            if (cookie.getName().equals("status")) {
                logged = true;
                break;
            }
        }
    }

    if (request.getParameter("theatre") != null && request.getParameter("id") != null) {
        theatre = DataBase.getTheatre(Integer.parseInt(request.getParameter("theatre")));
        performance = theatre.GetPerformanceById(Integer.parseInt(request.getParameter("id")));
        Date time = performance.getDate();
        Calendar calendar = GregorianCalendar.getInstance();
        calendar.setTime(time);
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd'T'H:mm");
        String timeS = format.format(time);
        if (calendar.get(Calendar.HOUR_OF_DAY) < 10)
            timeS = timeS.split("T")[0] + "T0" + timeS.split("T")[1];

%>
<div class="edit">
    <form method="get" action="performances.jsp">
        <input type="hidden" name="id" value="<%=theatre.getId()%>">
        <input type="hidden" name="saveid" value="<%=performance.getId()%>">
        <p>Название: <%=performance.getName()%>
        </p>
        <p>Начало: <input type="datetime-local" name="date" value="<%=timeS%>"
                          readonly></p>
        <p>Продолжительность:<%=performance.getLength()%> минут</p>
        <div class="Info">
            <div class="block">
                <h2>Режиссеры</h2>

                <%
                    for (String producer : performance.getProducers()) {
                %>
                <p><%=producer + "\n"%>
                </p>
                <%
                    }
                %>
            </div>
            <div class="block">
                <h2>Актёры</h2>
                <%
                    for (String producer : performance.getActors()) {
                %>
                <p><%=producer + "\n"%>
                </p>
                <%
                    }
                %>
            </div>
        </div>
        <div class="Info">
            <div class="blockPrice">
                <h2>Партер</h2>
                <p>Кол-во свободных мест: <%=performance.getFree_parter()%>
                <p>Цена: <%=performance.getPrice_parter()%>
                </>
                <p><%
                    if (logged) {
                        if (performance.getFree_parter() > 0) {
                %>
                    <input type="submit" form="parter" class="jbtn" value="Купить"></p>
                <%
                } else {
                %>
                <h3>Билеты распроданы</h3></
            >
            <%
                }
            } else {
            %>
            <h3>Зарегистрируйтесь чтобы купить</h3></
        >
            <%
                }
            %>
</div>
<div class="blockPrice">
    <h2>Бельэтаж</h2>
    <p>Кол-во свободных мест: <%=performance.getFree_beletage()%>
    </>
    <p>Цена: <%=performance.getPrice_beletage()%>
    </>
    <p><%
        if (logged) {
            if (performance.getFree_beletage() > 0) {
    %>
        <input type="submit" form="beletage" class="jbtn" value="Купить"></p>
    <%
    } else {
    %>
    <h3>Билеты распроданы</h3></
>
<%
    }
} else {
%>
<h3>Зарегистрируйтесь чтобы купить</h3></
>
<%
    }
%>
</div>
<div class="blockPrice">
    <h2>Балкон</h2>
    <p>Кол-во свободных мест: <%=performance.getFree_balcony()%>
    <p>Цена: <%=performance.getPrice_balcony() %>
    </>
    <p><%
        if (logged) {
            if (performance.getFree_balcony() > 0) {
    %>
        <input type="submit" form="balcony" class="jbtn" value="Купить"></p>
    <%
    } else {
    %>
    <h3>Билеты распроданы</h3></
>
<%
    }
} else {
%>
<h3>Зарегистрируйтесь чтобы купить</h3></
>
<%
    }
%>
</div>
</div>
<div class="controls">
    <a href="performances.jsp?id=<%=theatre.getId()%>" class="jbtn">Назад</a>
</div>
</form>
</div>
<form id="parter" method="get" action="orders.jsp">
    <input type="hidden" name="buy" value="parter">
    <input type="hidden" name="theatre" value="<%=theatre.getId()%>">
    <input type="hidden" name="perf" value="<%=performance.getId()%>">
    <input type="hidden" name="place" value="Партер">
</form>
<form id="beletage" method="post" action="orders.jsp">
    <input type="hidden" name="buy" value="parter">
    <input type="hidden" name="theatre" value="<%=theatre.getId()%>">
    <input type="hidden" name="perf" value="<%=performance.getId()%>">
    <input type="hidden" name="place" value="Бельэтаж">
</form>
<form id="balcony" method="post" action="orders.jsp">
    <input type="hidden" name="buy" value="parter">
    <input type="hidden" name="theatre" value="<%=theatre.getId()%>">
    <input type="hidden" name="perf" value="<%=performance.getId()%>">
    <input type="hidden" name="place" value="Балкон">
</form>
<%
    }
%>
</body>
</html>
