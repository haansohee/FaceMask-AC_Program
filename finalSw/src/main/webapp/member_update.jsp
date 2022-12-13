<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="dbconn.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String Id = (String)session.getAttribute("sessionId"); // 세션에 저장된 id를 불러오기
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql = "select * from Professor where id=?"; 
			
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, Id);
	rs = pstmt.executeQuery();
	while(rs.next()){
		
%>
<form action="member_update_process.jsp" method="post">
	<label><%=Id %></label>
	<input type="password" name="pw" value="<%=rs.getString("passwd")%>">
	<input type="text" name="name" value="<%=rs.getString("name") %>">
	<input type="submit" value="수정">
</form>
<%
	}
	conn.close();
	pstmt.close();
	rs.close();
%>
</body>
</html>