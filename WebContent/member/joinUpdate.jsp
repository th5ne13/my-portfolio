<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>    
<%@ page import="vo.*"%>    
<%
//index 기본 설정
String mlid = "";
MemberInfo memberInfo = (MemberInfo)session.getAttribute("memberInfo");
if (memberInfo == null) {
	out.println("<script>");
	out.println("alert('로그인 후 사용할 수 있습니다');");
	out.println("history.back();");
	out.println("</script>");
} else {	
	mlid = memberInfo.getMl_id();
}
ArrayList<GroundListInfo> groundList = (ArrayList<GroundListInfo>)request.getAttribute("groundList");
String groundRq = "구장제휴신청";
String glCode = "";

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	<!-- CSS STYLE -->
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/reset.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/base.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/layout.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css" />
<style>
</style>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function api() {
	new daum.Postcode({
	    oncomplete: function(data) {
	        document.getElementById('addr1').value = data.sigungu;
	        document.getElementById('addr2').value = data.bname;
	    }
	}).open();
}
//입력받은 문자열이 영문과 숫자, 언더바 만으로 이루어졌는지 여부를 검사하는 함수
function isEngNum(str, chk) {
// str : 글자단위로 검사할 문자열 / chk : 첫글자에 대한 영문사용을 검사할지 여부
	str = str.toLowerCase();
	// 받아온 문자열을 일괄적으로 소문자로 변환한 후 검사

	if (chk == "y") {	// 첫 글자가 영문인지 여부를 검사
		var c = str.charAt(0);	// 첫 글자 추출
		if (c < "a" || c > "z") {
			alert("영문이 아닙니다");
			return false;
		}
	}
	// 한 글자씩 추출하여 검사하는 for문
	for (var i = 0; i < str.length ; i++) {
		var c = str.charAt(i);
		if (!((c >= "0" && c <= "9") || (c >= 'a' && c <= 'z') || c == "_")) {
			alert("영문");
			return false;
		}
	}
	return true;
}
//전화번호 숫자만 입력하게 함
function onlyNum(obj) {
	if (isNaN(obj.value)) {
		obj.value = "";		obj.focus();
	}
}
//취소 눌렀을시 로그인화면으로 돌아감
function returnIndex() {
	location.href="curRev.jsp";
}
//회원가입폼에 입력된 데이터들을 검사하여 서버로의 전송여부를 결정하는 함수
function chkValue(frmJoin) {
	var pw = frmJoin.pwd.value;
	var pw2 = frmJoin.pwd2.value;
	var m2 = frmJoin.m2.value;
	var m3 = frmJoin.m3.value;
	var addr1 = frmJoin.addr1.value;
	var addr2 = frmJoin.addr2.value;
	// 비밀번호검사
	if (pw == "") {
		alert("비밀번호를 입력하세요.");
		frmJoin.pwd.focus();
		return false;

	} else if (!isEngNum(pw, "n")) {
		alert("비밀번호는 영문, 숫자, 언더바의 조합으로만 입력하세요.");
		frmJoin.pwd.value = "";
		frmJoin.pwd.focus();
		return false;

	} else if (pw != pw2) {
		alert("비밀번호와 비밀번호 확인이 서로 다릅니다.");
		frmJoin.pwd.value = "";
		frmJoin.pwd2.value = "";
		frmJoin.pwd.focus();
		return false;
	}
	
	// m2는 세자리 이상의 숫자, m3는 네자리의 숫자인지 검사
	if (m2 == "" || m2.length < 3) {
		alert("휴대폰 번호 가운데 3자리이상을 입력하세요.");
		frmJoin.m2.select();
		frmJoin.m2.focus();
		return false;
	}
	if (m3 == "" || m3.length != 4) {
		alert("휴대폰 번호 마지막 4자리를 입력하세요.");
		frmJoin.m3.value = "";
		frmJoin.m3.focus();
		return false;
	}
	// 구, 동 검사
	if (addr1 == "") {
		alert("구를 입력하세요.");
		frmJoin.addr1.focus();
		return false;
	}
	if (addr2 == "") {
		alert("동을 입력하세요.");
		frmJoin.addr2.focus();
		return false;
	}
	return true;
}
</script>
</head>
<body>
<div id="wrapper">
<div id="header">	
<div class="main_common">
<% if (memberInfo == null) { %>
<a href="list.board?btype=d">게시판</a>
<a href="loginForm.jsp" onclick="alert('로그인 후 사용하실 수 있습니다.')">용병</a>
<a href="loginForm.jsp" onclick="alert('로그인 후 사용하실 수 있습니다.')"><%=groundRq  %></a>
</div>
<div class="main_common"><a href="start.jsp">그림그림</a></div>
<div class="main_common">
	<a href="loginForm.jsp">로그인</a>
	<a href="joinClause.jsp">회원가입</a>
<% } else { 
	String reqType = "in";
	if (memberInfo.getMl_membertype().equals("o"))	{
		groundRq = "내구장관리";
		glCode = memberInfo.getGl_code();
		reqType = "up";
//		out.println(glCode);
	}
//	out.println(memberInfo.getMl_name() + "(" + memberInfo.getMl_id() + ") 님 환영합니다.<br />");
%>
	<a href="../list.board?btype=d">게시판</a>
	<a href="../list.notice?memberInfo=<%=memberInfo %>">용병</a>
</div>
<div class="main_common"><a href="../start.jsp">그림그림</a></div>
<div class="main_common">
	<a href="../<%=reqType %>.groundReq?glcode=<%=glCode%>"><%=groundRq %></a>
	<a href="../logout">로그아웃</a>
	<a href="../list.reserve?mlid=<%=mlid%>">마이페이지</a>
<% } %>
</div>	
</div>
<!-- body 시작-->
<div id="body">
	<!-- 구장 예약현황 시작 -->
	<div class="myPage">
		<div class="container">
			<div class="sideMenu"><br />	
				<a href="../list.reserve?mlid=<%=mlid%>">예약 현황</a><br />
				<a href="../player/list.request">용병 현황</a><br />
				<a href="joinUpdate.jsp">회원정보 수정</a><br />
				<a href="../per.board?mlid=<%=mlid%>">1 : 1 문의</a><br />
				<a href="outClause.jsp">회원탈퇴</a>
			</div>
			<div class="curSituation">
				<div class="groundRev">					
					<form name="frmJoin" action="../up.join" method="post" onsubmit="return chkValue(this);">
					<input type="hidden" name="kind" value="up" />
						<table class="upForm">
							<tr>
								<th width="20%">아이디</th>
								<td width="*" valign="middle">
									<label for="uid"></label><input type="text" name="uid" id="uid" value="<%=memberInfo.getMl_id()%>"  readonly="readonly" />&nbsp;&nbsp;&nbsp;
									<!-- <input type="button" value="아이디 중복 확인" onclick="openIdChk();"/> -->
								</td>
							</tr>							
							<tr>
								<th>비밀번호</th>
								<td><label for="pwd"></label><input type="password" name="pwd" maxlength="20" id="pwd" /></td>
							</tr>
							<tr>
								<th>비밀번호 재확인</th>
								<td><label for="pwd2"></label><input type="password" name="pwd2" maxlength="20" id="pwd2" /></td>
							</tr>
							<tr>
								<th>이름</th>
								<td><label for="uname"></label><input type="text" name="uname" id="uname" value="<%=memberInfo.getMl_name() %>" readonly="readonly" /></td>
							</tr>
<%
String p1 = "", p2 = "", p3 = "";
if (memberInfo.getMl_phone() != null && !memberInfo.getMl_phone().equals("010--")) {
	String [] arrPhone = memberInfo.getMl_phone().split("-");
	p1 = arrPhone[0];
	p2 = arrPhone[1];
	p3 = arrPhone[2];
}
%>							
							<tr>
								<th>연락처</th>
								<td>
									<select name="m1">
										<option value="010" <% if (p1.equals("010")) { %> selected="selected" <% } %>>010</option>
										<option value="011" <% if (p1.equals("011")) { %> selected="selected" <% } %>>011</option>
										<option value="016" <% if (p1.equals("016")) { %> selected="selected" <% } %>>016</option>
										<option value="019" <% if (p1.equals("019")) { %> selected="selected" <% } %>>019</option>
									</select>
									-
									<input type="text" name="m2" id="" size="4" value="<%=p2 %>" maxlength="4" onkeyup="onlyNum(this);" />
									-
									<input type="text" name="m3" id="" size="4" value="<%=p3 %>" maxlength="4" onkeyup="onlyNum(this);" />
								</td>
							</tr>
							<tr>
								<th>선호하는 풋살장 지역</th>
								<td>					
									<input type="text" name="addr1" id="addr1" value="<%=memberInfo.getMl_addr1() %>" size="9" readonly="readonly"/>
									<input type="text" name="addr2" id="addr2" value="<%=memberInfo.getMl_addr2() %>" size="5" readonly="readonly"/>
									<input type="button" value="주소 검색" onclick="api();"/>
								</td>
							</tr>
							<tr>
								<th>선호 포지션</th>
								<td>
									<input type="checkbox" name="position" id="forward" value="A" /><label for="forward">공격수</label>
									<input type="checkbox" name="position" id="midfielder" value="B" /><label for="midfielder">미드필더</label>
									<input type="checkbox" name="position" id="defender" value="C" /><label for="defender">수비수</label>
									<input type="checkbox" name="position" id="goalkeeper" value="D" /><label for="goalkeeper">골키퍼</label>
								</td>
							</tr>
							<tr>
								<th>질문</th>
								<td>
									<select name="question">
										<option value="fruits">좋아하는 과일은?</option>
										<option value="player">좋아하는 축구선수의 이름은?</option>
										<option value="team">좋아하는 축구팀은?</option>
										<option value="middleschool">졸업한 중학교의 이름은?</option>
										<option value="favorite">가장 소중하게 생각하는 것은?</option>
									</select>
								</td>
							</tr>
							<tr>
								<th>답변</th>
								<td><input type="text" maxlength="30" name="answer" id="answer" /></td>
							</tr>					
						</table>
						<table class="btn">
							<tr>
								<td>
									<input type="button" value="취 소" onclick="location.href='../start.jsp'"/>&nbsp;&nbsp;&nbsp;
									<input type="submit" value="확 인" />
								</td>
							</tr>
						</table><br /><br />	
					</form>					
				</div>
			</div>		
		</div>
	</div><br /><br />
	<!-- 구장 예약현황 종료 -->
</div>
<!-- body 종료-->

<div id="footer">
	<div class="companyInfo">
		<ul>
			<li><a href="#">사이트 도움말</a></li>
			<li><a href="#">사이트 이용약관</a></li>
			<li><a href="#">사이트 운영규칙</a></li>
			<li><a href="#"><strong>개인정보취급방침</strong></a></li>
			<li><a href="#">책임의 한계와 법적고지</a></li>
			<li><a href="#">게시중단요청 서비스</a></li>
			<li><a href="#">고객센터</a></li>
		</ul>
	</div>
	<div class="w3c">
        <a href="http://validator.w3.org/check?uri=referer">
            <img src="http://www.w3.org/Icons/valid-xhtml10" alt="Valid XHTML 1.0 Transitional" height="31" width="88" />
        </a>
        <a href="http://jigsaw.w3.org/css-validator/check/referer">
            <img style="border:0;width:88px;height:31px" src="http://jigsaw.w3.org/css-validator/images/vcss-blue" alt="올바른 CSS입니다!" />
        </a>
    </div>
</div>
</div>
</body>
</html>