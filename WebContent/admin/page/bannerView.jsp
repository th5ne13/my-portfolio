<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
request.setCharacterEncoding("utf-8");
PageMainInfo bannerInfo = (PageMainInfo)request.getAttribute("bannerInfo");
String img1 = "", img2 = "", img3 = "", img4 = "", img5 = "", saveimg1 = "", saveimg2 = "", saveimg3 = "", saveimg4 = "", saveimg5 = "";
int bimgtime = 0;
int time = 0;
if (bannerInfo != null)	 {
	img1 = bannerInfo.getPl_bimg1();
	img2 = bannerInfo.getPl_bimg2();
	img3 = bannerInfo.getPl_bimg3();
	img4 = bannerInfo.getPl_bimg4();
	img5 = bannerInfo.getPl_bimg5();
	saveimg1 = bannerInfo.getPl_savebimg1();
	saveimg2 = bannerInfo.getPl_savebimg2();
	saveimg3 = bannerInfo.getPl_savebimg3();
	saveimg4 = bannerInfo.getPl_savebimg4();
	saveimg5 = bannerInfo.getPl_savebimg5();
	bimgtime = bannerInfo.getPl_bimgtime();
	time = bimgtime * 1000;
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/admincss.css" />
<!-- #wrapper #leftMenu #main #mainHead css -->
<style>
/* 슬라이드 스타일 */
.slideshow {
	width: 90%; margin:auto; margin-top:20px; overflow:hidden; position:relative; height:200px; text-align:center; border:1px solid black;
}
.slideshow-slides {
	width: 100%;  height:100%; position:absolute;
}
.slideshow-slides .slide {
	width:100%; height:100%; overflow:hidden; position:absolute;
}
.slideshow-slides .slide img { left:50%; margin-left:-200px; position:absolute; }
/* 슬라이드 내비게이션 스타일 */
.slideshow-nav a, .slideshow-indicator a { overflow:hidden; }
.slideshow-nav a:before, .slideshow-indicator a:before {
	display:inline-block; font-size:0; line-height:0;
}
.slideshow-nav a {
	position:absolute; top:50%; left:50%; width:72px; height:72px; margin-top:-36px;
}
.slideshow-nav a.prev { margin-left:-280px; }
.slideshow-nav a.prev:before { margin-top:-20px; }
.slideshow-nav a.next { margin-left:204px; }
.slideshow-nav a.next:before { margin-top:-20px; margin-left:-40px; }
.slideshow-nav a.disabled { display:none; }
/* 인디케이터 스타일 */
.slideshow-indicator {
	bottom:20px; height:16px; position:absolute; left:0; right:0; text-align:center;
}
.slideshow-indicator a {
	display:inline-block; width:16px; height:16px; margin-left:3px; margin-right:3px;
}
.slideshow-indicator a.active { cursor:default; }
.slideshow-indicator a:before { margin-left:-55px; }
.slideshow-indicator a.active:before { margin-left:-65px; }

#bannerForm {
	width: 90%; margin:0 auto; text-align:center;
}
#bannerCng {
	width: 100%; margin-top: 20px; display: inline-block;
}
#timeCng {
	width: 100%; height: 50px;
}
#imgCng {
	width: 100%; border: 1px solid black; height: 290px; margin-top:10px;
}
#footer {
	width: 90%; margin:0 auto; height: 30px; margin-top:20px; text-align: center;
}

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
<script>
$(function() {
	$(".slideshow").each(function() {
		var $container = $(this);
		var $slideGroup = $container.find(".slideshow-slides");
		var $slides = $slideGroup.find(".slide");
		var $nav = $container.find(".slideshow-nav");
		var $indicator = $container.find(".slideshow-indicator");
		var slideCount = $slides.length;
		var indicatorHTML = "";
		var currentIndex = 0;
		var duration = 500;
		var interval = <%=time %>;	// 슬라이드 넘어가는 시간
		var timer;

		$slides.each(function(i) {
			$(this).css({ left:100 * i + "%" });
			indicatorHTML += "<a href='#'>" + (i + 1) + "</a>";
		});
		$indicator.html(indicatorHTML);
		function goToSlide(index) {
			$slideGroup.animate({ left:-100 * index + "%" }, duration);
			currentIndex = index;
			updateNav();
		}
		function updateNav() {
			var $navPrev = $nav.find(".prev");
			var $navNext = $nav.find(".next");
			
			$indicator.find("a").removeClass("active").eq(currentIndex).addClass("active");
		}
		function startTimer() {
			timer = setInterval(function() {
				var nextIndex = (currentIndex + 1) % slideCount;
				goToSlide(nextIndex);
			}, interval);
		}
		function stopTimer() {
			clearInterval(timer);
		}			
		$nav.on("click", "a", function(event) {
			event.preventDefault();
			if ($(this).hasClass("prev")) {
				if (currentIndex == 0) {
					currentIndex = 5;
				}
				goToSlide(currentIndex - 1);
			} else {
				if (currentIndex == 4) {
					currentIndex = -1;
				}
				goToSlide(currentIndex + 1);
			}
		});
		$indicator.on("click", "a", function(event) {
			event.preventDefault();
			if (!$(this).hasClass("active")) {
				goToSlide($(this).index());
			}
		});
		$container.on({
			mouseenter:stopTimer, mouseleave:startTimer
		});
		goToSlide(currentIndex);
		startTimer();
	});
});

function delImg(val) {
	if (confirm("정말 삭제 하시겠습니까??")) {
		val.type = "submit";
		alert("삭제하였습니다.");
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
	<form name="frm" action="bannerProc.page" method="post" enctype="multipart/form-data">
	<input type="hidden" name="img1" value="<%=img1 %>" />
	<input type="hidden" name="img2" value="<%=img2 %>" />
	<input type="hidden" name="img3" value="<%=img3 %>" />
	<input type="hidden" name="img4" value="<%=img4 %>" />
	<input type="hidden" name="img5" value="<%=img5 %>" />
	<input type="hidden" name="simg1" value="<%=saveimg1 %>" />
	<input type="hidden" name="simg2" value="<%=saveimg2 %>" />
	<input type="hidden" name="simg3" value="<%=saveimg3 %>" />
	<input type="hidden" name="simg4" value="<%=saveimg4 %>" />
	<input type="hidden" name="simg5" value="<%=saveimg5 %>" />
	<div id="main">
		<div id="mainHead">배너관리</div>
		<div class="slideshow">
			<div class="slideshow-slides">
				<a href="#" class="slide"><img src="img/<%=img1 %>" alt="배너이미지" width="400" height="200" id="imgslide1"/></a>
				<a href="#" class="slide"><img src="img/<%=img2 %>" alt="배너이미지" width="400" height="200" id="imgslide2"/></a>
				<a href="#" class="slide"><img src="img/<%=img3 %>" alt="배너이미지" width="400" height="200" id="imgslide3"/></a>
				<a href="#" class="slide"><img src="img/<%=img4 %>" alt="배너이미지" width="400" height="200" id="imgslide4"/></a>
				<a href="#" class="slide"><img src="img/<%=img5 %>" alt="배너이미지" width="400" height="200" id="imgslide5"/></a>
			</div>
			<div class="slideshow-nav">
				<a href="#" class="prev">Prev</a>
				<a href="#" class="next">Next</a>
			</div>
			<div class="slideshow-indicator"></div>
		</div>
		<div id="bannerForm">
			<div id="bannerCng">
				<div id="timeCng">
					<div id="timeTxt">페이지 당 시간 간격(초)</div>
					<div id="timeSlt">
						<select name="bannerTime" id="bannerTime">
<%
String slt = "";
for (int i = 1; i <= 10; i++) {
	if (bimgtime == i)	slt = " selected=\"selected\"";
	else									slt = "";
%>
<option <%=slt %>><%=i %></option>
<% } %>
						</select>
					</div>
				</div>
				<table id="imgCng">
					<tr height="40px" align="left">
						<td width="300px">현재 이미지 명 : <%=img1 %></td>
						<td><input type="file" name="file1" id="file1" /></td>
						<td> </td>
						<td><button name="img1" type="button" onclick="delImg(this);">삭제</button></td>
					</tr>
					<tr height="40px" align="left">
						<td width="300px">현재 이미지 명 : <%=img2 %></td>
						<td><input type="file" name="file2" id="file2" /></td>
						<td> </td>
						<td><button name="img2" type="button" onclick="delImg(this);">삭제</button></td>
					</tr>
					<tr height="40px" align="left">
						<td width="300px">현재 이미지 명 : <%=img3 %></td>
						<td><input type="file" name="file3" id="file3" /></td>
						<td> </td>
						<td><button name="img3" type="button" onclick="delImg(this);">삭제</button></td>
					</tr>
					<tr height="40px" align="left">
						<td width="300px">현재 이미지 명 : <%=img4 %></td>
						<td><input type="file" name="file4" id="file4" /></td>
						<td> </td>
						<td><button name="img4" type="button" onclick="delImg(this);">삭제</button></td>
					</tr>
					<tr height="40px" align="left">
						<td width="300px">현재 이미지 명 : <%=img5 %></td>
						<td><input type="file" name="file5" id="file5" /></td>
						<td> </td>
						<td><button name="img5" type="button" onclick="delImg(this);">삭제</button></td>
					</tr>
				</table>
			</div>
		</div>
		<div id="footer">
			<input type="reset" value="취소" />&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="확인" />
		</div>
	</div>
	</form>
</div>
</body>
</html>