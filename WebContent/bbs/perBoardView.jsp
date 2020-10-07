<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>    
<%@ page import="vo.*"%>    
<%
//index 설정
request.setCharacterEncoding("utf-8");
MemberInfo memberInfo = (MemberInfo)session.getAttribute("memberInfo");
ArrayList<PerBoardInfo> perList = (ArrayList<PerBoardInfo>)request.getAttribute("perBoardList"); 
String groundRq = "구장제휴신청";
String glCode = "", mlid = "";
if (memberInfo != null)	mlid = memberInfo.getMl_id();

//perBoard 글 등록폼 설정

 
// perBoardView 설정
PerBoardInfo perBoardInfo = (PerBoardInfo)request.getAttribute("perBoardInfo");
String answer = perBoardInfo.getQl_answer();

String qlCata = "기타";
if (perBoardInfo.getQl_cata().equals("a"))		qlCata = "입장문의";
else if (perBoardInfo.getQl_cata().equals("b"))	qlCata = "환불문의";
else if (perBoardInfo.getQl_cata().equals("c"))	qlCata = "구장문의";
else if (perBoardInfo.getQl_cata().equals("d"))	qlCata = "제휴신청문의";

String memId = "", bodId = "";
boolean isLogin = false;
boolean isYou = false;
if (memberInfo != null) {
	isLogin = true;
	memId = memberInfo.getMl_id();
	bodId = perBoardInfo.getMl_id();
	if (memId.equals(bodId)) {
		isYou = true;
	}
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	 <!-- CSS STYLE -->
<style>
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
  	   td > span{
           color:blue;
       }
       
       #maintable {
       	margin-top:50px;
       	margin-left:30px;
       }
       tr:hover {
       background:#f8efef;
       }
       #sbox {
       margin-left:55px; 
       }
       .btn {
       		margin-left:635px;
       		margin-top : 20px;
       		margin-bottom: 100px;
       }
       #ans {
       text-align:center;
       margin-top:100px;
       border:1px solid #abeff6;
       }
</style><script>
function isUp() {
	var isYou = <%=isYou%>;
	var answer = "<%=answer %>";
	if (isYou) {
		if (answer != "null") {
			alert("이미 답변이 있는 글은 수정할 수 없습니다.");
		} else {
			location.href="perUp.board?wtype=up&num=<%=perBoardInfo.getQl_num()%>";			
		}
	}	
}

function isDel() {
	var isYou = <%=isYou%>;
	var answer = "<%=answer %>";
	if (isYou) {
		if (answer != "null") {
			alert("이미 답변이 있는 글은 삭제할 수 없습니다.");
		} else {
			if (confirm("정말 삭제 하시겠습니까?")) {
				location.href="perProc.board?wtype=del&num=<%=perBoardInfo.getQl_num()%>";
			}
		}
	}	
}
</script>
</head>
<body>
    <div class="container">
        <div class="left">
            <div class="logo"><a href="start.jsp"><img src="groundImg/logo.png" alt="" width="45%"></a></div>
          
            <div class="menu">
                <div><a href="list.reserve?mlid=<%=mlid%>" id="aa">예약 현황</a></div>
                <div><a href="list.request" id="ab" >용병 현황</a></div>
                <div><a href="per.board?mlid=<%=mlid%>">1:1 문의</a></div>
                <div><a href="member/outClause.jsp">회원탈퇴</a></div>
            </div>
        </div>
        <div class="right">
            <div class="right_left">
                <a href="list.notice?memberInfo=<%=memberInfo %>">용병 모집/지원 게시판</a>
                <a href="list.board?btype=d">국내 축구 게시판</a>
            </div>
            <div class="right_right">
                <a href="list.reserve?mlid=<%=mlid%>">마이 페이지</a>
                <a href="logout">로그아웃</a>
                <h3><%=mlid %> 님 환영합니다.</h3>
            </div>
            <div class="line"></div>
            <div class="text">
                <span>1:1 문의 답변</span>
            </div>
            <div class="line"></div>
            
			<div id="maintable">
				<form name="frmBoard" action="perProc.board" method="post" onsubmit="return chkCata(this.qlCata)" >

				<table width="800" class="perBoardForm" bgcolor="#abeff6">
				<tr align="left" bgcolor="white" height="40">
				<td width="15%">문의 제목</td>
				<td width="*"> [<%=qlCata %>] <%=perBoardInfo.getQl_title() %></td>
				</tr>
				<tr align="left" bgcolor="white" height="40">
				<td>문의 등록일</td>
				<td><%=perBoardInfo.getQl_date().substring(0, 10) %></td>
				</tr>
				<tr align="left" bgcolor="white" height="300">
				<td>문의 내용</td>
				<td><%=perBoardInfo.getQl_content().replace("\r\n", "<br />") %></td>
				</tr>
				</table>
				<div id="btn">

				</div>
				</form>	

				
		<table class="btn">
			<tr><td>
				<input type="button" value="수정" onclick="isUp();" />&nbsp;&nbsp;
				<input type="button" value="삭제" onclick="isDel();" />&nbsp;&nbsp;
				<input type="button" value="목록" onclick="location.href='per.board'" />&nbsp;&nbsp;
			</td></tr>		
		</table>
		<!-- 답변 div -->
<% if (answer != null) { %> 
		<div id="ans">
			<div width="200">답변일 : <%=perBoardInfo.getQl_adate().substring(0, 10) %></div>
			<div width="1000"><%=answer %></div>
<% } else { %>
			<div width="1200">※ 답변 작성 준비 중입니다.</div>
		</div>
<% } %>
		<!-- 답변 종료 -->				
				
				
						
			</div>            
			
   	 	</div>
	</div>
<!-- body 시작-->



</body>
</html>