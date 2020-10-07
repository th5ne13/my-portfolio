package action;

import java.io.*;
import java.util.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

public class RnoticeProcAction implements Action {
	public ActionForward execute(HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String wtype = request.getParameter("wtype");

		int result = 0, nlnum = 0;
		String lnk = "", nlResult = "";
		RnoticeService rnoticeService = new RnoticeService();

		if (wtype.equals("in")) {	// 공지사항 등록이면
			nlResult = rnoticeService.insertNotice(request);
			result = Integer.parseInt(nlResult.substring(0, nlResult.indexOf(':')));
			nlnum = Integer.parseInt(nlResult.substring(nlResult.indexOf(':') + 1));
			lnk = "view.notice?cpage=1&num=" + nlnum;
			
		} else if (wtype.equals("up")) {	// 공지사항 수정이면
			result = rnoticeService.updateNotice(request);
				
			lnk = "list.notice";

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
