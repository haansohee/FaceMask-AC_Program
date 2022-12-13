<%@ include file="dbconn.jsp"%>
<%
	request.setCharacterEncoding("utf-8");
	
	String id = (String)session.getAttribute("sessionId");
	String passwd = request.getParameter("pw");
	String name = request.getParameter("name");

	PreparedStatement pstmt = null;

	String sql = "update Professor set passwd=?, name=? where id=?";
	
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, passwd);
	pstmt.setString(2, name);
	pstmt.setString(3, id);
	
	pstmt.executeUpdate();
	
	conn.close();
	pstmt.close();
	
	//session.removeAttribute("sessionId");
	session.removeAttribute("name");
	//session.setAttribute("sessionId", id);
	session.setAttribute("sessionName", name);
	response.sendRedirect("Main.jsp");
%>