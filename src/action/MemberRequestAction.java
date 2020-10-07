package action;

import java.io.*;
import java.util.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

public class MemberRequestAction implements Action {
	public ActionForward execute(HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String type = request.getParameter("type");
		String reqnum = request.getParameter("reqnum");
		String btntype = request.getParameter("btntype");
		String mlid = request.getParameter("mlid");
		
		int result = 0, nlnum = 0;
		String lnk = "", nlResult = "";
		MemberRequestService memrequest = new MemberRequestService();

		if (type.equals("in")) {				// 모집신청 등록이면
			nlResult = memrequest.insertRequest(request);
			result = Integer.parseInt(nlResult.substring(0, nlResult.indexOf(':')));
			nlnum = Integer.parseInt(nlResult.substring(nlResult.indexOf(':') + 1));
			lnk = "list.request?cpage=1&num=" + nlnum;
			
		} else if (type.equals("up")) {			// 수정
			result = memrequest.updateNotice(reqnum, btntype);
			lnk = "list.request?cpage=1&num=" + nlnum;
		} else if (type.equals("del")) {		// 삭제
			result = memrequest.deleteNotice(reqnum, btntype, mlid);
			lnk = "list.request?cpage=1&num=" + nlnum;
		}
		
		ActionForward forward = new ActionForward();
		if (result > 0) {
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
