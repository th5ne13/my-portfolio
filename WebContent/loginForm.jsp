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
           background:grey;
           margin-bottom:3.5px;
           margin-top : 3.5px;
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
      
	   #a1 {
	   border-right:1px solid black;
	   margin-left:13px;
	   padding-right:15px;
	   font-weight:bold;
	   }
	   	   #a2 {
	   border-right:1px solid black;
	   padding-left: 5px;
	   padding-right:15px;
	   	   font-weight:bold;
	   
	   }
	   #a3 {
	   padding-left:8px;
	   	   font-weight:bold;
	   
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
            </div>
        </div>
        <div class="right">
            <div class="right_left">
<% if (memberInfo == null) { %>            
                <a href="list.notice?memberInfo=<%=memberInfo %>" onclick="alert('로그인 후 사용하실 수 있습니다.')">용병 모집/지원 게시판</a>
                <a href="list.board?btype=d" onclick="alert('로그인 후 사용하실 수 있습니다.')">국내 축구 게시판</a>
            </div>
<%} %>
            <div class="right_right">
                <a href="member/joinClause.jsp">회원 가입</a>
                <a href="#">로그인</a>
            </div>
 			<div class="loginimg"><img src="groundImg/12345.jpg"></div>
 
 			<div id="loginForm">
 				<div id="ltop"><img src="https://www.iamground.kr/img/logos/logo_red.png" alt=""></div>
 				<div id="lmid">
	         	<form action="member.login" method="post">
	         	아이디&nbsp;&nbsp;&nbsp;&nbsp;: 		
				<input class="inputText" type="text" name="uid" value="test1" placeholder="아이디" /><br />
				비밀번호 : 
				<input class="inputText" type="password" name="pwd" value="1234" placeholder="비밀번호" />
				<input class="btn" type="submit" value="로그인" /><br /><br />
				
				<div class="line"></div>
				<a id="a1" href="member/joinClause.jsp">회원가입</a>
				<a id="a2" href="member/idFind.jsp">아이디 찾기</a>
				<a id="a3" href="member/pwdFind.jsp">비밀번호찾기</a>	

				<br />		
				</form>
				</div>
				
         	</div>           
    </div>


</body>
</html>