
<%@ page import="com.example.demo5.Account" %>
<%@ page import="com.example.demo5.DataBase" %>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
  <%
    if (request.getParameter("llogin") != null && request.getParameter("lpass")!=null) {
      String value1 = request.getParameter("llogin");
      String value2 = request.getParameter("lpass");
      Account account = new Account(value1, value2, false);
      DataBase.accounts.add(account);
      response.sendRedirect("index.jsp");
//      if(){
//        response.sendRedirect("#");
//      }
    }
  %>
</head>

<body>
<%@ include file = "include/shapka.jsp" %>
<div class="top">
  <div class="shapka">
    <img src="res/logo.png" alt="Здесь было лого, но его украли!">
    <hr>
  </div>
</div>
<div align="center">
  <div class='login'>
    <form action='regScript.jsp' method='get' id='login'>
      <input name='llogin' type='text' id='llogin' placeholder='Логин' required> <br>
      <input name='lpass' type='password' id='lpass' placeholder='Пароль' required> <br>
      <button class='login' type='submit'>Регистрация</button>
    </form>
  </div>
</div>
</body>
</html>
