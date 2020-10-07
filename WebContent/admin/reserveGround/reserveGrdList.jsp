<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
request.setCharacterEncoding("utf-8");
ArrayList<GroundRevInfo> grdRevList = (ArrayList<GroundRevInfo>)request.getAttribute("grdRevList");
AdminInfo adminInfo = (AdminInfo)session.getAttribute("adminInfo");

String alid = "";
if (adminInfo != null)	alid = adminInfo.getAl_id();
String title = "전체 대관목록";
String ltype = request.getParameter("ltype");
if (ltype.equals("c")) {
	title = "취소 대관목록";
}

PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
int rcount = pageInfo.getRcount();
int cpage = pageInfo.getCpage();
int mpage = pageInfo.getMpage();
int spage = pageInfo.getSpage();
int epage = pageInfo.getEpage();
String schType = pageInfo.getSchType();
String keyword = pageInfo.getKeyword();
if (schType == null)	schType = "";
if (keyword == null)	keyword = "";
String args = "&schType=" + schType + "&keyword=" + keyword + "&ltype=" + ltype;
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
#grd-slide {
	display:none;
}
#page-slide {
	display:none;
}
#rent-slide {
	display:block;
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
				<dd><b><a href="bannerView.page">2-1. 배너 관리</a></b></dd>
				<dd><a href="view.page?btype=intro">2-2. 회사 소개</a></dd>
				<dd><a href="view.page?btype=per">2-3. 개인 정보 보호 정책</a></dd>
				<dd><a href="view.page?btype=use">2-4. 이용 약관</a></dd>
				<dd><a href="view.page?btype=pay">2-5. 결제 정보</a></dd>
			</div>
		</div>
		<div id="rent"><strong>3. 대관관리</strong><hr>
			<div id="rent-slide">
				<dd><%if (ltype.equals("a")) { %><b><a href="list.reserve?ltype=a">3-1. 전체대관 목록</a></b><% } else { %><a href="list.reserve?ltype=a">3-1. 전체대관 목록</a><% } %></dd>
				<dd><%if (ltype.equals("c")) { %><b><a href="list.reserve?ltype=c">3-2. 취소대관 목록</a></b><% } else { %><a href="list.reserve?ltype=c">3-2. 취소대관 목록</a><% } %></dd>
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
		<div id="mainHead"><%=title %></div>
		<div id="mainBody">
			<table width="750">
				<tr>
					<th>번호</th>
					<th>예약코드</th>
					<th>구장명</th>
					<th>예약일 / 시</th>
					<th>사용일 / 시</th>
					<th>회원ID</th>
					<th>연락처</th>
					<th>금액</th>
				</tr>
<%
if (grdRevList.size() == 0) {
	out.println("<tr><th colspan=\"8\">예약이 없습니다.</th></tr>");
} else {
	int num = rcount - (cpage - 1) * 10;
	for (int i = 0; i < grdRevList.size(); i++) {
		GroundRevInfo gri = (GroundRevInfo)grdRevList.get(i);
%>
				<tr>
					<td><%=gri.getGr_num() %></td>
					<td><%=gri.getGr_code() %></td>
					<td><%=gri.getGr_name() %></td>
					<td><%=gri.getGr_revdate() %></td>
					<td><%=gri.getGr_date() %></td>
					<td><%=gri.getMl_id() %></td>
					<td><%=gri.getMl_phone() %></td>
					<td><%=gri.getGr_cost() %></td>
				</tr>
<%
	}
}
%>

			</table>
			
<!-- 페이징 테이블 -->
<table width="750">
<tr><td align="center">
<%
String lnk = "";
if (cpage == 1) {
	out.println("<&nbsp;&nbsp;&nbsp;");
} else {
	lnk = "<a href='list.reserve?cpage=" + (cpage - 1) + args + "'>";
	out.println(lnk + "< </a>&nbsp;&nbsp;&nbsp;");
}

// 숫자로 페이지 이동 버튼
for (int i = 1; i <= mpage; i++) {
	lnk = "<a href='list.reserve?cpage=" + i + args + "'>";
	if (i == cpage) {
		out.println("&nbsp;&nbsp;<b>" + i + "</b>&nbsp;&nbsp;");
	} else {
		out.println("&nbsp;&nbsp;" + lnk + i + "</a>&nbsp;&nbsp;");
	}
} 


// 다음 페이지 이동버튼
if (cpage == mpage) {
	out.println("&nbsp;&nbsp;&nbsp; > ");
} else {
	lnk = "<a href='list.reserve?cpage=" + (cpage + 1) + args + "'>";
	out.println("&nbsp;&nbsp;&nbsp;" + lnk + "> </a>");
}
%>
</td></tr>
</table>
<form action="list.reserve" method="get">
<input type="hidden" name="ltype" value="<%=ltype %>" />
<div class="nBox">
	<select name="schType">
		<option value="">검색 조건</option>
		<option value="gr_name" <% if (schType.equals("gr_name")) { %>selected="selected" <% } %> >구장명</option>
		<option value="ml_id" <% if (schType.equals("ml_id")) { %>selected="selected" <% } %> >회원ID</option>
	</select>
	<input type="text" name="keyword" size="10" value="<%=keyword %>" />
	<input type="submit" value="검 색" />
</div>
</form>
		</div>
	</div>
</div>
</body>
</html>