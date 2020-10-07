<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/admincss.css" />
<!-- #wrapper #leftMenu #main #mainHead css -->
<style>
#mainBody {
	width: 90%; margin:0 auto; margin-top:20px; text-align:center;
}
#grd-slide {
	display:none;
}
#page-slide {
	display:none;
}
#rent-slide {
	display:none;
}
#member-slide {
	display:none;
}
#statistics-slide {
	display:none;
}
#board-slide {
	display:none;
}
</style>
<script src="../js/jquery-1.12.4.min.js"></script>
<script src="../js/jquery-ui.min.js"></script>
<script>
$(function() {
	$("#grd").on("click", function() {
		$("#grd-slide").slideToggle("fast");
	});
	$("#page").on("click", function() {
		$("#page-slide").slideToggle("fast");
	});
	$("#rent").on("click", function() {
		$("#rent-slide").slideToggle("fast");
	});
	$("#member").on("click", function() {
		$("#member-slide").slideToggle("fast");
	});
	$("#statistics").on("click", function() {
		$("#statistics-slide").slideToggle("fast");
	});
	$("#board").on("click", function() {
		$("#board-slide").slideToggle("fast");
	});
});
</script>
</head>
<body>
<!-- 전체를 감싸는 div -->
<div id="wrapper">

	<!-- 왼쪽 메뉴바 div -->
	<div id="leftMenu">
		<div id="dashBoard"><a href="index.jsp">Dash Board</a></div>
		<div id="grd">1. 구장관리
			<div id="grd-slide">
				<dd><a href="#">1-1. 구장 등록(변경)</a></dd>
				<dd><a href="#">1-2. 구장 리스트</a></dd>
			</div>
		</div>
		<div id="page">2. 페이지관리
			<div id="page-slide">
				<dd><a href="../bannerView.page">2-1. 배너 관리</a></dd>
				<dd><a href="../view.page?btype=intro">2-2. 회사 소개</a></dd>
				<dd><a href="../view.page?btype=per">2-3. 개인 정보 보호 정책</a></dd>
				<dd><a href="../view.page?btype=use">2-4. 이용 약관</a></dd>
				<dd><a href="../view.page?btype=pay">2-5. 결제 정보</a></dd>
			</div>
		</div>
		<div id="rent">3. 대관관리
			<div id="rent-slide">
				<dd><a href="#">3-1. 전체대관 목록</a></dd>
				<dd><a href="#">3-2. 취소대관 목록</a></dd>
			</div>
		</div>
		<div id="member">4. 회원관리
			<div id="member-slide">
				<dd><a href="#">4-1. 회원목록</a></dd>
				<dd><a href="#">4-2. 탈퇴회원 목록</a></dd>
			</div>
		</div>
		<div id="statistics">5. 통계
			<div id="statistics-slide">
				<dd><a href="#">5-1. 매출 통계</a></dd>
				<dd><a href="#">5-2. 회원 통계</a></dd>
			</div>
		</div>
		<div id="board">6. 게시판관리
			<div id="board-slide">
				<dd><a href="../perView.adminBoard">6-1. 1:1 문의 관리</a></dd>
				<dd><a href="#">6-2. 용병게시판 관리</a></dd>
				<dd><a href="#">6-3. 해외 축구 게시판 관리</a></dd>
				<dd><a href="#">6-4. 국내 축구 게시판 관리</a></dd>
			</div>
		</div>
	</div>
	
	<!-- 메인화면 div -->
	<div id="main">
		<div id="mainHead">헤드영역</div>
		<div id="mainBody">메인영역</div>
	</div>
</div>
</body>
</html>