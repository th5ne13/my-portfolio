<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>

<%

request.setCharacterEncoding("utf-8");
String wtype = request.getParameter("wtype");
String btn = "등록";

String glCode = "";
String img1 = "", glcode = "", area = "";
String address = "", glgrdname = "";

int cnt = 1;

ArrayList<GroundListInfo> groundlist = 
(ArrayList<GroundListInfo>)session.getAttribute("groundList");
String smallcata = "", bigcata = "";

for (int i = 0 ; i < groundlist.size() ; i++) {
	GroundListInfo grdInfo = (GroundListInfo)groundlist.get(i);
	address = grdInfo.getGl_code().substring(0, 2);
	glgrdname = grdInfo.getGl_grdname();

	area="강남구";
	cnt = cnt + 1;
	bigcata = bigcata + "," + grdInfo.getGl_jibeon().substring(3, 6);
	smallcata = smallcata + "," + grdInfo.getGl_grdname(); 

}

int rlnum = 0, recruitnum = 0;
String phone = "", phone1 = "", phone2 = "", phone3 = "", addr1 = "", addr2 = "", matchtype = "", rlname = "", matchdate = "", matchtime = "", level = "", isend = "", content = "";
String position = "";

if (session.getAttribute("memberInfo") == null) {
	out.println("<script>");
	out.println("alert('잘못된 경로로 들어 오셨습니다.');");
	out.println("history.back();");
	out.println("</script>");
}
MemberInfo mem = (MemberInfo)session.getAttribute("memberInfo");

String mid = mem.getMl_id();

String args = "", cpage = "", schType = "", keyword = "";
if (wtype.equals("up")) {	// 공지사항 수정일 경우
	btn = "수정";
	RnoticeInfo rnoticeInfo = (RnoticeInfo)request.getAttribute("rnoticeInfo");	
    phone = rnoticeInfo.getRl_phone();
    phone1 = phone.substring(0, 3);
    phone2 = phone.substring(3, 7);
    phone3 = phone.substring(7);

	rlname = rnoticeInfo.getRl_name();
	rlnum = rnoticeInfo.getRl_num();
	recruitnum = rnoticeInfo.getRl_recruitnum();
	String id = rnoticeInfo.getMl_id();
	String date = rnoticeInfo.getRl_date();
	String isview = rnoticeInfo.getRl_isview();
	String ip = rnoticeInfo.getRl_ip();
	 addr1 = rnoticeInfo.getRl_addr1();
	 addr2 = rnoticeInfo.getRl_addr2();
	 matchtype = rnoticeInfo.getRl_matchtype();
	 matchdate = rnoticeInfo.getRl_matchdate();
	 matchtime = rnoticeInfo.getRl_matchtime();
	 level = rnoticeInfo.getRl_level();
	position = rnoticeInfo.getRl_position();
	 isend = rnoticeInfo.getRl_isend();
	 content = rnoticeInfo.getRl_content();


	cpage = (String)request.getAttribute("cpage");
	schType = (String)request.getAttribute("schType");
	keyword = (String)request.getAttribute("keyword");
	if (schType == null)	schType = "";
	if (keyword == null)	keyword = "";
	args = "?cpage=" + cpage + "&schType=" + schType + "&keyword=" + keyword;
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
  <style>

        .container{
            width: 100%;
        }
        header{
            width: 100%;
            height: 500px;
            background:red;
        }
        .btn{
            width: 100%;
            overflow: hidden;
        }
        .btn  a{
            float:left;
            border:1px solid black;
            width: 33.3333333%;
            padding:30px;
            background:#fff;
            color:#2C3C57;
            font-weight: bold;
            font-size:30px;
            text-decoration: none;
            box-sizing: border-box;
            text-align: center;
            border-top:none;
            transition: 1s;
        }
        .btn a:hover{
            background-color: #233D64;
            color:#fff;
        }
        .btn .active{
            color:#fff;
            background-color: #233D64;
        }
        .h1{
            clear: both;
            text-align: center;
            font-size:50px;
            font-weight: normal;
            color:#403D3F;
            margin-bottom:30px;
        }
        .line{
            height: 2px;
            width: 7%;
            background:#ccc;
            text-align: center;
            margin:0 auto;
        }
        .table_app{
            width: 65%;
            margin:0 auto;
            overflow: hidden;
        }
        .table_app h2{
            padding-left:px;
            font-weight: normal;
            font-size:30px;
        }
        .table_app h2:before{
            content: '\f274';
            font-family: "Font Awesome 5 Free";
            font-weight: 900;
            margin-right:20px;
            color:green;
        }
        .app_line{
            width: 100%;
            height: 2px;
            background:#353535;
        }
        .name{
            color:#353535;
            margin-top:20px;
        }
        .left_name{
            width: 50%;
            float:left;
            font-size: 20px;
            font-weight:700;
            margin-top:14px;
            margin-bottom:20px;
        }
        .right_name{
            width: 50%;
            float:left;
            font-size: 20px;
            font-weight:700;
            margin-top:14px;
            margin-bottom:20px;
        }
        input[type=text]{
            
        }
        select{
            display:block;
            height: 45px;
            width: 96%;
            border-radius: 0;
        }
        option{
            border-radius: 0;
        }
        .left_input{
        	float:left;
            width: 50%;
            margin-bottom:20px;
        }
        .right_input{
           	overflow:hidden;
            width: 50%;
            margin-bottom:20px;
        }
        .input_box2 input[type=text]{
            width: 94.5%;
            height: 39px;
        }
        .right_input > input[type=text]{
            width: 28%;
        }
        .input_box3 input[type=text]{
            width: 94.5%;
            height: 39px;
        }
        .input_box5  input[type=text]{
            width: 28.9%;
            margin-right:5px;
            height:39px;
        }
        .input_box5 input[type=text]:focus::placeholder{
            visibility: hidden;
        }
        .input_box6 input[type=text]{
            width: 94.5%;
            height: 39px;
        }
        .left_name_finish{
            float:none;
            width: 50%;
            font-size: 20px;
            font-weight:700;
            margin-top:14px;
            margin-bottom:20px;
            
        }
        .name_finish{
            color:#353535;
            margin-top:20px;
        }
        textarea{
            width: 97.5%;
            height: 200px;
        }
        textarea:focus::placeholder{
            visibility: hidden;
        }
        .app_line_finish{
            width: 100%;
            height: 2px;
            background:#353535;
            margin-top:50px;
            margin-bottom:50px;
        }
        .btn_finish{
            width: 70%;
            margin:0 auto;
            margin-bottom:100px;
            text-align: center;
        }
        .left_btn{
            display:inline-block;
            background:#2C3C57;
            width: 250px;
            padding:30px 40px;
            color:#fff;
            font-size:22px;
            margin-right:5px;
        }
        .right_btn{
            display:inline-block;
            background:#2C3C57;
            width: 250px;
            padding:30px 40px;
            color:#fff;
            font-size:22px;
        }
        .btn_finish a{
            text-decoration: none;
            transition:0.5s;
        }
        .btn_finish a:last-child{
            background:#868686;
        }
        .btn_finish a:nth-of-type(1):hover{
            background:#003F96;
        }
        .btn_finish a:nth-of-type(2):hover{
            background:#003F96;
        }
		label {
			margin:30px;
		}
		.right_input > .sel2 {
		width:145px;
		float:left;
		}
		.right_input > input {
		float:left;
		margin-left:15px;
		
		}
  </style>
</head>
<script type="text/javascript" src="/integration/calendar.js"></script>
<script>

function isDel() {
	if (confirm("정말 삭제하시겠습니까?")) {
		location.href="list.notice";
	}
}
function chkValue(frm) {
	var name = frm.name.value;	var phone2 = frm.phone2.value;
	var phone3 = frm.phone3.value;	var content = frm.content.value;

	if (name == ""){
		alert("이름을 입력하세요.");
		frm.name.focus();		return false;
	}
	if (phone2 == ""){
		alert("핸드폰번호 2번째 자리를 입력하세요.");
		frm.phone2.focus();		return false;
	}
	
	if (phone3 == ""){
		alert("핸드폰번호 3번째 자리를 입력하세요.");
		frm.phone3.focus();		return false;
	}
	
	if (content == ""){
		alert("내용을 간단히 입력하세요.");
		frm.content.focus();		return false;
	}
}

function chkCata(obj, target){
	var arrsmallcata = "<%=smallcata %>".split(",");
	var arrbigcata = "<%=bigcata %>".split(",");
	var x = obj.value;
	var s = document.getElementById("bigcata");
 	var bigcata = s.options[s.selectedIndex].value;

	
	for (var i = target.options.length - 1 ; i > 0 ; i--){
		target.options[i] = null;
	} // 지우는 과정 프로세스
	
	var arrsw = new Array();	
	var arrnum = new Array();
	var num = 0;
	for (var i = 0, j = 0 ; j < <%=cnt %> ; j++) {
		if (arrbigcata[j].indexOf(bigcata) != -1) {
			arrsw[i] = new Option(arrsmallcata[j], arrsmallcata[j]);
			i = i + 1;
			num = i;
		}
	}
	alert('성공');
	
	if (x != ""){
		var selArray = arrsw; 
		for (var i = 0 ; i < selArray.length ; i++){
			target.options[i] = new Option(selArray[i].value, selArray[i].text);
		}
		target.options[0].selected = true;
	}
}
</script>
<body>
<form name="frmNotice" action="proc.notice" method="post" onsubmit="return chkValue(this);" >
	<input type="hidden" name="num" value="<%=rlnum %>" />
	<input type="hidden" name="mid" value="<%=mid %>" />
	
	<input type="hidden" name="wtype" value="<%=wtype %>" />
	<input type="hidden" name="cpage" value="<%=cpage %>" />
	<input type="hidden" name="schType" value="<%=schType %>" />
	<input type="hidden" name="keyword" value="<%=keyword %>" />
    <div class="container">
        <header>
            <div class="menu"></div>
        </header>

        <section>
            <div class="btn">
                <a href="#" class="active">매치신청</a>
                <a href="#">용병모집</a>
                <a href="#">용병지원</a>
            </div>
            <h1 class="h1">매치신청</h1>
            <div class="line"></div>
        </section>
        <div class="table_app">
            <h2>매치신청</h2>
            <div class="app_line"></div>
            <div class="name">
                <div class="left_name">지점</div>
                <div class="right_name">구장선택</div>
            </div>
            <div class="input_box1">
                <div class="left_input">
                    <select class="sel1" name="addr1" id="bigcata" onchange="chkCata(this, this.form.addr2);" >
						<%
						
						ArrayList<String> list = new ArrayList<String>();
						if (groundlist.size() > 0) {
							for (int i = 0 ; i < groundlist.size() ; i++) {
								GroundListInfo grdInfo = (GroundListInfo)groundlist.get(i);
								glcode = grdInfo.getGl_code();
								address = grdInfo.getGl_code().substring(0, 2);
						
							}
							String[] arry  = {"종로구", "중구", "용산구", "성동구",	"광진구", "동대문구", "중랑구", "성북구", "강북구", "도봉구", "노원구", "은평구",
									 "서대문구", "마포구", "양천구", "강서구", "구로구", "금천구",	"영등포구",	"동작구", "관악구",	"서초구", "강남구",	"송파구", "강동구" };
							for(int i = 0 ; i < arry.length;i++){
							       if(!list.contains(arry[i])){ //포함되어 있나 없나 체크
							           list.add(arry[i]); // list에 arry[i]에 해당하는 값이 없으면 추가
							       }
							}
							System.out.println(addr1);
							System.out.println(addr2);
							for(int z = 0 ; z<list.size();z++){
							%>						
								<option value="<%=list.get(z) %>" 
								<% if (addr1.equals(list.get(z))) { %>selected="selected"<% } %>><%=list.get(z) %></option>
							<%
							}
						}
						%>	
                    </select>
                </div>
                <div class="right_input">
					<select name="addr2" id="">
						<option value="<%=addr2 %>" ><%=addr2 %></option>
					</select>
                </div>
            </div>
            <div class="name">
                <div class="left_name">신청자명</div>
                <div class="right_name">연락처</div>
            </div>
            <div class="input_box2">
                <div class="left_input">
					<input type="text" class="sel1" name="name" value="<%=rlname %>">
                </div>
                <div class="right_input">
					<select class="sel2" name="phone" id="">
						<option value="010" <% if (matchtype.equals("010")) { %>selected="selected"<% } %>>010</option>
						<option value="011" <% if (matchtype.equals("011")) { %>selected="selected"<% } %>>011</option>
						<option value="019" <% if (matchtype.equals("019")) { %>selected="selected"<% } %>>019</option>
					</select>	
					<input type="text" name="phone2" value=<%=phone2 %> >
					<input type="text" name="phone3" value=<%=phone3 %> >
                </div>
            </div>
            <div class="name">
                <div class="left_name">매치일정</div>
                <div class="right_name">시간선택</div>
            </div>
            <div class="input_box3">
                <div class="left_input">
					<input type="text" <% if (!(matchdate == null)) { %> value="<%=matchdate.substring(0, 10) %>" <% } %> name="matchdate" class="sel1" onclick="fnPopUpCalendar(matchdate, matchdate, 'yyyy-mm-dd')" />
                </div>
                <div class="right_input">
					<select name="matchtime" id="">
						<option value="A" <% if (matchtime.equals("A")) { %>selected="selected"<% } %>>08:00 ~ 10:00</option>
						<option value="B" <% if (matchtime.equals("B")) { %>selected="selected"<% } %>>10:00 ~ 12:00</option>
						<option value="C" <% if (matchtime.equals("C")) { %>selected="selected"<% } %>>12:00 ~ 14:00</option>
						<option value="D" <% if (matchtime.equals("D")) { %>selected="selected"<% } %>>14:00 ~ 16:00</option>
						<option value="E" <% if (matchtime.equals("E")) { %>selected="selected"<% } %>>16:00 ~ 18:00</option>
						<option value="F" <% if (matchtime.equals("F")) { %>selected="selected"<% } %>>18:00 ~ 20:00</option>
						<option value="G" <% if (matchtime.equals("G")) { %>selected="selected"<% } %>>20:00 ~ 22:00</option>
					</select>
                </div>
            </div>
            <div class="name">
                <div class="left_name">매치형태</div>
                <div class="right_name">모집인원 선택</div>
            </div>
            <div class="input_box4">
                <div class="left_input">
					<select name="matchtype" id="">
						<option value="5:5" <% if (matchtype.equals("5:5")) { %>selected="selected"<% } %>>5:5</option>
						<option value="6:6" <% if (matchtype.equals("6:6")) { %>selected="selected"<% } %>>6:6</option>
					</select>
                </div>
                <div class="right_input">
					<select name="recruitnum" id="">
						<option value="1" <% if (recruitnum == 1) { %>selected="selected"<% } %>>1</option>
						<option value="2" <% if (recruitnum == 2) { %>selected="selected"<% } %>>2</option>
						<option value="3" <% if (recruitnum == 3) { %>selected="selected"<% } %>>3</option>
						<option value="4" <% if (recruitnum == 4) { %>selected="selected"<% } %>>4</option>
						<option value="5" <% if (recruitnum == 5) { %>selected="selected"<% } %>>5</option>
						<option value="6" <% if (recruitnum == 6) { %>selected="selected"<% } %>>6</option>
						<option value="7" <% if (recruitnum == 7) { %>selected="selected"<% } %>>7</option>
						<option value="8" <% if (recruitnum == 8) { %>selected="selected"<% } %>>8</option>
						<option value="9" <% if (recruitnum == 9) { %>selected="selected"<% } %>>9</option>
						<option value="10" <% if (recruitnum == 10) { %>selected="selected"<% } %>>10</option>
					</select>
                </div>
            </div>
            <div class="name">
                <div class="left_name">모집 포지션</div>
                <div class="right_name">팀수준</div>
            </div>
            <div class="input_box5">
                <div class="left_input">
							<label for="">공격수&nbsp;&nbsp;<input type="checkbox" name="position" value="A"></label>
							<label for="">미드필더&nbsp;&nbsp;<input type="checkbox" name="position" value="B"></label><br>
							<label for="">수비수&nbsp;&nbsp;<input type="checkbox" name="position" value="C"></label>
							<label for="">골키퍼&nbsp;&nbsp;<input type="checkbox" name="position" value="D"></label>
                </div>
                <div class="right_input">
						<select name="level" id="">
							<option value="상" <% if (level.equals("상")) { %>selected="selected"<% } %>>상</option>
							<option value="중" <% if (level.equals("중")) { %>selected="selected"<% } %>>중</option>
							<option value="하" <% if (level.equals("하")) { %>selected="selected"<% } %>>하</option>
						</select>
                </div>
            </div>
            <div class="name">
                <div class="left_name">마감여부</div>
                <div class="right_name">비회원 비밀번호</div>
            </div>
            <div class="input_box6">
                <div class="left_input">
						<select class="sel1" name="isend" id="">
							<option value="y">가능</option>
							<option value="n">마감</option>
						</select>
                </div>
                <div class="right_input">
                    <input type="text">
                </div>
            </div>
            <div class="name_finish">
                <div class="left_name_finish">메모</div>
            </div>
            <div class="input_box7">
					<textarea class="tbox" rows="10" cols="100" name="content" ><%=content %></textarea>		
            </div>
            <div class="app_line_finish"></div>
            <div class="btn_finish">
                <a href="#" class="left_btn" onclick="isDel();">취소하기</a>
				<div class=right_btn><input type="submit" value="<%=btn %> 하기" /></div>
            </div>
        </div>
    </div>
</form>
</body>
</html>