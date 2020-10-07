<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="vo.MemberInfo"%>  
<%
// index 기본 설정
MemberInfo memberInfo = (MemberInfo)session.getAttribute("memberInfo");
ArrayList<GroundListInfo> groundList = (ArrayList<GroundListInfo>)request.getAttribute("groundList");
String groundRq = "구장제휴신청";
String glCode = "";


MemberInfo mem = (MemberInfo) request.getAttribute("MemberInfo");
String uid = request.getParameter("uid");
String uname = request.getParameter("uname");
String question = request.getParameter("question");
String answer = request.getParameter("answer");
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
<script>
function isEngNum(str, chk) {
	// str : 글자단위로 검사할 문자열 / chk : 첫글자에 대한 영문사용을 검사할지 여부
		str = str.toLowerCase();
		// 받아온 문자열을 일괄적으로 소문자로 변환한 후 검사

		if (chk == "y") {	// 첫 글자가 영문인지 여부를 검사
			var c = str.charAt(0);	// 첫 글자 추출
			if (c < "a" || c > "z") {
				alert("아이디와 비밀번호는 영어, 숫자 조합만 가능합니다");
				return false;
			}
		}
		// 한 글자씩 추출하여 검사하는 for문
		for (var i = 0; i < str.length ; i++) {
			var c = str.charAt(i);
			if (!((c >= "0" && c <= "9") || (c >= 'a' && c <= 'z') || c == "_")) {
				alert("아이디와 비밀번호는 영어, 숫자 조합만 가능합니다");
				return false;
			}
		}
		return true;
	}
	function chkValue(frm) {
		var pwd = frm.newpwd.value;
		var pwd2 = frm.newpwd2.value;
		// 비밀번호검사
		if (pwd == "") {
			alert("비밀번호를 입력하세요.");
			frm.newpwd.focus();
			return false;

		} else if (!isEngNum(pwd, "n")) {
			alert("비밀번호는 영문, 숫자, 언더바의 조합으로만 입력하세요.");
			frm.newpwd.value = "";
			frm.newpwd.focus();
			return false;

		} else if (pwd != pwd2) {
			alert("비밀번호와 비밀번호 확인이 서로 다릅니다.");
			frm.newpwd.value = "";
			frm.newpwd2.value = "";
			frm.newpwd.focus();
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
	<a href="list.board?btype=d">게시판</a>
	<a href="list.notice?memberInfo=<%=memberInfo %>">용병</a>
</div>
<div class="main_common"><a href="start.jsp">그림그림</a></div>
<div class="main_common">
	<a href="<%=reqType %>.groundReq?glcode=<%=glCode%>"><%=groundRq %></a>
	<a href="logout">로그아웃</a>
	<a href="list.request">마이페이지</a>
<% } %>
</div>	
</div>
<!-- 로그인 body 시작-->
<div id="body">
	<div id="banner">
		<img src="img/banner4.jfif" alt="banner2" width="800" height="300" />
	</div>
	<!-- pwdShow 시작 -->
	<div class="layout">
	<form name="frm" action="newpwd.find" method="post" onsubmit="return chkValue(this);">
	<input type="hidden" name="uid" value="<%=uid %>" />
	<input type="hidden" name="uname" value="<%=uname %>" />
	<input type="hidden" name="question" value="<%=question %>" />
	<input type="hidden" name="answer" value="<%=answer %>" />
	<div class="idPwFind">
		<div class="l_btn" id="findid" onclick="location.href='member/idFind.jsp';">아이디 찾기</div>
		<div class="r_btn" id="findpwd" onclick="location.href='member/pwdFind.jsp';">비밀번호 찾기</div>
	</div>
	<div class="pwFindForm">
		<table class="pwForm">
			<tr>
				<td>새 비밀번호 입력 : </td>
				<td><input type="password" name="newpwd" /></td>
			</tr>
			<tr>
				<td>새 비밀번호 확인 : </td>
				<td><input type="password" name="newpwd2" /></td>
			</tr>
		</table>
		<table class="btn">
			<tr>
				<td>
					<input type="button" value="취소" onclick="location.href='loginForm.jsp'"/>&nbsp;&nbsp;&nbsp;
					<input type="submit" value="비밀번호 수정" />					
				</td>
			</tr>
		</table>
	</div>
	</form>
	</div>
	<!-- pwdShow 종료 -->
</div>
<!-- 로그인 body 종료-->

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