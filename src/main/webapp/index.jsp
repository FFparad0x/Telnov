<%@ page import="com.example.demo5.Records" %>
<%@ page import="java.io.IOException" %>
<%@ page import="com.example.demo5.Theatre" %>
<%@ page import="com.example.demo5.DataBase" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.stream.Collectors" %>
<%@ page import="com.example.demo5.Performance" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <% DataBase.InitTheatre(10);

        try {
            ArrayList<Theatre> searchResult = null;
            if (request.getParameter("theatres") != null) {

                String[] parameters = request.getParameterMap().get("theatres");
                ArrayList<Theatre> temp = new ArrayList<>();
                for (int i = 0; i < parameters.length; i++) {
                    for (int j = 0; j < DataBase.theatres.size(); j++) {
                        if (Integer.parseInt(parameters[i]) == DataBase.theatres.get(j).getId()) {
                            temp.add(DataBase.theatres.get(i));
                        }
                    }
                }
                searchResult = new ArrayList<>(temp);
            }


            if (request.getParameter("producers") != null) {
                if (searchResult == null) {
                    searchResult = new ArrayList<>();
                }
                String[] parameters = request.getParameterMap().get("producers");
                if (searchResult.size() == 0) {
                    for (String parameter : parameters) {
                        for (int j = 0; j < DataBase.theatres.size(); j++) {
                            if (parameter.equals(DataBase.theatres.get(j).getProducers().get(j))) {
                                searchResult.add(DataBase.theatres.get(j));
                            }
                        }
                    }
                } else {
                    ArrayList<Theatre> temp = new ArrayList<>();
                    for (String parameter : parameters) {
                        for (int j = 0; j < searchResult.size(); j++) {
                            if (parameter.equals(searchResult.get(j).getProducers().get(j))) {
                                temp.add(searchResult.get(j));
                            }
                        }
                    }
                    searchResult.clear();
                    searchResult.addAll(temp);
                }
            }
            if (request.getParameter("actors") != null) {
                if (searchResult == null) {
                    searchResult = new ArrayList<>();
                }
                String[] parameters = request.getParameterMap().get("actors");
                if (request.getParameter("producers") == null && request.getParameter("theatres") == null) {
                    for (String parameter : parameters) {
                        for (int j = 0; j < DataBase.theatres.size(); j++) {
                            if (parameter.equals(DataBase.theatres.get(j).getActors().get(j))) {
                                searchResult.add(DataBase.theatres.get(j));
                            }
                        }
                    }
                } else {
                    ArrayList<Theatre> temp = new ArrayList<>();
                    for (String parameter : parameters) {
                        for (int j = 0; j < searchResult.size(); j++) {
                            if (parameter.equals(searchResult.get(j).getActors().get(j))) {
                                temp.add(searchResult.get(j));
                            }
                        }
                    }
                    searchResult.clear();
                    searchResult.addAll(temp);
                }
            }
            if (request.getParameter("performances") != null) {
                if (searchResult == null) {
                    searchResult = new ArrayList<>();
                }
                String[] parameters = request.getParameterMap().get("performances");
                if (request.getParameter("producers") == null && request.getParameter("theatres") == null && request.getParameter("actors") == null) {
                    for (String parameter : parameters) {
                        for (int j = 0; j < DataBase.theatres.size(); j++) {
                            for (int k = 0; k < DataBase.theatres.get(j).getPerformances().size(); k++) {
                                if (Integer.parseInt(parameter) == DataBase.theatres.get(j).getPerformances().get(k).getId()) {
                                    searchResult.add(DataBase.theatres.get(j));
                                }
                            }
                        }
                    }
                } else {
                    ArrayList<Theatre> temp = new ArrayList<>();
                    for (String parameter : parameters) {
                        for (int j = 0; j < searchResult.size(); j++) {
                            for (int k = 0; k < searchResult.get(j).getPerformances().size(); k++) {
                                if (Integer.parseInt(parameter) == searchResult.get(j).getPerformances().get(k).getId()) {
                                    temp.add(DataBase.theatres.get(j));
                                }
                            }
                        }
                    }
                    searchResult.clear();
                    searchResult.addAll(temp);
                }
            }
            if (request.getParameter("dStart") != null) {
                if (!request.getParameter("dStart").equals("") && !request.getParameter("dEnd").equals("")) {
                    if (searchResult == null) {
                        searchResult = new ArrayList<>();
                    }
                    String start = request.getParameter("dStart");
                    String end = request.getParameter("dEnd");
                    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");

                    String dateInString = "7-Jun-2013";
                    Date dStart = formatter.parse(start);
                    Date dEnd = formatter.parse(end);
                    if (request.getParameter("producers") == null && request.getParameter("theatres") == null && request.getParameter("actors") == null) {
                        for (int i = 0; i < DataBase.theatres.size(); i++) {
                            for (int j = 0; j < DataBase.theatres.get(i).getPerformances().size(); j++) {
                                if (dStart.after(DataBase.theatres.get(i).getPerformances().get(j).getDate()) && dEnd.before(DataBase.theatres.get(i).getPerformances().get(j).getDate())) {
                                    searchResult.add(DataBase.theatres.get(i));
                                }
                            }
                        }
                    } else {
                        ArrayList<Theatre> temp = new ArrayList<>();
                        for (Theatre theatre : searchResult) {
                            for (int j = 0; j < theatre.getPerformances().size(); j++) {
                                if (dStart.after(theatre.getPerformances().get(j).getDate()) && dEnd.before(theatre.getPerformances().get(j).getDate())) {
                                    temp.add(theatre);
                                }
                            }
                        }
                        searchResult.clear();
                        searchResult.addAll(temp);
                    }
                    response.getWriter().println(dEnd.toString());
                }
            }
        } catch (Exception e) {

            response.getWriter().println("Все блять поиск не работает");
            for (StackTraceElement stackTraceElement : e.getStackTrace()) {
                response.getWriter().println(stackTraceElement.toString() + "\n");
            }
        }


    %>
    <link rel="stylesheet" href="res/styles.css">
    <% if (Records.list == null) {
        response.getWriter().println("null");
        Records.list = new ArrayList<>();
    }
        if (request.getParameter("print") != null) {
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
                <a href='#'>Главное меню</a>
            </li>
            <li>
                <a href='#'>Корзина</a>
            </li>
        </ul>
        <div class='login'>
            <form action='' method='post' id='login'>
                <input name='llogin' type='text' id='llogin' placeholder='Логин' required> <br>
                <input name='lpass' type='password' id='lpass' placeholder='Пароль' required> <br>
                <button class='login' type='submit'>Войти</button>
                | <!--<a href='signup.php'>Регистрация</a>-->
                <a href="registration.jsp">Регистрация</a>
            </form>
        </div>
    </div>
</div>
<div class="selector">  <%--TODO: id - element index. Set hidden input with search = 1  --%>
    <form action="index.jsp" method="get" class="mainsel">
        <div class="Content">
            <div class="header">
                Театры
            </div>
        <div class="Content-Body">
            <%
                for (Theatre theatre : DataBase.theatres){%>
            <div class="line">
                <input type="checkbox" name="theatres" value="<%=theatre.getId()%>" id ="<%=theatre.getId()%> ">
                <label for="<%=theatre.getId()%>"> <%=theatre.getName()%></label>
            </div>
            <%
                }
            %>
        </div>
        </div>
        <div class="Content">
            <div class="header">
                Режиссеры
            </div>
            <div class="Content-Body">
                <%  ArrayList<String> prod = new ArrayList<>();
                    for (Theatre theatre : DataBase.theatres){
                        prod.addAll(theatre.getProducers());
                    }
                    for (String pr : prod){%>
                <div class="line">
                    <input type="checkbox" name="theatres" value="<%=pr%>" id ="<%=pr%> ">
                    <label for="<%=pr%>"> <%=pr%></label>
                </div>
                <%
                    }
                %>
            </div>
        </div>
        <div class="Content">
            <div class="header">
                Актеры
            </div>
            <div class="Content-Body">
                <%   prod.clear();
                    for (Theatre theatre : DataBase.theatres){
                        prod.addAll(theatre.getActors());
                    }
                    for (String pr : prod){%>
                <div class="line">
                    <input type="checkbox" name="theatres" value="<%=pr%>" id ="<%=pr%> ">
                    <label for="<%=pr%>"> <%=pr%></label>
                </div>
                <%
                    }
                %>
            </div>
        </div>
        <div class="Content">
            <div class="header">
                Представления id - id
            </div>
            <div class="Content-Body">
                <% prod.clear();
                    for (Theatre theatre : DataBase.theatres){
                        prod.addAll(theatre.getPerformances().stream().map(performance -> String.valueOf(performance.getId())).collect(Collectors.toList()));
                    }
                    for (String pr : prod){%>
                <div class="line">
                    <input type="checkbox" name="theatres" value="<%=pr%>" id ="<%=pr%> ">
                    <label for="<%=pr%>"> <%=pr%></label>
                </div>
                <%
                    }
                %>
            </div>
        </div>
        <div class="Content">
            <div class="header">
                Даты
            </div>
            <div class="Content-Body">
                <%
                    Long min = null;
                    Long max = null;
                    for (Theatre theatre : DataBase.theatres){

                        for (Performance performance : theatre.getPerformances()) {
                            Long t = performance.getDate().getTime();
                            if(min == null) {
                                min = performance.getDate().getTime();
                                max = performance.getDate().getTime();
                            }
                            else{
                                if(t > max){
                                    max = t;
                                }
                                if(t < min){
                                    min = t;
                                }
                            }
                        }
                    }
                    Date sDate = new Date(min);
                    Date eDate = new Date(max);
                    SimpleDateFormat formater = new SimpleDateFormat("yyyy-MM-dd");

                    %>
                <div class="line">
                    <input type="date" name="dStart" value="<%=formater.format(sDate)%>" >
                    <input type="date" name="dEnd" value="<%=formater.format(sDate)%>">
            </div>
        </div>

        <input type="submit" value="Поиск">
    </form>
</div>
<%

    if (DataBase.theatres != null) { %>
<table class="iksweb">
    <tr>
        <th>Название</th>
        <th>Адрес</th>
        <th>Количество мест</th>
    </tr>

    <%
        for (Theatre theatre : DataBase.theatres) {
            int id = theatre.getId();%>
    <tr>
        <td onclick="window.location = 'performances.jsp?id=<%=theatre.getId()%>'">
            <%=theatre.getName()%>
        </td>
        <td>
            <%=theatre.getAddress()%>
        </td>
        <td>
            <%=theatre.getNum_sum()%>
        </td>
    </tr>
    <%
        }
    %>

</table>
<%
    }

%>


<form action="index.jsp" method="get">
    <button type="submit" name="print">Добавить</button>
</form>
<%
    if (Records.list != null)
        for (String i : Records.list) {
%> <%= i %> <br><%
        }
%>


<h1><%= "Hello World!" %>
</h1>
<br>

<a href="hello-servlet">Hello Servlet</a>
<%
    if (request.getParameter("vehicle") != null) {
//        response.getWriter().println(request.getParameter("vehicle"));
        Arrays.stream(request.getParameterMap().get("vehicle")).forEach(i -> {
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