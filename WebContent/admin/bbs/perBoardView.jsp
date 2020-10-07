<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
request.setCharacterEncoding("utf-8");
AdminInfo adminInfo = (AdminInfo)session.getAttribute("adminInfo");
ArrayList<PerBoardInfo> perList = (ArrayList<PerBoardInfo>)request.getAttribute("perBoardList");
int size = perList.size();

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
#schFrame { width: 100%; border:1px solid black; }
#perListFrame, #answerFrame { width: 100%; padding-top: 20px; border:1px solid black; }
#perList, #answer { width: 100%; border:1px solid black; border-collapse: collapse; }
#perList tr { border:1px solid black; }

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
	display:block;
}
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
				<dd><b><a href="perView.adminBoard">6-1. 1:1 문의 관리</a></b></dd>
			</div>
		</div>
	</div>
	
	<!-- 메인화면 div -->
	<div id="main">
		<div id="mainHead">게시판관리 - 1:1문의</div>
		<div id="mainBody">
			<table id="schFrame">
			<tr>
			<td width="15%">조건검색</td>
			<td width="15%">
			<td>
			<form name="searchFrm" action="perView.adminBoard" method="post">
				<select name="cata" id="cata">
					<option value="">선택하세요</option>
					<option value="a">입장문의</option>
					<option value="b">환불문의</option>
					<option value="c">구장문의</option>
					<option value="d">제휴신청문의</option>
					<option value="e">기타</option>
				</select>
			</td>
			<td width="15%">
				<select name="schType" id="schType">
					<option value="id">아이디</option>
					<option value="title">제목</option>
					<option value="content">내용</option>
					<option value="tc">제목+내용</option>
				</select>
			</td>
			<td width="*"><input type="text" name="keyword" /></td>
			<td width="15%"><input type="submit" value="검색" /></td>
			</form>
			</tr>
			</table>
			<div id="perListFrame">
			<table id="perList" cellpadding="0" cellspacing="0">
<%
if (perList.size() == 0) {
	out.println("<tr><th>1:1 문의 글이 없습니다.</th></tr>");
} else {
%>
	<tr height="40">
		<th width="7%">번호</th>
		<th width="15%">작성자</th>
		<th width="15%">처리상황</th>
		<th width="*">제목</th>
		<th width="10%">답변여부</th>
	</tr>
<%
String answer = "답변하기";	
String status = "답변대기";	
int num = 0;
	for (int i = 0; i < perList.size(); i++) {
		PerBoardInfo per = perList.get(i);
		num = i;
		if (per.getQl_status().equals("y")) {
			answer = "답변수정";	
			status = "답변완료";
		}
%>
	<tr height="30">
		<td><%=per.getQl_num() %></td>
		<td><%=per.getMl_id() %></td>
		<td><%=status %></td>
		<td><%=per.getQl_title() %></td>
		<td><button value="<%=i %>" name="<%=per.getQl_num() %>" onclick="answer(this);"><%=answer %></button></td>
	</tr>
<%		
	}
} 
%>
<script>
function answer(val) {
	var num = "answerBox" + val.value;
	var end = "<%=size%>";
	for (var i = 0; i < end; i++) {
		var answerBox = document.getElementById("answerBox" + i);
		answerBox.style.display = 'none';		
	}
	var answerBox = document.getElementById(num);
	answerBox.style.display = "block";
	var qlNum = val.name;
	var odNum = val.value;
	document.getElementById("qlNum").value = qlNum;
	document.getElementById("odNum").value = odNum;
}
</script>
			</table>
			</div>
			<form name="answerFrm" action="adminPerProc.board" method="post">
			<input type="text" name="qlNum" value="" id="qlNum" style="display:none"/>
			<input type="text" name="odNum" value="" id="odNum" style="display:none"/>
			<div id="answerFrame">
<%			
for (int i = 0; i < perList.size(); i++) {
		PerBoardInfo per = perList.get(i);
		String answer = "";
		if (per.getQl_answer() != null && !per.getQl_answer().equals(""))		answer = per.getQl_answer();
%>			
			<table id="answerBox<%=i%>" width="700" border="1px solid black" style="display:none">
				<tr height="30">
					<th width="100">작성자ID</th>
					<td width="700" align="left"><%=per.getMl_id() %></td>
				</tr>
				<tr height="30">
					<th>제목</th>
					<td align="left"><%=per.getQl_title() %></td>
				</tr>
				<tr height="50">
					<th>질문내용</th>
					<td align="left"><%=per.getQl_content() %></td>
				</tr>
				<tr height="50">
					<th>답변</th>
					<td align="left"><input type="text" id="answer<%=i %>" name="answer<%=i %>" value="<%=answer %>" /></td>
				</tr>
			</table>
<%		
	}			
%>					
			<table width="700" border="1px solid black">
				<tr>
					<td align="center" colspan="2"><input type="submit" value="확 인" /></td>
				</tr>
			</table>
			</div>	
			</form>
		</div>
	</div>
</div>
</body>
</html>