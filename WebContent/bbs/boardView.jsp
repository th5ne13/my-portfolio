<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>    
<%@ page import="vo.*"%>    
<%
// index 설정
MemberInfo memberInfo = (MemberInfo)session.getAttribute("memberInfo");
request.setCharacterEncoding("utf-8");
ArrayList<PerBoardInfo> perList = (ArrayList<PerBoardInfo>)request.getAttribute("perBoardList"); 
String groundRq = "구장제휴신청";
String glCode = "", mlid = "";
if (memberInfo != null)	mlid = memberInfo.getMl_id();


// dAndIBoardList 글목록 뷰 설정
BoardInfo boardInfo = (BoardInfo)request.getAttribute("boardInfo");
ArrayList<ReplyInfo> replyList = (ArrayList<ReplyInfo>)request.getAttribute("replyList");

String memId = "", bodId = "", msg = "로그인 후 사용이 가능합니다.", brContent = "";
boolean isLogin = false;
boolean isYou = false;
if (memberInfo != null) {
	isLogin = true;
	msg = "댓글은 400자 내외로 작성해주세요.";
	memId = memberInfo.getMl_id();
	bodId = boardInfo.getMl_id();
	if (memId.equals(bodId)) {
		isYou = true;
	}
}

String cpage = "";
int blnum = boardInfo.getBl_num();
cpage = (String)request.getParameter("cpage");								// getParameter의 리턴타입은 항상 String
String schType = (String)request.getParameter("schType");
String keyword = (String)request.getParameter("keyword");
if (schType == null)	schType = "";
if (keyword == null)	keyword = "";
String btype = (String)boardInfo.getBl_boardtype();
String board = "국내축구 글 상세보기";
if (btype.equals("i")) {
	board = "해외축구 글 상세보기";
}

// String args = "?btype=" + btype + "&cpage=" + cpage + "&schType=" + schType + "&keyword=" + keyword;
String args = "?btype=" + btype;
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
        td > a {
        	color:black;
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
       }
       tr:hover {
       background:#f8efef;
       }
       .btn {
       	margin-top :50px;
       }
       .text {
       position:relative;
       left:20px; 
       top:20px;
       width:820px;
       }
       .std {
       position:absolute;
       overflow:auto;
       }
       #btn {
       margin-left:650px;
       margin-top:330px;
       
       }
       #btn2 {
       margin-left:40px;
       margin-top : 50px;
       }
       #subbtn {
       	margin-top:-20px;
       }

</style>
<script>

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
                <span><%=board %></span>
            </div>
            <div class="line"></div>
            
			<div id="maintable">
			
				<table width="820" cellspacing="0" cellpadding="0" align="center">
					<tr height="1" bgcolor="#b2acac"><td colspan="5"></td></tr>				
					<tr height="45">
						<th align="left" colspan="3">&nbsp;&nbsp;<%=boardInfo.getBl_title() %></th>
						<td width="25%"><%=boardInfo.getBl_date() %></td>
					</tr>
					<tr height="1" bgcolor="#b2acac"><td colspan="5"></td></tr>									
					<tr>
					<td height="45" align="left" colspan="3">&nbsp;&nbsp;글쓴이 : <b><%=mlid %></b></td>
					<td>조회수 <b><%=boardInfo.getBl_read() %></b></td>
					</tr>
							
					<tr height="1"><td colspan="5" bgcolor="#e6e0e0"></td></tr>
					<tr height="300" class="std">
					
					<td colspan="5" align="left" class="text"><%=boardInfo.getBl_content().replace("\r\n", "<br />") %></td>
					</tr>
					<tr height="1" bgcolor="#b2acac"><td colspan="5"></td></tr>									
					
				</table>
				
	<script>
	function isLogin() {
		var brContent = document.getElementById("brContent").value.trim();
		if (<%=isLogin %>) {
			if(brContent == "") {
				alert("댓글을 입력하세요.");
				return false;
			} else { return true; }
			
		} else {
			alert("댓글은 로그인 후 사용할 수 있습니다.");
			location.href="loginForm.jsp";
			return false;
		}
	}
	</script>				
				<div id="btn">
					<input type="button" value="수정" onclick="update();" />
					&nbsp;&nbsp;&nbsp;
	<script>
	function update() {
		if (<%=isLogin %>) {
			if (<%=isYou %>) {
				location.href="up.board<%=args %>&num=<%=boardInfo.getBl_num() %>"
			} else {
				alert("본인이 쓴 글만 수정이 가능합니다.");
			}
		} else {
			alert("로그인 후 수정이 가능합니다.");
			location.href="loginForm.jsp";
		}
	}
	
	function issDel() {
		if (confirm("정말 삭제 하시겠습니까?")) {
			location.href="proc.board?btype=<%=btype %>&wtype=del&num=<%=boardInfo.getBl_num() %>";
		}
	}
	</script>	
					
					<input type="button" value="삭제" onclick="issDel();" />
					&nbsp;&nbsp;&nbsp;
					<input type="button" value="목록보기" onclick="location.href='list.board<%=args %>';" />			
				</div>
				<div id="btn2">
	<form name="frmReply" action="replyIn.board" method="post" onsubmit="return isLogin();">
	<input type="hidden" name="wtype" value="replyIn" />
	<input type="hidden" name="blnum" value="<%=blnum %>" />
	<input type="hidden" name="brNum" value="" />
	<% if (schType != null && keyword != null) { %>
	<input type="hidden" name="mlid" value="<%=memId %>" />
	<% } %>
				
					<textarea name="brContent" id="brContent" name="brContent" cols="100" rows="5" placeholder="<%=msg %>" ></textarea></td>
		    		<input type="submit" id="subbtn" name="btn" value="댓글 달기" />
	</form>
				</div>
				
	<table width="870" class="replyList">
	<tr>
	<th width="15%">작성자</th>
	<th width="*">내용</th>
	<th width="15%">작성일</th>
	<th width="15%">상태</th>
	</tr>
	<%
	String lnk = "", qlCata = "", qlStatus = "답변 전";
	if (replyList.size() > 0) {		// 공지사항 목록이 있으면
		for (int i = 0; i < replyList.size(); i++) {
			ReplyInfo reply = replyList.get(i);
			lnk = "<a href='view.board?num=" + blnum + "'>";
			String wid = reply.getMl_id();
	%>
	<tr align="center" height="30">
	<td><%=wid %></td>
	<td align="left" class="c">&nbsp;&nbsp;<%=reply.getBr_content() %></td>&nbsp;&nbsp;
	<td><%=reply.getBr_date().substring(0, 10) %></td>
	<td>
	<%
	if (memId.equals(reply.getMl_id())) {
	%>
	<input type="hidden" id="<%=reply.getBr_num() %>" value="<%=reply.getBr_content() %>" />
	<script>
	function isUp(num) {
		var content = document.getElementById(num).value;
		document.frmReply.brContent.value = content;
		document.frmReply.brNum.value = num;
		document.frmReply.wtype.value = "replyUp";
		document.frmReply.btn.value = "댓글 수정";
		document.frmReply.action = "replyProc.board";
	}
	
	function isDel(num) {
		if (confirm("정말 삭제 하시겠습니까?")) {
			location.href="replyProc.board?wtype=replyDel&num=" + num + "&blnum=<%=boardInfo.getBl_num()%>";
		}	
	}
	</script>
	
	<input type="button" value="수정" onclick="isUp(<%=reply.getBr_num() %>);" />&nbsp;&nbsp;
	<input type="button" value="삭제" onclick="isDel(<%=reply.getBr_num()%>);" />
	<%	
	} else {
		out.println("노권한");
	}
	%>
	</td>
	</tr>
	<%	
		}
	}
		else {							// 댓글 목록이 없으면
			out.println("<tr height='100'><th colspan='4'>댓글이 없습니다.</th></tr>");
		}
	%>
	</table><br /><br />				
				
			</div>            
   	 	</div>
	</div>
	
<!-- body 시작-->

	
	

	<!-- 국/외 게시판 뷰 종료 -->
<!-- body 종료-->
</body>
</html>