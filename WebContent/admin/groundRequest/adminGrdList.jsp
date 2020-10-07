<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %> <!-- ArrayList를 사용하기 위한 -->
<%@ page import="vo.*" %> <!-- NoticeInfo, PageInfo를 사용하기 위한 -->
<%
ArrayList<GroundListInfo> adminGroundList = (ArrayList<GroundListInfo>)request.getAttribute("adminGroundList");
MemberInfo mem = (MemberInfo)request.getAttribute("memberInfo");


PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
// 페이징 관련 데이터들을 담은 인스턴스 생성
int rcount = pageInfo.getRcount();	// 전체 게시글 개수
int cpage = pageInfo.getCpage();	// 현재 페이지 번호
int mpage = pageInfo.getMpage();	// 전체 페이지 개수(마지막 페이지 번호)
int spage = pageInfo.getSpage();	// 시작페이지 번호
int epage = pageInfo.getEpage();	// 끝 페이지 번호
String schType = pageInfo.getSchType();	//검색조건
String keyword = pageInfo.getKeyword();	// 검색어
if (schType == null)	schType = "";
if (keyword == null)	keyword = "";

String args = "&schType=" + schType + "&keyword=" + keyword;
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
	display:block;
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
strong, a {cursor:pointer;}
a { text-decoration:none; }
.th { border:1px solid green; }
.td { border:1px solid green; }
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
				<dd><b><a href="adminGrdList.groundReq">1-2. 구장 리스트</a></b></dd>
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
	<div id="main">
		<div id="mainHead">구장 리스트</div>
		<form action="list.groundReq" method="get">
		<div id="mainBody">
			<select name="schType">
				<option value="">검색 조건</option>
				<option value="jibeon" <% if (schType.equals("jibeon")) { %>selected="selected"<% } %>>지역명</option>
				<option value="grdname" <% if (schType.equals("grdname")) { %>selected="selected"<% } %>>구장명</option>
				<option value="name" <% if (schType.equals("name")) { %>selected="selected"<% } %>>구장주이름</option>	
			</select>
			<input type="text" name="keyword" size="10" value="<%=keyword %>" />
			<input type="submit" value="검색" />
			<table width="750">
				<tr>
					<th width="10%" class="th">게시여부</th>
					<th width="35%" class="th">주소</th>
					<th width="15%" class="th">구장명</th>
					<th width="15%" class="th">구장주명</th>
					<th width="10%" class="th">상세</th>
				</tr>
<%
String lnk="", upt="";

if (adminGroundList.size() > 0) {	
	for (int i = 0 ; i < adminGroundList.size() ; i++) {	
		GroundListInfo ground = adminGroundList.get(i);
		
		lnk = "<a href='view.groundReq?cpage=" + cpage + args + "&glcode=" + ground.getGl_code() + "'>";
		upt = "<a href='up.groundReq?cpage=" + cpage + args + "&glcode=" + ground.getGl_code() + "'>";
		System.out.println(upt);
		String jibeon = ground.getGl_jibeon();
		if (jibeon.length() > 27) jibeon = jibeon.substring(0, 25) + "...";
%>
				<tr align="center">
					<td><%=ground.getGl_isview() %></td>
					<td align="left">&nbsp;<%=lnk + jibeon + "</a>" %></td>
					<td><%=ground.getGl_grdname() %></td>
					<td><%=ground.getGl_name() %></td>
					<td><%=upt + "수정" + "</a>" %></td>
				</tr>
<%
	}
%>
			</table><br />
			<table width="750">
				<tr>
					<td align="center">
<% 
lnk ="";
//이전 페이지 이동 버튼
if (cpage == 1) {
// 만약 현재 페이지 번호가 1이면
	out.println(" < &nbsp;&nbsp;&nbsp;");	
} else {
	lnk = "<a href='adminGrdList.groundReq?cpage=" + (cpage - 1) + args + "'>";
	out.println(lnk + " < </a>&nbsp;&nbsp;&nbsp;");
}

for (int i = 1 ; i <= mpage ; i++) {
	lnk = "<a href='adminGrdList.groundReq?cpage=" + i + args + "'>";
	if (i == cpage) {
		out.println("&nbsp;&nbsp;<b>" + i + "</b>&nbsp;&nbsp;");
	} else {
		out.println("&nbsp;&nbsp;" + lnk + i + "</a>&nbsp;&nbsp;");		
	}
}

//다음 페이지 이동 버튼
if (cpage == mpage) {
//만약 현재 페이지 번호와 마지막 페이지 번호가 같다면  
	out.println("&nbsp;&nbsp;&nbsp; > ");	
} else {
	lnk = "<a href='adminGrdList.groundReq?cpage=" + (cpage + 1) + args + "'>";
	out.println("&nbsp;&nbsp;&nbsp;" + lnk + " > </a>");
}
%>
					</td>
				</tr>
<%	
} else {	// 공지사항 목록이 없으면
	out.println("<tr height='50'><th colspan='4'>");
	out.println("검색결과가 없습니다.</th></tr>");
}
%>
			</table>
		</div>
		</form>
	</div>
</div>
</body>
</html>