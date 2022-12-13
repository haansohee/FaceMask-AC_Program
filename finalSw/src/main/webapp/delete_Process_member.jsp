<%@ include file="dbconn.jsp" %>
<%
	//세션에 저장되어 있는 id값을 받아옴
	String id = (String)session.getAttribute("sessionId");
	
	//해당 세션 id를 mysql DB에서 제거함
	String sql = "delete from Professor where id = ?";

	PreparedStatement pstmt = null;

	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, id);

	pstmt.executeUpdate();
	
	//세션을 지움
	session.invalidate();
	pstmt.close();
	conn.close();
	response.sendRedirect("Main.jsp");
%>