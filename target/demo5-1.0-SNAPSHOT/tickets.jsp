<%@ page import="com.example.demo5.Ticket" %>
<%@ page import="com.example.demo5.DataBaseTicket" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page session="false" %>

<html>
<head>
    <title>Покупка билета</title>
</head>
<body>
    <%

    if (DataBaseTicket.tickets != null) { %>
<table class="iksweb">
    <tr>
    </tr>

    <%
        for (Ticket ticket : DataBaseTicket.tickets) {
    %>
    <%
        }
    %>
</table>
<%
    }
%>
</body>
</html>