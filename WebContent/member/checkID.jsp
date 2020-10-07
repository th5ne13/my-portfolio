<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="vo.MemberInfo"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
request.setCharacterEncoding("utf-8");
String uid1 = request.getParameter("ml_id");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!-- 사용자가 입력한 아이디를 받아 중복검사(DB작업)를 한 후 회원가입 페이지에 검사결과에 따른 작업을 처리하는 파일 -->
	<script>
	// 입력받은 문자열이 영문과 숫자, 언더바 만으로 이루어졌는지 여부를 검사하는 함수
		function isEngNum(str, chk) {
		// str : 글자단위로 검사할 문자열 / chk : 첫글자에 대한 영문사용을 검사할지 여부
			str = str.toLowerCase();
			// 받아온 문자열을 일괄적으로 소문자로 변환한 후 검사

			if (chk == "y") {	// 첫 글자가 영문인지 여부를 검사
				var c = str.charAt(0);	// 첫 글자 추출
				if (c < "a" || c > "z") {
					alert("아이디의 시작은 영문으로 해야합니다.");
					return false;
				}
			}
			// 한 글자씩 추출하여 검사하는 for문
			for (var i = 0; i < str.length ; i++) {
				var c = str.charAt(i);
				if (!((c >= "0" && c <= "9") || (c >= 'a' && c <= 'z') || c == "_")) {
					return false;
				}
			}
			return true;
		}
		var uid = parent.frmJoin.uid.value;
		var uid1 = "<%=uid1 %>";
		// id1 ~ id4까지의 아이디들과 비교 후 같으면 "이미 사용중인 아이디입니다." 라는 메시지를 빨간색으로 표시하고,
		// 다르면 "사용할 수 있는 아이디입니다." 라는 메시지를 파란색으로 표시

		var msg = "";
		if (uid == uid1) {
			msg = "<span id='redFont'>이미 사용중인 아이디입니다.</span>";
			parent.frmJoin.uniqueID.value = "C";

		} else if (!isEngNum(uid,"y")) {
			msg = "<span id='redFont'>아이디는 영문, 숫자 언더바의 조합으로 입력하세요.</span>";
			parent.frmJoin.uniqueID.value = "E"

		} else {
			msg = "<span id='blueFont'>사용할 수 있는 아이디입니다.</span>";
			parent.frmJoin.uniqueID.value = "Y";
		}

		var obj = parent.document.getElementById("idMsg");
		obj.innerHTML = msg;
	</script>
</head>
</html>