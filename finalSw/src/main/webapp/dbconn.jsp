<%@page import="java.sql.*"%> <%-- JDBC API 임포트 작업 --%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String driverName="com.mysql.jdbc.Driver";	// mysql driver
    String url = "jdbc:mysql://localhost:3306/FaceMask_Program"; //swproject 위치는 테이블 명
    String root = "sohee";	//아이디
    String pwd ="wnsgur0702";	//비번
   
    try{
        //[1] JDBC 드라이버 로드
        Class.forName(driverName);     
    }catch(ClassNotFoundException e){
        out.println("Where is your mysql jdbc driver?");
        e.printStackTrace();
        return;
    }
    //out.println("mysql jdbc Driver registered!!");
   
    //[2]데이타베이스 연결 
    Connection conn = DriverManager.getConnection(url,root,pwd);
    //out.println("DB연결성공!!");
     
    //[3]데이타베이스 연결 해제
    //conn.close();
%>