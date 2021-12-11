<%@ page import="java.io.IOException" %>
<%@ page import="com.example.demo5.Theatre" %>
<%@ page import="com.example.demo5.DataBase" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.stream.Collectors" %>
<%@ page import="com.example.demo5.Performance" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.ParseException" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="res/styles.css">
    <meta charset="UTF-8">
    <%
        if (DataBase.theatres == null) {
            DataBase.InitTheatre(1);
            response.getWriter().println("Создан театр");
        }
        response.getWriter().println(DataBase.theatres.size());
        if (request.getParameter("add") != null) {
            Theatre theatre = new Theatre();
            theatre.setName(request.getParameter("name"));
            theatre.setAddress(request.getParameter("address"));
            theatre.setNum_balcon(Integer.parseInt(request.getParameter("balcony")));
            theatre.setNum_beletage(Integer.parseInt(request.getParameter("beletage")));
            theatre.setNum_parter(Integer.parseInt(request.getParameter("parter")));
            for (String producers : request.getParameter("producersset").split("\n")) {
                theatre.getProducers().add(producers);
            }
            for (String producers : request.getParameter("actorsset").split("\n")) {
                theatre.getActors().add(producers);
            }
            DataBase.theatres.add(theatre);
        }
        if (request.getParameter("save") != null) {
            int id = Integer.parseInt(request.getParameter("saveid"));
            Theatre theatre = DataBase.getTheatre(id);
            theatre.setName(request.getParameter("name"));
            theatre.setAddress(request.getParameter("address"));
            theatre.setNum_balcon(Integer.parseInt(request.getParameter("balcony")));
            theatre.setNum_beletage(Integer.parseInt(request.getParameter("beletage")));
            theatre.setNum_parter(Integer.parseInt(request.getParameter("parter")));
            theatre.getProducers().clear();
            theatre.getActors().clear();
            for (String producers : request.getParameter("producersset").split("\n")) {
                theatre.getProducers().add(producers);
            }
            for (String producers : request.getParameter("actorsset").split("\n")) {
                theatre.getActors().add(producers);
            }
        }
        if (request.getParameter("delid") != null) {
            DataBase.theatres.remove(DataBase.getTheatre(Integer.parseInt(request.getParameter("delid"))));
        }
        if (DataBase.accounts == null){
            DataBase.InitAccounts();
        }
        ArrayList<Theatre> theatresToShow = null;
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
                response.getWriter().println(searchResult.size());
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
            if (request.getParameter("search") != null) {
                theatresToShow = searchResult;
            } else {
                theatresToShow = DataBase.theatres;
            }
        } catch (Exception e) {
            response.getWriter().println("Все блять поиск не работает");
            for (StackTraceElement stackTraceElement : e.getStackTrace()) {
                response.getWriter().println(stackTraceElement.toString() + "\n");
            }
        }
        response.getWriter().println(theatresToShow.size());
    %>


    <title>Концертная касса</title>
</head>
<body>

<jsp:include page="include/shapka.jsp"></jsp:include>

<div class="selector">  <%--TODO: id - element index. Set hidden input with search = 1  --%>
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
                Представления id - id
            </div>
            <div class="Content-Body">
                <% prod.clear();
                    for (Theatre theatre : DataBase.theatres) {
                        prod.addAll(theatre.getPerformances().stream().map(performance -> String.valueOf(performance.getId())).collect(Collectors.toList()));
                    }
                    for (String pr : prod) {%>
                <div class="line">
                    <input type="checkbox" name="performances" value="<%=pr%>" id="<%=pr%> "
                           <% if(request.getParameter("performances") != null) if(Arrays.stream(request.getParameterMap().get("performances")).filter(i->i.equals(pr)).findFirst().equals(Optional.of(pr)))%>checked>
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
                Даты
            </div>
            <div class="Content-Body">
                <%
                    Long min = null;
                    Long max = null;
                    Date sDate, eDate;
                    String data1, data2;
                    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                    if (request.getParameter("dStart") == null) {
                        for (Theatre theatre : DataBase.theatres) {
                            for (Performance performance : theatre.getPerformances()) {
                                Long t = performance.getDate().getTime();
                                if (min == null) {
                                    min = performance.getDate().getTime();
                                    max = performance.getDate().getTime();
                                } else {
                                    if (t > max) {
                                        max = t;
                                    }
                                    if (t < min) {
                                        min = t;
                                    }
                                }
                            }
                        }
                        if (min == null) {
                            sDate = new Date();
                            eDate = new Date();
                        } else {
                            sDate = new Date(min);
                            eDate = new Date(max);
                        }
                        data1 = formatter.format(sDate);
                        data2 = formatter.format(eDate);
                    } else {
                        data1 = request.getParameter("dStart");
                        data2 = request.getParameter("dEnd");
                    }
                %>
                <div class="line">
                    <input type="date" name="dStart" value="<%=data1%>">
                    <input type="date" name="dEnd" value="<%=data2%>">
                </div>
            </div>
        </div>
        <input type="submit" value="Поиск">
    </form>
</div>
<%-- Тут вывод в таблицу--%>
<%
    if (true) { //TODO: if admin%>
<form action="Theatre.jsp" method="post">
    <button type="submit" name="id" value="-1" class="jbtn">Добавить театр</button>
</form>
<% }
    if (DataBase.theatres != null) {
        if (theatresToShow == null) {
            theatresToShow = DataBase.theatres;
        }%>
<table class="iksweb">
    <tr>
        <th>Название</th>
        <th>Адрес</th>
        <th>Количество мест</th>
        <% //TODO: if admin show that column
            if (true) {
        %>
        <th>Ред.</th>
        <%
            }%>
    </tr>

    <%
        if (theatresToShow.size() != 0)
            for (Theatre theatre : theatresToShow) {
    %>
    <tr>
        <td onclick="window.location = 'performances.jsp?id=<%=theatre.getId()%>'">
            <%=theatre.getName()%>
        </td>
        <td onclick="window.location = 'performances.jsp?id=<%=theatre.getId()%>'">
            <%=theatre.getAddress()%>
        </td>
        <td onclick="window.location = 'performances.jsp?id=<%=theatre.getId()%>'">
            <%=theatre.getNum_sum()%>
        </td>
        <%
            // TODO: make login work again
            if (true) {
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