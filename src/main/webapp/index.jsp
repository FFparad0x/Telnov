<%--
Главная страница приложения, где выводятся театры и фильтр для поиска по параметрам
--%>
<%@ page import="com.example.demo5.Theatre" %>
<%@ page import="com.example.demo5.DataBase" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.example.demo5.Performance" %>
<%@ page import="java.util.*" %>
<%--<%@ page import="javax.servlet.http.Cookie" %>--%>
<%@ page import="javax.servlet.http.Cookie" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page session="false" %>
<anyxmlelement xmlns:c="http://java.sun.com/jsp/jstl/core"/>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="res/styles.css">
    <meta charset="UTF-8">

    <%
        /*
        При отсутствии созданных объектов, создаем и инициализируем
         */
        if (DataBase.theatres == null) {
            DataBase.InitTheatre();
        }
        if (DataBase.accounts == null) {
            DataBase.InitAccounts();
        }
        boolean admin = false; // Проверка на логин, если есть куки - значит, что пользователь зашел
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : request.getCookies()) {
                if (cookie.getName().equals("status") && cookie.getValue().equals("admin")) {
                    admin = true;
                    break;
                }
            }
        }
        /*
        Для операций добавления, изменения, удаления
        Считываем параметры запросов и в зависимости от них
        выполняем действия
         */
        if (request.getParameter("add") != null) { // добавление театра
            Theatre theatre = new Theatre();
            theatre.setName(request.getParameter("name"));
            theatre.setAddress(request.getParameter("address"));
            theatre.setNum_balcon(Integer.parseInt(request.getParameter("balcony")));
            theatre.setNum_beletage(Integer.parseInt(request.getParameter("beletage")));
            theatre.setNum_parter(Integer.parseInt(request.getParameter("parter")));
            for (String producers : request.getParameter("producersset").split("(\\R)")) {
                theatre.getProducers().add(producers);
            }
            for (String producers : request.getParameter("actorsset").split("(\\R)")) {
                theatre.getActors().add(producers);
            }
            DataBase.theatres.add(theatre);
        }
        if (request.getParameter("save") != null) { // сохранение изменений в театре
            int id = Integer.parseInt(request.getParameter("saveid"));
            Theatre theatre = DataBase.getTheatre(id);
            theatre.setName(request.getParameter("name"));
            theatre.setAddress(request.getParameter("address"));
            theatre.setNum_balcon(Integer.parseInt(request.getParameter("balcony")));
            theatre.setNum_beletage(Integer.parseInt(request.getParameter("beletage")));
            theatre.setNum_parter(Integer.parseInt(request.getParameter("parter")));
            theatre.getProducers().clear();
            theatre.getActors().clear();
            for (String producers : request.getParameter("producersset").split("(\\R)")) {
                theatre.getProducers().add(producers);
            }
            for (String producers : request.getParameter("actorsset").split("(\\R)")) {
                theatre.getActors().add(producers);
            }
        }
        if (request.getParameter("delid") != null) { // уаление театра
            DataBase.theatres.remove(DataBase.getTheatre(Integer.parseInt(request.getParameter("delid"))));
        }
/*
 Для отображения фильтра в циклах for проходимся по всем театрам и прдеставлениям
 и выводим их значениия, записывая в id значения эл-тов
 */
        ArrayList<Theatre> theatresToShow = null;
        try { // проходимся по театрам, если поиск не производитсяЮ то отображаем все что есть
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
            if (request.getParameter("producers") != null) { // поиск по режиссерам
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
            if (request.getParameter("actors") != null) { //поиск по актерам
                if (searchResult == null) {
                    searchResult = new ArrayList<>();
                }
                String[] parameters = request.getParameterMap().get("actors");
                if (request.getParameter("producers") == null && request.getParameter("theatres") == null) {
                    for (String parameter : parameters) {
                        for (Theatre theatre : DataBase.theatres) {
                            for (int i = 0; i < theatre.getActors().size(); i++) {
                                if (parameter.equals(theatre.getActors().get(i))) {
                                    searchResult.add(theatre);
                                }
                            }
                        }
                    }
                } else {
                    ArrayList<Theatre> temp = new ArrayList<>();
                    for (String parameter : parameters) {
                        for (Theatre theatre : searchResult) {
                            for (int i = 0; i < theatre.getActors().size(); i++) {
                                if (parameter.equals(theatre.getActors().get(i))) {
                                    temp.add(theatre);
                                }
                            }
                        }
                    }
                    searchResult.clear();
                    searchResult.addAll(temp);
                }
            }
            if (request.getParameter("performances") != null) { // поиск по представлениям
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
            if (request.getParameter("dStart") != null) { //поиск по дате
                if (!request.getParameter("dStart").equals("") && !request.getParameter("dEnd").equals("")) {
                    if (searchResult == null) {
                        searchResult = new ArrayList<>();
                    }
                    String start = request.getParameter("dStart") + " 00:00:00";
                    String end = request.getParameter("dEnd") + " 23:59:59";
                    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    Date dStart = formatter.parse(start);
                    Date dEnd = formatter.parse(end);
                    if (request.getParameter("producers") == null && request.getParameter("theatres") == null && request.getParameter("actors") == null && request.getParameter("performances") == null) {
                        for (Theatre theatre : DataBase.theatres) {
                            for (int j = 0; j < theatre.getPerformances().size(); j++) {
                                if (dStart.before(theatre.getPerformances().get(j).getDate()) && dEnd.after(theatre.getPerformances().get(j).getDate())) {
                                    searchResult.add(theatre);
                                    break;
                                }
                            }
                        }
                    } else {
                        ArrayList<Theatre> temp = new ArrayList<>();
                        for (Theatre theatre : searchResult) {
                            for (int j = 0; j < theatre.getPerformances().size(); j++) {
                                if (dStart.before(theatre.getPerformances().get(j).getDate()) && dEnd.after(theatre.getPerformances().get(j).getDate())) {
                                    temp.add(theatre);
                                    break;
                                }
                            }
                        }
                        searchResult.clear();
                        searchResult.addAll(temp);
                    }
                }
            }
            if (request.getParameter("search") != null) { //если был поиск, что отбражаем результат
                theatresToShow = searchResult;
            } else {
                theatresToShow = DataBase.theatres;
            }
        } catch (Exception e) {
            response.getWriter().println("поиск не работает");
            for (StackTraceElement stackTraceElement : e.getStackTrace()) {
            }
        }
    %>

<%--
    Вывод таблицы с театрами и фильтров
--%>
    <title>Концертная касса</title>
</head>
<body>

<%@ include file="include/shapka.jsp" %>
<%

%>
<div class="selector">
    <form action="index.jsp" method="get" class="mainsel">
        <input type="hidden" name="search" value="1">
        <div class="Content">
            <div class="header">
                Театры
            </div>
            <div class="Content-Body">
                <%
                    for (Theatre theatre : DataBase.theatres) {
                %>
                <div class="line">
                    <%--                    //вывод элементов по которым может идти поиск--%>
                    <input type="checkbox" name="theatres" value="<%=theatre.getId()%>" id="<%=theatre.getId()%> "
                           <% if(request.getParameter("theatres") !=null)if(Arrays.stream(request.getParameterMap().get("theatres")).filter(i->i.equals(String.valueOf(theatre.getId()))).findFirst().equals(Optional.of(String.valueOf(theatre.getId()))))%>checked>
                    <label for="<%=theatre.getId()%>"><%=theatre.getName()%>
                    </label>
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
                <% ArrayList<String> prod = new ArrayList<>();
                    for (Theatre theatre : DataBase.theatres) {
                        prod.addAll(theatre.getProducers());
                    }
                    for (String pr : prod) {%>
                <div class="line">
                    <input type="checkbox" name="producers" value="<%=pr%>" id="<%=pr%>"
                           <% if(request.getParameter("producers") != null) if(Arrays.stream(request.getParameterMap().get("producers")).filter(i->i.equals(pr)).findFirst().equals(Optional.of(pr)))%>checked>
                    <label for="<%=pr%>"><%=pr%>
                    </label>
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
                <% prod.clear();
                    for (Theatre theatre : DataBase.theatres) {
                        prod.addAll(theatre.getActors());
                    }
                    for (String pr : prod) {%>
                <div class="line">
                    <input type="checkbox" name="actors" value="<%=pr%>" id="<%=pr%> "
                           <% if(request.getParameter("actors") != null) if(Arrays.stream(request.getParameterMap().get("actors")).filter(i->i.equals(pr)).findFirst().equals(Optional.of(pr)))%>checked>
                    <label for="<%=pr%>"><%=pr%>
                    </label>
                </div>
                <%
                    }
                %>
            </div>
        </div>
        <div class="Content">
            <div class="header">
                Представления
            </div>
            <div class="Content-Body">
                <% prod.clear();
                    for (Theatre theatre : DataBase.theatres) {
                        for (Performance pr : theatre.getPerformances()) {
                %>
                <div class="line">
                    <input type="checkbox" name="performances" value="<%=pr.getId()%>" id="<%=pr.getId()%> "
                           <% if(request.getParameter("performances") != null) if(Arrays.stream(request.getParameterMap().get("performances"))
                           .filter(
                                   i->i.equals(String.valueOf(pr.getId())))
                                   .findFirst()
                                   .equals(Optional.of(String.valueOf(pr.getId()))))%>checked>
                    <label for="<%=pr%>"><%=pr.getName()%>
                    </label>
                </div>
                <%
                        }

                    }
                %>
            </div>
        </div>
        <div class="Content">
            <div class="header">
                Даты
            </div>
            <div class="Content-Body">
                <% //почему то idea после форматирования решила разбить все на строки. Идет выставление даты
                    //Если нет представлений, то ставится сегодняшняя дата, если есть, то минимальная и масимальная
                    Long
                            min
                            =
                            null;
                    Long
                            max
                            =
                            null;
                    Date
                            sDate,
                            eDate;
                    String
                            data1,
                            data2;
                    SimpleDateFormat
                            formatter
                            =
                            new
                                    SimpleDateFormat
                                    (
                                            "yyyy-MM-dd"
                                    );
                    if
                    (
                            request
                                    .
                                    getParameter
                                            (
                                                    "dStart"
                                            )
                                    ==
                                    null
                    ) {
                        for
                        (
                                Theatre
                                        theatre
                                :
                                DataBase
                                        .
                                        theatres
                        ) {
                            for
                            (
                                    Performance
                                            performance
                                    :
                                    theatre
                                            .
                                            getPerformances
                                                    (
                                                    )
                            ) {
                                Long
                                        t
                                        =
                                        performance
                                                .
                                                getDate
                                                        (
                                                        )
                                                        .
                                                getTime
                                                        (
                                                        );
                                if
                                (
                                        min
                                                ==
                                                null
                                ) {
                                    min
                                            =
                                            performance
                                                    .
                                                    getDate
                                                            (
                                                            )
                                                            .
                                                    getTime
                                                            (
                                                            )
                                    ;
                                    max
                                            =
                                            performance
                                                    .
                                                    getDate
                                                            (
                                                            )
                                                            .
                                                    getTime
                                                            (
                                                            )
                                    ;
                                } else {
                                    if
                                    (
                                            t
                                                    >
                                                    max
                                    ) {
                                        max
                                                =
                                                t
                                        ;
                                    }
                                    if
                                    (
                                            t
                                                    <
                                                    min
                                    ) {
                                        min
                                                =
                                                t
                                        ;
                                    }
                                }
                            }
                        }
                        if
                        (
                                min
                                        ==
                                        null
                        ) {
                            sDate
                                    =
                                    new
                                            Date
                                            (
                                            )
                            ;
                            eDate
                                    =
                                    new
                                            Date
                                            (
                                            )
                            ;
                        } else {
                            sDate
                                    =
                                    new
                                            Date
                                            (
                                                    min
                                            )
                            ;
                            eDate
                                    =
                                    new
                                            Date
                                            (
                                                    max
                                            )
                            ;
                        }
                        data1
                                =
                                formatter
                                        .
                                        format
                                                (
                                                        sDate
                                                )
                        ;
                        data2
                                =
                                formatter
                                        .
                                        format
                                                (
                                                        eDate
                                                )
                        ;
                    } else {
                        data1=request.getParameter("dStart" );
                        data2=request.getParameter("dEnd");
                    }
                %>
                <div class="line">
                    <input type="date" name="dStart" value="<%=data1%>">
                    <input type="date" name="dEnd" value="<%=data2%>">
                </div>
            </div>
        </div>
        <input type="submit" value="Поиск" class="search">
    </form>
</div>
<%-- Тут вывод в таблицу--%>
<%
    if
    (
            admin
    ) {
%>
<form action="Theatre.jsp" method="post">
    <button type="submit" name="id" value="-1" class="jbtn">Добавить театр</button>
</form>
<%
    }
    if
    (
            DataBase
                    .
                    theatres
                    !=
                    null
    ) {
        if
        (
                theatresToShow
                        ==
                        null
        ) {
            theatresToShow
                    =
                    DataBase
                            .
                            theatres
            ;
        }%>
<table class="iksweb">
    <tr>
        <th>Название</th>
        <th>Адрес</th>
        <th>Количество мест</th>
        <%
            if
            (
                    admin
            ) {
        %>
        <th>Ред.</th>
        <%
            }%>
    </tr>

    <%
        if
        (
                theatresToShow
                        .
                        size
                                (
                                )
                        !=
                        0
        )
            for
            (
                    Theatre
                            theatre
                    :
                    theatresToShow
            ) {
    %>
    <tr>
        <td onclick="window.location = 'performances.jsp?id=<%=theatre.getId()%>'">
            <%=theatre
                    .
                    getName
                            (
                            )%>
        </td>
        <td onclick="window.location = 'performances.jsp?id=<%=theatre.getId()%>'">
            <%=theatre
                    .
                    getAddress
                            (
                            )%>
        </td>
        <td onclick="window.location = 'performances.jsp?id=<%=theatre.getId()%>'">
            <%=theatre
                    .
                    getNum_sum
                            (
                            )%>
        </td>
        <%

            if
            (
                    admin
            ) {
        %>
        <td class="Superb" onclick="window.location = 'Theatre.jsp?id=<%=theatre.getId()%>'">&#9998;</td>

        <%
            }
        %>
    </tr>
    <%
        }
    else {%>
    <tr>
        <td colspan="3"> К сожалению по вашему поиску не найдено результатов</td>
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