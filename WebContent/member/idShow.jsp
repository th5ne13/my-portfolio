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
function idClick() {
	location.href = "idFind.jsp";
}
function pwdClick() {
	location.href = "pwdFind.jsp";
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
	<!-- 계정찾기 시작 -->
	<div class="layout">
	<div class="idPwFind">
		<div class="l_btn" id="findid" onclick="location.href='member/idFind.jsp';">아이디 찾기</div>
		<div class="r_btn" id="findpwd" onclick="location.href='member/pwdFind.jsp';">비밀번호 찾기</div>
	</div>
	<div class="idFindForm">
		<table class="idForm">
			<tr>
				<td>가입하신 아이디는 : <%=mem.getMl_id() %>&nbsp;&nbsp;&nbsp;입니다</td>
			</tr>			
		</table>
		<table class="btn">
			<tr>
				<td><input type="button" value="로그인하러가기" onclick="location.href='loginForm.jsp';" /></td>
			</tr>		
		</table>
	</div> 
	</div>
	<!-- 계정찾기 종료 -->
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