<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>    
<%@ page import="vo.*"%>    
<%
//index 기본 설정
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

// 구장 예약 현황
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
           color:black;
           
       }
       .table td{
           padding:9px;
       }
       .table span{
           color:orange;
       }
</style>
<script>
function cancle(val) {
	var code = val.value;
	var cost = val.name;
	if (confirm("정말로 취소 하시겠습니까? 환불 금액은" + cost + "원 입니다.")) {
		location.href="del.reserve?mlid=<%=mlid%>&grcode=" + code + "&cost=" + cost;
	}
	
}
function idClick() {
	location.href = "idFind.jsp";
}
function pwdClick() {
	location.href = "pwdFind.jsp";
}
</script>
</head>
<body>
<% if (memberInfo == null) { 
		out.println("<script>");
		out.println("alert('로그인이 필요합니다.');");
		out.println("history.back();");
		out.println("</script>");
	}
%>
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
                <span>예약 현황</span><i>예약 현황을 확인해 주세요.</i>
            </div>
            <div class="line"></div>
            <div class="no_1">
                <label for="aa"><div class="table" width="1200px">
                    <table border="1" cellspacing="0">
                        <tr>
                        
                            <th>예약번호</th>
                            <th>예약신청일</th>
                            <th>사용일시</th>
                            <th>구장이름</th>
                            <th>가격</th>
                            <th>예약 취소</th>
                        </tr>
<%
if (grdRevList.size() == 0) {
%>                      <tr><td colspan="6"><h2>예약하신 구장이 없습니다.</h2></td></tr>
<% 
} else {
String grcode = "", grrevdate = "", grdate = "", grname = "", grstatus = "", cancle = "";
int grcost = 0; 
	for (int i = 0; i < grdRevList.size(); i++) {
		GroundRevInfo gri = (GroundRevInfo)grdRevList.get(i);
		grcode = gri.getGr_code();
		grrevdate = gri.getGr_revdate().substring(0, 10);
		grdate = gri.getGr_date() + gri.getRevtime();
		grname = gri.getGr_name();
		grcost = gri.getGr_cost();
		cancle = gri.getGr_cancle();
%>
                        <tr>
							<td><%=grcode %></td>
							<td><%=grrevdate %></td>
							<td><%=grdate %></td>
							<td><span><%=grname %></span></td>
							<td><%=grcost %></td>
							<td><% if (cancle.equals("n")) { %><button value="<%=grcode %>" name="<%=grcost %>" onclick="cancle(this);">취소하기</button> <% } else { %> 취소완료 <% } %></td>
                        </tr>
                        
                        
<% 	} 
}
%>
                    </table>
                </label></div>
            </div>
            
    </div>
</body>
</html>