<%@ page import="jakarta.servlet.http.Cookie" %>
<%@ page import="com.example.demo5.Account" %>
<%@ page import="com.example.demo5.DataBase" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page session="false" %>
<div class="top">

    <%
        response.setCharacterEncoding("utf-8");
        if(request.getParameter("exit")!=null || request.getParameter("llogin") != null) {
            boolean isEqual = false;
            if (request.getParameter("exit") != null) {
                Cookie[] cookie = request.getCookies();
                for (Cookie o : cookie) {
                    o.setMaxAge(0);
                    o.setValue(null);
                    response.addCookie(o);
                }
            }
            boolean isLogin =false;
            String value1 = request.getParameter("llogin");
            String value2 = request.getParameter("lpass");
            if (value1 != null) {
                Account.status = false;
                for (Account account : DataBase.accounts) {

                    if (value1.equals(account.getLogin()) && value2.equals(account.getPassword())) {
                        //response.sendRedirect("performances.jsp");
                        isEqual = true;
                        if (account.isAdmin()) {
                            Account.isAdmin = true;
                            Cookie cookie = new Cookie("status", "admin");
                            Cookie cookie1 = new Cookie("id", String.valueOf(account.getId()));
                            cookie.setMaxAge(24 * 60 * 60);
                            cookie1.setMaxAge(24 * 60 * 60);
//                cookie.setPath("http://localhost:8080/demo5_war_exploded/");
                            response.addCookie(cookie);
                            response.addCookie(cookie1);
                            isLogin = true;
                        } else {
                            Account.isAdmin = false;
                            Cookie cookie = new Cookie("status", "client");
                            cookie.setMaxAge(24 * 60 * 60);
                            Cookie cookie1 = new Cookie("id", String.valueOf(account.getId()));
                            cookie1.setMaxAge(24 * 60 * 60);
//                cookie.setPath("http://localhost:8080/demo5_war_exploded/");
                            response.addCookie(cookie);
                            response.addCookie(cookie1);
                            isLogin = false;
                        }
                    }
                }
            }


            if (!isEqual) {
                Account.status = true;
            }
            response.sendRedirect("index.jsp");
            return;
        }

    %>
    <%

        boolean isClient1 = false;
        Cookie[] cookies1 = request.getCookies();
        if(cookies1 != null){
            for (Cookie cookie2 : cookies1) {
                if(cookie2.getName().equals("status") && cookie2.getValue().equals("client"))
                    isClient1 = true;
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
                    if(isClient1){
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
                Cookie[] cok = request.getCookies();
                if (cok != null) {

            %>
            <form action='' method='post' id='login'>
                <button class='login' type='submit'>Выйти</button>
                <input name="exit" value="1" type="hidden">
            </form>
            <%
            } else {
            %>
            <form action='' method='post' id='login'>
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