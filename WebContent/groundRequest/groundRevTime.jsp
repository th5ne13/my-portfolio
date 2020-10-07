<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>    
<%
request.setCharacterEncoding("utf-8");
ArrayList<GroundRevInfo> grdRevList = (ArrayList<GroundRevInfo>)request.getAttribute("grdRevList");
GroundListInfo grd = (GroundListInfo)session.getAttribute("groundListInfo");
String revTime = "";
String grdTime = "";
final String[] WEEK_DAY = {"", "일", "월", "화", "수", "목", "금", "토"};

if (grdRevList != null) {
	for (int i = 0; i < grdRevList.size(); i++) {
		revTime += grdRevList.get(i).getGr_time();
	}
} 
String glcode = request.getParameter("glcode");
String date = (String)request.getAttribute("date");
int yy = Integer.parseInt(date.substring(0, 4));
int mm = Integer.parseInt(date.substring(5, 7));
int dd = Integer.parseInt(date.substring(8));
Calendar today = Calendar.getInstance();
Calendar sdate = Calendar.getInstance();
today.set(yy, mm-1, dd);
String now = new java.text.SimpleDateFormat("yyyy-MM-dd").format(today.getTime());
if (today.get(Calendar.DAY_OF_WEEK) == 1 || today.get(Calendar.DAY_OF_WEEK) == 7) {
	grdTime = grd.getGl_weekendtime();
} else {
	grdTime = grd.getGl_weekdaytime();
}
out.println(glcode);
out.println(date);

%>
<style>
#timeWrap { width:860px;}
.rev { width:105px; margin:0 auto; display: inline-block; float: center; background-color: #b4bbbe; margin-left:-4px; text-align: center; 
border-radius:3px;
border-left:1px dotted black;
border-right:1px dotted black
}
.time { width:105px; margin:0 auto; display: inline-block; float: center; margin-left: -7px; margin-right: 10px;
}
#last8 { display: inline-block; width: 1px; margin-left: -20px; }
#last7 { margin-right:-2px;}
#last6 { margin-right:-2px;}
#last5 { margin-right:-4px;}
#last4 { margin-right:-10px;}
#hidden { margin-top:1000px; display:none; }
</style>
<script type="text/javascript">
function open() {
	var box = document.getElementById("a");		cngBox(box);
	box = document.getElementById("b");			cngBox(box);
	box = document.getElementById("c");			cngBox(box);
	box = document.getElementById("d");			cngBox(box);
	box = document.getElementById("e");			cngBox(box);
	box = document.getElementById("f");			cngBox(box);
	box = document.getElementById("g");			cngBox(box);
}

window.onload=open;
</script>
<script>
function chkRev(id) {
	var id = id;
	var box = document.getElementById(id);
	var slt = document.getElementsByName("slt");
	if (box.innerHTML == "예약 불가") {
		alert("예약이 불가합니다.");	
	} else {
		if (box.style.backgroundColor == "red") {
			box.style.backgroundColor = "#b4bbbe";
			for (var i = 0; i < slt.length; i++) {
				if (slt[i].value == id) {
					slt[i].checked = false;
				}
			}
		} else { 		
			box.style.backgroundColor = "red";
			for (var i = 0; i < slt.length; i++) {
				if (slt[i].value == id) {
					slt[i].checked = true;
				}
			}
		}
		var num = 0;
		for (var i = 0; i < slt.length; i++) {
			if (slt[i].checked)	num++;
		}
		parent.cngMsg(num);
	}	
}
function cngBox(box) {
	var grdTime = "<%=grdTime%>";
	var time = "<%=revTime %>";	
	if (grdTime.indexOf(box.id) < 0) {
		box.style.backgroundColor = "#c8eefe";
		box.innerHTML = "예약 불가";
	}	
	if (time.indexOf(box.id) >= 0) {
		box.style.backgroundColor = "#c8eefe";
		box.innerHTML = "예약 불가";
	}	
}

function cngDate(val) {
	var date = val.value.substr(0, 10);
	var glcode = "<%=glcode %>";
	var now = document.getElementById("now");
	location.href="time.groundReq?glcode=" + glcode + "&date=" + date;
}
</script>
</head>
<body>
<div id="timeWrap">
	<div class="rev" id="a" onclick="chkRev(this.id);">예약 가능</div>
	<div class="rev" id="b" onclick="chkRev(this.id);">예약 가능</div>
	<div class="rev" id="c" onclick="chkRev(this.id);">예약 가능</div>
	<div class="rev" id="d" onclick="chkRev(this.id);">예약 가능</div>
	<div class="rev" id="e" onclick="chkRev(this.id);">예약 가능</div>
	<div class="rev" id="f" onclick="chkRev(this.id);">예약 가능</div>
	<div class="rev" id="g" onclick="chkRev(this.id);">예약 가능</div>
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
<input type="checkbox" value="a" name="slt" id="slt" />
<input type="checkbox" value="b" name="slt" id="slt" />
<input type="checkbox" value="c" name="slt" id="slt" />
<input type="checkbox" value="d" name="slt" id="slt" />
<input type="checkbox" value="e" name="slt" id="slt" />
<input type="checkbox" value="f" name="slt" id="slt" />
<input type="checkbox" value="g" name="slt" id="slt" />
</div>