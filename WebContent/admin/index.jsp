<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
AdminInfo adminInfo = (AdminInfo)session.getAttribute("adminInfo");
SiteInfo siteInfo = (SiteInfo)session.getAttribute("siteInfo");
ArrayList<GroundRevInfo> grdRevList = (ArrayList<GroundRevInfo>)session.getAttribute("grdRevList");
String alid = "";
if (adminInfo != null)	alid = adminInfo.getAl_id();

String[] day = new String[7];
Calendar today = Calendar.getInstance();
for (int i = 0; i < 7; i++) {
	day[i] = new java.text.SimpleDateFormat("yyyy-MM-dd").format(today.getTime());
	today.add(Calendar.DATE, -1);
}

int[] sale = {0, 0, 0, 0, 0, 0, 0}; 
if (grdRevList != null) {
	for (int i = 0; i < grdRevList.size(); i++) {
		GroundRevInfo gri = grdRevList.get(i);
		for (int j = 0; j < 7; j++) {
			if (gri.getGr_revdate().equals(day[j]))		sale[j] = gri.getGr_cost();
		}
	}
}

String wDate = "'" + day[6] + "'";
String wSale = sale[6] + "";

for (int i = 5; i >= 0; i--) {
	wDate += ", '" + day[i] + "'";
	wSale += ", " + sale[i];
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/admincss.css" />
<!-- #wrapper #leftMenu #main #mainHead css -->
<style>
#login { margin: 0 auto; width:80%; border:1 black solid; width:500px; }

.upBox {
	width:150px; height:150px; border:1px solid black; float:left; margin-top:10px; margin-left:30px; text-align: center;
}
.inBoxBtn {
	border:2px solid black; font-size: 12px; height:20px; width:120px; margin:auto;
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
strong, a {cursor:pointer;}
a { text-decoration:none; }
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
<%
if (adminInfo == null) {
%>
<div id="login">
<form action="../admin.login" method="post">
<fieldset>
	<table width="400">
	<tr>
	<th colspan="3"><h1>안녕 어드민?</h1></th>
	</tr>
	<tr>
	<th width="100">아이디</th>
	<td width="200"><input type="text" name="aid" value="admin" /></td>
	<td width="*" rowspan="2"><input type="submit" value="로그인" /></td>
	</tr>
	<tr>
	<th>비밀번호</th>
	<td><input type="password" name="pwd" value="1234" /></td>
	</tr>
	</table>
</fieldset>
</form>
</div>
<% } else { %>

<!-- 전체를 감싸는 div -->
<div id="wrapper">
	<!-- 왼쪽 메뉴바 div -->
	<div id="leftMenu">
		<div id="dashBoard"><strong><a href="index.jsp">Dash Board</a></strong><hr></div>
		<div id="grd"><strong>1. 구장관리</strong><hr>
			<div id="grd-slide">
				<dd><a href="../adminIn.groundReq">1-1. 구장 등록(변경)</a></dd>
				<dd><a href="../adminGrdList.groundReq">1-2. 구장 리스트</a></dd>
			</div>
		</div>
		<div id="page"><strong>2. 페이지관리</strong><hr>
			<div id="page-slide">
				<dd><a href="../bannerView.page">2-1. 배너 관리</a></dd>
				<dd><a href="../view.page?btype=intro">2-2. 회사 소개</a></dd>
				<dd><a href="../view.page?btype=per">2-3. 개인 정보 보호 정책</a></dd>
				<dd><a href="../view.page?btype=use">2-4. 이용 약관</a></dd>
				<dd><a href="../view.page?btype=pay">2-5. 결제 정보</a></dd>
			</div>
		</div>
		<div id="rent"><strong>3. 대관관리</strong><hr>
			<div id="rent-slide">
				<dd><a href="../list.reserve?ltype=a">3-1. 전체대관 목록</a></dd>
				<dd><a href="../list.reserve?ltype=c">3-2. 취소대관 목록</a></dd>
			</div>
		</div>
		<div id="member"><strong>4. 회원관리</strong><hr>
			<div id="member-slide">
				<dd><a href="../list.member">4-1. 회원목록</a></dd>
				<dd><a href="../deleted.member">4-2. 탈퇴회원 목록</a></dd>
			</div>
		</div>
		<div id="statistics"><strong>5. 통계</strong><hr>
			<div id="statistics-slide">
				<dd><a href="../sale.stat">5-1. 매출 통계</a></dd>
				<dd><a href="../statistics.member">5-2. 회원 통계</a></dd>
			</div>
		</div>
		<div id="board"><strong>6. 게시판관리</strong><hr>
			<div id="board-slide">
				<dd><a href="../perView.adminBoard">6-1. 1:1 문의 관리</a></dd>
			</div>
		</div>
	</div>
	
	<!-- 메인화면 div -->
	<div id="main">
		<div id="groundInfo" class="upBox"><br />
		<span style="font-size:50px;"><%=siteInfo.getGrdCnt() %></span>(+<%=siteInfo.getGrdCntWeek() %>)<br />
		<span style="font-size:12px">현재 리스팅된 구장</span><br /><br />
		</div>
		<div id="memberInfo" class="upBox"><br />
		<span style="font-size:50px;"><%=siteInfo.getMemCnt() %></span>(+<%=siteInfo.getMemCntWeek() %>)<br />
		<span style="font-size:12px">전체 회원 수</span><br /><br />
		<div class="inBoxBtn" onclick="location.href='../list.member'">회원 목록 보러 가기</div>
		</div>
		<div id="groundReq" class="upBox"><br />
		<span style="font-size:50px; <%if (siteInfo.getNewGrdReq() > 0) { %> color:red; <% } %>"><%=siteInfo.getNewGrdReq() %></span><%if (siteInfo.getNewGrdReq() > 0) { %>&nbsp;&nbsp;<span style="font-size:15px; color:red;">N</span><% } %><br />
		<span style="font-size:12px">구장 제휴 신청</span><br /><br />
		<div class="inBoxBtn" onclick="location.href='../adminGrdList.groundReq'">구장 리스트 가기</div>
		</div>
		<div id="perBoard" class="upBox"><br />
		<span style="font-size:50px; <%if (siteInfo.getNewPerBoard() > 0) { %> color:red; <% } %>"><%=siteInfo.getNewPerBoard() %></span><%if (siteInfo.getNewPerBoard() > 0) { %>&nbsp;&nbsp;<span style="font-size:15px; color:red;">N</span><% } %><br />
		<span style="font-size:12px">1:1 문의</span><br /><br />
		<div class="inBoxBtn" onclick="location.href='../perView.adminBoard'">1:1 답변하러 가기</div>
		</div>
	<div id="chart">
	<canvas id="canvas"></canvas>
	</div>
	</div>
</div>
<% }
%>
</body>
</html>
<style>
canvas {
	-moz-user-select: none;
	-webkit-user-select: none;
	-ms-user-select: none;
}
</style>
<script src="js/Chart.min.js"></script>
<script src="js/utils.js"></script>
<script>
var color = Chart.helpers.color;
var barChartData = {
	labels: [<%=wDate%>],
	datasets: [{
		label: '매출액',
		backgroundColor: color(window.chartColors.red).alpha(0.5).rgbString(),
		borderColor: window.chartColors.red,
		borderWidth: 1,
		data: [<%=wSale%>]
	},
	]
};

window.onload = function() {
	var ctx = document.getElementById('canvas').getContext('2d');
	window.myBar = new Chart(ctx, {
		type: 'bar',
		data: barChartData,
		options: {
			responsive: true,
			legend:{ position:'top' }, 
			title:{ display:true, text:'최근 일주일 매출' }
		}
	});
};
</script>