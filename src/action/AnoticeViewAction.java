package action;

import java.io.*;
import java.util.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

public class AnoticeViewAction implements Action {
	public ActionForward execute(HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		int num = Integer.parseInt(request.getParameter("num"));
		// 글번호를 int형으로 변환하여 저장

		AnoticeService anoticeService = new AnoticeService();

		AnoticeInfo anoticeInfo = anoticeService.getNotice(num);
		// 글번호에 해당하는 글의 데이터를 NoticeInfo형 인스턴스로 받아옴(글수정을위해서)

		if (anoticeInfo == null) {	// 게시글 정보가 없으면
			response.setContentType("html/text; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('잘못된 경로로 들어오셨습니다.');");
			out.println("history.back();");
			out.println("</script>");
		}
		request.setAttribute("cpage", request.getParameter("cpage"));
		request.setAttribute("schType", request.getParameter("schType"));
		request.setAttribute("keyword", request.getParameter("keyword"));
		request.setAttribute("anoticeInfo", anoticeInfo);
		// 필요한 데이터들은 request객체의 속성으로 담아서 가져감
		// 단, Dispatcher방식일 경우에만 사용가능

		ActionForward forward = new ActionForward();
		forward.setPath("/list.anotice");

		return forward;
	}
}
