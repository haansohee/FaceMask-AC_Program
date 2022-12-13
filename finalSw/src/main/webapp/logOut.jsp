<%
	//세션아이디와 이름을 제거함
	session.removeAttribute("sessionId");
	session.removeAttribute("sessionName");
	session.invalidate();
	
	response.sendRedirect("Main.jsp");
%>