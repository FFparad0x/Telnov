<%@ page import="jakarta.servlet.http.Cookie" %>
<%@ page contentType="text/html; charset=UTF-8" %>
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
<%--                TODO:if logined--%>
                <a href='#'>Зазазы</a>
            </li>
            <%
                Cookie[] cookies = request.getCookies();
                String cookieName = "status";
                Cookie cookie = null;
                if (cookies != null) {
                    for (Cookie c : cookies) {
                        if (cookieName.equals(c.getName())) {
                            cookie = c;
                            break;
                        }
                    }
                }
                if (cookie != null && cookie.getValue().equals("admin")) {%>
            <%="<li><a href = '#'>Редактировать</a></li>"%>
            <%
                }
            %>

        </ul>
        <div class='login'>
            <form action='authorization.jsp' method='post' id='login'>
                <input name='llogin' type='text' id='llogin' placeholder='Логин' required> <br>
                <input name='lpass' type='password' id='lpass' placeholder='Пароль' required> <br>
                <button class='login' type='submit'>Войти</button>
                | <!--<a href='signup.php'>Регистрация</a>-->
                <a href="registration.jsp">Регистрация</a>
            </form>
        </div>
    </div>
</div>