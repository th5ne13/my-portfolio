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
String glCode = "";

//dAndIBoardList 설정
ArrayList<BoardInfo> boardList = (ArrayList<BoardInfo>)request.getAttribute("boardList");	
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
boolean login = false;
if (memberInfo != null)	login = true;

int rcount = pageInfo.getRcount();		// 전체 게시글 개수
int cpage = pageInfo.getCpage();		// 현제 페이지 번호
int mpage = pageInfo.getMpage();		// 전체 페이지 개수(마지막 페이지 번호)
int spage = pageInfo.getSpage();		// 시작 페이지 번호
int epage = pageInfo.getEpage();		// 끝 페이지 번호
String schType = pageInfo.getSchType();	// 검색 조건
String keyword = pageInfo.getKeyword();	// 검색어
if (schType == null)	schType = "";	// null일 경우 입력창에 null이 찍힐 수 있으므로 빈문자열로 바꿔줌
if (keyword == null)	keyword = "";
String btype = request.getParameter("btype");
String btn = "";
if (btype.equals("d"))	btn = "국내 축구";
else					btn = "해외 축구";


String args = "&schType=" + schType + "&keyword=" + keyword + "&btype=" + btype;

String mlid="";
MemberInfo mem = (MemberInfo)session.getAttribute("memberInfo");
if (mem == null) {
	out.println("<script>");
	out.println("alert('로그인 후 사용할 수 있습니다');");
	out.println("history.back();");
	out.println("</script>");
} else {	
	mlid = memberInfo.getMl_id();
}
ArrayList<GroundRevInfo> grdRevList = (ArrayList<GroundRevInfo>)request.getAttribute("grdRevList");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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
       #page {
       margin-top : 50px;
       }
       .btn > input {
       margin-top:-50px;
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
                <a href="list.board?btype=d">국내 축구 게시판</a>
                <a href="list.board?btype=i">해외 축구 게시판</a>
            </div>
            <div class="right_right">
                <a href="list.reserve?mlid=<%=mlid%>">마이 페이지</a>
                <a href="logout">로그아웃</a>
                <h3><%=mlid %> 님 환영합니다.</h3>
            </div>
            <div class="line"></div>
            <div class="text">
                <span><%=btn %> 게시판</span>
            </div>
            <div class="line"></div>
            
			<div id="maintable">
			
				<table width="820" cellspacing="0" cellpadding="0" align="center">
					<tr height="1" bgcolor="#b2acac"><td colspan="5"></td></tr>				
					<tr height="30">
						<th width="10%">번호</th>
						<th width="*">제목</th>
						<th width="13%">작성자</th>
						<th width="13%">작성일</th>
						<th width="13%">조회수</th>						
					</tr>
									
					<tr height="1" bgcolor="#b2acac"><td colspan="5"></td></tr>
<%
String lnk = "";
if (boardList.size() > 0) {		// 게시글 목록이 있으면
	int num = rcount - (cpage - 1) * 10;
	for (int i = 0; i < boardList.size(); i++) {
		String replyCnt = "";
		BoardInfo board = boardList.get(i);
		lnk = "<a href='view.board?cpage=" + cpage + args + "&num=" + board.getBl_num() + "'>";
		String title = board.getBl_title();
		if (title.length() > 25)	title = title.substring(0, 23) + "...";
		if (board.getBl_replycnt() > 0)	replyCnt = "(" + board.getBl_replycnt() + ")";
%>
		<tr align="center">
		<td height="30px"><%=num %></td>
		<td class="t">&nbsp;&nbsp;&nbsp;<%=lnk + title + "</a>" %> <%=replyCnt %></td>
		<td><%=board.getMl_id() %></td>
		<td><%=board.getBl_date().substring(2, 10) %></td>
		<td><%=board.getBl_read() %></td>
		</tr>
		<%		num--;
			}

		%>
			<tr height="1" bgcolor="#b2acac"><td colspan="5"></td></tr>		
		</table>

		<!-- 페이징 테이블 -->
		<div id="page">
			<table width="860">
			<tr align="center"><td>
	<%	
	lnk = "";
	if (cpage == 1) {
		out.println("<&nbsp;&nbsp;&nbsp;");
	} else {
		lnk = "<a href='list.board?cpage=" + (cpage - 1) + args + "'>";
		out.println(lnk + "< </a>&nbsp;&nbsp;&nbsp;");
	}
	
	// 숫자로 페이지 이동 버튼
	for (int i = 1; i <= mpage; i++) {
		lnk = "<a href='list.board?cpage=" + i + args + "'>";
		if (i == cpage) {
			out.println("&nbsp;&nbsp;<b>" + i + "</b>&nbsp;&nbsp;");
		} else {
			out.println("&nbsp;&nbsp;" + lnk + i + "</a>&nbsp;&nbsp;");
		}
	} 
			
			
	// 다음 페이지 이동버튼
	if (cpage == mpage) {
		out.println("&nbsp;&nbsp;&nbsp; > ");
	} else {
		lnk = "<a href='list.board?cpage=" + (cpage + 1) + args + "'>";
		out.println("&nbsp;&nbsp;&nbsp;" + lnk + "> </a>");
}
%>
	</td></tr>
	
	<%
	} else {							// 게시글 목록이 없으면
		out.println("<tr height='50'><th colspan='4'>'" + keyword + "'의 검색결과가 없습니다.</th></tr>");
	}
	%>
			</table>
			
			<table class="btn" width="860">
				<tr align="right"><td>
			
<script>
function isLogin() {
	if (<%=login %>) {	
		location.href="in.board?btype=<%=btype %>";
	} else {
		alert("로그인 후 사용하실 수 있습니다.");
		location.href="loginForm.jsp";		
	}
	
}
</script>
			
				<input type="button" value="글쓰기" onclick="isLogin();" />
				</td></tr>
			</table>
		
		</div>				
			</div>            
   	 	</div>
	</div>
	
</body>
</html>