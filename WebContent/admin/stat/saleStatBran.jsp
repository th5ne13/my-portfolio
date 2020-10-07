<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
request.setCharacterEncoding("utf-8");

String date = "", sdate = "", edate = "";
date = (String)request.getAttribute("date");
if (date.equals("~") || date.equals("null ~ null"))	date = "전체";

String addr2 = "", grname = "", grnamesum = "", grcostsum = "", grcostsum2 = "";
int grcost = 0;
ArrayList<GroundListInfo> branList = (ArrayList<GroundListInfo>)request.getAttribute("branList");

String addr[] = null;
for (int i = 0 ; i < branList.size() ; i++) {
	addr = new String[branList.size()];
	GroundListInfo grdInfo = (GroundListInfo)branList.get(i);
		addr2 += grdInfo.getGl_grdname() + ",";		
}
addr = addr2.split(",");


AdminInfo adminInfo = (AdminInfo)session.getAttribute("adminInfo");
SiteInfo siteInfo = (SiteInfo)session.getAttribute("siteInfo");
String alid = "";
if (adminInfo != null)	alid = adminInfo.getAl_id();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/admincss.css" />
<!-- #wrapper #leftMenu #main #mainHead css -->
<style>
#login { margin: 0 auto; width:80%; border:1 black solid; width:500px; }

#saleTitle {
	margin: 15px 0 0 30px; margin: 20;
}
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
#box2 {
	width:795px;
	height : 390px;
	border: 2px solid black; 
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

function showgrname() {
	var schGu = document.getElementById("schGu");
	var sdate = document.getElementById("sdate");
	var edate = document.getElementById("edate");
	var payMethod = document.getElementById("payMethod");
	var period = document.getElementById("period");
	if (schGu.style.display == 'none') { 
		schGu.style.display = 'block';
		sdate.style.display = 'none';
		edate.style.display = 'none';
		payMethod.style.display = 'none';
		period.style.display = 'none';
	} else {
		schGu.style.display = 'none';
		sdate.style.display = 'block';
		edate.style.display = 'block';
		payMethod.style.display = 'block';	
		period.style.display = 'block';	
		
		var getGu = document.getElementById("getGu");
		alert(getGu.length);		
	}
	
}
</script>
<script type="text/javascript" src="calendar.js"></script>
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
				<dd><a href="sale.stat">5-1_1. 매출 통계(지역별)</a></dd>
				<dd><a href="saleBran.stat">5-1_2. 매출 통계(지점별)</a></dd>
				<dd><a href="statistics.member">5-2. 회원 통계</a></dd>
			</div>
		</div>
		<div id="board"><strong>6. 게시판관리</strong><hr>
			<div id="board-slide">
				<dd><a href="perView.adminBoard">6-1. 1:1 문의 관리</a></dd>
			</div>
		</div>
	</div>
	<table>
		<tr>
		</tr>
	</table>
	<!-- 메인화면 div -->
	<div id="main">
	
		<form name="schFrm" action="saleBran.stat" method="post">
		<table width="750" cellpadding="0" cellspacing="1" bgcolor="black">
			<tr bgcolor="white" align="center">
				<th width="15%">지역 선택</th>
				<td width="*" align="left">&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="checkbox" name="allGrd" value="all" id="all"/>구장별<span onclick="showgrname();">▼</span>
					<div id="schGu" style="display:none">
<%

				for (int i = 0; i < addr.length; i++) {
					if (i%4 == 0)	out.println("<br />");
			%>	
	 				<span id="size"><input type="checkbox" name="schGu" value="<%=addr[i] %>" id="getGu" />
	 				<%=addr[i] %></span>
			<%
				}
%>		
						
					</div>				
				</td>
				<td width="8%" rowspan="4"><input type="submit" style="width:60px; height:150px; " value="검 색"></td>
			</tr>
			<tr bgcolor="white" align="center">
				<th>기간 조회</th>
				<td align="left">&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="text" name="sdate" id="sdate" value="" placeholder="날짜선택" onclick="fnPopUpCalendar(sdate, sdate, 'yyyy-mm-dd')" />
					<input type="text" name="edate" id="edate" value="" placeholder="날짜선택" onclick="fnPopUpCalendar(edate, edate, 'yyyy-mm-dd')" />
				</td>	
			</tr>		
			
			<tr bgcolor="white" align="center">
				<th>입금 방법</th>
				<td align="left">&nbsp;&nbsp;&nbsp;&nbsp;
					<select name="payMethod" id="payMethod">
						<option value="">전체</option>
						<option value="c">카드</option>
						<option value="m">휴대폰결제</option>
					</select>
				</td>
			</tr>
		</table>
		</form>
		<table width="220" cellpadding="0" cellspacing="1">
		<tr height="30" bgcolor="white" align="center" id="saleTitle">
		<th>지점별 매출 현황</th>
		</tr>
		</table>
		
		<div id="box2" >
			<div id="chart">
				<canvas id="canvas">
				</canvas>
			</div>		
		</div><br />
		<table width="795" cellpadding="0" cellspacing="1" bgcolor="black">
			<tr bgcolor="white" align="center">
			<th>구분</th><th>지점</th><th>매출</th>
			
<%

ArrayList<GroundRevInfo> grdRevBranList = (ArrayList<GroundRevInfo>)request.getAttribute("grdRevBranList");
if (grdRevBranList.size() > 0) {
	for (int i = 0 ; i < grdRevBranList.size() ; i++) {
		GroundRevInfo grdRevInfo = (GroundRevInfo)grdRevBranList.get(i);
		grname += "'" + grdRevInfo.getGr_name() + "', ";
		grnamesum = grname.substring(0, grname.length() - 2);
		
		
		grcostsum += grdRevInfo.getGr_cost() + ", ";
		grcostsum2 = grcostsum.substring(0, grcostsum.length() - 2);
		
		%>
		<tr bgcolor="white" align="center"><td><%=date %></td><td><%=grdRevInfo.getGr_name() %></td><td><%=grdRevInfo.getGr_cost() %></td></tr>
		<%
	}
	
	%>
			</table>
		</div>
	
	</div>
<% 
} else {
	out.println("<tr bgcolor='white' height='50'><th colspan='3'>");
	out.println("검색 결과가 없습니다.</th></tr>");		
}

}
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
	labels: [<%=grnamesum %>],
	datasets: [{
		label: '매출액',
		backgroundColor: color(window.chartColors.red).alpha(0.5).rgbString(),
		borderColor: window.chartColors.red,
		borderWidth: 1,
		data: [<%=grcostsum %>]
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
			title:{ display:true, text:'' }
		}
	});
};
</script>

