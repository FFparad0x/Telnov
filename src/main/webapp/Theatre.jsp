<%@ page import="com.example.demo5.Theatre" %>
<%@ page import="com.example.demo5.DataBase" %><%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 08.12.2021
  Time: 21:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="res/styles.css">
    <title>Редактирование театра</title>
</head>
<body>
<jsp:include page="include/shapka.jsp"></jsp:include>
<%
    Integer id = Integer.parseInt(request.getParameter("id"));
    if (id != null) {
        if (id >= 0) {
            Theatre temp = DataBase.getTheatre(id);
%>
<div class="edit">
    <form method="get" action="index.jsp">

        <input  type="hidden" name="saveid" value="<%=temp.getId()%>">
        <label for="1" >Название:
        <input id="1" type="text" placeholder="Название" name="name" value="<%=temp.getName()%>" required>
            </label>
        <label>Адрес:
            <input type="text" placeholder="Адрес" name="address" value="<%=temp.getAddress()%>" required>
        </label>
        <label>Режиссеры:
            <textarea cols="50" rows="10" placeholder="producers" name="producers" required><%=temp.PrintProducers()%></textarea>
        </label>
        <label>Актёры:
            <textarea cols="50" rows="10" placeholder="actors" name="actors" required><%=temp.PrintActors()%></textarea>
        </label>
        <label>Кол-во  мест на балконе
            <input type="text" placeholder="Название" name="balcony" value="<%=temp.getNum_balcon()%>" required pattern="\d*">
        </label>
        <label>Кол-во мест в партере
            <input type="text" placeholder="Название" name="parter" value="<%=temp.getNum_parter()%>" required pattern="\d*">
        </label>
        <label>Кол-во мест в бельэтаже
            <input type="text" placeholder="Название" name="beletage" value="<%=temp.getNum_beletage()%>" required pattern="\d*">
        </label>
        <div class="controls">
            <a href="index.jsp" class="jbtn">Назад</a>
            <input type="submit" value="Сохранить" name="save" class="jbtn">
            <input type="submit" value="Удалить" form="del" class="jbtn" style="background-color: #902019;border: none">
        </div>
    </form>
    <form name="del" id="del" action="index.jsp" method="get">
        <input type="hidden" name="delid" value="<%=temp.getId()%>" class="jbtn">
    </form>
</div>
<%} else {%>
<form method="get" action="index.jsp">
    <input type="text" placeholder="Название" name="name">
    <input type="text" placeholder="Адрес" name="address">
    <textarea cols="50" rows="10" placeholder="Продюссеры. Вводить по 1 на строку" name="producers"></textarea>
    <textarea cols="50" rows="10" placeholder="Актеры. Вводить по 1 на строку" name="actors"></textarea>
    <input type="text" placeholder="Кол-во мест на балконе" name="balcony">
    <input type="text" placeholder="Кол-во мест в партере" name="parter">
    <input type="text" placeholder="Кол-во мест в бельэтаже" name="beletage">
    <div class="controls">
        <a href="index.jsp">Назад</a>
        <input type="submit" value="Сохранить" name="add">
    </div>
</form>

<%
        }

    }
%>
</body>
</html>
