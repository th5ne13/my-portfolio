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


String errMsg = null;
if (session.getAttribute("memberInfo") != null)			
	errMsg = "잘못된 경로로 들어 오셨습니다.";

if (errMsg != null) {
	out.println("<script>");
	out.println("alert('"+ errMsg +"');");
	out.println("history.back();");	
	out.println("</script>");
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	 <!-- CSS STYLE -->	 
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/reset.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css" />
<style>
	table {
		color:#000;
		font-size:75%;
		line-height:1.2;
		font-family:돋움, Dotum, 굴림, Gulim, sans-serif;
		background:url("../images/bg_body.gif") repeat-x;
	}
       body {
           margin:0; padding:0;
       }
       a{
           text-decoration: none;
           color:#fff;
       }
       .container {
           margin:0 auto;
           width:1200px;
           height:5000px;
           border:1px solid #cccccc;
           overflow:hidden;
       }
      .left{
          float:left;
          width: 300px;
          height:5000px;
          background:#be0436;
          
      }
      .logo{ margin: 16px 0 16px 16px;}
      .right{
          width: 900px;
          height: 5000px;
          float:left;
          background:#fff;
      }
      .menu > div{
          padding:20px;
          text-align: left;
          color:#fff;
          background:rgba(165, 42, 42, 0.4);
      }
      .menu > div > a{
          display:block;
      }
      .menu > div:hover{
          background:brown;
      }
      .right_left{
          float:left;
      }
      .right_left a{
          display:inline-block;
          width:180px;
          height: 50px;
          background:#ccc;
          text-align: center;
          line-height: 50px;
          border-radius: 5px;
          margin-left:20px;
          margin-top:15px;
      }
      .right_left > a:hover{
          background:red;
      }
      .right_right{
          float:right;
      }
      .right_right a{
          display:inline-block;
          color:black;
          margin-top:30px;
          margin-right:20px;
          font-weight: bold;
      }
      .line{
          clear: both;
          display:inline-block;
          width: 100%;
          height: 1px;
          background:red;
          margin-bottom:3.5px;
      }
      .text{
          margin-left:20px;
          margin-top:25px;
          margin-bottom:25px;
      }
      .text span{
          font-size: 22px;
      }
      .text i{
          font-style: normal;
          margin-left:10px;
          margin-bottom:5px;
          color:red;
      }
      .table{
      	   margin-left:60px;
      	   font-style:serif;
          margin-top:30px;
          text-align: center;
      }
      .table th{
          padding:5px 5px;
          background:#ccc;
          color:dodgerblue;
          
      }
      .table td{
          padding:9px;
      }
      .table span{
          color:orange;
      }
      #tandc {
      border:1px solid #c1bbbb;
      width:700px;
      height:400px;
      margin-left:100px;
      margin-top:70px;
      overflow:auto;
      
      }
      #cbox {
      position:relative;
      left:545px;
      top:20px;
      }
      #withreason {
      margin-top : 60px;
      margin-left:100px;
      padding-top : 20px;
      padding-left: 40px;
      
      overflow:hidden;
      width:660px;
      height:230px;
      border:1px solid #c1bbbb;
      }
      #withreason > h3 {
       margin-top : 70px;
      	float:left;
      	
      }
      ul {
           list-style:none;
      		float:left;
      }
      #btn {margin-left:650px;
      margin-top:50px;}
      
      .loginimg > img {
    	
      	width:100%;
      	height:360px;
      	margin-top:20px;
      }
      #loginForm {
      width:400px;
      height:240px;
      border-radius:25px;
      border:1px solid grey;
      background-color:#f4f0f0;
      margin:30px auto;
      	
      }
      #ltop > img {
      margin-top:28px;
      margin-left:42px;
      width:20%;
      height:33px;
      }
      #loginForm a {
      color:black;
      }
      #lmid {
      margin:30px 40px;
      
      }
      #lmid input:nth-child(1) {
      margin-left:-1px;
      }
      
      #lmid input[type=submit] {
      height:48px;
      position:absolute;
      margin-top:-23px;
      margin-left:10px;
      color:white;
      background-color:navy;
      }
   .btn {
   position:absolute;
   margin:110px 220px;
   overflow:hidden;
   }
   .btn input {
   width:150px;
   height:50px;
   background-color:navy;
   color:white;
   float:left;
   margin-left:50px;
   }
</style>
<script>
//입력받은 문자열이 영문과 숫자, 언더바 만으로 이루어졌는지 여부를 검사하는 함수
function isEngNum(str, chk) {
// str : 글자단위로 검사할 문자열 / chk : 첫글자에 대한 영문사용을 검사할지 여부
	str = str.toLowerCase();
	// 받아온 문자열을 일괄적으로 소문자로 변환한 후 검사

	if (chk == "y") {	// 첫 글자가 영문인지 여부를 검사
		var c = str.charAt(0);	// 첫 글자 추출
		if (c < "a" || c > "z") {
			alert("영문이 아닙니다");
			return false;
		}
	}
	// 한 글자씩 추출하여 검사하는 for문
	for (var i = 0; i < str.length ; i++) {
		var c = str.charAt(i);
		if (!((c >= "0" && c <= "9") || (c >= 'a' && c <= 'z') || c == "_")) {
			alert("영문");
			return false;
		}
	}
	return true;
}


// span태그로 아이디 4자 이상인지 나타내줌
function idChk(val) {
	if (val.length < 4) {
		var msg = document.getElementById("idMsg");
		msg.innerHTML = "<span id='redFont'>아이디는 4자 이상입력해야 합니다</span>";
	} else {
		var obj = document.getElementById("chkID");
		obj.src = "checkID.jsp?uid=" + val;
		// obj의 src값을 지정하여 사용자가 입력한 아이디로 검사한 결과를 가진 페이지를 iframe의 src로 호출함
		// 페이지 호출시 검사할 아이디를 get방식의 쿼리스트링으로 보냄
		/* var msg = document.getElementById("idMsg");
		msg.innerHTML = ""; */
	}
}

// 회원가입폼에 입력된 데이터들을 검사하여 서버로의 전송여부를 결정하는 함수
function chkValue(frmJoin) {
	var id = frmJoin.uid.value;
	var pw = frmJoin.pwd.value;
	var pw2 = frmJoin.pwd2.value;
	var uniqueID = frmJoin.uniqueID.value;
	var name = frmJoin.uname.value;
	var m2 = frmJoin.m2.value;
	var m3 = frmJoin.m3.value;
	var addr1 = frmJoin.addr1.value;
	var addr2 = frmJoin.addr2.value;
	
	// 아이디 검사
	if (id == "") {
		alert("아이디를 4자리이상 입력하세요.");
		frmJoin.uid.focus();
		return false;
	} else if (uniqueID != "Y") {	// 아이디 중복검사를 통과하지 못했을 경우
		var str = "";
		if (uniqueID == "N") {
			str = "아이디는 4자 이상입력해야 합니다.";
		} else if (uniqueID == "C") {
			str = "이미 사용중인 아이디입니다.";
		} else if (uniqueID == "E") {
			str = "영문, 숫자, 언더바의 조합으로만 입력하세요.";
		}
		alert(str);
		frmJoin.uid.focus();
		return false;
	}
	// 비밀번호검사
	if (pw == "") {
		alert("비밀번호를 입력하세요.");
		frmJoin.pwd.focus();
		return false;

	} else if (!isEngNum(pw, "n")) {
		alert("비밀번호는 영문, 숫자, 언더바의 조합으로만 입력하세요.");
		frmJoin.pwd.value = "";
		frmJoin.pwd.focus();
		return false;

	} else if (pw != pw2) {
		alert("비밀번호와 비밀번호 확인이 서로 다릅니다.");
		frmJoin.pwd.value = "";
		frmJoin.pwd2.value = "";
		frmJoin.pwd.focus();
		return false;
	}
	// 이름 공백검사
	if (name == "") {
		alert("이름을 입력하세요.");
		frmJoin.uname.focus();
		return false;
	}
	
	// m2는 세자리 이상의 숫자, m3는 네자리의 숫자인지 검사
	if (m2 == "" || m2.length < 3) {
		alert("휴대폰 번호 가운데 3자리이상을 입력하세요.");
		frmJoin.m2.select();
		frmJoin.m2.focus();
		return false;
	}
	if (m3 == "" || m3.length != 4) {
		alert("휴대폰 번호 마지막 4자리를 입력하세요.");
		frmJoin.m3.value = "";
		frmJoin.m3.focus();
		return false;
	}
	// 구, 동 검사
	if (addr1 == "") {
		alert("구를 입력하세요.");
		frmJoin.addr1.focus();
		return false;
	}
	if (addr2 == "") {
		alert("동을 입력하세요.");
		frmJoin.addr2.focus();
		return false;
	}
	return true;
}

//아이디 중복체크 화면open
function openIdChk() {
	window.name = "parentFrom";
	window.open("IdCheckForm.jsp", "chkForm", "width=500, height=300, resizable = no, scrollbars = no");
	// open("경로 및 파일명", "창이름", "옵션들-창의 너비와 높이, 창의 위치좌표값 등");
}

// 전화번호 숫자만 입력하게 함
function onlyNum(obj) {
	if (isNaN(obj.value)) {
		obj.value = "";		obj.focus();
	}
}
</script>
<style>
#redFont { color:red; font-weight:bold; }
#blueFont { color:blue; font-weight:bold; }
</style>
</head>
<body>
    <div class="container">
        <div class="left">
            <div class="logo"><a href="../start.jsp"><img src="../groundImg/logo.png" alt="" width="45%"></a></div>          
        </div>
        <div class="right">
            <div class="right_left">
<% if (memberInfo == null) { %>            
                <a href="../list.notice?memberInfo=<%=memberInfo %>" onclick="alert('로그인 후 사용하실 수 있습니다.')">용병 모집/지원 게시판</a>
                <a href="../list.board?btype=d" onclick="alert('로그인 후 사용하실 수 있습니다.')">국내 축구 게시판</a>
            </div>
<%} %>
            <div class="right_right">
                <a href="joinClause.jsp">회원 가입</a>
                <a href="../loginForm.jsp">로그인</a>
            </div>
 			<div class="loginimg"><img src="../groundImg/12345.jpg"></div>


	<div class="joinForm"><br /><br /><b class="now">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;회원가입 신청</b><br /><br />
	<iframe id="chkID" src="" frameborder="0" style="display:none;"></iframe>
	<form name="frmJoin" action="../in.join" method="post" onsubmit="return chkValue(this);">
	<input type="hidden" name="uniqueID" value="N" />
	<!-- 아이디 사용가능 여부를 검사하는 히든 컨트롤로 사용가능한 아이디 입력시 y로 값이 바뀜 -->
	<!-- 아이디 중복 검사 여부 및 통과 여부를 의미하는 값 
	N : 검사 안 함, C : 중복됨, Y : 사용할 수 있는 아이디-->	
		<table class="form">
			<tr>
				<th width="20%">아이디</th>
				<td width="*" valign="middle">
					<label for="uid"></label><input type="text" name="uid" maxlength="20" id="uid" value="green" onkeyup="idChk(this.value);" />&nbsp;&nbsp;&nbsp;
					<!-- <input type="button" value="아이디 중복 확인" onclick="openIdChk();"/> -->
				</td>
			</tr>
			<tr><td colspan="2"><span id="idMsg">아이디는 4~20자로 영문, 숫자 조합으로 입력하세요.</span></td></tr>
			<tr>
				<th>비밀번호</th>
				<td><label for="pwd"></label><input type="password" name="pwd" maxlength="20" id="pwd" /></td>
			</tr>
			<tr>
				<th>비밀번호 재확인</th>
				<td><label for="pwd2"></label><input type="password" name="pwd2" maxlength="20" id="pwd2" /></td>
			</tr>
			<tr>
				<th>이름</th>
				<td><label for="uname"></label><input type="text" name="uname" id="uname" /></td>
			</tr>
			<tr>
				<th>연락처</th>
				<td>
					<select name="m1">
					<option value="010" selected="selected">010</option>
					<option value="011">011</option>
					<option value="016">016</option>
					<option value="019">019</option>
				</select>
				-
				<input type="text" name="m2" id="" size="4" maxlength="4" value="1577" onkeyup="onlyNum(this);" />
				-
				<input type="text" name="m3" id="" size="4" maxlength="4" value="1577" onkeyup="onlyNum(this);" />
				</td>
			</tr>
			<tr>
				<th>선호하는 풋살장 지역</th>
				<td>					
					<input type="text" name="addr1" id="gu" placeholder="구" value="강남구" />&nbsp;
					<span id="guide" style="color:#999;display:none"></span>
					<input type="text" name="addr2" id="dong" placeholder="동" value="도곡동" />&nbsp;
					<input type="button" onclick="sample4_execDaumPostcode()" value="주소 검색" />&nbsp;&nbsp;	
					<input type="hidden" id="sample4_extraAddress" placeholder="참고항목">
				</td>
			</tr>
			<tr>
				<th>선호 포지션</th>
				<td>
					<input type="checkbox" name="position" id="forward" value="A" /><label for="forward">공격수</label>&nbsp;
					<input type="checkbox" name="position" id="midfielder" value="B" /><label for="midfielder">미드필더</label>&nbsp;
					<input type="checkbox" name="position" id="defender" value="C" /><label for="defender">수비수</label>&nbsp;
					<input type="checkbox" name="position" id="goalkeeper" value="D" /><label for="goalkeeper">골키퍼</label>
				</td>
			</tr>
			<tr>
				<th>질문</th>
				<td>
					<select name="question">
						<option value="fruits">좋아하는 과일은?</option>
						<option value="player">좋아하는 축구선수의 이름은?</option>
						<option value="team">좋아하는 축구팀은?</option>
						<option value="middleschool">졸업한 중학교의 이름은?</option>
						<option value="favorite">가장 소중하게 생각하는 것은?</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>답변</th>
				<td><input type="text" maxlength="30" name="answer" id="answer" value="사과" /></td>
			</tr>
		</table>
		<table class="btn">
			<tr>
				<td>
					<input type="button" value="취 소" onclick="location.href='../start.jsp'"/>&nbsp;&nbsp;&nbsp;
					<input type="submit" value="확 인" />
				</td>
			</tr>
		</table><br /><br />			
	</form>
	</div>																
        </div>
            
    </div>





<!-- body 시작-->
	<!-- 회원가입 시작 -->

	<!-- 회원가입 종료 -->



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

            var addr = data.jibunAddress.split(" ");
            document.getElementById("gu").value = addr[addr.length - 3];
            document.getElementById("dong").value = addr[addr.length - 2];
                     
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
</script>
</html>