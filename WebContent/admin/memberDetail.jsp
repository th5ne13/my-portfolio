<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>

<%
ArrayList<MemberInfo> memberList = (ArrayList<MemberInfo>)session.getAttribute("memberList");
// 공지사항 목록을 ArrayList에 담음(제네릭도 포함해서 작업해야 함)
int memnum = Integer.parseInt(request.getParameter("memnum"));
MemberInfo memInfo = (MemberInfo)memberList.get(memnum);

int mlnum = memInfo.getMl_num();
String id = memInfo.getMl_id(), name = memInfo.getMl_name();
String p1 = memInfo.getMl_phone().substring(0, 3), p2 = memInfo.getMl_phone().substring(4, 8), p3 = memInfo.getMl_phone().substring(9); 
String addr1 = memInfo.getMl_addr1(), addr2 = memInfo.getMl_addr2(), membertype = memInfo.getMl_membertype();
String position = memInfo.getMl_position(), question = memInfo.getMl_question(), answer = memInfo.getMl_answer();
int boardcnt = memInfo.getMl_boardcnt(), amountofpayment = memInfo.getMl_pay();
int recruitcnt = memInfo.getMl_recruitcnt(), applycnt = memInfo.getMl_applycnt(), revcnt = memInfo.getMl_revcnt();
System.out.println(position);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
</style>
</head>
<body>
<form name ="detailfrm" action="update.member?type=up" method="post" >
<input type="hidden" name="mlnum" value="<%=mlnum %>" />
<table width="800px" cellpadding="5" cellspacing="1" bgcolor="black">
<tr bgcolor="white"><th colspan="2">아이디</th><th colspan="3">이름</th></tr>
<tr bgcolor="white"><td colspan="2" align="center"><input type="text" name="id" value="<%=id %>" size="25" disabled="disabled"></td><td colspan="3" align="center"><input type="text" name="name" size="25" value="<%=name %>"></td></tr>
<tr bgcolor="white" align="left"><th colspan="5">연락처</th></tr>
<tr bgcolor="white">
<td><select name="p1">
	<option value="<%=p1 %>"><%=p1 %></option>
	</select></td>
<td colspan="2"><input type="text" name="p2" value="<%=p2 %>" size="10"></td><td><input type="text" name="p3" size="10" value="<%=p3 %>"></td>
<tr bgcolor="white" align="left"><th colspan="5">선호하는 풋살장 지역</th></tr>
<tr bgcolor="white">
<td colspan="5">
			<input type="button" onclick="sample4_execDaumPostcode()" value="주소 검색" />
			<input type="text" name="addr1" id="gu" placeholder="구" value="<%=addr1 %>" />
			<span id="guide" style="color:#999;display:none"></span>
			<input type="text" name="addr2" id="dong" placeholder="동" value="<%=addr2 %>" />
			<input type="hidden" id="sample4_extraAddress" placeholder="참고항목">
</td></tr>
<tr bgcolor="white" align="left"><th colspan="5">선호 포지션</th></tr>
<tr bgcolor="white" align="left">
<td><input type="checkbox" name="position" <% if (position.contains("A")) { %>checked="checked" <% } %> value="A"  />공격수</td>
<td><input type="checkbox" name="position" <% if (position.contains("B")) { %>checked="checked" <% } %> value="B"  />미드필더</td>
<td><input type="checkbox" name="position" <% if (position.contains("C")) { %>checked="checked" <% } %> value="C"  />수비수</td>
<td><input type="checkbox" name="position" <% if (position.contains("D")) { %>checked="checked" <% } %> value="D"  />골키퍼</td>
</tr>
<tr bgcolor="white" align="left"><th colspan="5">보안 질문 및 답변</th></tr>
<tr bgcolor="white" align="left"><td colspan="5">
	<p>
	<select name="question">
		<option value="좋아하는 과일은?">좋아하는 과일은?</option>
		<option value="좋아하는 축구선수의 이름은?">좋아하는 축구선수의 이름은?</option>
		<option value="좋아하는 축구팀은?">좋아하는 축구팀은?</option>
		<option value="졸업한 중학교의 이름은?">졸업한 중학교의 이름은?</option>
		<option value="가장 소중하게 생각하는 것은?">가장 소중하게 생각하는 것은?</option>
	</select></p>
</td></tr>
<tr bgcolor="white" align="center"><td colspan="5">
	<input type="text" name="answer" value="<%=answer %>" size="110">
</td></tr>
<tr bgcolor="white" colspan="4"><th>게시글 수 : <%=boardcnt %></th><th colspan="4" align="left">사용금액 : <%=amountofpayment %></th></tr>
<tr bgcolor="white" colspan="4"><th>용병모집횟수 : <%=recruitcnt %> </th><th colspan="4" align="left">용병지원횟수 : <%=applycnt %> </th></tr>
<tr bgcolor="white" colspan="4"><th>예약횟수 : <%=revcnt %></th><th colspan="4" align="left">구장제휴 : <%=membertype %> </th></tr>
</table><br />
<table width="800px">
<tr align="center"><td><input type="button" onclick="alert('회원을 강제 탈퇴시켰습니다.'); location.href='update.member?type=byforce&mlnum=<%=mlnum %>'" value="임의 탈퇴"></td></tr>
</table><br/>
<table width="800px">
<tr align="center">
<td><input type="button" onclick="window.close()" value="취소">&nbsp;&nbsp;&nbsp;<input type="submit" onclick="alert('수정이 성공적으로 완료 되었습니다');" value="수정"></td>
</tr>
</table>
</form>
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