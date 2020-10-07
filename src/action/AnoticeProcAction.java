package action;

import java.io.*;
import java.util.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

public class AnoticeProcAction implements Action {
	public ActionForward execute(HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String wtype = request.getParameter("wtype");

		int result = 0, nlnum = 0;
		String lnk = "", nlResult = "";
		AnoticeService anoticeService = new AnoticeService();

		if (wtype.equals("in")) {	// 공지사항 등록이면
			nlResult = anoticeService.insertNotice(request);
			result = Integer.parseInt(nlResult.substring(0, nlResult.indexOf(':')));
			nlnum = Integer.parseInt(nlResult.substring(nlResult.indexOf(':') + 1));
			lnk = "view.anotice?cpage=1&num=" + nlnum;
			
		} else if (wtype.equals("up")) {	// 공지사항 수정이면
			result = anoticeService.updateNotice(request);
				
			lnk = "list.anotice";

		}
		
		ActionForward forward = new ActionForward();
		if (result == 1) {
			forward.setRedirect(true);	// sendRedirect 방식으로 이동시킴
			forward.setPath(lnk);
		} else {
			response.setContentType("html/text; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('작업에 실패했습니다.');");
			out.println("history.back();");
			out.println("</script>");
		}

		return forward;
	}
}
