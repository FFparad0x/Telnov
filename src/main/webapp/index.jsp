<%@ page import="jakarta.ws.rs.core.Request" %>
<%@ page import="jakarta.annotation.Resource" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <% String a = "<b>ggg</b>"; %>
    <title>JSP - Hello World</title>
</head>
<body>
<div class = "shapka">
    <img src = "res/logo.png" alt = "Здесь было лого, но его украли!">
    <hr>
</div>
<div class='fline'>
    <ul class="topmenu">
        <li>
            <a href='index.php'>Главное меню</a>
        </li>
        <li>
            <a href='news.php'>Корзина</a>
        </li>
    </ul>
    <div class = 'login'>
        <form action = '' method = 'post' id='login'>
            <input name='llogin' type='text' id='llogin' placeholder='Логин' required>  <br>
            <input name='lpass' type='password' id='lpass' placeholder='Пароль' required> <br>
            <button class='login' type='submit'>Войти</button> | <a href = 'signup.php'>Регистрация</a>
        </form>
    </div>
</div>
<h1><%= "Hello World!" %>
</h1>
<br>

<a href="hello-servlet">Hello Servlet</a>


    </body>
</html>