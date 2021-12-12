<%@ page import="jakarta.servlet.http.Cookie" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="false" %>
<meta charset="UTF-8">
<div class="top">
    <div class="shapka">
        <img src="res/logo.png" alt="Здесь было лого, но его украли!">
        <hr>
    </div>
    <div class='fline'>
        <ul class="topmenu">
            <li>
                <a href='index.jsp'>Главное меню</a>
            </li>
            <li>
                <a href='#'>Корзина</a>
            </li>
            <%
                Cookie[] cookies = request.getCookies();
            %>
        </ul>
        <div class='login'>
            <%

                if (cookies != null) {

            %>
            <form action='authorization.jsp' method='post' id='login'>
                <button class='login' type='submit'>Выйти</button>
                <input name="exit" value="1" type="hidden">
                <a href="registration.jsp">Регистрация</a>
            </form>
            <%
            } else {
            %>
            <form action='authorization.jsp' method='post' id='login'>
                <input name='llogin' type='text' id='llogin' placeholder='Логин' required> <br>
                <input name='lpass' type='password' id='lpass' placeholder='Пароль' required> <br>
                <button class='login' type='submit'>Войти</button>
                | <!--<a href='signup.php'>Регистрация</a>-->
                <a href="registration.jsp">Регистрация</a>
            </form>
            <%
                }
            %>
        </div>
    </div>
</div>