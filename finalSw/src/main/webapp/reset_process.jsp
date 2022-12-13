<%@page import="java.sql.*" %>
<%@include file="dbconn.jsp"%>
<%@page contentType="text/html; charset=UTF-8" %>
<%
	PreparedStatement pstmt = null; //sql구문 입력
	//ResultSet rs = null;			//sql구문 결과
	//"null" sql문 "''" 절대 null이 아님
	//다쓴 휴지 or 없는 휴지
	String sql = "update FaceMask set whether=" + "''" + " where id is not null";
	pstmt = conn.prepareStatement(sql); //pstmt에다가 connection 한 pstmt 사용함
	pstmt.executeUpdate();	//sql구문 실행

	if(conn != null){
		conn.close();
	}
	if(pstmt != null){
		pstmt.close();
	}
	response.sendRedirect("Main.jsp");
%>