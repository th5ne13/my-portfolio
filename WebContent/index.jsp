<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>    
<%@ page import="vo.*"%>    
<%
String[] addr = { "종로구", "중구",	"용산구", "성동구",	"광진구", "동대문구", "중랑구", "성북구", "강북구", "도봉구", "노원구", "은평구",
		 "서대문구", "마포구", "양천구", "강서구", "구로구", "금천구",	"영등포구",	"동작구", "관악구",	"서초구", "강남구",	"송파구", "강동구" };

MemberInfo memberInfo = (MemberInfo)session.getAttribute("memberInfo");
String mlid ="";
String lnk, loginChk, lnk2, myPage = "";
String reqType = "in";
String groundRq = "구장제휴신청";
String glCode = "";

if (memberInfo != null) {
	mlid = memberInfo.getMl_id();
	if (memberInfo.getMl_membertype().equals("o"))	{
		groundRq = "내구장관리";
		glCode = memberInfo.getGl_code();
		reqType = "up";
	}
	lnk = "logout";
	lnk2 = "list.reserve?mlid=mlid";
	myPage = "마이페이지";
	loginChk = "로그아웃";
} else {
	lnk = "loginForm.jsp";
	lnk2 = "member/joinClause.jsp";
	loginChk = "로그인";
	myPage ="회원가입";
}
ArrayList<GroundListInfo> groundList = (ArrayList<GroundListInfo>)request.getAttribute("groundList");
String revTime = "";
String grdTime = "";
String grdWeekdayTime = "";
String grdWeekEndTime = "";

String park = "주차가능", coldhot = "냉/난방", floor = "잔디", ball = "공대여가능", vest = "조끼대여", shower = "샤워가능";

String schDate = request.getParameter("schDate");
Calendar today = Calendar.getInstance();
String now = new java.text.SimpleDateFormat("yyyy-MM-dd").format(today.getTime());
if (schDate != null && !schDate.equals("")) { 
	now = schDate;
}
int yy = Integer.parseInt(now.substring(0, 4));
int mm = Integer.parseInt(now.substring(5, 7));
int dd = Integer.parseInt(now.substring(8));
Calendar sdate = Calendar.getInstance();
today.set(yy, mm-1, dd);


final String[] WEEK_DAY = {"", "일", "월", "화", "수", "목", "금", "토"};
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script>
function cngFrame(val) {
	var grdNum = val.name
	var glcode = val.id;
	var date = val.value.substr(0, 10);
	alert(grdNum);
	alert(glcode);
	alert(date);
}
</script>

<style>

        body {
            margin:0; padding:0;
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
           display:inline-block;
           width:110px;
           height: 40px;
           background:#ccc;
           color:white;
           text-align: center;
           line-height: 40px;
           border-radius: 5px;
           margin-left:-17px;
           margin-top:10px;
        }
        #my > a:hover{
           background:red;
        }        
        #big {
            margin:0 auto;
            width:1200px;
            height:5000px;
            border:1px solid #cccccc;
            overflow:hidden;
            
            }
        #side {
            background-color:#be0436;
             
            float: left;
            border: 1px solid #cccccc;
            width:300px;
            height:100%;
            position:fixed;
        }
        #side #map {
            margin-top : 200px;
        }
        #side #side_mark {
            margin:15px;
        }
        #right {
            float:left;
           margin-left:300px;
            width:900px;
            height:100%;
        }
        #content {
            width:900px;
            height:320px;
            border:1px solid #cccccc;
            margin:30px;
            overflow:hidden;
        }
       #right #banner {
           clear: both;
           width: 900px;
           height:410px;
           border: 1px solid #cccccc;
           border-bottom:0;
           position:relative;

        }
        #right > p {
           font-size:1.2em; 
           font-weight:bold;
           border-bottom:1px solid #cccccc;
           padding-bottom:5px;
        }
        #post {
            width: 350px;
            height: 320px;
            float:left;
            position:relative;
        }
        #post > img {
            width:352px;
            height:280px;
        }
        #post2 {
            width: 546px;
            border: 1px solid #cccccc;
            height: 320px;
            float: right;
        }
        #groundtitle {
            background:black;
            color:white;
            font-weight:bold;
            height:40px;
            width:352px;
            text-align:center;
            position:absolute;
            margin-bottom:15px;
        }
        #post ul {
            overflow:hidden;
        }
        #post ul li {
            float:left;
        }
        #post ul li.class1 {
            width:400px;
            
        }
            #post ul li.class2 {
                width: 500px;
            }
       #sch {
           overflow:hidden;
           position:absolute;
           margin-top:18px;
       }
       #my {
           position:absolute;
           margin-left:790px;
           margin-top:20px;
           list-style:none;
       }
       #sch input {
           border-radius: 15px;
       }
       #sch input, #sch div {
           float:left;
           margin-left:10px;
       }
       #more {
           width:900px;
           height:30px;
           border:1px solid black;
           position:relative;
       }
       #more > a {
           text-decoration:none;
           text-align:center;
           position:absolute;
           margin-left:405px;
           margin-top:-15px;

       }
        
           
#wrapper {
	width:1150px; margin:0 auto; border:1px solid black; padding-bottom: 10px;
}

#header {
	width:1090px; margin: 0 auto; border:1px solid black; text-align: center; padding: 10px 0; margin-top: 10px;
}

.main_common { 
	width: 30%;	height: 50px; display: inline-block; float: center; border: 1px solid green; text-align: center;
	font-size: 1.5em; vertical-align: middle; padding-top: 30px;
}
#groundList { width:1090px; margin: auto; text-align: center; margin-top: 15px;  }
#grdName { background-color: black; font-color: white; font-size: 1.2em; }
#addr { text-align: left; }
#reserveInfo { width:900px; margin: 0 auto; height:30px; margin-top: 15px; }
#reservTime { width:875px; height:80px; margin-top: 15px; position: relative; }
#reservTime iframe { width:100%; height:100% position: absolute; }
#green { border-radius:3px; width:30px; height: 30px; background-color: #b4bbbe; margin-left:30px;}
#gray { border-radius:3px; width:30px; height: 30px; background-color: #c8eefe; margin-left: 40px; }
#sltDay { text-align: center; position: relative; top: 40px; left:155px; z-index: 10; }
#grdInfo { width: 90%; text-align: center; }
.float { float: left; }
#timeWrap { width:600px; margin-left:5px;}
.rev { height:20px; width:70px; margin:0 auto; display: inline-block; float: center; 
border-left:1px dotted black;
border-right:1px dotted black;
border-radius:3px;
background-color: #b4bbbe; margin-left:-4px; text-align: center; font-size:14px;
font-style:Serif;}

.time { width:50px; margin:0 auto; display: inline-block; float: center; margin-left:0px; margin-right: 9px; font-size:13px;
font-weight:bold;}
#last8 { display: inline-block; width: 1px;  font-size:13px; font-weight:bold;}
#last4 { margin-left:5px; }
#last5 { margin-left:12px; }
#last6 { margin-left:5px; }
#last7 { margin-left:2px; }

#hidden  { margin-top:1000px; display:none; }
#getTime { display: none;}
</style>
</head>
<body>
    <div id="big">
        <div id="side">
            <div id="side_mark">
           		<a href="#"><img src="groundImg/logo.png"/></a>
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
        <div id="right">
            <div id="banner">
                <div id="sch">
		        <!--  시작 --> 
		        </div>                

                <div id="my">
                	<a href="<%=lnk %>"><%=loginChk %></a>&nbsp;&nbsp;&nbsp;
                	<a href="<%=lnk2 %>"><%=myPage %></a>
               	</div>
               	<img src="groundImg/hana_2020.jpg" width="900" height="411">
			</div>
            <p>&nbsp;&nbsp;예약 가능 구장&nbsp;&nbsp;</p>
<%
int grdNum = 0;
if (groundList.size() == 0) {
	out.println("등록된 구장이 없습니다.");
} else {
	grdNum = groundList.size();
	for (int i = 0; i < 3; i++) {
		GroundListInfo grd = groundList.get(i);
		glCode = grd.getGl_code();		
		revTime = grd.getRevTime();
		grdWeekdayTime = grd.getGl_weekdaytime();
		if (grd.getGl_coldhot().equals("n"))	coldhot = "냉/난방불가";
		if (grd.getGl_floor().equals("n"))		floor = "흙바닥";		
		if (grd.getGl_parking().equals("n"))	park = "주차불가";
		if (grd.getGl_rentball().equals("n"))	ball = "공대여불가";
		if (grd.getGl_rentvest().equals("n"))	vest = "조끼대여불가";
		if (grd.getGl_shower().equals("n"))		shower = "샤워불가";

		if (today.get(Calendar.DAY_OF_WEEK) == 1 || today.get(Calendar.DAY_OF_WEEK) == 7) {
			grdTime = grd.getGl_weekendtime();
			grdWeekEndTime = grd.getGl_weekendtime();
		} else {
			grdTime = grd.getGl_weekdaytime();
		}

%>            
            <div id="content">

                <div id="post">
                    <a href="view.groundReq?glcode=<%=grd.getGl_code() %>&date=<%=now%>"><img src="groundImg/<%=grd.getGl_img1() %>" alt="구장이미지" width="352" height="280" /></a>
                    <div id="groundtitle"><%=grd.getGl_grdname() %></div>
                </div>
                <div id="post2">
                    <p><b>&nbsp;&nbsp;주소 : <%=grd.getGl_jibeon() %> <%=grd.getGl_addrdtl() %></b></p>
                    			<div id="sltDay">			
									<iframe id="getTime" name="getTime" src="" frameborder="0"></iframe>
										<select name="<%=i %>" id="<%=glCode %>" onchange="cngTime(this)">
<%
		String sltDay = "";
		for (int j = 1; j <= 30; j++) {
			sltDay = new java.text.SimpleDateFormat("yyyy-MM-dd").format(today.getTime());
			sltDay += "(" + WEEK_DAY[today.get(Calendar.DAY_OF_WEEK)] + ")";
			if (sltDay.substring(0, 10).equals(now))	out.println("<option selected=\"selected\">" + sltDay + "</option>");
			else										out.println("<option>" + sltDay + "</option>");
			today.add(Calendar.DATE , +1);
		}
		today.add(Calendar.DATE , -30);
%>
										</select>
								</div>
		<div id="reserveInfo">
			<div id="green" class="float"></div>
			<div id="revTxt" class="float">&nbsp;예약 가능</div>
			<div id="gray" class="float"></div>
			<div id="revTxt">&nbsp;예약 불가</div>
		</div>
		<div id="reservTime">			
			<div id="timeWrap">
				<div class="rev" id="a<%=i %>" >예약 가능</div>
				<div class="rev" id="b<%=i %>" >예약 가능</div>
				<div class="rev" id="c<%=i %>" >예약 가능</div>
				<div class="rev" id="d<%=i %>" >예약 가능</div>
				<div class="rev" id="e<%=i %>" >예약 가능</div>
				<div class="rev" id="f<%=i %>" >예약 가능</div>
				<div class="rev" id="g<%=i %>" >예약 가능</div>
				<br />
				<div class="time">08:00</div>
				<div class="time">10:00</div>
				<div class="time">12:00</div>
				<div id="last4" class="time">14:00</div>
				<div id="last5" class="time">16:00</div>
				<div id="last6" class="time">18:00</div>
				<div id="last7" class="time">20:00</div>
				<div id="last8">22:00</div>
			</div>
			<div id=hidden>
			<input type="text" value="<%=revTime %>/<%=grdTime%>" id="slt<%=i %>" name="<%=glCode %>" />
			<input type="checkbox" value="a" name="<%=glCode %>" id="slt" />
			<input type="checkbox" value="b" name="<%=glCode %>" id="slt" />
			<input type="checkbox" value="c" name="<%=glCode %>" id="slt" />
			<input type="checkbox" value="d" name="<%=glCode %>" id="slt" />
			<input type="checkbox" value="e" name="<%=glCode %>" id="slt" />
			<input type="checkbox" value="f" name="<%=glCode %>" id="slt" />
			<input type="checkbox" value="g" name="<%=glCode %>" id="slt" />
			</div>
		</div>    
					<div id="groundList">
						<input type="hidden" value="<%=grdWeekdayTime %>" id="day<%=i %>" />
						<input type="hidden" value="<%=grdWeekEndTime %>" id="end<%=i %>" />
					</div>
                </div><!-- 여기까지가 post에 해당되는 div!!!!!!!!!!!!!!!!!!!!! -->
              
            </div>
<%
	}
}
%>
            <div id="more">
                <a href="more.groundReq"><h4>구장 더보기</h4></a>
            </div>
            
            
        </div>
    </div>

<script>
function open() {
	var grdNum = "<%=grdNum%>";
	for (var i = 0; i < grdNum; i++) {
		var sltBox = "slt" + i;
		var timeChk = document.getElementById(sltBox);
		var noTime = timeChk.value;
		var time = noTime.split("/");
		var revTime = time[0];
		var openTime = time[1];
		var timeName = timeChk.name;
		var slt = document.getElementsByName(timeName);
		for (var j = 1; j < slt.length; j++) {
			if (revTime.indexOf(slt[j].value) >= 0 || openTime.indexOf(slt[j].value) < 0) { 
				var boxName = slt[j].value + i;
				var box = document.getElementById(boxName);
				box.style.backgroundColor = "#c8eefe";
				box.innerHTML = "예약 불가";
			}
		}	
	}	
}
window.onload=open;
</script>	
<script>
function cngTime(val) {
	var glcode = val.id;
	var num = val.name;
	var date = val.value.substring(0, 10);
	var getTime = document.getElementById("getTime");
	getTime.src = "time.groundReq?glcode=" + glcode + "&date=" + date + "&num=" + num;
}

function getTime(revTime, date, dayType, num, glcode) {
	if (dayType == "1") {
		var openTime = document.getElementById("end" + num).value;
	} else {
		var openTime = document.getElementById("day" + num).value;
	}
	
	var slt = document.getElementsByName(glcode);
	for (var j = 1; j < 8; j++) {
		var boxName = slt[j].value + num;
		var box = document.getElementById(boxName);
		box.style.backgroundColor = "#c8eefe";
		box.innerHTML = "예약 불가";			
		if (openTime.indexOf(slt[j].value) >= 0) {
			box.style.backgroundColor = "#b4bbbe";
			box.innerHTML = "예약 가능";			
		}
		if (revTime.indexOf(slt[j].value) >= 0) {
			box.style.backgroundColor = "#c8eefe";
			box.innerHTML = "예약 불가";	

		}
	}	
}
</script>


</body>
</html>