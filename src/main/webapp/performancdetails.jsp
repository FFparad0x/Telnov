<%--suppress CheckTagEmptyBody --%>
<%@ page import="com.example.demo5.Theatre" %>
<%@ page import="com.example.demo5.Performance" %>
<%@ page import="com.example.demo5.DataBase" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd'T'H:mm");
%>
<div class="edit">
    <form method="get" action="performances.jsp">
        <input type="hidden" name="id" value="<%=theatre.getId()%>">
        <input type="hidden" name="saveid" value="<%=performance.getId()%>">
        <p>Название: <%=performance.getName()%>
        </p>
        <p>Дата: <input type="datetime-local" name="date" value="<%=format.format(time)%>"
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
            <div class="block">
                <h2>Партер</h2>
                <p>Кол-во свободных мест: <%=performance.getFree_parter()%>
                <p>Цена: <%=performance.getPrice_parter()%>
                </><p><a
                    href="#" class="jbtn">Купить</a></p>
            </div>
            <div class="block">
                <h2>Бельэтаж</h2>
                <p>Кол-во свободных мест: <%=performance.getFree_beletage()%>
                </>
                <p>Цена: <%=performance.getPrice_beletage()%>
                </> <p><a
                    href="#>" class="jbtn">Купить</a></p>
            </div>
            <div class="block">
                <h2>Балкон</h2>
                <p>Кол-во свободных мест: <%=performance.getFree_balcony()%>
                <p>Цена: <%=performance.getPrice_balcony() %>
                </>
                <p><a href="#" class="jbtn">Купить</a></p>
            </div>
        </div>
        <div class="controls">
            <a href="performances.jsp?id=<%=theatre.getId()%>" class="jbtn">Назад</a>
        </div>
    </form>
</div>
<%
    }
%>
</body>
</html>
