<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="vo.MemberInfo"%>  
<%
// index 기본 설정
MemberInfo memberInfo = (MemberInfo)session.getAttribute("memberInfo");
ArrayList<GroundListInfo> groundList = (ArrayList<GroundListInfo>)request.getAttribute("groundList");
String groundRq = "구장제휴신청";
String glCode = "";


// 구장등록신청 기본설정
int wdcost = 0, wkcost = 0, size1 = 0, size2 = 0;
String grdname = "", name = "", zipcode = "", jibeon = "", addrdtl = "", water = "", weekdayslt = "", weekendslt = "", weekdaytime="", weekendtime="", matchtype="";
String p1="", p2="", p3="";
String parking="", coldhot="", rentball="", rentvest="", pshoes="", shower="", rule="", code="", mlid = "", adminid=""; 
String wtype = request.getParameter("wtype");
String img1="", img2="", img3="", img4="", img5="", img6="";
String saveimg1="", saveimg2="", saveimg3="", saveimg4="", saveimg5="", saveimg6="";

String btn = "신청";
String glcode = request.getParameter("glcode");

if (memberInfo != null)	mlid = memberInfo.getMl_id();


if (wtype.equals("up")) {
	 btn = "수정";
	GroundListInfo grd = (GroundListInfo)request.getAttribute("groundListInfo");
	grdname = grd.getGl_grdname();			name = grd.getGl_name();				zipcode = grd.getGl_zipcode();
	jibeon = grd.getGl_jibeon();			addrdtl = grd.getGl_addrdtl();			weekdayslt = grd.getGl_weekdayslt();
	weekendslt = grd.getGl_weekendslt();	weekdaytime = grd.getGl_weekdaytime();	weekendtime = grd.getGl_weekendtime();
	matchtype = grd.getGl_matchtype(); 		water = grd.getGl_water();	
	
	if (grd.getGl_phone() != null && !grd.getGl_phone().equals("010--")) {
		String[] arrPhone = grd.getGl_phone().split("-");
		p1 = arrPhone[0];		p2 = arrPhone[1];		p3 = arrPhone[2];
	}
	
	parking = grd.getGl_parking();			coldhot = grd.getGl_coldhot();			rentball = grd.getGl_rentball();
	rentvest = grd.getGl_rentvest();		pshoes = grd.getGl_phone();				shower = grd.getGl_shower();
	size1 = grd.getGl_size1();				size2 = grd.getGl_size2();				wdcost = grd.getGl_wdcost();
 	wkcost = grd.getGl_wkcost();			rule = grd.getGl_rule();				code = grd.getGl_code();
 	
 	img1 = grd.getGl_img1();				img2 = grd.getGl_img2();				img3 = grd.getGl_img3();
 	img4 = grd.getGl_img4();				img5 = grd.getGl_img5();				img6 = grd.getGl_img6();
 	
 	saveimg1 = grd.getGl_saveimg1();		saveimg2 = grd.getGl_saveimg2();		saveimg3 = grd.getGl_saveimg3();
 	saveimg4 = grd.getGl_saveimg4();		saveimg5 = grd.getGl_saveimg5();		saveimg6 = grd.getGl_saveimg6();
 	
 	if (memberInfo != null) mlid = memberInfo.getMl_id();			
} else if (wtype.equals("admin")) { 
	wtype = "admin";
} else {
	wtype = "in";
}



%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	 <!-- CSS STYLE -->
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/reset.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/base.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/layout.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css" />
<script>
function getVal() {
	var weekdayTime = document.frmReq.weekdayTime;
	var weekdaytime = "<%=weekdaytime%>";
	for (var i = 0; i < weekdayTime.length; i++) {
		if (weekdaytime.search(weekdayTime[i].value) >= 0)	weekdayTime[i].checked = true;
	}
	var weekdaySlt = document.frmReq.weekdaySlt;
	var weekdayslt = "<%=weekdayslt%>";
	for (var i = 0; i < weekdaySlt.length; i++) {
		if (weekdayslt.search(weekdaySlt[i].value) >= 0)	weekdaySlt[i].checked = true;
	}
	var weekendTime = document.frmReq.weekendTime;
	var weekendtime = "<%=weekendtime%>";
	for (var i = 0; i < weekendTime.length; i++) {
		if (weekendtime.search(weekendTime[i].value) >= 0)	weekendTime[i].checked = true;
	}
	var weekendSlt = document.frmReq.weekendSlt;
	var weekendslt = "<%=weekendslt%>";
	for (var i = 0; i < weekendSlt.length; i++) {
		if (weekendslt.search(weekendSlt[i].value) >= 0)	weekendSlt[i].checked = true;
	}
	var matchType = document.frmReq.matchType;
	var matchtype = "<%=matchtype%>";
	for (var i = 0; i < matchType.length; i++) {
		if (matchtype.search(matchType[i].value) >= 0)		matchType[i].checked = true;
	}	
	var water = document.frmReq.water;
	var cWater = "<%=water%>";
	for (var i = 0; i < water.length; i++) {
		if (cWater.search(water[i].value) >= 0)				water[i].checked = true;
	}
}

window.onload=getVal;
</script>
</head>
<body>
<div id="wrapper">
<div id="header">
<div class="main_common">
<% if (memberInfo == null) { %>
<a href="list.board?btype=d">게시판</a>
<a href="loginForm.jsp" onclick="alert('로그인 후 사용하실 수 있습니다.')">용병</a>
<a href="loginForm.jsp" onclick="alert('로그인 후 사용하실 수 있습니다.')"><%=groundRq  %></a>
</div>
<div class="main_common"><a href="start.jsp">그림그림</a></div>
<div class="main_common">
	<a href="loginForm.jsp">로그인</a>
	<a href="member/joinClause.jsp">회원가입</a>
<% } else { 
	String reqType = "in";
	if (memberInfo.getMl_membertype().equals("o"))	{
		groundRq = "내구장관리";
		glCode = memberInfo.getGl_code();
		reqType = "up";
//		out.println(glCode);
	}
//	out.println(memberInfo.getMl_name() + "(" + memberInfo.getMl_id() + ") 님 환영합니다.<br />");
%>
	<a href="list.board?btype=d">게시판</a>
	<a href="list.notice?memberInfo=<%=memberInfo %>">용병</a>
</div>
<div class="main_common"><a href="start.jsp">그림그림</a></div>
<div class="main_common">
	<a href="<%=reqType %>.groundReq?glcode=<%=glCode%>"><%=groundRq %></a>
	<a href="logout">로그아웃</a>
	<a href="list.reserve?mlid=<%=mlid%>">마이페이지</a>
<% } %>
</div>	
</div>
<!-- 게시판 body 시작-->
<div id="body">
	<div id="banner">
		<img src="img/banner4.jfif" alt="banner2" width="800" height="300" />
	</div>
	<!-- 구장제휴신청 시작 -->
	<div class="groundReq">
		<form name="frmReq" action="proc.groundReq" method="post" enctype="multipart/form-data" onsubmit="return chkVal(this);">
		<input type="text" name="wtype" value="<%=wtype %>" />
		<input type="hidden" name="mlid" value="<%=mlid %>" />
		<input type="hidden" name="glcode" value="<%=glcode %>" />
		<input type="hidden" name="img1" value="<%=img1 %>" />
		<input type="hidden" name="img2" value="<%=img2 %>" />
		<input type="hidden" name="img3" value="<%=img3 %>" />
		<input type="hidden" name="img4" value="<%=img4 %>" />
		<input type="hidden" name="img5" value="<%=img5 %>" />
		<input type="hidden" name="img6" value="<%=img6 %>" />
		<input type="hidden" name="saveimg1" value="<%=saveimg1 %>" />
		<input type="hidden" name="saveimg2" value="<%=saveimg2 %>" />
		<input type="hidden" name="saveimg3" value="<%=saveimg3 %>" />
		<input type="hidden" name="saveimg4" value="<%=saveimg4 %>" />
		<input type="hidden" name="saveimg5" value="<%=saveimg5 %>" />
		<input type="hidden" name="saveimg6" value="<%=saveimg6 %>" />
		<input type="hidden" name="gu" value="" /><br />
		<b >구장제휴신청</b><br /><br />
		<table class="namePhone">
			<tr>
				<th width="20%">구장이름</th>
				<th width="20%">대표자이름</th>
				<th width="*">전화번호</th>
			</tr>
			<tr>
				<td><input type="text" name="grdname" maxlength="50" id="grdname" size="15" value="<%=grdname %>" /></td>
				<td><input type="text" name="name" maxlength="20" id="name" class="txt" size="10" value="<%=name %>" /></td>
				<td>					
					<select name="p1">
						<option <% if (p1.equals("010")) { %>selected="selected"<% } %>>010</option>
						<option <% if (p1.equals("011")) { %>selected="selected"<% } %>>011</option>
						<option <% if (p1.equals("016")) { %>selected="selected"<% } %>>016</option>
						<option <% if (p1.equals("019")) { %>selected="selected"<% } %>>019</option>
					</select> - 
					<input type="text" name="p2" maxlength="4" size="4" class="txt2" value="<%=p2 %>" /> -
					<input type="text" name="p3" maxlength="4" size="4" class="txt2" value="<%=p3 %>" /> 	
				</td>
			</tr>
		</table>
		<table class="addr">
			<tr><th>구장주소</th></tr>
			<tr>
				<td>						
					<input type="text" name="zipcode" id="sample4_postcode" placeholder="우편번호" value="<%=zipcode %>" />
					<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기" /><br>
					<input type="hidden" id="sample4_roadAddress" placeholder="도로명주소">
					<input type="text" name="jibeon" id="sample4_jibunAddress" placeholder="지번주소" value="<%=jibeon %>" />
					<span id="guide" style="color:#999;display:none"></span>
					<input type="text" name="addrdtl" id="sample4_detailAddress" placeholder="상세주소" value="<%=addrdtl %>" />
					<input type="hidden" id="sample4_extraAddress" placeholder="참고항목">
				</td>
			</tr>	
		</table>
		<table class="wdTimeDayInfo">			
			<tr>
				<th width="20%">평일 예약가능시간</th><th width="20%" ></th><th width="*">평일요금 책정</th>
			</tr>
			<tr>
				<td>예약가능시간(체크)</td>
				<td>전체선택&nbsp;<input type="checkbox" name="all" onclick="selectAll(this)"/></td>				
				<td><input type="text" name="wdcost" class="txt" size="6" value="<%=wdcost %>" />원</td>			
			</tr>
		</table>
		<table class="wdTimeDay">
			<tr>
				<td>
				0800-1000<input type="checkbox" name="weekdayTime" value="a" />&nbsp;&nbsp;
				1000-1200<input type="checkbox" name="weekdayTime" value="b" />&nbsp;&nbsp;
				1200-1400<input type="checkbox" name="weekdayTime" value="c" />&nbsp;&nbsp;
				1400-1600<input type="checkbox" name="weekdayTime" value="d" />&nbsp;&nbsp;
				1600-1800<input type="checkbox" name="weekdayTime" value="e" />&nbsp;&nbsp;
				1800-2000<input type="checkbox" name="weekdayTime" value="f" />&nbsp;&nbsp;
				2000-2200<input type="checkbox" name="weekdayTime" value="g" />
				</td>
			</tr>	
			<tr>
				<td>
					월<input type="checkbox" name="weekdaySlt" <% if (wtype.equals("in")) { %> checked="checked" <% } %> value="월" />&nbsp;
					화<input type="checkbox" name="weekdaySlt" <% if (wtype.equals("in")) { %> checked="checked" <% } %> value="화" />&nbsp;
					수<input type="checkbox" name="weekdaySlt" <% if (wtype.equals("in")) { %> checked="checked" <% } %> value="수" />&nbsp;
					목<input type="checkbox" name="weekdaySlt" <% if (wtype.equals("in")) { %> checked="checked" <% } %> value="목" />&nbsp;
					금<input type="checkbox" name="weekdaySlt" <% if (wtype.equals("in")) { %> checked="checked" <% } %> value="금" />
					<!-- 자바스크립트로 전체선택해제 하기 -->
				</td>
			</tr>
		</table>
		<table class="weekendTimeInfo">
			<tr><th width="20%">주말 예약가능시간</th><th width="20%"></th><th width="*">주말요금 책정</th></tr>
			<tr>
				<td>예약가능시간(체크)</td>
				<td>전체선택<input type="checkbox" name="all2" onclick="selectAll2(this)" /></td>
				<td><input type="text" name="wkcost" class="txt" size="6" value="<%=wkcost %>" />원</td>
			</tr>
		</table>
		<table class="wkTimeDay">
			<tr>
				<td>
					0800-1000<input type="checkbox" name="weekendTime" value="a" />&nbsp;&nbsp;
					1000-1200<input type="checkbox" name="weekendTime" value="b" />&nbsp;&nbsp;
					1200-1400<input type="checkbox" name="weekendTime" value="c" />&nbsp;&nbsp;
					1400-1600<input type="checkbox" name="weekendTime" value="d" />&nbsp;&nbsp;
					1600-1800<input type="checkbox" name="weekendTime" value="e" />&nbsp;&nbsp;
					1800-2000<input type="checkbox" name="weekendTime" value="f" />&nbsp;&nbsp;
					2000-2200<input type="checkbox" name="weekendTime" value="g" />
				</td>
			</tr>	
			<tr>
				<td>		
					토<input type="checkbox" name="weekendSlt" <% if (wtype.equals("in")) { %> checked="checked" <% } %> value="토" />&nbsp;
					일<input type="checkbox" name="weekendSlt" <% if (wtype.equals("in")) { %> checked="checked" <% } %> value="일" />		
				</td>
			</tr>
		</table>
		<table class="isFacility">
			<tr><th>주차여부</th><th>냉난방여부</th><th>샤워시설여부</th><th>조끼대여</th><th>풋살화대여</th><th>공대여</th></tr>
			<tr>
				<td>
					<label for="y">가능</label> 
					<input type="radio" name="isparking" value="y" <% if (parking.equals("y")) { %> checked="checked" <% } %> />
					<label for="n">불가능</label>
					<input type="radio" name="isparking" value="n" <% if (!parking.equals("y")) { %> checked="checked" <% } %> />
				</td>
				<td>
					<label for="y">가능</label> 
					<input type="radio" name="iscoldhot" value="y" <% if (coldhot.equals("y")) { %> checked="checked" <% } %> />
					<label for="n">불가능</label>
					<input type="radio" name="iscoldhot" value="n" <% if (!coldhot.equals("y")) { %> checked="checked" <% } %> />
				</td>
				<td>
					<label for="y">가능</label> 
					<input type="radio" name="isshower" value="y" <% if (shower.equals("y")) { %> checked="checked" <% } %> />
					<label for="n">불가능</label>
					<input type="radio" name="isshower" value="n" <% if (!shower.equals("y")) { %> checked="checked" <% } %> />
				</td>
				<td>
					<label for="y">가능</label> 
					<input type="radio" name="isvest" value="y" <% if (rentvest.equals("y")) { %> checked="checked" <% } %> />
					<label for="n">불가능</label>
					<input type="radio" name="isvest" value="n" <% if (!rentvest.equals("y")) { %> checked="checked" <% } %> />
				</td>
				<td>
					<label for="y">가능</label> <!-- 공대여 : football yes or no-->
					<input type="radio" name="isfootshoes" value="y" <% if (pshoes.equals("y")) { %> checked="checked" <% } %> />
					<label for="n">불가능</label>
					<input type="radio" name="isfootshoes" value="n" <% if (!pshoes.equals("y")) { %> checked="checked" <% } %> />
				</td>
				<td>
					<label for="y">가능</label> <!-- 공대여 : football yes or no-->
					<input type="radio" name="isball" value="y" <% if (rentball.equals("y")) { %> checked="checked" <% } %> />
					<label for="n">불가능</label>
					<input type="radio" name="isball" value="n" <% if (!rentball.equals("y")) { %> checked="checked" <% } %> />
				</td>
			</tr>
		</table>
		<table class="groundInfo">		
			<tr><th colspan="4">구장정보</th></tr>
			<tr><th width="20%">구장크기</th><th width="20%">추천인원</th><th width="*">잔디여부</th><th width="30%">물사용여부</th></tr>
			<tr>
				<td>
				<input type="text" name="grdsizewidth" maxlength="4" class="txt2" size="4" value="<%=size1 %>" />m X
				<input type="text" name="grdsizeheight" maxlength="4" class="txt2"size="4" value="<%=size2 %>" />m
				&nbsp;&nbsp;&nbsp;
				</td>
				<td> 
				<input type="checkbox" name="matchType" value="5vs5" /> 5 : 5&nbsp;
				<input type="checkbox" name="matchType" value="6vs6" /> 6 : 6
				</td>
				<td>		
				인조잔디<input type="radio" name="isLawn" value="a" checked="checked"/><label for="isLawn"></label>&nbsp;
				천연잔디<input type="radio" name="isLawn" value="b" /><label for="isLawn"></label>&nbsp;
				흑바닥<input type="radio" name="isLawn" value="c" /><label for="isLawn"></label>&nbsp;
				우레탄<input type="radio" name="isLawn" value="d" /><label for="isLawn"></label>&nbsp;
				</td>
				<td>			
				정수기 사용<input type="checkbox" name="water" value="a" checked="checked" /><label for="water"></label>&nbsp;
				물 판매<input type="checkbox" name="water" value="b" /><label for="water"></label>&nbsp;
				음료 판매<input type="checkbox" name="water" value="c" /><label for="water"></label>
				</td>
			</tr>			
		</table>
		<table class="imgAndInfo">
			<tr><th>구장이미지 등록</th></tr>
			<tr>
				<td>
					<label for="file1">구장이미지 파일1 : </label>&nbsp;&nbsp;<input type="file" name="file1" id="file1" value="abc" />
					<label for="file2">구장이미지 파일2 : </label>&nbsp;&nbsp;<input type="file" name="file2" id="file2" /><br />
					<label for="file3">구장이미지 파일3 : </label>&nbsp;&nbsp;<input type="file" name="file3" id="file3" />
					<label for="file4">구장이미지 파일4 : </label>&nbsp;&nbsp;<input type="file" name="file4" id="file4" /><br />
					<label for="file5">구장이미지 파일5 : </label>&nbsp;&nbsp;<input type="file" name="file5" id="file5" />
					<label for="file6">구장이미지 파일6 : </label>&nbsp;&nbsp;<input type="file" name="file6" id="file6" />
				</td>
			</tr>
			<tr>
				<th>안내사항 이용규칙</th>
			</tr>
			<tr>
				<td><textarea rows="5" cols="50" name="infoAndRule" ><%=rule %></textarea></td>
			</tr>
		</table>
		<table class="btn">
			<tr><td><input type="button" value="취소" onclick="history.back();"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="submit" value="<%=btn %>" /></td></tr>
		</table>	
		</form>
	</div>
	<!-- 구장제휴신청 종료 -->
</div>
<!-- 게시판 body 종료-->


<div id="footer">
	<div class="companyInfo">
		<ul>
			<li><a href="#">사이트 도움말</a></li>
			<li><a href="#">사이트 이용약관</a></li>
			<li><a href="#">사이트 운영규칙</a></li>
			<li><a href="#"><strong>개인정보취급방침</strong></a></li>
			<li><a href="#">책임의 한계와 법적고지</a></li>
			<li><a href="#">게시중단요청 서비스</a></li>
			<li><a href="#">고객센터</a></li>
		</ul>
	</div>
	<div class="w3c">
        <a href="http://validator.w3.org/check?uri=referer">
            <img src="http://www.w3.org/Icons/valid-xhtml10" alt="Valid XHTML 1.0 Transitional" height="31" width="88" />
        </a>
        <a href="http://jigsaw.w3.org/css-validator/check/referer">
            <img style="border:0;width:88px;height:31px" src="http://jigsaw.w3.org/css-validator/images/vcss-blue" alt="올바른 CSS입니다!" />
        </a>
    </div>
</div>
</div>
</body>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function sample4_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
           
            var roadAddr = data.roadAddress; 
            var extraRoadAddr = '';
          
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }
          
            if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
         
            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }

            document.getElementById('sample4_postcode').value = data.zonecode;
            document.getElementById("sample4_roadAddress").value = roadAddr;
            document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
                     
            if(roadAddr !== ''){
                document.getElementById("sample4_extraAddress").value = extraRoadAddr;
            } else {
                document.getElementById("sample4_extraAddress").value = '';
            }

            var guideTextBox = document.getElementById("guide");          
            if(data.autoRoadAddress) {
                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                guideTextBox.style.display = 'block';

            } else if(data.autoJibunAddress) {
                var expJibunAddr = data.autoJibunAddress;
                guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                guideTextBox.style.display = 'block';
            } else {
                guideTextBox.innerHTML = '';
                guideTextBox.style.display = 'none';
            }
        }
    }).open();
}
    
function selectAll(all) {
	var weekdayTime = document.frmReq.weekdayTime;
	for (var i = 0; i < weekdayTime.length; i++) {
		weekdayTime[i].checked = all.checked; 		
	} 	
}
function selectAll2(all2) {
	var weekendTime = document.frmReq.weekendTime;
	for (var i = 0; i < weekendTime.length; i++) {
		weekendTime[i].checked = all2.checked; 		
	} 	
}

function chkVal(frm) {
	var addr = frm.jibeon.value;
	var arr = addr.split(" ");
	var gu = arr[arr.length-3];
	alert(gu);
	frm.gu.value = gu;
	return true;
}
</script>
</html>