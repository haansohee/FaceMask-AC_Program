<%@ include file="dbconn.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");
	//아이디, 비밀번호, 이름, 코드를 받아옴
	String id = request.getParameter("id");
	String pw = request.getParameter("passwd");
	String name = request.getParameter("name");
	String code = request.getParameter("code");
	
	//해당 아이디가 있는지 확인함
	String sql = "select * from  Professor where id =?";
	
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, id);
	rs = pstmt.executeQuery();
	
	//아이디가 없으면 아이디를 생성
	if(!rs.next()){
		sql = "insert into Professor values(?,?,?,?)";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, name);
		pstmt.setString(3, pw);
		pstmt.setString(4, code);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		rs.close();
		conn.close();
		
		response.sendRedirect("Main.jsp");
	}else{		
		//아이디가 있으면 error를 1을 보내고 회원가입 화면으로 내보냄
		pstmt.close();
		rs.close();
		conn.close();
		
		response.sendRedirect("register.jsp?error=1");
	}
%>