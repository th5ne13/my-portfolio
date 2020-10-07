<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
request.setCharacterEncoding("utf-8");

ArrayList<GroundRevInfo> grdRevList = (ArrayList<GroundRevInfo>)request.getAttribute("grdRevList");
int size = grdRevList.size();
String date = "", sdate = "", edate = "", grdName = "", grdSale = "";
date = (String)request.getAttribute("date");
if (date.equals(" ~ ") || date.equals("null ~ null")) {
	date = "전체";
}

String[] addr = { "종로구", "중구",	"용산구", "성동구",	"광진구", "동대문구", "중랑구", "성북구", "강북구", "도봉구", "노원구", "은평구",
		 "서대문구", "마포구", "양천구", "강서구", "구로구", "금천구",	"영등포구",	"동작구", "관악구",	"서초구", "강남구",	"송파구", "강동구" };

String args = "";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/admincss.css" />
<!-- #wrapper #leftMenu #main #mainHead css -->
<style>
#head {
	height: 140px;
}
#saleTitle {
	margin: 15px 0 0 30px;
}

#mainBody {
	width: 90%; margin:0 auto; text-align:center;
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
	display:block;
}
#board-slide {
	display:none;
}

#schTable { width:700px; }
#schTable td { text-align: left; }
#schTable tr { height: 50px; }
#schGu { position: absolute; width: 460px; border: 1px black solid; letter-spacing: 5px; }
#chart {width: 720px; height: 350px; border: 1px black solid; }
#grdSaleResult {width: 720px; height: 200px; border: 1px black solid; margin-top: 10px; }
#schBtn { width: 100px; border: 1px black solid; height: 125px; position: absolute; top:52px; right:120px; }
#perList td { text-align: center; }
canvas {
	-moz-user-select: none;
	-webkit-user-select: none;
	-ms-user-select: none;
}

</style>
<script src="js/Chart.min.js"></script>
<script src="js/utils.js"></script>
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

function showGu() {
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
	
	<!-- 메인화면 div -->
	<div id="main">
		<div id="head">
			<form name="schFrm" action="sale.stat" method="post">
			<table id="schTable">
				<tr>
					<th width="20%">지역 선택</th>
					<td>
					<label for="all"><input type="checkbox" name="allGu" value="all" id="all"/></label>지역별<span onclick="showGu();">▼</span>
					<iframe src="" frameborder="0" style="display:none"></iframe>
					&nbsp;&nbsp;&nbsp;
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
					<td rowspan="4"><input type="submit" value="검색" id="schBtn" /></td>					
				</tr>
				<tr>
					<th>기간조회</th>
					<td><input type="text" name="sdate" id="sdate" value="<%=sdate %>" placeholder="시작일" onclick="fnPopUpCalendar(sdate, sdate, 'yyyy-mm-dd')" />
					<input type="text" name="edate" id="edate" value="<%=edate %>" placeholder="종료일" onclick="fnPopUpCalendar(edate, edate, 'yyyy-mm-dd')" /></td>
				</tr>
				<tr>
					<th>입금방법</th>
					<td>
					<select name="payMethod" id="payMethod">
						<option value="">전체</option>
						<option value="c">카드</option>
						<option value="m">휴대폰결제</option>
					</select>
					</td>
				</tr>
			</table>
			</form>
		<table width="180" cellpadding="0" cellspacing="1" id="saleTitle">
		<tr height="30" bgcolor="white" align="center">
		<th>기간별 매출 현황</th>
		</tr>
		</table><br />
		
		</div>		
		<div id="mainBody">	
			<br/>
			<div id="chart">
			<br/>
			<canvas id="canvas"></canvas>
			</div>	
			<br />
			<div id="grdSaleResult">
			<table id="perList" cellpadding="0" cellspacing="0" width="700">
<%
String abc = "";
if (grdRevList != null) {
	if (grdRevList.size() == 0) {
		out.println("<tr><th>조회 결과가 없습니다.</th></tr>");
	} else {
		GroundRevInfo grd0 = grdRevList.get(0);
		grdName = "'" + grd0.getGr_addr() + "'";
		grdSale = grd0.getGr_cost() + "";
%>
				<tr height="40">
					<th width="30%">기간</th>
					<th width="30%">구장주소</th>
					<th width="20%">구장명</th>
					<th width="*">매출액</th>
				</tr>
				<tr height="30">
					<td rowspan="<%=size%>" align="center"><%=date %></td>
					<td><%=grd0.getGr_addr() %></td>
					<td><%=grd0.getGr_name() %></td>
					<td><%=grd0.getGr_cost() %></td>
				</tr>
<%
		for (int i = 1; i < grdRevList.size(); i++) {
			GroundRevInfo grd = grdRevList.get(i);
			grdName += ", '" + grd.getGr_addr() + "'";
			grdSale += ", " + grd.getGr_cost();
%>
				<tr height="30">
					<td><%=grd.getGr_addr() %></td>
					<td><%=grd.getGr_name() %></td>
					<td><%=grd.getGr_cost() %></td>
				</tr>
<%		
		}
	} 
}
%>
		</table>
		</div>
	</div>
</div>
</body>
</html>
<script type="text/javascript" src="calendar.js"></script>
<script>
var color = Chart.helpers.color;
var barChartData = {
	labels: [<%=grdName%>],
	datasets: [{
		label: '매출액',
		backgroundColor: color(window.chartColors.red).alpha(0.5).rgbString(),
		borderColor: window.chartColors.red,
		borderWidth: 1,
		data: [<%=grdSale%>]
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
		}
	});
};
</script>