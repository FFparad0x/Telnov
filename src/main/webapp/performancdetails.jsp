<%@ page import="com.example.demo5.Theatre" %>
<%@ page import="com.example.demo5.Performance" %>
<%@ page import="com.example.demo5.DataBase" %>
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
    Theatre theatre = null;
    Performance performance = null;
    if(request.getParameter("theatre") != null){
        theatre = DataBase.getTheatre(Integer.parseInt(request.getParameter("theatre")));
    }
    if(request.getParameter("id") != null){
        performance = theatre.GetPerformanceById(Integer.parseInt(request.getParameter("id")));
    }
%>

</body>
</html>
