<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>    
<%@ page import="vo.*"%>    
<%
//index 기본 설정
String mlid = "";
MemberInfo memberInfo = (MemberInfo)session.getAttribute("memberInfo");
if (memberInfo == null) {
	out.println("<script>");
	out.println("alert('로그인 후 사용할 수 있습니다');");
	out.println("history.back();");
	out.println("</script>");
} else {	
	mlid = memberInfo.getMl_id();
}
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
       .table span{
           color:orange;
       }
       #tandc {
       border:1px solid #c1bbbb;
       width:700px;
       height:400px;
       margin-left:100px;
       margin-top:70px;
       overflow:auto;
       
       }
       #cbox {
       position:relative;
       left:545px;
       top:20px;
       }
       #withreason {
       margin-top : 60px;
       margin-left:100px;
       padding-top : 20px;
       padding-left: 40px;
       
       overflow:hidden;
       width:660px;
       height:230px;
       border:1px solid #c1bbbb;
       }
       #withreason > h3 {
        margin-top : 70px;
       	float:left;
       	
       }
       ul {
            list-style:none;
       		float:left;
       }
       #btn {margin-left:650px;
       margin-top:50px;}
</style>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function chkAgree(frm) {
	var isAgree = frm.isAgree;
	if (!isAgree.checked) {
		alert("약관에 동의하셔야 회원탈퇴가 가능합니다.");
		return false;
	}
	return true;
}
// 취소버튼을 눌렀을 때 메인화면으로 돌아가는 자바스크립트
function returnIndex() {
	location.href = "../start.jsp";
}
</script>
</head>
<body>
    <div class="container">
        <div class="left">
            <div class="logo"><a href="../start.jsp"><img src="../groundImg/logo.png" alt="" width="45%"></a></div>
          
            <div class="menu">
                <div><a href="../list.reserve?mlid=<%=mlid%>" id="aa">예약 현황</a></div>
                <div><a href="../list.request" id="ab" >용병 현황</a></div>
                <div><a href="../per.board?mlid=<%=mlid%>">1:1 문의</a></div>
                <div><a href="../member/outClause.jsp">회원탈퇴</a></div>
            </div>
        </div>
        <div class="right">
            <div class="right_left">
                <a href="../list.notice?memberInfo=<%=memberInfo %>">용병 모집/지원 게시판</a>
                <a href="../list.board?btype=d">국내 축구 게시판</a>
            </div>
            <div class="right_right">
                <a href="../list.reserve?mlid=<%=mlid%>">마이 페이지</a>
                <a href="../logout">로그아웃</a>
                <h3><%=mlid %> 님 환영합니다.</h3>
            </div>
            <div class="line"></div>
            <div class="text">
                <span>회원 탈퇴</span>
            </div>
            <div class="line"></div>
			<div id="tandc">
<제1장 총칙>
제1조(목적)
이 약관은 (주)아이엠그라운드(이하 "회사"라고 함)가 제공하는 게임 및 제반 서비스의 이용과 관련하여 회원과 회사 간의 조건 및 절차에 관한 기본적인 사항을 정함을 목적으로 합니다.

제2조(용어의 정의)
① 이 약관에서 사용하는 용어의 정의는 다음과 같습니다.
1. 이용 계약: 회사가 제공하는 서비스 이용과 관련하여 회사와 이용 고객 간에 체결하는 계약을 말합니다.
2. 회원: 회사가 제공하는 절차에 따른 가입 신청 및 이용 계약 체결을 완료한 뒤, ID를 발급받아 회사의 서비스를 이용할 수 있는 자를 말합니다.
3. ID: 회원 식별과 서비스 이용을 위하여 회원이 선정하고 회사가 승인하는 문자, 특수문자, 숫자 등의 조합을 말합니다.
4. 체험 ID: 회원 식별과 회사가 제공하는 특정 서비스를 이용하기 위하여 회원이 선정하고 회사가 승인하는 문자, 특수문자, 숫자 등을 말합니다.
5. PASSWORD(이하 "비밀번호"라고 함): 회원이 자신의 ID 또는 체험 ID와 일치하는 이용 고객임을 확인하기 위해 선정한 문자, 특수문자, 숫자 등의 조합을 말합니다.
6. 회원 탈퇴: 회원이 이용 계약을 해지함을 의미합니다.
7. 계정 : ID에 수반하여 게임 이용을 위해 회원이 별도로 생성하는 캐릭터, 게임 ID 등을 의미합니다.
② 이 약관에서 사용하는 용어의 정의는 제1항에서 정하는 것을 제외하고는 관계 법령 및 각 서비스 별 안내에서 정하는 바에 의합니다. 관계 법령과 각 서비스 별 안내에서 정하지 않는 것은 일반적인 상관례에 의합니다.
제3조(약관의 효력 및 적용과 변경)
① 회사는 이 약관의 내용을 회원이 알 수 있도록 회사에서 운영하는 홈페이지(www.nexon.com, 이하 "홈페이지"라 함)에 게시하거나 연결화면을 제공하는 방법으로 회원에게 공지합니다.
② 이 약관에 동의하고 회원 가입을 한 회원은 약관에 동의한 시점부터 동의한 약관의 적용을 받고 약관의 변경이 있을 경우에는 변경의 효력이 발생한 시점부터 변경된 약관의 적용을 받습니다. 이 약관에 동의하는 것은 정기적으로 홈페이지를 방문하여 약관의 변경 사항을 확인하는 것에 동의하는 것을 의미합니다.
③ 회사는 필요하다고 인정되는 경우 이 약관을 변경할 수 있습니다. 회사는 약관이 변경되는 경우에 변경된 약관의 내용과 시행일을 정하여, 그 시행일로부터 7일전 홈페이지에 온라인으로 공시합니다. 다만, 이용자에게 불리하게 약관 내용을 변경하는 경우에는 시행일로부터 30일전 홈페이지에 온라인으로 공시하거나 회원이 회원 가입 시 등록한 e-mail로 전송하는 방법으로 회원에게 고지합니다. 변경된 약관은 공시하거나 고지한 시행일로부터 효력이 발생합니다.
④ 회원은 변경된 약관에 대해 거부할 권리가 있습니다. 본 약관의 변경에 대해 이의가 있는 회원은 서비스 이용을 중단하고 회원 탈퇴를 할 수 있습니다. 회원이 변경된 이용약관의 시행일 이후에도 서비스를 계속 이용하는 경우에는 변경된 약관에 동의한 것으로 봅니다.
제4조(개인정보의 보호 및 사용)
① 회사는 관계법령이 정하는 바에 따라 이용자 등록정보를 포함한 이용자의 개인 정보를 보호하기 위해 노력합니다. 이용자의 개인 정보 보호 및 사용에 대해서는 관련 법령 및 회사의 개인정보처리방침이 적용됩니다. 단, 회사의 공식 사이트 이외의 링크된 사이트에서는 회사의 개인정보처리방침이 적용되지 않습니다.
② 회사는 이용자의 귀책 사유로 인해 노출된 이용자의 계정 정보를 비롯한 모든 정보에 대해서 일체의 책임을 지지 않습니다.
제5조(운영 정책)
① 회사는 약관을 적용하기 위해 필요한 사항과 회원의 권익을 보호하고 게임 세계 내 질서를 유지하기 위하여 약관에서 구체적 범위를 정하여 위임한 사항을 게임 서비스 운영 정책(이하 "운영 정책"이라고 함)으로 정할 수 있습니다.
② 회사는 운영 정책의 내용을 회원이 알 수 있도록 게임별 서비스 홈페이지(이하 "게임 홈페이지"라고 함)에 게시하거나 연결 화면을 제공하는 방법으로 회원에게 공지합니다.
③ 회원의 권리 또는 의무에 중대한 변경을 가져오거나 약관 내용을 변경하는 것과 동일한 효력이 발생하는 운영정책 개정의 경우에는 제3조 제3항의 절차에 따릅니다. 단, 운영정책 개정이 다음 각 호의 어느 하나에 해당하는 경우에는 본 조 제2항의 방법으로 사전에 공지합니다.
1. 약관에서 구체적으로 범위를 정하여 위임한 사항을 개정하는 경우
2. 회원의 권리·의무와 관련 없는 사항을 개정하는 경우
3. 운영정책의 내용이 약관에서 정한 내용과 근본적으로 다르지 않고 회원이 예측 가능한 범위 내에서 운영정책을 개정하는 경우
제6조(약관의 규정 외 사항에 관한 준칙)
이 약관에 규정 되지 않은 사항과 이 약관의 해석에 대해서는 회사가 정한 개별 서비스 이용약관, 운영정책 및 관계법령이 적용됩니다.

<제2장 서비스 이용 계약>
제7조(서비스 이용 신청 및 이용계약의 성립)
① 회사가 제공하는 서비스를 이용하고자 하는 자가 본 약관의 내용에 대하여 동의를 한 다음 회사가 제시하는 양식과 절차에 따라 이용 신청을 하고, 그 신청한 내용에 대해 회사가 승낙함으로써 회사와 이용자 간 이용 계약이 체결됩니다. 단, 신청자가 만 14세 미만인 경우 또는 만 18세 미만인 경우, 관련법에 따라 법정 대리인의 동의 절차를 각각 거쳐야만 이용 계약이 체결 됩니다.
② 이용자는 제1항의 이용 신청 시 반드시 본인의 실제 정보를 기재하여야 합니다. 이를 준수하지 않은 회원은 일체의 권리를 주장할 수 없으며, 관련법에 따라 처벌을 받을 수 있습니다.
③ 이용 계약이 성립되면 회사는 ID를 통해 회원에 대한 제반 관리 업무를 수행하며, 회원은 본 약관 및 게임별 운영정책, 회사가 설정한 규칙에 따라 서비스를 이용할 수 있습니다.
④ 회원은 회사가 정한 절차에 의해 ID를 생성할 수 있으며, 각 ID를 통해 당해 회사가 제공하는 서비스를 이용할 수 있습니다. 단, 회사가 제시하는 절차를 완료하지 않은 회원 및 실명 확인이 완료되지 않은 회원, 체험 ID는 일부 서비스 이용에 제한이 있을 수 있습니다.
⑤ 회사가 다른 회사와의 협력, 중개 계약을 통해 제공하는 서비스에 대한 내용, 제3자 회사의 의무, 이용자의 권리와 의무 등 상세 사항은 해당 서비스에 대하여 제3자가 제공하는 별도 약관, 운영정책 등에서 정하는 바에 따릅니다. 이용자가 해당 서비스를 이용할 경우, 제3자가 제공하는 서비스 이용 약관에 대한 동의가 필요할 수 있습니다.
제8조(이용신청에 대한 승낙의 제한)
① 회사는 이용 고객의 회원 신청에 대하여 업무상 또는 기술상의 문제가 없는 경우 서비스 이용을 승낙함을 원칙으로 합니다. 단, 회사는 다음 각 호에 해당하는 신청에 대하여는 승낙을 하지 않을 수 있습니다.
1. 본 약관 제 21조 제2항 각 호에서 금지하고 있는 사항을 위반하여 신청한 경우
2. 본 약관 제 23조 제6항에 의거, 재가입이 제한된 이용자에 해당되는 경우
3. 회원 탈퇴 후 1개월 이내 회원 가입을 재신청하려는 경우
4. 법에서 금지하는 위법 행위를 할 목적으로 이용 신청을 하는 경우
5. 기타 회원으로서 부적절한 행위를 할 우려가 있다고 인정되는 경우
② 회사는 다음 각 호의 경우에 원인이 해소될 때까지 승낙을 유보할 수 있습니다.
1. 회사의 설비에 여유가 없는 경우
2. 기술상 서비스를 처리하지 못할 장애 사항이 발생한 경우
3. 이용자가 관련 법령에 따른 법정 대리인 동의 등 필요한 절차를 완료하지 않은 경우
4. 회사가 제시하는 회원 가입 절차를 완료하지 않은 경우
5. 기타 회원으로서 부적절한 행위를 할 우려가 있다고 인정되는 경우
<제3장 서비스의 이용>
제9조(서비스의 이용개시)
① 회사는 이용 고객의 회원 가입을 승낙한 때부터 서비스를 개시합니다. 단, 일부 서비스의 경우에는 회사의 필요에 따라 지정된 일자부터 서비스를 개시하거나, 별도의 약관 체결이 필요한 경우 별도의 약관 동의를 포함한 관련 절차가 완료된 후 서비스를 개시할 수 있습니다.
② 회사의 업무상 또는 기술상의 장애로 인하여 서비스를 개시하지 못하는 경우에는 홈페이지 또는 개별 서비스 관련 홈페이지에 공지하거나 회원에게 이를 고지합니다.
③ 회사는 각 서비스 이용에 필요한 최소 또는 권장 기술 사양 정보를 각 서비스 별 홈페이지를 통해 제공합니다. 회원은 각 서비스 이용을 위해 기기 사양, 유무선 통신망의 품질 등이 해당 서비스 이용에 적합한지 여부를 확인하여야 합니다. 서비스 업데이트와 기술 발전 등의 환경 변화로 서비스 이용에 필요한 기술 사양 정보가 변경될 수 있으며, 회사는 기술 사양 정보의 변경으로 인한 책임을 부담하지 않습니다.
④ 회원은 서비스를 이용함에 있어 클라이언트 등 게임 플레이, 패치, 업데이트 등을 위한 목적으로 설치되는 프로그램(이하 "프로그램"이라고 함) 및 원활한 프로그램 구동을 위해 추가적으로 필요한 프로그램, 소프트웨어 등(이하 "부가 프로그램"이라고 함)의 설치가 필요할 수 있습니다. 프로그램 및 부가 프로그램의 설치는 회사가 제공하는 서비스를 이용하기 위해 필요한 사항으로, 설치되는 프로그램 용량 및 종류 등은 서비스 제공 내용에 따라 상이할 수 있으며, 이는 각 서비스별 홈페이지를 통해 안내합니다. 각 프로그램은 제어판>프로그램 추가/제거에서 선택하여 삭제할 수 있습니다.
제10조(서비스의 제공 및 중단 등)
① 회사는 회원에게 아래와 같은 서비스를 제공합니다.
1. 게임 서비스 및 게임에 부수되는 콘텐츠, 넥슨 캐시 등의 제반 서비스
2. 기타 회사가 자체 개발하거나 다른 회사와의 협력 계약 등을 통해 회원에게 제공하는 일체의 서비스
② 제1항 상의 각 서비스 및 제휴 서비스의 내용은 변경될 수 있으며, 이 경우 회사는 홈페이지, 각 서비스 별 홈페이지 및 제휴 서비스 홈페이지 등을 통해 이용자에게 공지합니다.
③ 각 서비스는 회사의 영업 방침에 따라 정해진 시간 동안 제공합니다. 회사는 서비스 제공 시간을 홈페이지 또는 게임 홈페이지 등을 통해 적절한 방법으로 안내 합니다. 단, 회사는 관련법령에 따라 만 16세 미만의 회원에게는 오전0시부터 오전6시까지 서비스 이용을 제한할 수 있으며, 만 18세 미만의 회원에게는 본인 또는 법정대리인의 요청에 따라 서비스 이용을 제한할 수 있습니다. 이 때, 연령 확인이 완료되지 않은 회원은 만 16세 미만 회원에 준하여 서비스 이용을 제한합니다.
④ 제3항에도 불구하고, 다음 각 호에 해당하는 경우, 일정 시간 동안 게임 서비스가 제공되지 아니할 수 있으며, 해당 시간 동안 회사는 게임 서비스를 제공할 의무가 없습니다.
1. 컴퓨터 등 정보통신설비의 보수점검, 교체, 정기점검 또는 게임 내용이나 게임서비스의 수정을 위하여 필요한 경우
2. 해킹 등의 전자적 침해사고, 통신사고, 회원들의 비정상적인 게임 이용행태, 미처 예상하지 못한 게임서비스의 불안정성에 대응하기 위하여 필요한 경우
3. 관련 법령에서 특정 시간 또는 방법으로 게임서비스 제공을 금지하는 경우
4. 천재지변, 비상사태, 정전, 서비스 설비의 장애 또는 서비스 이용의 폭주 등으로 정상적인 게임서비스 제공이 불가능할 경우
5. 회사의 분할, 합병, 영업양도, 영업의 폐지, 당해 게임서비스의 수익 악화, 당해 게임의 서비스 권한 상실 등 회사의 경영상 중대한 필요에 의한 경우
⑤ 회사는 제4항 제1호의 경우, 매주 또는 격주 단위로 일정 시간을 정하여 게임서비스를 중지할 수 있습니다. 이 경우 회사는 최소한 24시간 전에 그 사실을 회원에게 홈페이지나 게임 홈페이지에 공지합니다.
⑥ 제4항 제2호의 경우, 회사는 사전 고지 없이 게임서비스를 일시 중지할 수 있습니다. 회사는 이러한 경우 그 사실을 홈페이지나 게임 홈페이지에 사후 고지할 수 있습니다.
⑦ 회사는 회사가 제공하는 무료 서비스 이용과 관련하여 이용자에게 발생한 어떠한 손해에 대해서도 책임을 지지 않습니다. 다만, 회사의 고의 또는 중대한 과실로 인하여 발생한 손해의 경우는 제외합니다.
⑧ 회사는 회사가 제공하는 유료서비스 이용과 관련하여 회사의 귀책사유로 사전고지 없이 1일 4시간(누적시간) 이상 연속하여 서비스가 중지되거나 장애가 발생한 경우 계속적 이용 계약에 한하여 서비스 중지·장애시간의 3배에 해당하는 이용시간을 무료로 연장하고, 이용자는 회사에 대하여 별도의 손해배상을 청구할 수 없습니다. 다만, 회사가 서버점검 등의 사유로 서비스 중지·장애를 사전에 고지하였으나, 서비스 중지·장애시간이 10시간이 초과하는 경우에는 그 초과된 시간만큼 이용시간을 무료로 연장하고, 이용자는 회사에 대하여 별도의 손해배상을 청구할 수 없습니다.
⑨ 제4항 제3호 내지 제5호의 경우에 회사는 기술상․운영상 필요에 의해 게임서비스 전부를 중단할 수 있으며, 30일전에 홈페이지에 이를 공지하고 게임서비스의 제공을 중단할 수 있습니다. 사전에 통지할 수 없는 부득이한 사정이 있는 경우는 사후에 통지를 할 수 있습니다.
⑩ 회사가 제9항에 따라 게임서비스를 종료하는 경우 회원은 무료 서비스, 제 13조 2항에 따른 사용 기간이 남아 있지 않은 유료 서비스 및 유료 아이템, 계속적 유료 이용계약에 대하여 환불 및 손해배상을 청구할 수 없습니다.
제11조 (정보의 제공 및 수집 등)
① 회사는 다음의 사항을 게임 초기 화면이나 홈페이지에 회원이 알기 쉽게 표시합니다.
1. 상호
2. 게임물의 제명
3. 이용등급
4. 등급분류번호
5. 제작연월일
6. 게임물제작업자 또는 배급업자의 신고번호 또는 등록번호
7. 기타 회사가 필요하다고 인정하는 사항
② 회원에게 정보 등을 제공하는 경우 회사는 회원이 등록한 e-mail 주소로 고지하거나 또는 홈페이지에 공지하는 것으로 할 수 있습니다. 단, e-mail의 경우 해당 e-mail 서비스 제공사의 제한에 의해 개별통지가 불가한 경우 및 회원이 e-mail을 잘못 기재하여 등록한 경우 발생하는 문제에 대해서는 책임을 지지 않습니다.
③ 회사는 회사가 제공하는 서비스 내에서 이용자 간에 이루어지는 채팅 내용(대화, 귓말, 쪽지 등), 게임화면 등을 저장, 보관, 또는 열람할 수 있습니다. 회사는 이용자간의 분쟁 조정, 민원 처리 또는 게임 질서의 유지를 위하여 회사가 필요하다고 판단하는 경우에만 한정하여 해당 정보를 열람하도록 합니다. 해당 정보는 회사만이 보유하고 적법한 제3자 외에는 제공되지 않습니다. 자료 활용 시에는 활용이 필요한 이유 및 범위를 이용자에게 고지합니다. 다만, 계정도용, 현금거래, 언어폭력, 게임 내 사기 등 기망행위, 버그 악용, 기타 현행 법령 위반행위 및 이 약관 제20조에서 정하는 중대한 약관위반 행위의 조사, 처리, 확인 및 이의 구제와 관련하여 회원의 해당 정보를 열람해야 할 필요가 있는 경우에는, 사후에 해당 정보가 열람된 개인들에 대하여 열람한 사유와 열람한 정보 중 본인과 관련된 부분을 고지하기로 합니다.
④ 회사는 서비스의 안정화 및 오류개선, 악성코드 감염여부 확인 등을 위해 회원들의 개인정보를 제외한 PC사양 및 시스템 정보, 오류 정보를 수집할 수 있습니다.
⑤ 회사는 서비스 개선 및 회원 대상 서비스 소개 등을 위한 목적으로 회원 개인에 대한 추가정보를 요구할 수 있으며, 동 요청에 대해 회원은 승낙하여 추가정보를 제공하거나 거부할 수 있습니다.
제12조(테스트 목적의 서비스)
① 회사는 정식 서비스 전 일정 기간을 공지하고, 회원 중 제한된 인원을 선정하여 게임의 안정성 등을 테스트하기 위한 서비스(이하, "테스트 서비스")를 제공할 수 있습니다. 이 때 테스트 서비스를 위한 별도의 약관 체결 등의 절차가 필요할 수 있으며, 이는 테스트 서비스 신청 시, 안내합니다.
② 회사는 테스트 서비스 기간 동안 서비스 안정 및 테스트 목적 달성을 위하여 게임 데이터의 변경, 수정, 추가, 삭제 등의 조치를 취할 수 있으며, 회사는 이에 대한 복구 의무를 지지 않습니다. 또한 회사는 테스트 서비스가 종료된 후 테스트 서비스 기간 동안 회원이 취득한 게임 머니, 캐릭터 정보 등의 전부 또는 일부를 삭제할 수 있습니다.
제13조(콘텐츠서비스)
① 회사는 회원에게 아이템을 포함한 콘텐츠 서비스를 제공할 수 있습니다. 서비스에 제공되는 콘텐츠는 회사의 정책에 따라서 회원에게 이용 기한 및 조건을 정할 수 있으며, 이는 각 콘텐츠 서비스 이용 안내 또는 결제 화면 등에 미리 게시하여 회원에게 고지합니다.
② 회사는 콘텐츠 서비스 중 회원에게 게임에 사용하는 아이템(이하 "아이템"이라 함) 서비스를 유료 또는 무료로 구분하여 제공할 수 있으며 아이템 사용 기간 관련 정책은 다음을 따릅니다.
1. 아이템은 구매일로부터 1년 이내에 사용이 가능하며, 1년 이내에 사용이 개시되지 않은 아이템은 소멸될 수 있습니다. 패키지 아이템은 패키지의 개봉을 사용의 개시로 봅니다.
2. 사용이 개시된 아이템 중 사용 기간이 별도로 명시된 아이템은 명시된 기간 동안 사용할 수 있습니다.
3. 사용이 개시된 아이템 중 사용 기간이 '영구, 무기한' 등으로 표시되었거나 사용 기간이 표시되지 않은 아이템(이하 '영구 아이템'이라 함)은 사용 개시 시점부터 게임 서비스 중 사용할 수 있으며, 제10조 제9항에 따라 서비스가 중단 되는 경우, 영구 아이템의 사용 기간은 종료됩니다.
4. 회사는 게임 내용의 변경, 밸런스유지, 아이템 정책 등에 따라 기존 아이템 의 기능 등을 변경하거나 사용이 불가능하도록 변경할 수 있습니다. 이 때, 사용 기간 내 유료로 기구매한 아이템 사용이 불가능하게 되는 경우에는 사용 기간이 남은 아이템을 유료로 구매한 회원에 한해 기존 아이템의 잔여 기간을 산정한 뒤 등가의 신규 아이템이나 넥슨 캐시, 포인트 등으로 보상합니다.
③ 회사는 회원이 무료로 제공받은 콘텐츠, 포인트로 구매한 콘텐츠 등은 서비스 사용기간을 보증하지 않으며, 회사의 고의 또는 중대한 과실이 없는 한 환불, 손해배상 등의 책임을 지지 않습니다.
④ 회사가 회원에게 제공하는 유료 콘텐츠는 청약 철회가 가능한 콘텐츠와 청약철회가 제한 되는 콘텐츠로 구분 되어 제공됩니다. 청약 철회가 가능한 콘텐츠는 구매 시부터 7일 이내에 청약 철회를 할 수 있으며, 이 기간이 경과한 콘텐츠이거나 전자상거래등에서의소비자보호에관한법률 등 관계 법령에서 정한 청약철회 제한 사유에 해당하는 콘텐츠는 청약 철회가 제한됩니다. 청약 철회가 제한되는 콘텐츠는 제한되는 사실을 팝업 화면이나 연결 화면 등으로 표시합니다.
제14조(쿠폰 서비스)
① 회사는 회사에서 제공하는 웹사이트 또는 어플리케이션을 통해 쿠폰 서비스를 유료 또는 무료로 구분하여 제공할 수 있습니다. 회원은 쿠폰 사용 시 지급되는 쿠폰핀을 입력하여 이에 상응하는 아이템으로 교환할 수 있습니다.
② 회원은 신용카드, 휴대폰 결제, 문화상품권, 실시간 계좌이체, 토스, 카카오페이, 페이코 등 회사에서 제공하는 결제방식을 통해 쿠폰을 구매할 수 있습니다. 쿠폰은 종류에 따라 교환 가능 아이템, 가격, 사용기한 등이 상이하며, 회사는 이에 대해 회원이 상세히 확인할 수 있도록 안내합니다.
③ 회원은 유료 쿠폰 구매 후 7일 이내 미사용 시 청약철회를 할 수 있으며, 회원이 청약철회를 한 경우 회사는 지체 없이 회원에게 지급된 유료 쿠폰을 회수 또는 삭제합니다. 이 기간이 경과한 콘텐츠이거나 전자상거래등에서의소비자보호에관한법률 등 관계 법령에서 정한 청약철회 제한 사유에 해당하는 콘텐츠는 청약 철회가 제한됩니다. 청약 철회가 제한되는 콘텐츠는 제한되는 사실을 팝업 화면이나 연결 화면 등으로 표시합니다.
④ 쿠폰 서비스 이용 회원이 본 약관 제21조를 위반하는 행위가 적발될 경우, 회사는 쿠폰 구매를 승인을 하지 않거나 추후 해당 승인을 취소하고 쿠폰 서비스 및 넥슨 서비스 이용을 제한할 수 있으며, 이로 인해 발생하는 책임을 회사의 고의 또는 중대한 과실이 없는 한 부담하지 않습니다.
제15조(넥슨캐시 서비스)
회사가 제공하는 유료 서비스 및 서비스 이용을 위한 넥슨캐시에 관해서는 회사가 정하는 별도의 넥슨캐시이용약관에 따릅니다.

제16조(포인트 서비스)
① 회사는 회원 관리 등을 위한 게임별 포인트 또는 게임별 특성에 따라 제공될 수 있는 창작 모드, 크리에이터 후원, 온라인 대회 등의 운영을 위한 포인트(이하 "포인트 서비스")를 회원에게 제공할 수 있습니다. 게임별 포인트 지급 여부, 포인트 명칭, 방식 및 사용 방법 등은 상이할 수 있으며, 이는 각 게임 홈페이지 또는 서비스 제공 페이지를 통해 안내하는 방법에 따릅니다.
② 특정 포인트 서비스는 회사가 별도로 운영하는 페이지를 통하여 사용할 수 있으며, 사용에 대한 자세한 사항은 서비스 제공 페이지를 통해 안내합니다.
③ 회사가 정한 유효 기간 내 사용되지 않았거나, 회원이 게임 계정을 삭제하는 경우, 해당 게임 계정에 적립된 포인트는 소멸될 수 있습니다.
④ 회사는 경영상, 기술상 또는 운영상의 이유로 포인트 서비스를 종료할 수 있으며, 최소 30일 전 홈페이지 등을 통해 관련 내용을 사전 고지합니다. 이 경우, 사전에 고지한 서비스 종료일까지 사용되지 않은 포인트는 소멸됩니다.
제17조(크리에이터 서비스)
회사는 회원 중 크리에이터를 선정하여 후원 프로그램 서비스를 제공할 수 있습니다. 크리에이터 신청과 선정, 활동과 보상, 제재 등에 대한 자세한 내용은 별도 ‘크리에이터 운영정책’ 등을 통해 규정합니다.

제18조(메신저 서비스)
① 회사는 회원에게 넥슨 플러그 등의 메신저 서비스(이하 '메신저 서비스'라 함)를 제공할 수 있습니다. 메신저 서비스를 이용하기 위해서 회원은 관련 프로그램을 설치하여야 합니다.
② 회사는 회원이 메신저 서비스를 불법적이거나 타인의 권리를 침해하는 수단으로 이용하거나 청소년 유해매체물, 불법 복제물 등의 정보를 저장, 전송하는 수단으로 사용하는 것을 허락하지 않습니다. 회사는 회원 간에 메신저를 통하여 송수신한 정보를 바탕으로 하여 발생한 손해에 대하여 책임을 부담하지 않습니다.
제19조(광고 게재)
① 회사는 본 서비스 등을 유지하기 위하여 광고를 게재할 수 있으며, 회원은 서비스 이용 시 노출되는 광고 게재에 대하여 동의합니다.
② 회사가 제공하는, 제3자가 주체인, 제1항의 광고에 회원이 참여하거나 교신 또는 거래를 함으로써 발생하는 손실과 손해에 대해서는 회사의 고의 또는 중대한 과실이 없는 한 회원의 책임으로 합니다.
제20조(저작권 등의 귀속)
① 회사가 제공하는 모든 서비스의 지적 재산권을 포함한 모든 소유권은 회사에게 있으며, 서비스를 이용하는 회원은 회사가 제공하는 서비스 범위 내에서 이용권을 가집니다. 즉, 회원은 회사가 제공하는 서비스를 일정기간 동안 회사가 제공하는 각 서비스 범위 내에서 이용할 권한을 갖는 것이며, 이를 회사가 정한 방법 이외의 방법으로 이용 또는 사용할 수 없습니다.
② 회사가 작성한 저작물에 대한 저작권 및 기타 지적 재산권은 회사에 귀속하며, 회원이 서비스 내에 게시한 게시물의 저작권은 해당 저작권자에게 귀속합니다. 다만, 회사는 관리상 혹은 정책상의 필요에 따라 게시물을 사전 통지 없이 이동하거나 삭제할 수 있습니다.
③ 회원이 게재한 게시물로 인해 발생하는 손실이나 문제는 회원 개인의 책임이며 회사는 이에 대한 책임을 지지 않습니다. 회원의 게시물이 타인의 권리를 침해하였음을 이유로 타인으로부터 회사가 손해배상청구 등의 이의 제기를 받은 경우, 해당 게시물을 작성한 회원은 회사의 면책을 위하여 적극적으로 협조하여야 하며, 회사가 면책되지 못한 경우 회원은 그로 인해 발생한 문제에 대해 책임을 부담하여야 합니다.
④ 회원은 회사 또는 제3자에게 지적재산권이 귀속된 저작물 기타 정보를 회사 또는 제3자의 사전승낙 없이 복제, 전송, 출판, 배포, 방송 기타 방법에 의하여 영리목적으로 이용하거나 타인에게 이용하게 하여서는 안 됩니다.
⑤ 회원이 서비스 내에 게시하는 게시물은 검색 결과 내지 서비스 및 관련 프로모션 등에 노출될 수 있으며, 해당 노출을 위해 필요한 범위 내에서는 일부 수정, 복제, 편집될 수 있습니다. 이 경우, 회사는 저작권법의 내용을 준수하여야 하며, 회원은 언제든지 고객센터 또는 서비스 내 관리기능을 통해 해당 게시물에 대해 삭제, 검색 결과 제외, 비공개 등을 요청할 수 있습니다. 이는 회사가 서비스를 운영하는 동안 유효하며, 회원이 탈퇴한 이후에도 지속적으로 적용됩니다.
⑥ 회사는 회원의 게시물이 제3자로부터 저작권 등의 문제로 이의제기가 있고 그것이 상당한 이유가 있거나 제20조 제2항에서 금지하는 내용에 해당한다고 판단되는 경우, 사전 통지 없이 이를 삭제하거나 등록 자체를 거부할 수 있으며, 저작권 및 권리침해로 인한 게시물의 게시중단 등에 대한 사항은 저작권법 및 관계법령에 따릅니다.				
			</div>
			<div id="cbox"><input type="checkbox" name="isAgree" value="y" id="isAgree" /><label for="isAgree">약관에 동의하시겠습니까? (필수)</label></div>					
			<div id="withreason">
							<h3>탈퇴이유<br />(중복체크가능)</h3>
							<ul>
								<li><label for="a"><input type="checkbox" name="why" id="a" value="A" />&nbsp;서비스 이용방법 불만</label><br />
								<li><label for="b"><input type="checkbox" name="why" id="b" value="B" />&nbsp;고객응대 불만</label><br />
								<li><label for="c"><input type="checkbox" name="why" id="c" value="C" />&nbsp;포인트 및 혜택 부족</label><br />
								<li><label for="d"><input type="checkbox" name="why" id="d" value="D" />&nbsp;필요한 정보가 불충분</label><br />
								<li><label for="e"><input type="checkbox" name="why" id="e" value="E" />&nbsp;더 이상 이용할 필요가 없어서</label><br />
								<li><label for="f"><input type="checkbox" name="why" id="f" value="F" />&nbsp;시스템 장애(속도저하, 잦은에러)</label><br />
								<li><label for="g"><input type="checkbox" name="why" id="g" value="G" />&nbsp;재가입하기 위해서</label><br />
								<li><label for="h"><input type="checkbox" name="why" id="h" value="H" />&nbsp;기타</label>
							</ul>
			</div>				
				<div id="btn">
							<input type="button" value="취 소" onclick="returnIndex();" />&nbsp;&nbsp;&nbsp;
							<input type="submit" value="회원 탈퇴" />
				</div>																				
        </div>
            
    </div>
    

</body>
</html>