<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.Date" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/button.css">
        <link rel="stylesheet" href="css/table.css">
        <title>Sample</title>
        <script type="text/javascript">
      		//현재 날짜 불러오는 script
			window.onload = function() {
			today = new Date();
			System.out.println("today.toISOString() >>>" + today.toISOString());
			today = today.toISOString().slice(0, 10);
			console.log("today >>>> " + today);
			bir = document.getElementById("todaybirthday");
			bir.value = today;
			}
		</script>
    </head>
    <body>
        <div class="wrap">
            <div  class="header">
                <!--<button class="check">출결확인</button>-->
                <!--<button class="update">출결수정</button>-->
                <% 
                	//달력 데이터 포맷을 년-월-일로 고정한다
                	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                	//세션에 저장된 id가 없다면, 회원가입과 로그인 버튼이 보인다
                	if(session.getAttribute("sessionId") == null){
                %>
                <button onclick="location.href='register.jsp'"class="signUp" class="custom-btn btn-5">회원가입</button>
                <button onclick="location.href='login.jsp'" class="login" class="custom-btn btn-5">로그인</button>
                <%
                	}else{
                		%>
                	<script>
                	//로그인 할때 무슨 아이디로 접속 했는지 알 수 있다.
                	alert("<%=session.getAttribute("sessionName") %>교수님 어서오세요!");
                	</script>
                	<button style="margin-left:700px" id="logOut" onclick="location.href='logOut.jsp'" class="custom-btn btn-5">로그아웃</button>
                	<button style="margin-left:150px" id="member_delete" onclick="deleteCheck()" class="custom-btn btn-5">회원탈퇴</button>
                	<div class="dateResult" style="margin-left:1200px">
                		<form action="Searchpage.jsp">
                		<%
                			//선택된 달력 값으로 값을 받아옴
                			String selectDate = request.getParameter("dateSelect");
                		%>
                			<input id="todaybirthday" type="date" name="dateSelect">
                			<input type="submit" value="조회">
                		</form>
                	</div>
                	<script>
                	//회원탈퇴를 하게 되면 회원탈퇴 창이 뜬다.
					function deleteCheck() {
						if(window.confirm("정말로 회원 탈퇴 하시겠습니까?")){
		      			alert("탈퇴 완료.");
		      			location.href = 'delete_Process_member.jsp';
						}
		    		}
  					</script>
                	<!--<button onclick="location.href='member_update.jsp'" class="member_update">회원수정</button>-->
                <%
                	}
                %>
            </div>
            <div class="container">
            <br><br><br><br>
                        <%@include file ="dbconn.jsp" %>
        <%
        	// Select문을 사용하여 받아온 학번,이름,출결여부를 출력한다.
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            String sql = "Select * from FaceMask where dateTime like ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, format.format(new Date()));
            rs = pstmt.executeQuery();
        %>
        <form action="attendance_Process.jsp">
        <table align="center" width="250">
        <tr>
        	<th>학번</th>
        	<th>이름</th>
        	<th>출석여부</th>
        </tr>
        	<%while(rs.next()){
        		String ko = "";
        		if(rs.getString("whether") != null){
        			if(rs.getString("whether").equals("출석")){
        				ko = "출석";
        			}else if(rs.getString("whether").equals("지각")){
        				ko = "지각";
        			}else if(rs.getString("whether").equals("확인요망")){
        				ko = "확인요망";
        			}else{
        				ko = "결석";
        			}
    			}
        	%>
        	<tr class="column100 column1" data-column="column1"><td><%=rs.getString("id") %></td>
        		<td><%=rs.getString("name") %></td>
        		<td><%=rs.getString("whether") %>&nbsp;&nbsp;&nbsp;
        			<select name = "Chk">
        				<option value = "<%=rs.getString("whether")%>" selected><%=ko %></option>
          				<option value = "출석">출석</option>
          				<option value = "지각">지각</option>
          				<option value = "결석">결석</option>
          				<option value = "확인요망">확인요망</option>
          				<input type="hidden" name="tot" value='14'>
       				</select>
        		</td>
        		<%} %>
        	</tr>
        </table>
        <input class="custom-btn btn-5" type="submit" value="수정" style="margin-left: 800px; margin-top: 15px;">
  		</form>
        <br><br><br><br>
            </div>
        </div>
    </body>
</html>