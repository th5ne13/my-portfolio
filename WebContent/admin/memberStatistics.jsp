<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
request.setCharacterEncoding("utf-8");

ArrayList<MemberInfo> statMemList = 
	(ArrayList<MemberInfo>)request.getAttribute("statMemList");
// 공지사항 목록을 ArrayList에 담음(제네릭도 포함해서 작업해야 함)
int membercnt = 0;

for (int i = 0 ; i < statMemList.size() ; i++) {
	MemberInfo statmemInfo = (MemberInfo)statMemList.get(i);
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
	width: 90%; margin:0 auto; margin-top:20px; text-align:center; font-size:13px;
}	
#btn { width:60px; height:150px; }
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
	display:block;
}
#board-slide {
	display:none;
}
strong, a {cursor:pointer;}
a { text-decoration:none; }
</style>
</head>
<script type="text/javascript" src="/greenground/calendar.js"></script>
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
<script>
function onlyNum(obj) {
	// 인수에 사용자가 입력한 값(숫자인지 검사할 값)을 담은 컨트롤을 받아옴
		if (isNaN(obj.value)) {
			alert('숫자만 입력가능합니다.');
			obj.value = "";		obj.focus();
		}
	}
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
				<dd><a href="list.member">4-1. 회원목록</a></dd>
				<dd><a href="deleted.member">4-2. 탈퇴회원 목록</a></dd>
			</div>
		</div>
		<div id="statistics"><strong>5. 통계</strong><hr>
			<div id="statistics-slide">
				<dd><a href="sale.stat">5-1. 매출 통계</a></dd>
				<dd><b><a href="statistics.member">5-2. 회원 통계</a></b></dd>
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
		<div id="mainHead">회원 통계 분석</div>
		<div id="mainBody">
		<form name="statmemfrm" action="statsearch.member" method="get">
		<table width="750" cellpadding="0" cellspacing="1" bgcolor="black">
			<tr bgcolor="white" align="center">
				<td width="15%">이름</td>
				<td width="35%"><input type="text" name="name" size="10" ></td>
				<td width="15%">아이디</td>
				<td width="35%"><input type="text" name="memid" size="20" ></td>
				<td rowspan="4"><input type="submit" style="width:60px; height:150px; " value="검 색"></td>
			</tr>
			<tr bgcolor="white" align="center">
				<td>사용금액별</td>
				<td><input type="text" name="payment1" placeholder="0" size="7" onkeyup="onlyNum(this);">&nbsp;~&nbsp;
				<input type="text" name="payment2" placeholder="1000" size="7" onkeyup="onlyNum(this);"></td>
				<td>최종로그인</td>
				<td><input type="text" name="lastlogin" value="" onclick="fnPopUpCalendar(lastlogindate, lastlogindate, 'yyyy-mm-dd')" placeholder="2020-05-13" size="20"/></td>
			</tr>		
			<tr bgcolor="white" align="center">
				<td>게시글 수</td>
				<td align="center"><input type="text" name="thenumofpost1" placeholder="0" size="7" onkeyup="onlyNum(this);">&nbsp;~&nbsp;
				<input type="text" name="thenumofpost2" placeholder="100" size="7" onkeyup="onlyNum(this);"></td>
				<td>지역별</td>
				<td><input type="text" name="addr" size="20"></td>
			</tr>
			<tr bgcolor="white" align="center">		
				<td>용병 모집횟수</td>
				<td><input type="text" name="thenumofrecruitment1" placeholder="1이상" size="7" onkeyup="onlyNum(this);">&nbsp;~&nbsp;
				<input type="text" name="thenumofrecruitment2" placeholder="10미만" size="7" onkeyup="onlyNum(this);"></td>
				<td>용병 지원횟수</td>
				<td><input type="text" name="thenumofapply1" placeholder="1이상" size="7" onkeyup="onlyNum(this);">&nbsp;~&nbsp;
				<input type="text" name="thenumofapply2" placeholder="10미만" size="7" onkeyup="onlyNum(this);"></td>
			</tr>	
		</table><br />
		</form>
		<!-- 테이블 시작 -->		
		<table width="750" cellpadding="0" cellspacing="1" bgcolor="black">
			<tr bgcolor="#d3d3d3" align="center" height="50">
				<th>번호</th>
				<th>이름</th>
				<th>아이디</th>
				<th>지역</th>
				<th>사용금액</th>
				<th>게시글</th>
				<th>용병지원</th>
				<th>용병모집</th>
				<th>최종로그인</th>
			</tr>
<%
			String lnk = "";
			String id = "";
			int memnum = 0;
			String memposition = "";
			if (statMemList.size() > 0) {	// 공지사항 목록이 있으면
				int num = rcount - (cpage - 1) * 10;
				for (int i = 0 ; i < statMemList.size() ; i++) {
					MemberInfo statmemInfo = (MemberInfo)statMemList.get(i);
					memnum = i;
					lnk = "<a href='statistics.member?cpage=" + cpage + args + 
						"&num=" + num + "'>";
					id = statmemInfo.getMl_id();				
%>
			<tr bgcolor="white" align="center" height="40">
				<td><%=num %></td>
				<td><%=statmemInfo.getMl_name() %></td>
				<td><%=statmemInfo.getMl_id() %></td>
				<td><%=statmemInfo.getMl_addr1() %>, <%=statmemInfo.getMl_addr2() %></td>
				<td><%=statmemInfo.getMl_pay() %></td>
				<td><%=statmemInfo.getMl_boardcnt() %></td>
				<td><%=statmemInfo.getMl_recruitcnt() %></td>
				<td><%=statmemInfo.getMl_applycnt() %></td>
				<td><%=statmemInfo.getMl_lastlogin() %></td>
			</tr>		
<%
					num--;
				}
			
%>
		</table>
		<table width="750"><!-- 페이징 -->
		<tr><td align="center">
		<%
		lnk = "";
		// 이전 페이지 이동 버튼
		if (cpage == 1) {
			out.println(" < &nbsp;&nbsp;&nbsp;");
		} else {
			lnk = "<a href='statistics.member?cpage=" + (cpage - 1) + args + "'>";
			out.println(lnk + " < </a>&nbsp;&nbsp;&nbsp;");
		}
		
		for (int i = 1 ; i <= mpage ; i++) {
			lnk = "<a href='statistics.member?cpage=" + i + args + "'>";
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
			lnk = "<a href='statistics.member?cpage=" + (cpage + 1) + args + "'>";
			out.println("&nbsp;&nbsp;&nbsp;" + lnk + " > </a>");
		}
		%>
		</td></tr>
		<%
} else {
	out.println("<tr bgcolor='white' height='50'><th colspan='9'>");
	out.println("검색 결과가 없습니다.</th></tr>");
}
%>
			</table>				
		</div>
	</div>
</div>
</body>
</html>