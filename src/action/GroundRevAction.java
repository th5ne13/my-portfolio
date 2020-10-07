package action;

import java.io.*;
import java.util.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

public class GroundRevAction implements Action {

	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String mlid = request.getParameter("mlid");
		int result = 0;
		String lnk = "";
		GroundRevService groundRevService = new GroundRevService();
		
		result = groundRevService.groundRev(request);
		lnk = "close.jsp";

		ActionForward forward = new ActionForward();
		if (result == 1) {
			forward.setRedirect(true);
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
