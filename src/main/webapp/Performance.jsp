<%--
    На этой странице происходит изменение или создание представления

--%>
<%@ page import="com.example.demo5.Theatre" %>
<%@ page import="com.example.demo5.DataBase" %>
<%@ page import="com.example.demo5.Performance" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.GregorianCalendar" %>
<%@ page import="java.util.Calendar" %>
<%@ page session="false" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <link rel="stylesheet" href="res/styles.css">
    <title>Редактирование театра</title>
</head>
<body>
<%@ include file = "include/shapka.jsp" %>
<%
/*
    При установленном id представления происходит редактирование
    Если id = -1, создание новогого
    */
    Integer id = Integer.parseInt(request.getParameter("id")); // идет получения представении и вывод информации о нем
    Integer theatreId = Integer.parseInt(request.getParameter("theatre"));
    Theatre theatre = DataBase.getTheatre(theatreId);
    String timeS = "";
    if (id != null && theatreId != null) {
        if (id >= 0) {
            Performance temp = DataBase.getTheatre(theatreId).GetPerformanceById(id);
            Date time = temp.getDate();
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd'T'H:mm");
            Calendar calendar = GregorianCalendar.getInstance();
            calendar.setTime(time);
            timeS = format.format(time);
            if (calendar.get(Calendar.HOUR_OF_DAY) < 10) {
                timeS = timeS.split("T")[0] + "T0" + timeS.split("T")[1];
            }

%>
<div class="edit">
    <form method="get" action="performances.jsp">
        <input type="hidden" name="id" value="<%=theatre.getId()%>">
        <input type="hidden" name="saveid" value="<%=temp.getId()%>">
        <div class="details">
            <label for="1">Название:
                <input id="1" type="text" placeholder="Название" name="name" value="<%=temp.getName()%>" required>
            </label>
            <label>Дата:
                <input type="datetime-local" name="date" value="<%=timeS%>"
                       required>
            </label><br>
            <label>Продолжительность в минутах
                <input type="text" name="len" placeholder="Продолжительность (мин)" required pattern="\d*"
                       value="<%=temp.getLength()%>">
            </label><br>
        </div>
        <div class="Info" style="text-align: left">
            <div class="block">
                <p>Режиссеры:</p>
                <%
                    for (String producer : theatre.getProducers()) {%>
                <div class="line">
                    <input type="checkbox" name="producers" value="<%=producer%>"
                        <%
                         if(temp.getProducer().contains(producer)){
                %>
                           checked <%}%>> <%=producer%>
                </div>
                <%
                    }
                %>
            </div>
            <div class="block">
                <p>Актёры:</p>
                <%
                    for (String actor : theatre.getActors()) {%>
                <div class="line">
                    <input type="checkbox" name="actors" value="<%=actor%>"
                        <%
                        if(temp.getActors().contains(actor)){
                %>
                           checked<%}%> > <%=actor%>
                </div>
                <%
                    }
                %>
            </div>
        </div>

        <div class="Info">
            <div class="blockPrice">
                <h2>Партер</h2>
                <label>Кол-во свободных мест
                    <input type="text" placeholder="Кол-во" name="freeparter" value="<%=temp.getFree_parter()%>"
                           required
                           pattern="\d*">
                </label><br>
                <label>Цена
                    <input type="text" placeholder="Цена" name="parter" value="<%=temp.getPrice_parter()%>" required
                           pattern="\d*">
                </label>
            </div>
            <div class="blockPrice">
                <h2>Бэльэтаж</h2>
                <label>Кол-во свободных мест
                    <input type="text" placeholder="Кол-во" name="freebeletage" value="<%=temp.getFree_beletage()%>"
                           required pattern="\d*">
                </label><br>
                <label>Цена
                    <input type="text" placeholder="Цена" name="beletage" value="<%=temp.getPrice_beletage()%>"
                           required pattern="\d*">
                </label>
            </div>
            <div class="blockPrice">
                <h2>Балкон</h2>
                <label>Кол-во свободных мест
                    <input type="text" placeholder="Кол-во" name="freebalcony" value="<%=temp.getFree_balcony()%>"
                           required pattern="\d*">
                </label><br>
                <label>Цена
                    <input type="text" placeholder="Цена" name="balcony" value="<%=temp.getPrice_balcony() %>"
                           required pattern="\d*">
                </label>
            </div>
        </div>
        <div class="controls">
            <a href="performances.jsp?id=<%=theatre.getId()%>" class="jbtn">Назад</a>
            <input type="submit" value="Сохранить" name="save" class="jbtn">
            <input type="submit" value="Удалить" form="del" class="jbtn" style="background-color: #902019;border: none">
        </div>
    </form>
    <form name="del" id="del" action="performances.jsp" method="get">
        <input type="hidden" name="delid" value="<%=temp.getId()%>" class="jbtn">
        <input type="hidden" name="id" value="<%=theatre.getId()%>">
    </form>
</div>
<%} else {%>
<div class="edit">
    <form method="get" action="performances.jsp">
        <input type="hidden" name="id" value="<%=theatre.getId()%>">
        <input type="hidden" name="add" value="1">
        <div class="details">
            <label>Название:
                <input type="text" placeholder="Название" name="name" required>
            </label>
            <label>Дата:
                <input type="datetime-local" name="date" required>
            </label>
            <label>Продолжительность в минутах:
                <input type="text" name="len" placeholder="Продолжительность (мин)" required pattern="\d*">
            </label><br>
        </div>
        <div class="Info">
            <div class="block">
                <p>Режиссеры: </p>
                <%
                    for (String producer : theatre.getProducers()) {%>
                <div class="line">
                    <input type="checkbox" name="producers" value="<%=producer%>"> <%=producer%>
                </div>
                <%
                    }
                %>

            </div>
            <div class="block">
                <p>Актёры: </p>
                <%
                    for (String actor : theatre.getActors()) {%>
                <div class="line">
                    <input type="checkbox" name="actors" value="<%=actor%>"> <%=actor%>
                </div>
                <%
                    }
                %>
                </p>
            </div>
        </div>

        <div class="Info">
            <div class="blockPrice">
                <h2>Партер</h2>
                <label>Кол-во свободных мест
                    <input type="text" placeholder="Кол-во" name="freeparter" required pattern="\d*">
                </label><br>
                <label>Цена места
                    <input type="text" placeholder="Цена" name="parter" required
                           pattern="\d*">
                </label>
            </div>
            <div class="blockPrice">
                <h2>Бэльэтаж</h2>
                <label>Кол-во свободных мест
                    <input type="text" placeholder="Кол-во" name="freebeletage" required pattern="\d*">
                </label><br>
                <label>Цена места
                    <input type="text" placeholder="Цена" name="beletage"
                           required pattern="\d*">
                </label>
            </div>
            <div class="blockPrice">
                <h2>Балкон</h2>
                <label>Кол-во свободных мест
                    <input type="text" placeholder="Кол-во" name="freebalcony" required pattern="\d*">
                </label><br>
                <label>Цена места
                    <input type="text" placeholder="Цена" name="balcony"
                           required pattern="\d*">
                </label>
            </div>
        </div>
        <div class="controls">
            <a href="performances.jsp?id=<%=theatre.getId()%>" class="jbtn">Назад</a>
            <input type="submit" value="Добавить" name="save" class="jbtn">
        </div>
    </form>
</div>
<%
        }

    }
%>
</body>
</html>
