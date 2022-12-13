<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/login.css">
<title>Insert title here</title>
</head>
<body>
<%
	//register_process.jsp에서 id가 중복 되었으면 id가 중복 되었다고 출력함
	String error = request.getParameter("error");
	if(error != null){
		out.println("아이디가 중복되었습니다.");
	}
%>
<form action="register_process.jsp" method="post">
      <div class="login-wrap">
        <div class="login-html">
          <input id="tab-1" type="radio" name="tab" class="sign-in" checked><label for="tab-1" class="tab">회원가입</label>
          <input id="tab-2" type="radio" name="tab" class="sign-up"><label for="tab-2" class="tab"></label>
          <div class="login-form">
            <div class="sign-in-htm">
              <div class="group">
                <label for="user" class="label">학번</label>
                <input id="user" type="text" class="input" name="id">
              </div>
              <div class="group">
                <label for="pass" class="label">이름</label>
                <input id="pass"  type="text" class="input" data-type="input" name="name">
              </div>
              <div class="group">
                <label for="pass" class="label">비밀번호</label>
                <input id="pass"  type="password" class="input" data-type="password" name="passwd">
              </div>
              <div class="group">
                <label for="pass" class="label">인증 코드</label>
                <input id="pass" type="text" class="input" data-type="code" name="code">
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

</form>
</body>
</html>
</body>
</html>

