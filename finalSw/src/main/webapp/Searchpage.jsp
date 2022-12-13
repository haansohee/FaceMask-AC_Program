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
    </head>
    <body>
        <div class="wrap">
            <div  class="header">
                <!--<button class="check">출결확인</button>-->
                <!--<button class="update">출결수정</button>-->
                <% 
                /* Searchpage.jsp는 admin.jsp와 유사함 */
                // 다만 저번 출결결과를 확인만 가능하고, 수정은 불가함
                	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                	if(session.getAttribute("sessionId") == null){
                %>
                <button onclick="location.href='register.jsp'"class="signUp">회원가입</button>
                <button onclick="location.href='login.jsp'" class="login">로그인</button>
                <%
                	}else{
                		%>
                	<script>
                	alert("<%=session.getAttribute("sessionName") %>교수님 어서오세요!");
                	</script>
                	<button style="margin-left:700px" class="custom-btn btn-5" id="logOut" onclick="location.href='logOut.jsp'" >로그아웃</button>
                	<button style="margin-left:150px" class="custom-btn btn-5" id="member_delete" onclick="deleteCheck()">회원탈퇴</button>
                	<div class="dateResult" style="margin-left:1200px">
                		<form action="Searchpage.jsp">
                		<%
                			String selectDate = request.getParameter("dateSelect");
                			if(selectDate == null){ 
                			//선택된 값이 없다면, 기본 값이 들어감
                		%>
                			<input type="date" name="dateSelect">
                			<%}else { 
                			//받아온 날짜 값이 들어감
                			%>
                			<input type="date" value = "<%=selectDate%>"name="dateSelect">
                			<%} %> 
                			<input type="submit" value="조회">
                		</form>
                	</div>
                	<script>
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
        	//날짜 값을 받아와서 해당 날짜값으로 데이터를 변경해줌
        	String changeDate = request.getParameter("dateSelect");
        	/* System.out.println(changeDate); */
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            String sql = "Select * from FaceMask where dateTime=?";
            //"Select * from student where dateTime like ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, changeDate);
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
  		</form>
        <br><br><br><br>
            </div>
        </div>
    </body>
</html>