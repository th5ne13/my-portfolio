<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>    
<%
request.setCharacterEncoding("utf-8");
MemberInfo memberInfo = (MemberInfo)session.getAttribute("memberInfo");
String mlid = "";
if (memberInfo != null) {
	mlid = memberInfo.getMl_id();
}
String wtype = request.getParameter("wtype");		// in : 등록
String btype = request.getParameter("btype");		// d : 국내축구, i : 해외축구
String board = "국내축구 게시판";
if (btype.equals("i"))	board = "해외축구 게시판";
String btn = "등록";

int blnum = 0;
String args = "", title = "", content = "", cpage = "", schType="", keyword="";

if (wtype.equals("up")) {
	btn = "수정";
	wtype = "up";
	BoardInfo boardInfo = (BoardInfo)request.getAttribute("boardInfo");
	blnum = boardInfo.getBl_num();
	title = boardInfo.getBl_title();
	content = boardInfo.getBl_content();
	cpage = (String)request.getParameter("cpage");
	schType = (String)request.getParameter("schType");
	keyword = (String)request.getParameter("keyword");
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
       #btn {
       		margin-left:660px;
       }
</style>
</style>
<script>
function login() {
	if (memberInfo != null) {
		alert("로그인 후 사용하실 수 있습니다.");
		location.href="../loginForm.jsp";
	} else {
		return true;
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
                <span><%=board %> <%=btn %></span>
            </div>
            <div class="line"></div>
  
			<div id="maintable">  
<form name="frmBoard" action="proc.board" method="post" onsubmit="return login()">
<input type="hidden" name="num" value="<%=blnum %>" />
<input type="hidden" name="wtype" value="<%=wtype %>" />
<input type="hidden" name="cpage" value="<%=cpage %>" />
<input type="hidden" name="schType" value="<%=schType %>" />
<input type="hidden" name="keyword" value="<%=keyword %>" />
<input type="hidden" name="btype" value="<%=btype %>" />
<input type="hidden" name="mlid" value="<%=mlid %>" />
				<table width="800" class="perBoardForm">
				<tr>
				<th width="15%">제목</th>
				<td width="*"><input type="text" name="title" size="110" value="<%=title %>" /></td>
				</tr>
				<tr>
				<th>내용</th>
				<td><textarea name="content" rows="20" cols="100" ><%=content %></textarea></td>
				</tr>
				</table>
				<div id="btn">
				<table class="btn">
				<tr><td align="center">
					<input type="submit" value="<%=btn %>" />
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" value="취소" onclick="history.back();" />
				</td></tr>
				</table>

</form>
</div>
</body>
</html>