<%--<%@ page import="javax.servlet.http.Cookie" %>--%>
<%@ page import="jakarta.servlet.http.Cookie" %>
<%@ page import="com.example.demo5.Account" %>
<%@ page import="com.example.demo5.DataBase" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page session="false" %>
<div class="top">

    <%
        response.setCharacterEncoding("utf-8");
        boolean isLogin = false;
        if(request.getParameter("exit")!=null || request.getParameter("llogin") != null) {
            boolean isEqual = false;
            if (request.getParameter("exit") != null) {
                Cookie[] cookie = request.getCookies();
                for (Cookie o : cookie) {
                    o.setMaxAge(0);
                    o.setValue(null);
                    response.addCookie(o);
                }
                isEqual = true;
            }
            String value1 = request.getParameter("llogin");
            String value2 = request.getParameter("lpass");
            if (value1 != null) {
                Account.status = false;
                for (Account account : DataBase.accounts) {

                    if (value1.equals(account.getLogin()) && value2.equals(account.getPassword())) {
                        //response.sendRedirect("performances.jsp");
                        if (account.isAdmin()) {
                            Account.isAdmin = true;
                            Cookie cookie = new Cookie("status", "admin");
                            Cookie cookie1 = new Cookie("id", String.valueOf(account.getId()));
                            cookie.setMaxAge(24 * 60 * 60);
                            cookie1.setMaxAge(24 * 60 * 60);
//                cookie.setPath("http://localhost:8080/demo5_war_exploded/");
                            response.addCookie(cookie);
                            response.addCookie(cookie1);
                            isLogin = false;
                            isEqual = true;
                            break;
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
                            isEqual = true;
                            break;
                        }
                    }
                }
                isLogin = true;

            }


            if (isEqual) {
                Account.status = true;
                response.setIntHeader("Refresh", 0);
                return;
            }

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
        <img src="res/logo.png" alt="?????????? ???????? ????????, ???? ?????? ????????????!">
        <hr>
    </div>
    <div class='fline'>
        <ul class="topmenu">
            <li>
                <a href='index.jsp'>?????????????? ????????</a>
            </li>

                <%
                    if(isClient1){
                %>
            <li>
                <a href='orders.jsp'>?????????????? ??????????????</a>
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
                <button class='login' type='submit'>??????????</button>
                <input name="exit" value="1" type="hidden">
            </form>
            <%
            } else {
                if(isLogin){
                    %>
            <span style="color: red; font-size: smaller">???????????????? ?????????? ?????? ????????????</span>
            <%
                }
            %>
            <form action='' method='post' id='login'>
                <input name='llogin' type='text' id='llogin' placeholder='??????????' required> <br>
                <input name='lpass' type='password' id='lpass' placeholder='????????????' required> <br>
                <button class='login' type='submit'>??????????</button>
                | <!--<a href='signup.php'>??????????????????????</a>-->
                <a href="registration.jsp">??????????????????????</a>
            </form>
            <%
                }
            %>
        </div>
    </div>
</div>