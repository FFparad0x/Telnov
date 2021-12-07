
<%@ page import="com.example.demo5.Account" %>
<%@ page import="com.example.demo5.DataBaseAccount" %>

<%
  Account account = new Account();
  if (request.getParameter("llogin") != null && request.getParameter("lpass")!=null) {
    String value1 = request.getParameter("llogin");
    String value2 = request.getParameter("lpass");
    account.InitAccount(value1, value2);
    DataBaseAccount.accounts.add(account);
  }
%>
