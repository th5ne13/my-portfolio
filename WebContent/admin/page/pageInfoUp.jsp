<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
request.setCharacterEncoding("utf-8");
PageMainInfo pg = (PageMainInfo)request.getAttribute("pageMainInfo");
String btype = "";
if (pg.getBtype() == null || pg.getBtype().equals(""))	btype = request.getParameter("btype");
else 													btype = pg.getBtype();

String title = "", content = "", img = "", saveimg = "", head = "";
if (btype.equals("intro")) {
	title = pg.getPl_introtitle();	content = pg.getPl_introcontent();
	img = pg.getPl_introimg();		saveimg = pg.getPl_introsaveimg();	head = "회사 소개";
} else if (btype.equals("per")) {
	title = pg.getPl_pertitle();	content = pg.getPl_percontent();
	img = pg.getPl_perimg();		saveimg = pg.getPl_persaveimg();	head = "개인정보 보호 정책";
} else if (btype.equals("use")) {
	title = pg.getPl_usetitle();	content = pg.getPl_usecontent();
	img = pg.getPl_useimg();		saveimg = pg.getPl_usesaveimg();	head = "이용 약관";	
} else if (btype.equals("pay")) {
	title = pg.getPl_paytitle();	content = pg.getPl_paycontent();
	img = pg.getPl_payimg();		saveimg = pg.getPl_paysaveimg();	head = "결제 정보";	
}
out.println(btype);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/admincss.css" />
<!-- #wrapper #leftMenu #main #mainHead css -->
<style>
#mainBody {
	width: 90%; margin:0 auto; margin-top:20px; text-align:center;
}
#mainTxt { width:100%; border-collapse:collapse; }
th, td { border: 1px solid black; }

#grd-slide {
	display:none;
}
#page-slide {
	display:block;
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
strong, a {cursor:pointer;}
a { text-decoration:none; }
</style>
<script src="js/jquery-1.12.4.min.js"></script>
<script src="js/jquery-ui.min.js"></script>
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
		<div id="dashBoard"><strong><a href="admin/index.jsp">Dash Board</a></strong><hr></div>
		<div id="grd"><strong>1. 구장관리</strong><hr>
			<div id="grd-slide">
				<dd><a href="admin.groundReq">1-1. 구장 등록(변경)</a></dd>
				<dd><a href="adminGrdList.groundReq">1-2. 구장 리스트</a></dd>
			</div>
		</div>
		<div id="page"><strong>2. 페이지관리</strong><hr>
			<div id="page-slide">
				<dd><a href="bannerView.page">2-1. 배너 관리</a></dd>
				<dd><a href="view.page?btype=intro" <%if (head.equals("회사 소개")) { %>style="font-weight:bold;" <% } %>>2-2. 회사 소개</a></dd>
				<dd><a href="view.page?btype=per" <%if (head.equals("개인정보 보호 정책")) { %>style="font-weight:bold;" <% } %>>2-3. 개인 정보 보호 정책</a></dd>
				<dd><a href="view.page?btype=use" <%if (head.equals("이용 약관")) { %>style="font-weight:bold;" <% } %>>2-4. 이용 약관</a></dd>
				<dd><a href="view.page?btype=pay" <%if (head.equals("결제 정보")) { %>style="font-weight:bold;" <% } %>>2-5. 결제 정보</a></dd>
			</div>
		</div>
		<div id="rent"><strong>3. 대관관리</strong><hr>
			<div id="rent-slide">
				<dd><a href="list.reserve?ltype=a">3-1. 전체대관 목록</a></dd>
				<dd><a href="list.reserve?ltype=c">3-2. 취소대관 목록</a></dd>
			</div>
		</div>
		<div id="member"><strong>4. 회원관리</strong><hr>
			<div id="member-slide">
				<dd><a href="list.member">4-1. 회원목록</a></dd>
				<dd><a href="deleted.member">4-2. 탈퇴회원 목록</a></dd>
			</div>
		</div>
		<div id="statistics"><strong>5. 통계</strong><hr>
			<div id="statistics-slide">
				<dd><a href="sale.stat">5-1. 매출 통계</a></dd>
				<dd><a href="statistics.member">5-2. 회원 통계</a></dd>
			</div>
		</div>
		<div id="board"><strong>6. 게시판관리</strong><hr>
			<div id="board-slide">
				<dd><a href="perView.adminBoard">6-1. 1:1 문의 관리</a></dd>
			</div>
		</div>
	</div>
	
	<!-- 메인화면 div -->
	<div id="main">
		<div id="mainHead"><%=head %></div>
		<div id="mainBody">
		<form name="pageFrm" action="proc.page" method="post" enctype="multipart/form-data" >
		<input type="hidden" name="btype" value="<%=btype %>" />
		<input type="hidden" name="orgImg" value="<%=img %>" />
		<input type="hidden" name="orgSaveImg" value="<%=saveimg %>" />
			<table id="mainTxt" cellpadding="0" cellspacing="0">
			 	<tr height="30">
			 		<th width="15%">제목</th>
			 		<td width="*"><input type="text" name="title" value="<%=title %>" /></td>
			 	</tr>
			 	<tr height="30">
			 		<th>이미지</th>
			 		<td>현재 이미지 : <%=img %> <input type="file" name="img" /></td>			 		
			 	</tr>
			 	<tr height="500">
			 		<th>내용</th>
			 		<td><textarea name="content" cols="30" rows="10"><%=content %></textarea></td>			 		
			 	</tr>
			</table>
			<br />
			<input type="reset" value="다시입력" /><input type="submit" value="수정" />
			</form>
		</div>
	</div>
</div>
</body>
</html>