<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
String sltTime = request.getParameter("sltTime");
String glcode = request.getParameter("glcode");
String glcost = request.getParameter("glcost");
String glname = request.getParameter("glname");
String mlname = request.getParameter("mlname");
String mlid = request.getParameter("mlid");
String phone = request.getParameter("phone");
String sltDay = request.getParameter("sltDay");
String glimg = request.getParameter("glimg");
System.out.println(glimg);
String time = "";
for (int i = 0; i < sltTime.length(); i++) {
	if (sltTime.indexOf('a') >= 0)			time += " 08:00 ~ 10:00 ";
	else if (sltTime.indexOf('b') >= 0)		time += " 10:00 ~ 12:00 ";
	else if (sltTime.indexOf('c') >= 0)		time += " 12:00 ~ 14:00 ";
	else if (sltTime.indexOf('d') >= 0)		time += " 14:00 ~ 16:00 ";
	else if (sltTime.indexOf('e') >= 0)		time += " 16:00 ~ 18:00 ";
	else if (sltTime.indexOf('f') >= 0)		time += " 18:00 ~ 20:00 ";
	else if (sltTime.indexOf('g') >= 0)		time += " 20:00 ~ 22:00 ";
}
%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
#body { width: 800px; margin: 0 auto; border: 1px solid green; }
#payMethod { width: 100%; margin: 0 auto; margin-top: 20px; }
#info { width: 100%; text-align: center; }
td { text-align: center; }
#noFrame { border: none; text-align: center; }
</style>
</head>
<body>
<div id="wrap">
<div id="head">
	<h2>경기장 예약하기 : <%=glname %></h2>
</div>
<div id="body">
<form name="frm" action="../rev.groundReq" method="post">
<input type="hidden" name="mlid" value="<%=mlid %>" />
<input type="hidden" name="glcode" value="<%=glcode %>" />
<input type="hidden" name="sltTime" value="<%=sltTime %>" />
<input type="hidden" name="glname" value="<%=glname %>" />
	<table width="700px" cellpadding="0" cellspacing="0">
	<tr>
		<td rowspan="5"><img src="../groundImg/<%=glimg %>" alt="구장메인이미지" width="300" height="300" /></td>
		<th>일자</th>
		<th>대관 시간</th>
		<th>가격</th>
	</tr>	
	<tr>
		<td><input type="text" name="sltDay" id="noFrame" readonly="readonly" value="<%=sltDay %>" /></td>
		<td><input type="text" name="time" id="noFrame" readonly="readonly" value="<%=time %>" /></td>
		<td><input type="text" name="cost" id="noFrame" readonly="readonly" value="<%=glcost %>" /></td>
	</tr>
	<tr>
	<td colspan="3">
	결제방법 : <input type="radio" name="pay" checked="checked" value="c" /> 체크/신용카드   <input type="radio" name="pay" value="m" /> 휴대폰결제
	</td>
	</tr>
	<tr>
	<td colspan="3">신청자 : <input type="text" name="mlname" id="noFrame" readonly="readonly" value="<%=mlname %>" /></td>
	</tr>
	<tr>
	<td colspan="3">연락처 : <input type="text" name="phone" id="noFrame" readonly="readonly" value="<%=phone %>" /></td>
	</tr>
	<tr>
	<th><input type="button" value="취소" onclick="self.close();"/>&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="예약" /></th>
	</tr>
	</table>
</form>
</div>
</div>
</body>
</html>