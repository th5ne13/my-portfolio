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
       .btn {
       	margin-top :50px;
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
                <span>1:1 문의</span><i>1:1문의글을 작성해주세요.</i>
            </div>
            <div class="line"></div>
            
			<div id="maintable">
			
				<table width="820" cellspacing="0" cellpadding="0" align="center">
					<tr height="1" bgcolor="#b2acac"><td colspan="5"></td></tr>				
					<tr height="30">
						<th width="10%">질문유형</th>
						<th width="*">제목</th>
						<th width="13%">작성일</th>
						<th width="13%">상태</th>
					</tr>
					
		<%
		String lnk = "", qlCata = "", qlStatus = "답변 전";
		if (perList.size() > 0) {		// 공지사항 목록이 있으면
			for (int i = 0; i < perList.size(); i++) {
				PerBoardInfo perBoard = perList.get(i);
				lnk = "<a href='perView.board?num=" + perBoard.getQl_num() + "'>";
				String title = perBoard.getQl_title();
				if (title.length() > 25)	title = title.substring(0, 23) + "...";
				if (perBoard.getQl_cata().equals("a"))		qlCata = "입장문의";
				else if (perBoard.getQl_cata().equals("b"))	qlCata = "환불문의";
				else if (perBoard.getQl_cata().equals("c"))	qlCata = "구장문의";
				else if (perBoard.getQl_cata().equals("d"))	qlCata = "제휴신청문의";
				else if (perBoard.getQl_cata().equals("e"))	qlCata = "기타";
				if (perBoard.getQl_status().equals("y"))	qlStatus = "답변 완료";
		%>
					
					<tr height="1" bgcolor="#b2acac"><td colspan="5"></td></tr>
					<tr height="30" align="center">
						<td><span><%=qlCata %></span></td>
						<td align="center">&nbsp;<a href="perView.board?num=<%=perBoard.getQl_num() %>"><%=title %></a></td>
						<td><%=perBoard.getQl_date().substring(0, 10) %></td><td><%=qlStatus %></td>
					</tr>
					
		<%	
			}
		}
		else {							// 게시글 목록이 없으면
				out.println("<tr height='100'><th colspan='4'>1:1 문의사항이 없습니다.</th></tr>");
			 }
		%>			
					<tr height="1"><td colspan="5" bgcolor="#e6e0e0"></td></tr>
				</table>
				
				<table width="860" class="btn">
					<tr height="30"><td colspan="4" align="right" ><input type="button" value="질문하기" onclick="location.href='perIn.board?wtype=in'" /></td></tr>
				</table>				
			</div>            
   	 	</div>
	</div>
</body>
</html>