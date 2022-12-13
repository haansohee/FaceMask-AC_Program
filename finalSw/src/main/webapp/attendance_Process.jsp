<%@page import="java.util.ArrayList"%>
<%@ include file="dbconn.jsp"%>
<%@ page import="sw.MemberDAO" %>
<%@ page import="sw.MemberDTO" %>
<%
	//utf-8로 인코딩한다
	request.setCharacterEncoding("utf-8");

	PreparedStatement pstmt = null;
	ResultSet rs = null;

	//String type에 student 배열을 만들고, student 테이블의 값을 받아와서 id를 추가한다
	ArrayList<String> student = new ArrayList<>();
    String sql1 = "select * from FaceMask";
    pstmt = conn.prepareStatement(sql1);
	rs = pstmt.executeQuery();

    while(rs.next()){
        student.add(rs.getString("id"));
    }

    for(String s: student){
        System.out.println(s);
    }
    
    String[] stu = request.getParameterValues("Chk");
    
    //출결여부를 배열로 만들고, 향상된 for문을 사용하여 체크량 만큼 배열을 추가한다.
    ArrayList<String> stuTemp = new ArrayList<>();
    if(stu!=null){
        for(String temp : stu){
        	stuTemp.add(temp);
        }
    }
    System.out.println(stuTemp);

	for(int i =0; i <student.size(); i++){
	//배열에 넣은 id값과 출결여부를 배열순대로 update한다. (출결수정)
	String sql2 = "update FaceMask set whether=? where id=?";
	pstmt = conn.prepareStatement(sql2);
	
	pstmt.setString(1, stuTemp.get(i));
	pstmt.setString(2, student.get(i));
	pstmt.executeUpdate();
	}

	conn.close();
	pstmt.close();
	response.sendRedirect("admin.jsp");
%>