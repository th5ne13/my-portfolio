<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>    
<%
request.setCharacterEncoding("utf-8");
ArrayList<GroundRevInfo> grdRevList = (ArrayList<GroundRevInfo>)request.getAttribute("grdRevList");
String revTime = "";
String date = request.getParameter("date");
String num = (String)request.getAttribute("num");
String glcode = (String)request.getAttribute("glcode");

if (grdRevList != null) {
	for (int i = 0; i < grdRevList.size(); i++) {
		revTime += grdRevList.get(i).getGr_time();
	}
} 

int dayType = 0;
if (!date.equals("")) {
	int yy = Integer.parseInt(date.substring(0, 4));
	int mm = Integer.parseInt(date.substring(5, 7));
	int dd = Integer.parseInt(date.substring(8));
	Calendar today = Calendar.getInstance();
	today.set(yy, mm-1, dd);
	if (today.get(Calendar.DAY_OF_WEEK) == 1 || today.get(Calendar.DAY_OF_WEEK) == 7) {
		dayType = 1;
	}
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
function sendTime() {
	var glcode = "<%=glcode%>";
	var num = "<%=num%>";
	var revTime = "<%=revTime%>";
	var date = "<%=date%>";
	var dayType = "<%=dayType%>"
	parent.getTime(revTime, date, dayType, num, glcode);
}

window.onload=sendTime;
</script>
</head>
<body>

</body>
</html>