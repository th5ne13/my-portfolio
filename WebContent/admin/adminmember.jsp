<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
request.setCharacterEncoding("utf-8");

ArrayList<MemberInfo> memberList = 
	(ArrayList<MemberInfo>)request.getAttribute("memberList");
// 공지사항 목록을 ArrayList에 담음(제네릭도 포함해서 작업해야 함)
int membercnt = 0;

for (int i = 0 ; i < memberList.size() ; i++) {
	MemberInfo memInfo = (MemberInfo)memberList.get(i);
	membercnt += 1;
}

PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
int rcount = pageInfo.getRcount();	// 전체 게시글 개수
int cpage = pageInfo.getCpage();	// 현재 페이지 번호
int mpage = pageInfo.getMpage();	// 전체 페이지 개수(마지막 페이지 번호)
int spage = pageInfo.getSpage();	// 시작 페이지 번호
int epage = pageInfo.getEpage();	// 끝 페이지 번호
String schType = pageInfo.getSchType();	// 검색조건
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
	width: 90%; margin:0 auto; margin-top:10px; text-align:center; font-size:13px;
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
	display:block;
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
</head>
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
				<dd><b><a href="list.member">4-1. 회원목록</a></b></dd>
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
		<div id="mainHead">회원목록</div>
		<div id="mainBody">
			<form action="list.member" method="get">
			<table width="420" cellpadding="5" cellspacing="1" bgcolor="black">
				<tr bgcolor="white">
					<td width="23%">조건검색</td>
					<td width="*" align="left">&nbsp;
						<select name="schType">
							<option value="">검색 조건</option>
							<option value="id" <% if (schType.equals("id")) { %>selected="selected"<% } %>>아이디</option>
							<option value="member" <% if (schType.equals("member")) { %>selected="selected"<% } %>>회원명</option>
							<option value="phone" <% if (schType.equals("phone")) { %>selected="selected"<% } %>>연락처</option>
						</select>
						<input type="text" name="keyword" size="15" value="<%=keyword %>" /><input type="submit" value="검 색" />
					</td>
				</tr>
			</table><br />
			<table width="170px" cellpadding="5" cellspacing="1" bgcolor="black">
				<tr bgcolor="white">
					<td>전체 회원수 : <%=membercnt %></td>
				</tr>
			</table><br />
			<table width=720px cellpadding="5" cellspacing="1" bgcolor="black">
				<tr bgcolor="#d3d3d3" align="center">
					<th width="8%">구분</th><th>번호</th><th>이름</th><th>아이디</th><th>연락처</th><th>선호포지션</th><th>사용금액</th><th>상세</th>
				</tr>
<%
			String lnk = "";
			String id = "";
			int memnum = 0;
			if (memberList.size() > 0) {	// 공지사항 목록이 있으면
				int num = rcount - (cpage - 1) * 10;
				for (int i = 0 ; i < memberList.size() ; i++) {
					MemberInfo memInfo = (MemberInfo)memberList.get(i);
					memnum = i;
					String memposition = "";
					if(memInfo.getMl_position().contains("A"))	memposition += " 공격수 ";
					if (memInfo.getMl_position().contains("B"))	memposition += " 미드필더 ";
					if (memInfo.getMl_position().contains("C"))	memposition += " 수비수 ";
					if (memInfo.getMl_position().contains("D")) memposition += "골기퍼";
					// noticeList안의 i번째 데이터를 notice에 넣음
					lnk = "<a href='view.member?cpage=" + cpage + args + 
						"&num=" + memInfo.getMl_addr1() + "'>";
					id = memInfo.getMl_id();
					
%>
				<tr bgcolor="white" align="center">
					<td width="8%"><%=memInfo.getMl_isrun() %></td><td><%=num %></td><td><%=memInfo.getMl_name() %></td><td><%=memInfo.getMl_id() %></td><td><%=memInfo.getMl_phone() %></td><td><%=memposition %></td><td><%=memInfo.getMl_pay() %></td><td>
					<a href="#" onclick="window.open('admin/memberDetail.jsp?memnum=<%=memnum %>&position=<%=memInfo.getMl_position() %>', '상세보기', 'width=1400, height=800');">상세보기</a></td>
				</tr>		
<%
					num--;
				}
			
%>
			</table>
			<table width="720"><!-- 페이징 -->
				<tr>
					<td align="center">
		<%
		lnk = "";
		// 이전 페이지 이동 버튼
		if (cpage == 1) {
			out.println(" < &nbsp;&nbsp;&nbsp;");
		} else {
			lnk = "<a href='list.member?cpage=" + (cpage - 1) + args + "'>";
			out.println(lnk + " < </a>&nbsp;&nbsp;&nbsp;");
		}
		
		for (int i = 1 ; i <= mpage ; i++) {
			lnk = "<a href='list.member?cpage=" + i + args + "'>";
			if (i == cpage) {
				out.println("&nbsp;&nbsp;<b>" + i + "</b>&nbsp;&nbsp;");
			} else {
				out.println("&nbsp;&nbsp;" + lnk + i + "</a>&nbsp;&nbsp;");
			}
		}
		
		// 다음 페이지 이동 버튼
		if (cpage == mpage) {
			out.println("&nbsp;&nbsp;&nbsp; > ");
		} else {
			lnk = "<a href='list.member?cpage=" + (cpage + 1) + args + "'>";
			out.println("&nbsp;&nbsp;&nbsp;" + lnk + " > </a>");
		}
		%>
					</td></tr>
		<%
} else {
	out.println("<tr bgcolor='white' height='50'><th colspan='8'>");
	out.println("검색 결과가 없습니다.</th></tr>");
}
%>
			</table>
			</form>
		</div>
	</div>
</div>
</body>
</html>