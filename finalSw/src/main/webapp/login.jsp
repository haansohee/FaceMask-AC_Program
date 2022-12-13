<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/login.css">
<title>Insert title here</title>
</head>
<body>
<%
	String error = request.getParameter("error");
	if(error != null){
		out.println("가입되지않는 아이디거나 비밀번호나 코드가 다릅니다.");
	}
%>
<form action="loginProcess.jsp" method="post">
 <div class="login-wrap">
        <div class="login-html">
          <input id="tab-1" type="radio" name="tab" class="sign-in" checked><label for="tab-1" class="tab">로그인</label>
          <input id="tab-2" type="radio" name="tab" class="sign-up"><label for="tab-2" class="tab"></label>
          <div class="login-form">
            <div class="sign-in-htm">
              <div class="group">
                <label for="user" class="label">아이디</label>
                <input id="id" type="text" name = "id" class="input">
              </div>
              <div class="group">
                <label for="pass" class="label">비밀번호</label>
                <input id="passwd" name = "passwd" type="password" class="input" data-type="password">
              </div>
              <div class="group">
                <label for="pass" class="label">인증 코드</label>
                <input id="code" name = "code" type="text" class="input" data-type="code">
              </div>
              <div class="group">
                <input id="check" type="checkbox" class="check" checked>

              </div>
              <div class="group">
                <input type="submit" class="button" value="Sign In">
              </div>
              <div class="hr"></div>
              <div class="foot-lnk">

              </div>
            </div>
        </div>
       </div>
      </div>
</form>
</body>
</html>
</body>
</html>

