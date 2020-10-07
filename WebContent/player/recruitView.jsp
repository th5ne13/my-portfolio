<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.MemberInfo"%>
<%
String chk = "";
int testval = 0;
MemberInfo memberInfo = (MemberInfo)session.getAttribute("memberInfo");

ArrayList<PlayerInfo> recruitViewList = 
(ArrayList<PlayerInfo>)request.getAttribute("recruitViewList");

String mlid = memberInfo.getMl_id();

if (session.getAttribute("memberInfo") == null) {
	out.println("<script>");
	out.println("alert('잘못된 경로로 들어 오셨습니다.');");
	out.println("history.back();");
	out.println("</script>");
}

String upid = request.getParameter("upid");
String realpwd = request.getParameter("chk");

String num = request.getParameter("num");
String title = request.getParameter("title");
String name = request.getParameter("name");
String addr = request.getParameter("addr");
String plan = request.getParameter("plan");
String phone = request.getParameter("phone");
String isend2 = request.getParameter("isend");
String level = request.getParameter("level");
String position = request.getParameter("position");
String[] positionArray = position.split(",");
String fav = "";
for (int i = 0 ; i < positionArray.length ; i++) {
	if (i > 0) fav += ",";
	if (positionArray[i].equals("A")) fav += "공격수";
	else if	(positionArray[i].equals("B")) fav += "미드필더";
	else if	(positionArray[i].equals("C")) fav += "수비수";
	else if (positionArray[i].equals("D")) fav += "골키퍼";
}
String matchtype = request.getParameter("matchtype");
String recruitnum = request.getParameter("recruitnum");
String date = request.getParameter("date");

String uniqueRevNum = "1" + mlid + num + "R";

String reqid = "", reqnum = "";
if (recruitViewList.size() > 0) {	// 공지사항 목록이 있으면
	for (int i = 0 ; i < recruitViewList.size() ; i++) {
		PlayerInfo notice = (PlayerInfo)recruitViewList.get(i);
		reqid = notice.getMl_id();	// post id가 아니라 mlid여야함
		reqnum = notice.getReq_num();
		if (reqnum.equals(uniqueRevNum)) {
			out.println("<script>");
			out.println("alert('이미 지원한 게시물입니다.');");
			out.println("window.close();");
			out.println("</script>");
		}
	}
}

if (isend2.equals("신청 가능")) {
	isend2 = "신청가능";
} else {
	isend2 = "마감";
}

String chkbtn = "신청하기";
if (memberInfo == null) {
	chk = "미로그인 상태";
} else {
	chk = "로그인 성공";
	if (memberInfo.getMl_id().equals(upid)) {	// 로그인id랑 글올린놈 id랑 같으면
		chkbtn = "수정하기";
		testval = 2;
	}
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
.recruitView td { padding:0 0 0 10px; }
.recruitView th { background:#EFEFEF; }
</style>
<style>
</style> 
<script>
function chkFun(all) {
	var textpwd = document.detail.pwd.value;
	if (<%=testval %> > 0) {
		if (textpwd == (<%=realpwd %>)){
			alert('수정화면으로 넘어갑니다.');
			// all.action="in.notice";
			all.action="#"; // 여기까진 먹음 
			opener.location.href="up.notice?num=<%=num %>&realpwd=<%=realpwd %>&upid=<%=upid %>&title=<%=title %>&name=<%=name %>&addr=<%=addr %>&plan=<%=plan %>&phone=<%=phone %>&isend2=<%=isend2 %>&level=<%=level %>&position=<%=position %>";
			self.close();
			return true;
		} else {
			alert('비밀번호가 다릅니다. 다시 확인해주세요');
			all.action="#";
		}	
	}
}

</script>
</head>
<body>


<form name="detail" onsubmit="return chkFun(this);" action="recruit.request" method="post" >
	<input type="hidden" name="type" value="in" />
	<input type="hidden" name="reqtype" value="R" />
	<input type="hidden" name="memid" value="<%=memberInfo.getMl_id() %>" />
	<input type="hidden" name="upid" value="<%=upid %>" />	
	<input type="hidden" name="num" value="<%=num %>" />	
	<input type="hidden" name="reqstatus" value="W" />	
	<input type="hidden" name="matchtype" value="<%=matchtype %>" />	
	<input type="hidden" name="addr" value="<%=addr %>" />
	<input type="hidden" name="plan" value="<%=plan %>" />
	<input type="hidden" name="recruitnum" value=<%=recruitnum %> />	
	<input type="hidden" name="name" value="<%=name %>" />
	<input type="hidden" name="date" value="<%=date %>" />	

<h2 align="center">용병 모집 상세보기</h2>
<table class="recruitView" width="800" height="600" border="1px solid black" align="center">
<tr><th width="15%">이름<td colspan="3"><%=name %></td></tr>
<tr><th>지점<td colspan="3"><%=addr %></td></tr>
<tr><th>경기일자<td colspan="3"><%=plan %></td></tr>
<tr><th>연락처<td colspan="3"><%=phone %></td></tr>
<tr><th width="15%">신청 가능 여부<td><%=isend2 %></td><td>팀 수준</td><td><%=level %></td></tr>
<tr><th>모집 포지션<td colspan="3"><%=fav %></td></tr>
<tr><th colspan="4"><%=title %></th></tr>
<%
if(chkbtn.equals("수정하기"))	out.println("<tr><th>비밀번호</th><td colspan='3' align='left'><input type='password' name='pwd' size='30' /></td></tr>");

%>
</table>

<br />
<table width="800" border="0px solid black" align="center">
	<tr>
		<td align="center"><input type="submit" value="<%=chkbtn %>" style="height:50px; width:150px;"></td>
	</tr>	
</table>

</form>

</body>
</html>