<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>    
<%@ page import="vo.*"%>    
<%@ page import="java.text.SimpleDateFormat"%>
<%
request.setCharacterEncoding("utf-8");
GroundListInfo grd = (GroundListInfo)request.getAttribute("groundListInfo");
MemberInfo memberInfo = (MemberInfo)session.getAttribute("memberInfo");
String sltDay = "";
String groundRq = "구장제휴신청";
String gladdr = grd.getGl_jibeon();
String glCode = grd.getGl_code();
String glName = grd.getGl_grdname();
String glimg = grd.getGl_img1();
String glrule = grd.getGl_rule();
String size1 = Integer.toString(grd.getGl_size1());
String size2 = Integer.toString(grd.getGl_size2());
String glSize1 = size1.substring(0, 2) + " x " + size1.substring(2) + " (단위 mm)";
String glSize2 = size2.substring(0, 2) + " x " + size2.substring(2);
String glMatchtype = grd.getGl_matchtype();
String floor = grd.getGl_floor();
String glPark = grd.getGl_parking();
String glBall = grd.getGl_rentball();
String glUni = grd.getGl_rentvest();
String glShoes = grd.getGl_pshoes();
int wkdCost = grd.getGl_wkcost();
int wdCost = grd.getGl_wdcost();


String parkChk = "groundImg/1.svg";
String ballChk = "groundImg/4.svg";
String uniChk = "groundImg/5.svg";
String shoesChk = "groundImg/6.svg";
if (glPark.equals("n")) {
	parkChk = "";
}
if (glBall.equals("n")) {
	ballChk = "";
}if (glUni.equals("n")) {
	uniChk = "";
}if (glShoes.equals("n")) {
	shoesChk = "";
}



String glFloor = "";
if (floor.equals('A')) {
	glFloor = "인조잔디";
} else if (glFloor.equals('B')) {
    glFloor = "천연잔디";
} else if (glFloor.equals('C')) {
	glFloor = "흙바닥";
} else {
	glFloor = "우레탄";
}
int glcost = grd.getGl_wdcost();


String mlName = "", mlphone = "", mlid = ""; 
if (memberInfo != null) {
	mlName = memberInfo.getMl_name();
	mlphone = memberInfo.getMl_phone();
	mlid = memberInfo.getMl_id();
}
String lnk, loginChk, lnk2, myPage = "";
String reqType = "in";

if (memberInfo != null) {
	mlid = memberInfo.getMl_id();
	if (memberInfo.getMl_membertype().equals("o"))	{
		groundRq = "내 구장관리";
		glCode = memberInfo.getGl_code();
		reqType = "up";
	}
	lnk = "logout";
	lnk2 = "list.reserve?mlid=<%=mlid>";
	myPage = "마이페이지";
	loginChk = "로그아웃";
} else {
	lnk = "loginForm.jsp";
	lnk2 = "member/joinClause.jsp";
	loginChk = "로그인";
	myPage ="회원가입";
}


Calendar today = Calendar.getInstance();
String now = new java.text.SimpleDateFormat("yyyy-MM-dd").format(today.getTime());
final String[] WEEK_DAY = {"", "일", "월", "화", "수", "목", "금", "토"};
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<style>
        body {margin:0;
              padding:0;
        }
        a{
            text-decoration: none;
        }
        #header_content {
            width:1200px;
            overflow:hidden;
            border:1px solid #cccccc;
            margin:0 auto;
        }
        #nav {
            float:left;
            background-color:#be0436;
            
            width:300px;
            height:4000px;

        }
        #content {
            float:right;
            background-color:#fff;
            width:899px;
            height:4000px;
        }
        #content .wrap {
            width: 90%;
            margin: 20px auto;
        }
        
        #content .logo_left{
            float:right;
            margin-right:-40px;
        }
        
        #content .logo_left a {
            display: inline-block;
            width: 100px;
            padding: 7px;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            text-align: center;
            background-color: brown;
            
        }
        #content .logo_left a:hover{
            background-color:darkgreen;
        }
       
        #content .logo_left a:nth-of-type(2) {
            background-color:pink;
            margin-left:20px;
        }


        #content .logo_left a:nth-of-type(2):hover{
            background-color:hotpink;
        }
        #content .logo_left input {
            display: inline-block;
            width: 150px;
            border-radius: 15px;
            padding: 10px;
            margin-left:20px;
        }
        #content .logo_right{
            float:right;
            padding:7px;
 
        }
        #content .logo_right a {
             color:white;
             text-decoration:none;
        }
        #content .logo_right a:hover{
            color:coral;
        }
        #content .logo_right a:last-child{
            margin-left:20px;
        }
        .tab-inner{
            width: 800px;
            height: 500px;
            position: relative;
        }
        .slide{
            margin-top:250px;
        }
        input[name=tabmenu]{
            display:none;
        }
        .content{
            display:none;
        }
        .btn{
        position: absolute;
        text-align: center;
        width: 100%;
        bottom:-230px;
        padding:5px;
        }
        .btn label{
            width: 120px;
            display:inline-block;
            border-radius: 50%;
            cursor: pointer;
        }   
        input[id=tab1]:checked ~ .slide01,
        input[id=tab2]:checked ~ .slide02,
        input[id=tab3]:checked ~ .slide03,
        input[id=tab4]:checked ~ .slide04,
        input[id=tab5]:checked ~ .slide05,
        input[id=tab6]:checked ~ .slide06{
            display:block;
        }
       img{
            width: 100%;
            margin-top:50px;
        }
        .headline{
            margin-top:300px;
        }
        .headline a:nth-child(1){
            border-radius: 5px;
            color:red;
            border:1px solid red;
            padding:0 5px;
            margin-right:10px;
        }
        .headline a:nth-child(2){
            border-radius: 5px;
            color:gray;
            border:1px solid gray;
            padding:0 5px;
            margin-right:10px;
        }
        .headline a:nth-child(3){
            border-radius: 5px;
            color:gray;
            border:1px solid gray;
            padding:0 5px;
        }
        .headline ~ h1{
            font-weight: normal;
            color:dodgerblue;
        }
        .headline ~ p:after{
            content:'길찾기';
            cursor: pointer;
            margin-left:20px;
            font-weight: bold;
            color:green;
            font-size:18px;
        }
        .info{
            overflow: hidden;
            width: 100%;
            margin-bottom: 100px;;
        }
        .info li{
            list-style: none;
        }
        .info_left{
            float:left;
            margin-top:32px;
        }
        .info_right{
            width: 550px;
            float:right;
            margin-right:-60px;
            margin-top:40px;
            
        }
        .info_right .img-box{}
        .img-box img{
            width: 20%;
        }
        .line1{
            margin-bottom:10px;
            margin-top:30px;
            float:left;
        }
        .line1 div:nth-child(1){
            display:inline-block;
            width: 30px;
            height: 30px;
            background:#b4bbbe;
            border-radius:3px;
        }
        .line1 div:nth-child(2){
            display:inline-block;
            width: 30px;
            height: 30px;
            background:#c8eefe;
            margin-left:5px;
            border-radius:3px;
        }
        .line1-2{
            float:right;
            margin-top:32px;
            margin-right:300px;
            position: relative;
        }
        .line1-2:after{
            content: '예약시간을 선택해주세요.';
            color:red;
            position: absolute;
            right:-200%;
        }
        .line2{
            width: 100%;
            clear: both;
        }
        .line2 span:nth-child(1){
            display:inline-block;
            width: 300px;
            padding:20px;
            background:gray;
        }
        .line2 span:nth-child(2){
            display:inline-block;
            width: 150px;
            padding:20px;
            background:skyblue;
        }
        .line2 span:nth-child(3){
            display:inline-block;
            width: 150px;
            padding:20px;
            background:skyblue;
        }
        .price-inner{
            float:right;
            font-size:30px;
            margin-right:75px;
            margin-top:50px;
        }
        .submit-inner{
            clear: both;
            float:right;
            cursor: pointer;
            font-size:20px;
            padding:10px 70px;
            background:rgba(221, 221, 221, 0.8);
            border-radius: 10px;
            color:#fff;
            margin-top:20px;
            margin-right:70px;
            transition: 1.5s;
            margin-bottom:100px;
        }
        .submit-inner:hover{
            background:gray;
        }
        .mid-line{
            clear: both;
            height: 1px;
            width: 750px;
            background:gray;
            margin-left:50px;
        }
        .con_box{
            width: 800px;
            margin:0 auto;
        }
        .con-1{
            line-height:30px;
        }
        .con_box  h1{
            color:crimson;
        }
        .finish-line{
            height: 1px;
            width: 100%;
            background:gray;
            margin:60px 0;
        }
        .con-2{
            line-height:30px;
        }
        .list1 li:nth-child(1){
            margin-top:50px;
            list-style:square;
            font-size:20px;
            margin-bottom:20px;
        }
        .list1 li:nth-child(2),
        .list1 li:nth-child(3),
        .list1 li:nth-child(4){
            list-style: circle;
        }
        .list2 li{
            margin-top:50px;
            list-style: square;
            font-size:20px;
        }
        .finish-line ~ p{
            font-size:22px;
            color:red;
        }
        .con-3 .ul_1 li{
            font-size:20px;
            list-style: square;
        }
        td{
            padding:10px 40px;  
            text-align: center;
        }
        th{
            text-align: center;
            background:rgba(245, 245, 220, 0.336)
        }
        .con-3_list li:nth-of-type(1){
            list-style: square;
            font-size:20px;
            margin-bottom:20px;
            margin-top:50px;
        }
        .con-3_list li:nth-of-type(2),
        .con-3_list li:nth-of-type(3),
        .con-3_list li:nth-of-type(4){
            list-style: circle;
        }
        .con-4 li{
            list-style: square;
            font-size:20px;
            line-height: 40px;
        }
    	#side_mark > ul {
    		overflow:hidden;
    		margin-left:-25px;
    		margin-top: 30px;
    		font-style:inherit;
    		font-weight:bold;
    		color:white;
    		
    	}
    	#side_mark > ul > li {
    		list-style:none;
    		margin-bottom:10px;
    	}
    	#side_mark > ul > li > a { text-decoration:none; color:white; font-weight:bold; }
        #my > a {
            text-decoration:none;
            color: white;
            font-weight:bold;
            
            
        }
        #side #map {
            margin-top : 200px;
        }
        #side #side_mark {
            margin:15px;
        }
        #sltDay {
       	 margin-left:500px;
        }
        #side_mark img {
        	margin-left:15px; width:43%;
        	margin-top:15px;
        	
        }
</style>
<script charset="utf-8">
function cngFrame(val) {
	var time = document.getElementById("chkTime");
	var msg = document.getElementById("msg");
	msg.innerHTML = "시간을 선택해 주세요.";
	var date = val.substr(0, 10);
	time.src = "time.groundReq?glcode=<%=glCode%>" + "&date=" + date;
}

function goRev() {
	var mlid = "<%=mlid%>";
	if (mlid == "") {
		alert("예약은 로그인 후 사용하실 수 있습니다.");
		location.href="loginForm.jsp";
	} else {
		var slt = "";
		var sltTime = chkTime.document.getElementsByName("slt");
		var sltNum = 0;
		for (var i = 0; i < sltTime.length; i++) {
			if (sltTime[i].checked) {
				sltNum++;
				slt += sltTime[i].value
			}
		}
		if (sltNum == 0) {
			alert("시간을 선택하세요.");
			return false;
		}
		
		var glcost = "<%=glcost%>";
		var cost = sltNum * glcost;
		var sltDay = document.getElementById("revDay").value;
		window.open("groundRequest/groundRev.jsp?sltTime="+slt+"&glcode=<%=glCode %>&glcost="+cost+"&glname=<%=glName%>&mlname=<%=mlName%>&&sltDay="+sltDay+"&phone=<%=mlphone%>&glimg=<%=glimg %>&mlid=<%=mlid%>", "구장예약", "width=900, height=300");
	}
}

function cngMsg(num) {
	var msg = document.getElementById("msg");
	if (num == 0) {
		msg.innerHTML = "시간을 선택해 주세요.";
	} else {
		msg.innerHTML = num + " 개를 선택하셨습니다.";
	}
}

function move() {
	location.href="list.reserve?mlid=<%=mlid%>";
}

function cngImg(src) {
	bigimg = document.getElementById("bigImg");
	bigimg.src = src;
}
</script>
</head>
<body>
    <div id="header_content">
        <div id="nav">
            <div id="side_mark">
                <a href="start.jsp"><img src="groundImg/logo.png" /></a>
                <ul>
	                <li><a href="list.notice">용병 모집/지원 게시판</a></li>
	                <li><a href="list.board?btype=d">국내 축구 게시판</a></li>
	                <li><a href="<%=reqType %>.groundReq?glcode=<%=glCode%>"><%=groundRq %></a></li>
                </ul>
            </div>
            <div id="map">
                <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d4605.47619216377!2d127.09469621983747!3d37.5349066571045!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357ca53d2402060b%3A0x2772f52b6e031e6b!2z6rCV67OA!5e0!3m2!1sko!2skr!4v1587898859828!5m2!1sko!2skr" width="300" height="300" frameborder="0" style="border:0;" allowfullscreen="" aria-hidden="false" tabindex="0"></iframe>
            </div>
        </div>
        <div id="content">
            <div class="wrap">
                <div class="logo_left">

                    <div id="my">
                   		<a href="<%=lnk %>"><%=loginChk %></a>
                    </div>
                </div>
                <div class="tab-inner">
 <%
String[] img = { grd.getGl_img1(), grd.getGl_img2(), grd.getGl_img3(), grd.getGl_img4(), grd.getGl_img5(), grd.getGl_img6() };
 for ( int i = 0; i < img.length ; i++) { %>               
                    <input type="radio" name="tabmenu" id="tab<%=(i + 1)%>" <%if(i == 0)%> ? checked="checked" : checked="none" <%  %>>
<% } 
for ( int i = 0; i < img.length ; i++) { %>   
                    <div class="content slide0<%=(i + 1) %>">
                        <img src="groundImg/<%=img[i] %>">
                    </div>
<%	} %>
                    <div class="btn">
<%for ( int i = 0; i < img.length ; i++) { %>                         
                        <label for="tab<%=(i + 1) %>"><img src="groundImg/<%=img[i] %>" alt=""></label>
<%} %>
                    </div>
                </div>
                <div class="headline">
       
                </div>
                <h1><%=glName %></h1>
                <h3><p><%=gladdr %></p></h3>
                <div class="info">
                    <div class="info_left">
                        <h1>구장안내</h1>
                        <ul>
                            <li>구장크기 : <%=glSize1 %></li>
                            <li>추천인원 : <%=glMatchtype %></li>
                            <li>구장정보 : <%=glFloor %></li>
                        </ul>
                    </div>
                    <div class="info_right">
                        <div class="img-box">
                            <img src="<%=parkChk %>" alt="">
                            <img src="<%=ballChk %>" alt="">
                            <img src="<%=uniChk %>" alt="">
                            <img src="<%=shoesChk %>" alt="">
                   
                        </div>
                    </div>
                </div>
	<div id="reserve">
		<div id="reserveInfo">
               <div class="line1">
                    <div class="color-box"></div>&nbsp;예약가능
                    <div class="color-box"></div>&nbsp;예약불가
                </div>
			<div id="sltDay" class="float">	
				<select name="revDay" id="revDay" onchange="cngFrame(this.value);">
<%
for (int i = 1; i <= 30; i++) {
	sltDay = new java.text.SimpleDateFormat("yyyy-MM-dd").format(today.getTime());
	sltDay += "(" + WEEK_DAY[today.get(Calendar.DAY_OF_WEEK)] + ")";
	out.println("<option>" + sltDay + "</option>");
	if (today.get(Calendar.DAY_OF_WEEK) == 1 || today.get(Calendar.DAY_OF_WEEK) == 7) {
		glcost = grd.getGl_wkcost();
	}
	today.add(Calendar.DATE , +1);
}
%>
				</select>
				<div id="revTxt" class="float"><span id="msg">시간을 선택해 주세요</span></div>
			</div>
		</div>
		<div id="reservTime">
			<iframe id="chkTime" name="chkTime" src="time.groundReq?glcode=<%=glCode %>&date=<%=now %>" width="900" frameborder="0"></iframe>
		</div>
	</div>                <div class="submit-inner">
                    <a onclick="goRev();">예약하기</a></div>
                </div>
                <div class="mid-line"></div>
                <div class="con_box">
                    <div class="con-1">
                        <h1>이용안내</h1>
                        <div><h3><주차 상세></h3></div> 
                        <%if (glPark.equals("n")) { %> 
                        <div>- 주차 불가 구역 (지상주차장&인근도로변, 무료)</div><br>
                        <% } else{ %>
                        <div>- 20대 이상 주차 가능 (전용 주차장 구비)</div><br>
                        <% }%> 
                        <div><h3>< 대여 상세 ></h3></div>
                        <%if (glBall.equals("n")) { %> 
                        <div>- 공 대여 불가</div><br>
                        <% } else{ %>
                        <div>공 무상 대여 가능</div><br>
                        <% }%> 
                        <div><h3>- 실내, 야외 대기실 제공</h3></div>
                        <div><h3>주말 한 타임당 구장대여 비 : </h3><%=wkdCost %></div>
                        <div><h3>주중 한 타임당 구장대여 비 : </h3><%=wdCost %></div>
                    </div>
                    <div class="finish-line"></div> 
                    <div class="con-2">
                        <h1>이용규칙</h1>
                        <div>** 풋살장 예약시간 준수</div>
                        <div>** 풋살장 내 취사, 흡연 및 음주행위, 지나친 소음행위 금지 (적발 시 이용불가)</div>
                        <div>** 시설 사용 후 정리정돈 (쓰레기 반드시 처리)</div>
                        <div>** 고의 및 과실로 인한 시설물 훼손 및 파손시 사용자가 배상하며 경기중 부상은 본인이 책임집니다.</div>
                        <div>** 잔디보호와 부상방지를 위하여 스터드가 있는 축구화(SG, FG, HG, AG)는 착용이 금지되며 풋살화(TF)만 착용 가능 합니다.</div>
                        <ul class="list1">
                            <li>사회적 거리두기 2단계 동안에는 다음내용이 적용됩니다.</li>
                            <li>운동시에는 마스크를 꼭 착용해주셔야합니다. 호흡이 어려운 경우 운동템포와 휴식시간을 조정해주세요.</li>
                            <li>내구장의 경우에는 휴식시에도 마스크를 착용해주셔야합니다.</li>
                            <li>야외구장의 경우에는 휴식시 2M 이상 거리를 유지해주세요.</li>
                        </ul>
                        <ul class="list2">
                            <li>위 내용이 지켜지지 않을 경우 퇴장조치 될 수 있으니 예약시 꼭 참고부탁드립니다.</li>
                        </ul>
                    </div>
                    <div class="finish-line"></div>
                    <p>※ 규정 외 요청은 적용이 불가합니다. 예약 전 반드시 확인해 주시길 바랍니다.</p>
                    <div class="finish-line"></div>
                    <div class="con-3">
                        <h1>환불 규정</h1>
                        <ul class="ul_1">
                            <li>환불은 예약날짜를 기준으로만 적용합니다. (예약 시간으로는 적용되지 않습니다)</li><br>
                            <div>예를들어, <b>5월7일</b> 예약일 경우 다음과 같습니다.</div>
                        </ul>
                        <table border="1">
                            <tr>
                                <th>이용 당일</th>
                                <th>이용 1일 전</th>
                                <th>이용 2일 전</th>
                                <th>이용 5일 전</th>
                                <th>이용 10일 전</th>
                            </tr>
                            <tr>
                                <td>5월 7일</td>
                                <td>5월 6일</td>
                                <td>5월 5일</td>
                                <td>5월 2일</td>
                                <td>4월 27일</td>
                            </tr>
                        </table>
                        <ul class="con-3_list">
                            <li>다음과 같은 경우에는 상단 규정대로 처리됩니다.</li>
                            <li>고객의 사정으로 예약된 날짜에 구장 이용을 못하는 경우</li>
                            <li>구장, 날짜, 시간 등을 실수로 잘못 선택했을 경우</li>
                            <li>단순 변심으로 인해 환불이나 변경을 요청하는 경우</li>
                        </ul>
                    </div>
                    <div class="finish-line"></div>
                    <div class="con-4">
                        <h1>변경 규정</h1>
                        <ul>
                            <li>변경은 상단 환불 규정 기준 100% 환불인 경우에만 가능하며, 변경 가능한 횟수는 1회 입니다.
                            </li>
                            <li>1회 변경된 예약은 환불 및 재변경이 불가능합니다.</li>
                        </ul>
                    </div>
                </div> 
        </div>
        
        

        <div id="footer">
            footer
        </div>
    </div>
</body>
</html>