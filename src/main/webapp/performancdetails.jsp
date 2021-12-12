<%--suppress CheckTagEmptyBody --%>
<%@ page import="com.example.demo5.Theatre" %>
<%@ page import="com.example.demo5.Performance" %>
<%@ page import="com.example.demo5.DataBase" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.GregorianCalendar" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="false" %>
<html>
<head>
    <link rel="stylesheet" href="res/styles.css">
    <title>
        Информация о представлении
    </title>
</head>
<body>
<jsp:include page="include/shapka.jsp"></jsp:include>
<%
    Theatre theatre;
    Performance performance;

    if (request.getParameter("theatre") != null && request.getParameter("id") != null) {
        theatre = DataBase.getTheatre(Integer.parseInt(request.getParameter("theatre")));
        performance = theatre.GetPerformanceById(Integer.parseInt(request.getParameter("id")));
        Date time = performance.getDate();
        Calendar calendar = GregorianCalendar.getInstance();
        calendar.setTime(time);
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd'T'H:mm");
        String timeS = format.format(time);
        if(calendar.get(Calendar.HOUR_OF_DAY) < 10)
           timeS = timeS.split("T")[0] + "T0" + timeS.split("T")[1];

        response.getWriter().println(format.format(time));
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
                </> <p><input type="submit" form="parter" class="jbtn" value="Купить"></p>
            </div>
            <div class="blockPrice">
                <h2>Бельэтаж</h2>
                <p>Кол-во свободных мест: <%=performance.getFree_beletage()%>
                </>
                <p>Цена: <%=performance.getPrice_beletage()%>
                </> <p> <input type="submit" form="beletage" class="jbtn" value="Купить"></p>
            </div>
            <div class="blockPrice">
                <h2>Балкон</h2>
                <p>Кол-во свободных мест: <%=performance.getFree_balcony()%>
                <p>Цена: <%=performance.getPrice_balcony() %>
                </>
                <p><input type="submit" form="balcony" class="jbtn" value="Купить"></p>
            </div>
        </div>
        <div class="controls">
            <a href="performances.jsp?id=<%=theatre.getId()%>" class="jbtn">Назад</a>
        </div>
    </form>
</div>
<form id="parter" method="get" action="orders.jsp" >
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
