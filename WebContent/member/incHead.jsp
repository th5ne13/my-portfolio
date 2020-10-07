<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>
<%
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	String sql = null;
	// DB로 연결할 때 사용하는 클래스
	String driver = "com.mysql.jdbc.Driver";
	String dbUrl = "jdbc:mysql://localhost:3306/greenground?serverTimezone=Asia/Seoul";
	// mysql 5.1 이상부터는 '?serverTimezone=Asia/Seoul'를 필수로 입력해야 함
	// localhost : mysql DBMS가 설치된 서버를 의미하며, 웹서버와 다른 서버일 경우 IP를 입력함
	// mall : 연결할 DB(스키마)의 이름
	// ?serverTimezone=Asia/Seoul : 5.1버전 이상부터 입력하는 시간대 지정 문자열

	try {
		Class.forName(driver);
		conn = DriverManager.getConnection(dbUrl, "root", "1234");
		// 아이디와 암호를 이용하여 DB에 연결함

	} catch (Exception e) {
		e.printStackTrace();
	}
	request.setCharacterEncoding("utf-8");
%>