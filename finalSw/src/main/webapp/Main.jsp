<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
    <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta charset="UTF-8">
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
                	if(session.getAttribute("sessionId") == null){
                %>
                <button style="margin-left:700px"onclick="location.href='register.jsp'"class="custom-btn btn-5">회원가입</button>
                <button style="margin-left:150px"onclick="location.href='login.jsp'" class="custom-btn btn-5">로그인</button>
                <%
                	}else{
                		%>
                	<script>
                	alert("<%=session.getAttribute("sessionName") %>님 어서오세요");
                	</script>
                	<button style="margin-left:700px" id="logOut" onclick="location.href='logOut.jsp'" class="custom-btn btn-5">로그아웃</button>
                	<button style="margin-left:150px" id="member_delete" onclick="deleteCheck()" class="custom-btn btn-5">회원탈퇴</button>
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
        //달력의 데이터 포맷을 년-월-일로 지정함
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        //오늘 날짜의 학번,이름,출석여부를 가져옴
        String sql = "Select * from FaceMask where dateTime like ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, format.format(new Date()));
        rs = pstmt.executeQuery();

        %>
        <table align="center" width="250">
        <tr>
        	<th>학번</th>
        	<th>이름</th>
        	<th>출석여부</th>
        </tr>
        	<%while(rs.next()){%>
        	<tr class="column100 column1" data-column="column1"><td><%=rs.getString("id") %></td>
        		<td><%=rs.getString("name") %></td>
        		<td><%=rs.getString("whether")%></td>
        		<%} %>
        	</tr>
        </table>
        <br><br><br><br>
            </div>
        </div>
    </body>
</html>