<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="dbconn.jsp"%>
<%
	request.setCharacterEncoding("UTF-8");
	//아이디, 비밀번호, 코드를 받아옴
	String id = request.getParameter("id");
	String pw = request.getParameter("passwd");
	String code = request.getParameter("code");
	//해당 아이디가 있는지 확인하고
	String sql = "select * from Professor where id = ? and passwd =? and code =?";
	
	String msg = "login.jsp?error=1";
	
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, id);
	pstmt.setString(2, pw);
	pstmt.setString(3, code);
	
	rs = pstmt.executeQuery();
	
	while(rs.next()){
		String name = rs.getString("name");
		session.setAttribute("sessionName", name);
		session.setAttribute("sessionId", id);
		session.setAttribute("sessionCode", code);
		if(session.getAttribute("sessionId") != null){
			msg = "Main.jsp";
		}
		//교수코드가 사용되었으면 교수님 페이지로 넘어감
		if(code.equalsIgnoreCase("MJH473SW")){ //대소문자 상관없이 똑같은 문자열이면 admin 페이지로 전환
			msg = "admin.jsp";
		}
	}
	rs.close();
	pstmt.close();
	conn.close();
	response.sendRedirect(msg);
%>