<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.demo5.Records" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.io.IOException" %>
<%@ page import="com.example.demo5.Theatre" %>
<%@ page import="com.example.demo5.DataBase" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <%
        try {
            ArrayList<Theatre> searchResult = new ArrayList<>();
            if (request.getParameter("theatres") != null) {
                var parametrs = request.getParameterMap().get("theatres");
                for (int i = 0; i < parametrs.length; i++) {
                    if(Integer.valueOf(parametrs[i]) < DataBase.theatres.size()){
                        searchResult.add(DataBase.theatres.get(i));
                    }
                }
            }
            if (request.getParameter("producers") != null) {
                var parametrs = request.getParameterMap().get("producers");
                for (int i = 0; i < parametrs.length; i++) {
                    for (int j = 0; j < DataBase.theatres.size(); j++) {
                        if(Integer.valueOf(parametrs[i]) == DataBase.theatres.get(j).){
                            searchResult.add(DataBase.theatres.get(i));
                        }
                    }
                }
            }

        }
        catch (Exception e){

        }




    %>
    <link rel="stylesheet" href="res/styles.css">
    <% if(Records.list == null){
        response.getWriter().println("null");
        Records.list = new ArrayList<>();
    }
    if(request.getParameter("print") != null){
        Records.list.add("hehe");

    }
    %>
    <title>JSP - Hello World</title>
</head>
<body>
<div class="top">
    <div class="shapka">
        <img src="res/logo.png" alt="Здесь было лого, но его украли!">
        <hr>
    </div>
    <div class='fline'>
        <ul class="topmenu">
            <li>
                <a href='index.php'>Главное меню</a>
            </li>
            <li>
                <a href='news.php'>Корзина</a>
            </li>
        </ul>
        <div class='login'>
            <form action='' method='post' id='login'>
                <input name='llogin' type='text' id='llogin' placeholder='Логин' required> <br>
                <input name='lpass' type='password' id='lpass' placeholder='Пароль' required> <br>
                <button class='login' type='submit'>Войти</button>
                | <a href='signup.php'>Регистрация</a>
            </form>
        </div>
    </div>
</div>
<div class="selector">  <%--TODO: id - element index. Set hidden input with search = 1  --%>
    <form action="index.jsp" method="get" class = "mainsel">
        <div class="Content">
            Театры name = theatres
            <div class="line">
            <input type="checkbox" name="vehicle" value="Bike">
            <label for="vehicle1"> I have a bike</label>
            </div>
            <input type="checkbox" name="vehicle" value="Car">
            <label for="vehicle2"> I have a car</label>
            <input type="checkbox"  name="vehicle" value="Boat">
            <label for="vehicle3"> I have a boat</label>
        </div>
        <div class="Content">
            Режиссеры = producers
            <input type="checkbox" id="vehicle1" name="vehicle" value="Bike">
            <label for="vehicle1"> I have a bike</label>
            <input type="checkbox" id="vehicle2" name="vehicle" value="Car">
            <label for="vehicle2"> I have a car</label>
            <input type="checkbox" id="vehicle3" name="vehicle" value="Boat">
            <label for="vehicle3"> I have a boat</label>
        </div>
        <div class="Content">
            Актеры = actors
            <input type="checkbox" name="vehicle" value="Bike">
            <label for="vehicle1"> I have a bike</label>
            <input type="checkbox"  name="vehicle" value="Car">
            <label for="vehicle2"> I have a car</label>
            <input type="checkbox"  name="vehicle" value="Boat">
            <label for="vehicle3"> I have a boat</label>
        </div>
        <div class="Content">
            Performances
            <input type="checkbox" name="vehicle" value="Bike">
            <label for="vehicle1"> I have a bike</label>
            <input type="checkbox"  name="vehicle" value="Car">
            <label for="vehicle2"> I have a car</label>
            <input type="checkbox"  name="vehicle" value="Boat">
            <label for="vehicle3"> I have a boat</label>
        </div>
        <div class="Content">
            date = dates
            <input type="date" name="dStart">
            <br>
            <input type="date" name="dEnd">
        </div>

        <input type="submit" value="Поиск">
    </form>
</div>

<form action="index.jsp" method="get">
    <button type="submit" name="print">Добавить</button>
</form>
<%
    if(Records.list != null)
    for(String i: Records.list){
        %> <%= i %> <br><%
    }
%>


<h1><%= "Hello World!" %>
</h1>
<br>

<a href="hello-servlet">Hello Servlet</a>
<%
    if(request.getParameter("vehicle") != null){
//        response.getWriter().println(request.getParameter("vehicle"));
        Arrays.stream(request.getParameterMap().get("vehicle")).forEach(i->{
            try {
                response.getWriter().println(i);
            } catch (IOException e) {
                e.printStackTrace();
            }
        });
    }
%>

</body>
</html>