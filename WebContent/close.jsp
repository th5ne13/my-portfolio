<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ page import="vo.*"%>    
<%
MemberInfo memberInfo = (MemberInfo)session.getAttribute("memberInfo");
String mlid = memberInfo.getMl_id();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
function goIndex() {
	var mlid = "<%=mlid%>";
	alert("예약이 완료되었습니다.");
	alert(mlid);
	opener.parent.location.href="list.reserve?mlid=" + mlid;
	window.open('', '_self', '');
	window.close();
}

window.onload=goIndex;
</script>
</head>
<body>
닫혀라
</body>
</html>