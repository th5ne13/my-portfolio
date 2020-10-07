<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
// index 기본 설정
String mlid="";
MemberInfo memberInfo = (MemberInfo)session.getAttribute("memberInfo");
if (memberInfo != null)		mlid = memberInfo.getMl_id();
ArrayList<GroundListInfo> groundList = (ArrayList<GroundListInfo>)request.getAttribute("groundList");
String groundRq = "구장제휴신청";
String glCode = "";

String lnk, loginChk, lnk2, myPage = "";
String reqType = "in";


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

// 구장 예약 현황
ArrayList<GroundRevInfo> grdRevList = (ArrayList<GroundRevInfo>)request.getAttribute("grdRevList");

// 마이페이지
ArrayList<PlayerInfo> recruitList = 
(ArrayList<PlayerInfo>)request.getAttribute("recruitList");
MemberInfo mem = (MemberInfo)session.getAttribute("memberInfo");

PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
//페이징 관련 데이터들을 담은 인스턴스 생성
int rcount = pageInfo.getRcount();	// 전체 게시글 개수
int cpage = pageInfo.getCpage();	// 현재 페이지 번호
int mpage = pageInfo.getMpage();	// 전체 페이지 개수(마지막 페이지 번호)
int spage = pageInfo.getSpage();	// 시작 페이지 번호
int epage = pageInfo.getEpage();	// 끝 페이지 번호
String schType = pageInfo.getSchType();	// 검색조건
String keyword = pageInfo.getKeyword();	// 검색어
if (schType == null)	schType = "";
if (keyword == null)	keyword = "";

String args = "&schType=" + schType + "&keyword=" + keyword;

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
       	   margin-left:20px;
       	   margin-right:35px;
       	   font-style:serif;
           margin-top:30px;
           text-align: center;
           width:860px;
       }
       .table th{
           background:#ccc;
           color:black;
       }
       .table td{
           padding:3px;
      
       }
       .table span{
           color:orange;
       }

</style>
<script>
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
                <span>나의 용병 현황</span><i>용병 현황을 확인해 주세요.</i>
            </div>
            
            
            <div class="line"></div>
            <div class="no_1">
                <label for="aa"><div class="table">
                    <table border="1" width="860" cellspacing="0">
                        <tr><th colspan="9"><b>용병 모집 신청</b></th></tr>
                        <tr height="15"> 
                            <th>예약번호</th>
                            <th width="5%">형태</th>
                            <th>지점 구분</th>
                            <th>매치 일자</th>
                            <th width="10%">모집/지원</th>
                            <th width="5%">인원</th>
                            <th width="10%">작성자</th>
                            <th>신청일자</th>  
                            <th>신청상태</th>                                                                                    
                        </tr>
 <%

String memid = mem.getMl_id(); // 멤버 ID (로그인 ID)
String requestid = "", postid = "", matchtype = "", addr2 = "";
int recruitnum = 0, cnt = 0; // i의 카운트를세기위한 cnt변수 선언
String postname = "", postdate = "", matchdate = "";
String reqnum = "", resnum = "";
String reqstatus = "";	String resstatus = "";
String btnChk = "";	String restype = "";
String restypename = "";
int count = 1;
int countchk = 0;
int ssibal = 0;

	int num = rcount - (cpage - 1) * 10;
	for (int i = 0 ; i < recruitList.size() ; i++) {
		if (i == recruitList.size() - 1)	ssibal = 1;
		PlayerInfo notice = (PlayerInfo)recruitList.get(i);
		requestid = notice.getMl_id();				matchdate = notice.getReq_matchdate().substring(0, 10);
		postid = notice.getReq_postid();			matchtype = notice.getReq_matchtype();
		recruitnum = notice.getReq_recruitnum();	addr2 =	notice.getReq_addr2();			
		postname = notice.getReq_postname();		postdate = notice.getReq_date().substring(0, 10);
		reqnum = notice.getReq_num();				resnum = notice.getRes_num();
		reqstatus = notice.getReq_status();			resstatus = notice.getRes_status();
		restype = notice.getRes_type();
		
		if (restype.equals("R")) {
			restypename = "모집";
		} else {
			restypename = "지원";
		}
		
		if (reqstatus.equals("W")) {
			btnChk = "수락대기중";
		} else if (reqstatus.equals("Y")) {
			btnChk = "승인됨";
			
		} else {
			btnChk = "마감됨";
		}	
		
		if (memid.equals(requestid) && restype.equals("R")) {
			count = 0;
%>
                                       
                        <tr height="10">
                        
							<td><%=reqnum %></td>
							<td><%=matchtype %></td>
							<td><span><%=addr2 %></span></td>
							<td><%=matchdate %></td>
							<td><%=restypename %></td>
							<td><%=recruitnum %></td>
							<td><%=postid %>(<%=postname %>)</td>
							<td><%=postdate %></td>
							<td align="center"><input type="button" name="btn1" value="<%=btnChk %>" disabled="disabled"/>
								<input type="button" onclick="location.href='del.request?type=del&btntype=C&reqnum=<%=reqnum %>'" <%if(btnChk.equals("승인됨"))%>	disabled="disabled" <%  %> name="btn2" value ="취 소"></td>
                        </tr>    
<%

		} else if(!memid.equals(requestid) && !restype.equals("R")) {
			countchk = 1;	
			if (count == 1 && countchk > 0 && ssibal == 1) {
			%><tr><td colspan="9">용병 모집 신청이 없습니다.</td></tr><% 						
			}
		}
		System.out.println("1 : " + countchk);
		System.out.println("2 : " + count);
		System.out.println("3 : " + ssibal);
	}  
	// 첫번째 for문 종료, 두번째시작
%>    
					                                 
                    </table><br />
                    <table border="1" cellspacing="0" width="860">
                    
                        <tr><th bgcolor="black" colspan="9"><b>용병 지원 신청</b></th></tr>
                        <tr bgcolor="black">
                            <th>예약번호</th>
                            <th width="5%">형태</th>
                            <th>지점 구분</th>
                            <th>매치 일자</th>
                            <th width="10%">모집/지원</th>
                            <th width="10%">작성자</th>
                            <th>신청일자</th>  
                            <th>신청상태</th>                                                                                    
                        </tr>  
				<%	
					
	for (int i = 0 ; i < recruitList.size() ; i++) {
		PlayerInfo notice2 = (PlayerInfo)recruitList.get(i);
		requestid = notice2.getMl_id();				matchdate = notice2.getReq_matchdate();
		postid = notice2.getReq_postid();			matchtype = notice2.getReq_matchtype();
		recruitnum = notice2.getReq_recruitnum();	addr2 =	notice2.getReq_addr2();			
		postname = notice2.getReq_postname();		postdate = notice2.getReq_date();
		reqnum = notice2.getReq_num();				resnum = notice2.getRes_num();
		reqstatus = notice2.getReq_status();		resstatus = notice2.getRes_status();
		restype = notice2.getRes_type();
		
		if (restype.equals("R")) {
			restypename = "모집";
		} else {
			restypename = "지원";
		}
		
		if (reqstatus.equals("W")) {
			btnChk = "수락대기중";
		} else if (reqstatus.equals("Y")) {
			btnChk = "승인됨";
			
		} else {
			btnChk = "마감됨";
		}
		if (memid.equals(requestid) && restype.equals("A")) {		
		
%>                        
                        <tr>
							<td><%=reqnum %></td>
							<td><%=matchtype %></td>
							<td><span><%=addr2 %></span></td>
							<td><%=matchdate %></td>
							<td><%=restypename %></td>
							<td><%=postid %>(<%=postname %>)</td>
							<td><%=postdate %></td>
							<td align="center"><input type="button" name="btn1" value="<%=btnChk %>" disabled="disabled"/>
							<input type="button" onclick="location.href='del.request?type=del&btntype=C&reqnum=<%=reqnum %>'" <%if(btnChk.equals("승인됨"))%>	disabled="disabled" <%  %> name="btn2" value ="취 소"></td>
                        </tr>   
<%
	} 
}	
%>                        
                        </table><br />   <!-- 세번째시작 -->
                         	
                    <table border="1" cellspacing="0" width="860">
                    
                        <tr><th colspan="8"><b>용병 모집 요청받음</b></th></tr>
                        <tr height="10">
                        
                            <th>No</th>
                            <th width="5%">형태</th>
                            <th>지점 구분</th>
                            <th>매치 일자</th>
                            <th width="10%">모집/지원</th>
                            <th width="7%">요청자</th>
                            <th>작성일자</th>
                            <th>요청상태</th>                                                                                  
                        </tr>  
<%	
	
	for (int i = 0 ; i < recruitList.size() ; i++) {
		PlayerInfo notice3 = (PlayerInfo)recruitList.get(i);
		requestid = notice3.getMl_id();				matchdate = notice3.getReq_matchdate();
		postid = notice3.getReq_postid();			matchtype = notice3.getReq_matchtype();
		recruitnum = notice3.getReq_recruitnum();	addr2 =	notice3.getReq_addr2();			
		postname = notice3.getReq_postname();		postdate = notice3.getReq_date();
		reqnum = notice3.getReq_num();				resnum = notice3.getRes_num();
		reqstatus = notice3.getReq_status();		resstatus = notice3.getRes_status();
		restype = notice3.getRes_type();		
		
		if (restype.equals("R")) {
			restypename = "모집";
		} else {
			restypename = "지원";
		}
			
		
		if (reqstatus.equals("W")) {
			btnChk = "수락";
		} else if (reqstatus.equals("Y")) {
			btnChk = "수락함";
			
		} else {
			btnChk = "거절함";		
		}
		if (memid.equals(postid) && restype.equals("R")) { 
		
%>	
						<tr height="10">
							<td><%=resnum %></td>
							<td><%=matchtype %></td>
							<td><span><%=addr2 %></span></td>
							<td><%=matchdate %></td>
							<td><%=restypename %></td>
							<td><%=requestid %></td>
							<td><%=postdate %></td>
							<td align="center">
							<input type="button" <% if(btnChk.equals("수락함") || btnChk.equals("거절함")) %> { disabled="disabled" } <%  %> name="btn3" 
							onsubmit="this.style.background='yellow'" onclick="location.href='up.request?type=up&btntype=A&reqnum=<%=reqnum %>'" value ="<%=btnChk %>">
							
							<input type="button" <% if(btnChk.equals("수락함") || btnChk.equals("거절함")) %> { disabled="disabled" } <%  %> name="btn4" 
							onclick="location.href='up.request?type=up&btntype=D&reqnum=<%=reqnum %>'" value ="거 절"></td>
						</tr>
<%			
		}
	} // 세번째 for문 종료
	
%>
					</table><br /> <!-- 네번째 시작 -->
                    <table border="1" cellspacing="0" width="860">
                    
                        <tr><th colspan="8"><b>용병 지원 요청받음</b></th></tr>
                        <tr>
                            <th>No</th>
                            <th width="5%">형태</th>
                            <th>지점 구분</th>
                            <th>매치 일자</th>
                            <th width="10%">모집/지원</th>
                            <th width="7%">요청자</th>
                            <th>작성일자</th>
                            <th>요청상태</th>                                                                                  
                        </tr>  
<%	

	for (int i = 0 ; i < recruitList.size() ; i++) {
	PlayerInfo notice4 = (PlayerInfo)recruitList.get(i);
	requestid = notice4.getMl_id();				matchdate = notice4.getReq_matchdate();
	postid = notice4.getReq_postid();			matchtype = notice4.getReq_matchtype();
	recruitnum = notice4.getReq_recruitnum();	addr2 =	notice4.getReq_addr2();			
	postname = notice4.getReq_postname();		postdate = notice4.getReq_date();
	reqnum = notice4.getReq_num();				resnum = notice4.getRes_num();
	reqstatus = notice4.getReq_status();		resstatus = notice4.getRes_status();
	restype = notice4.getRes_type();
	
		if (restype.equals("R")) {
			restypename = "모집";
		} else {
			restypename = "지원";
		}
		
		if (reqstatus.equals("W")) {
		btnChk = "수락";
		} else if (reqstatus.equals("Y")) {
		btnChk = "수락함";
		
		} else {
		btnChk = "거절함";
		
		}

		if (memid.equals(postid) && restype.equals("A")) { 
%>
						<tr>
							<td><%=resnum %></td>
							<td><%=matchtype %></td>
							<td><span><%=addr2 %></span></td>
							<td><%=matchdate %></td>
							<td><%=restypename %></td>
							<td><%=requestid %></td>
							<td><%=postdate %></td>
							<td align="center">
							<input type="button" <% if(btnChk.equals("수락함") || btnChk.equals("거절함")) %> { disabled="disabled" } <%  %> name="btn3" 
							onsubmit="this.style.background='yellow'" onclick="location.href='up.request?type=up&btntype=A&reqnum=<%=reqnum %>'" value ="<%=btnChk %>">
							
							<input type="button" <% if(btnChk.equals("수락함") || btnChk.equals("거절함")) %> { disabled="disabled" } <%  %> name="btn4" 
							onclick="location.href='up.request?type=up&btntype=D&reqnum=<%=reqnum %>'" value ="거 절"></td>
						</tr>
			<%
		} 	
	} // 마지막 for문 종료	
%>					
					</table><br /><br /><br /><br />	
				                                                     
                </label></div>
            </div>
            
    </div>
</body>

</html>