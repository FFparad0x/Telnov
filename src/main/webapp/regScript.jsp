<%@ page import="com.example.demo5.Account" %>
<%@ page import="com.example.demo5.DataBase" %>
<%@ page import="com.example.demo5.HelloServlet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="false" %>
<%
    if (request.getParameter("llogin") != null && request.getParameter("lpass")!=null) {
        boolean isDouble = false;
        for (Account account : DataBase.accounts ){
            if (request.getParameter("llogin").equals(account.getLogin())){
                response.getWriter().println("<script>alert(\"такой логин уже занят\")</script>");
                isDouble = true;
            }
        }
        if(!isDouble) {
            String value1 = request.getParameter("llogin");
            String value2 = request.getParameter("lpass");
            Account account = new Account(value1, value2, false);
            DataBase.accounts.add(account);
            response.sendRedirect("index.jsp");
        }
    }
%>
