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
String glCode = "", mlid = "" ; 
int rlNum = 0;
if (memberInfo != null)	mlid = memberInfo.getMl_id();

// 용병모집 게시판 기본설정
ArrayList<RnoticeInfo> rnoticeList = 
(ArrayList<RnoticeInfo>)request.getAttribute("rnoticeList");
MemberInfo mem = (MemberInfo)session.getAttribute("memberInfo");
if (mem == null) {
	out.println("<script>");
	out.println("alert('로그인 후 사용할 수 있습니다');");
	out.println("history.back();");
	out.println("</script>");
} else {	
	mlid = memberInfo.getMl_id();
}
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
int rcount = pageInfo.getRcount();
int cpage = pageInfo.getCpage();	
int mpage = pageInfo.getMpage();	
int spage = pageInfo.getSpage();	
int epage = pageInfo.getEpage();	
String schType = pageInfo.getSchType();
String keyword = pageInfo.getKeyword();
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
        .container{
            width: 100%;
        }

        header {
            width: 100%;
            height: 460px;
       
        }
        .btn{
            width: 100%;
            overflow: hidden;
        }
        .btn > a{
            float:left;
            border:1px solid black;
            width: 50%;
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
        .btn > a:hover{
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
        .table_wrap{
            width: 90%;
            margin:0 auto;
            overflow: hidden;
        }
        .right_btn{
            margin-top:70px;
            float:right;
        }
        .right_btn a{
            background:#233D64;
            padding:15px 10px;
            display:block;
            width: 220px;
            font-size: 18px;
            color:#fff;
            text-align: center;
            letter-spacing:5px;
            text-decoration: none;
            transition: 0.7s;
        }
        .right_btn a:hover{
            background:green;
        }
        .table_line{
            clear: both;
            height: 2px;
            width: 100%;
            background:#233D64;
            margin-top:140px;
        }
        table{
            width: 100%;
            border:none;
            border-bottom: #ccc;
            border-collapse: collapse;
        }
        table a{
            text-decoration: none;
            color:#fff;
            padding:5px 15px;
            background:#233D64;
            border-radius: 5px;
        }

        th{
            padding:15px;
            border-left:none;
            border-right:none;
        }
        td{ 
            padding:10px;
            text-align:center;
            border-left:none;
            border-right:none;
        }
        td a:hover{
            background:coral;
        }
        .search{
            margin:0 auto;
            text-align: center;
            margin-top:50px;
            margin-right:300px;
            margin-bottom:30px;
        }
        .search select{
            padding:7px 20px;
        }
        .search input[type=text]{
            padding:7px 20px;
            display:inline-block;
            height:16px;
            float:left;
            margin-right:170px;
            position:absolute;
            right:515px;
        }
        .search > .find{
            background:#233D64;
            display:inline-block;
            width: 100px;
            height: 34px;
            float:right;
            position: absolute;
            right:495px;
            color:#fff;
            text-decoration: none;
            line-height:34px;
        }
        .search > .find:hover{
            background:cornflowerblue;
        }
        .arrow{
            width: 100%;
            margin:0 auto;
            text-align: center;
            margin-bottom:100px;
        }
        .prev{
            display:inline-block;
            text-decoration: none;
        }
        .prev a{
            text-decoration: none;
            color:#000;
            padding:5px 10px;
            border:1px solid cornflowerblue;
            transition: 1s;
        }
        .prev a:hover{
            background:#000;
            color:#fff;
        }
        .numberr{
            display:inline-block;
            margin:10px;
        }
        .numberr a{
            color:#000;
            text-decoration: none;
            display:inline-block;
            margin:10px;
            border:1px solid #ccc;
            padding:5px 10px;
        }
        .numberr a:hover{
            border:1px solid dodgerblue;
        }
        .next{
            display:inline-block;
            text-decoration: none;
        }
        .next a{
            text-decoration: none;
            color:#000;
            padding:5px 10px;
            border:1px solid cornflowerblue;
            transition: 1s;
        }
        .next a:hover{
            background:#000;
            color:#fff;
        }
		#sbm > input {
            text-decoration: none;
            color:#fff;
            width:120px;
            padding:5px 15px;
            font-size:18px;
            background:#233D64;
            margin-left:590px;
            position:relative;
            bottom:35px;
		}
		#mp {

            width: 300px;
            height:100px;
            padding:30px;
            background:#fff;
            color:#2C3C57;
            font-weight: bold;
            font-size:20px;
            box-sizing: border-box;
            text-align: center;
            text-decoration:none;
			margin-left:1245px;
			margin-top:80px;
		}
		#mp > a {
			text-decoration:none;
		}			
</style>
<script>
</script>
</head>
<body>
    <div class="container">
        <header>
    		<a href="start.jsp">
    		<video src="groundImg/sub_03.mp4" muted autoplay="autoplay" loop="loop">1234</video>
    		</a>
            <div id="mp">
    			<a href="logout">로그아웃</a>&nbsp;&nbsp;
    			<a href="list.request">마이페이지</a>
    		</div>
        </header>
        <section>
            <div class="btn">
                <a href="list.notice" class="active">용병모집</a>
                <a href="list.anotice">용병지원</a>
            </div>
            <h1 class="h1">용병모집</h1>
            <div class="line"></div>
            <div class="table_wrap">
<%
int loginchk = 0;
String logid = "";
if (mem == null) {
	loginchk = 0;
} else {
	loginchk = 2;
	logid = mem.getMl_id();
}
%>	            
                <div class="right_btn">
                    <a href="#" onclick="javascript:if(<%=loginchk %> > 0) { location.href='in.notice'} else { alert('로그인하세요.'); location.href='loginForm.jsp' }">매치등록</a>
                </div>
                <div class="table_line"></div>
                <div class="table">
                    <table border="1">
                        <tr>
                            <th>지점구분</th>
                            <th>매치형태</th>
                            <th>매치일자</th>
                            <th>모집인원</th>
                            <th>작성자</th>
                            <th>작성일자</th>
                            <th>요청</th>
                        </tr>
                        
<%
String lnk = "";
if (rnoticeList.size() > 0) {
	int num = rcount - (cpage - 1) * 10;
	for (int i = 0 ; i < rnoticeList.size() ; i++) {
		RnoticeInfo notice = (RnoticeInfo)rnoticeList.get(i);

		String title = notice.getRl_content();
		if (title.length() > 500)	title = title.substring(0, 500) + "...";
		String isend = "신청가능";
		String upid = notice.getMl_id();

		String time = "";
		if (notice.getRl_matchtime().equals("A")) {
			time = "08:00 ~ 10:00";
		} else if (notice.getRl_matchtime().equals("B")) {
			time = "10:00 ~ 12:00";
		} else if (notice.getRl_matchtime().equals("C")) {
			time = "12:00 ~ 14:00";
		} else if (notice.getRl_matchtime().equals("D")) {
			time = "14:00 ~ 16:00";
		} else if (notice.getRl_matchtime().equals("E")) {
			time = "16:00 ~ 18:00";
		} else if (notice.getRl_matchtime().equals("F")) {
			time = "18:00 ~ 20:00";
		} else {
			time = "20:00 ~ 22:00";
		}		
		String name = notice.getRl_name();
		String addr = notice.getRl_addr1() + notice.getRl_addr2();
		String plan = notice.getRl_matchdate().substring(0, 10) + " " + time;
		String phone = notice.getRl_phone();
		String level = notice.getRl_level();
		String position = notice.getRl_position();
		String matchtype = notice.getRl_matchtype();
		String date = notice.getRl_date();
		int recruitnum = notice.getRl_recruitnum();		
		
		String chk = "";
		if (logid.equals(upid)) {
			chk = mem.getMl_pwd();
		}
		lnk = "'recruitView.jsp?cpage=" + cpage + args + 
				"&matchtype=" + matchtype + "&date=" + date + "&recruitnum=" + recruitnum + "&num=" + notice.getRl_num() + "&chk=" + chk + "&upid=" + upid + "&title=" + title + "&name=" + name + "&addr=" + addr + "&plan=" + plan + "&phone=" + phone + "&isend=" + isend + "&level=" + level + "&position=" + position + "'";
%>			
      
                        
                        <tr>
							<td class="title">
							<%=notice.getRl_addr2() %>
							</td>
							<td class="name"><%=notice.getRl_matchtype() %></td>
							<td class="date"><%=plan %></td>
							<td class="hit"><%=notice.getRl_recruitnum() %></td>
							<td><%=notice.getMl_id() %></td>
							<td><%=notice.getRl_date() %></td>
							<td><a href="#"
							onclick="window.open('view.request?btype=r&matchtype=<%=matchtype %>&date=<%=date %>&recruitnum=<%=recruitnum %>&cpage=<%=cpage %>&schType=<%=schType %>&keyword=<%=keyword %>&num=<%=notice.getRl_num() %>&chk=<%=chk %>&upid=<%=upid %>&title=<%=title %>&name=<%=name %>&addr=<%=addr %>&plan=<%=plan %>&phone=<%=phone %>&isend=<%=isend %>&level=<%=level %>&position=<%=position %>', '팝업창', 'width=1000, height=800'); 
							"><%=isend %></a></td>                     
						</tr>
<% 				
	}
}
%>							
                    </table>
					<form action="list.notice" method="get">
					<div class="search">
						<select name="schType">
							<option value="">검색 조건</option>
							<option value="matchtype" <% if (schType.equals("matchtype")) { %>selected="selected"<% } %>>매치형태</option>
							<option value="addr2" <% if (schType.equals("addr2")) { %>selected="selected"<% } %>>구장</option>
							<option value="tc" <% if (schType.equals("tc")) { %>selected="selected"<% } %>>매치형태 + 구장</option>
						</select>
						<input type="text" name="keyword" size="10" value="<%=keyword %>" />
						<div id="sbm">
						<input type="submit" value="검 색" />
						</div>
					</div><br />
                    
                    <div class="arrow">

                        <div class="numberr">

<%
lnk = "";
// 이전 페이지 이동 버튼
if (cpage == 1) {
	out.println(" < &nbsp;&nbsp;&nbsp;");
} else {
	lnk = "<a href='list.notice?cpage=" + (cpage - 1) + args + "'>";
	out.println(lnk + " < </a>&nbsp;&nbsp;&nbsp;");
}

for (int i = 1 ; i <= mpage ; i++) {
	lnk = "<a href='list.notice?cpage=" + i + args + "'>";
	if (i == cpage) {
		out.println("&nbsp;&nbsp;<b>" + i + "</b>&nbsp;&nbsp;");
	} else {
		out.println("&nbsp;&nbsp;" + lnk + i + "</a>&nbsp;&nbsp;");
	}
}

// 다음 페이지 이동 버튼
if (cpage == mpage) {
	out.println("&nbsp;&nbsp;&nbsp; > ");
} else {
	lnk = "<a href='list.notice?cpage=" + (cpage + 1) + args + "'>";
	out.println("&nbsp;&nbsp;&nbsp;" + lnk + " > </a>");
}
%>
                        </div>

                    </div>
                    </form>
                </div>
                </div>
            </div>
        </section>
    </div>

</body>
</html>