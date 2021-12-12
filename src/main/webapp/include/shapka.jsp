<%@ page import="jakarta.servlet.http.Cookie" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="false" %>
<meta charset="UTF-8">
<div class="top">
    <%
        boolean isClient = false;
        Cookie[] cookies = request.getCookies();
        if(cookies != null){
            for (Cookie cookie : cookies) {
                if(cookie.getName().equals("status") && cookie.getValue().equals("client"))
                    isClient = true;
            }
        }
    %>
    <div class="shapka">
        <img src="res/logo.png" alt="Здесь было лого, но его украли!">
        <hr>
    </div>
    <div class='fline'>
        <ul class="topmenu">
            <li>
                <a href='index.jsp'>Главное меню</a>
            </li>

                <%
                    if(isClient){
                %>
            <li>
                <a href='orders.jsp'>История покупок</a>
            </li>

                <%
                    }
                %>


        </ul>
        <div class='login'>
            <%

                if (cookies != null) {

            %>
            <form action='authorization.jsp' method='post' id='login'>
                <button class='login' type='submit'>Выйти</button>
                <input name="exit" value="1" type="hidden">
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