<%@ page import="jakarta.servlet.http.Cookie" %>
<%@ page import="com.example.demo5.Account" %>
<%@ page import="com.example.demo5.DataBase" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<meta charset="UTF-8">
<head>
<%
    boolean isEqual = false;
    Account.status = false;
    for (Account account : DataBase.accounts) {
        String value1 = request.getParameter("llogin");
        String value2 = request.getParameter("lpass");
        if (value1 != null) {
            if (value1.equals(account.getLogin()) && value2.equals(account.getPassword())) {
                //response.sendRedirect("performances.jsp");
                isEqual = true;
                if (value1.equals("Admin")) {
                    Account.isAdmin = true;
                    Cookie cookie = new Cookie("status", "admin");
                    //Cookie cookie1 = new Cookie("ID", "1");
                    cookie.setMaxAge(24 * 60 * 60);
                    //cookie1.setMaxAge(24 * 60 * 60);
                    cookie.setPath("http://localhost:8080/demo5_war_exploded/");
                    //cookie1.setPath("http://localhost:8080/demo5_war_exploded/");
                    response.addCookie(cookie);
                    response.setIntHeader("Refresh", 1);
                    //response.addCookie(cookie1);
                    //response.sendRedirect("index.jsp");
                } else {
                    Account.isAdmin = false;
                    Cookie cookie = new Cookie("status", "client");
                    //Cookie cookie1 = new Cookie("ID", "0");
                    cookie.setMaxAge(24 * 60 * 60);
                    //cookie1.setMaxAge(24 * 60 * 60);
                    cookie.setPath("http://localhost:8080/demo5_war_exploded/");
                    //cookie1.setPath("http://localhost:8080/demo5_war_exploded/");
                    response.addCookie(cookie);
                    //response.addCookie(cookie1);
                    response.sendRedirect("index.jsp");

                }
            }
        }
    }
    if (!isEqual){
        Account.status = true;
        //response.sendRedirect("index.jsp");
    }
%>
</head>
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
                <a href='#'>Заказы</a>
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
<%--        <div class='login'>--%>
<%--            <form action='' method='post' id='login1'>--%>
<%--                <input name='llogin1' type='text' id='llogin1' placeholder='Логин' required> <br>--%>
<%--                <input name='lpass1' type='password' id='lpass1' placeholder='Пароль' required> <br>--%>
<%--                <button class='login' type='submit'>Выйти</button>--%>
<%--            </form>--%>
<%--        </div>--%>
        <div class='login'>
            <form action='' method='post' id='login'>
                <input name='llogin' type='text' id='llogin' placeholder='Логин' required> <br>
                <input name='lpass' type='password' id='lpass' placeholder='Пароль' required> <br>
                <button class='login' type='submit'>Войти</button>
                <a href="registration.jsp">Регистрация</a>
            </form>
        </div>
    </div>
</div>