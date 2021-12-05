<%@ page import="com.example.demo5.DataBase" %>
<%@ page import="com.example.demo5.Theatre" %><%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 05.12.2021
  Time: 19:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Предстваления</title>
</head>
<body>

<%
    Theatre te = null;
if(request.getParameter("id") != null){
    int id = Integer.parseInt(request.getParameter("id"));
    te = DataBase.getTheatre(id);

}
%>
Привет <%=te.getName()%>

</body>
</html>
