package action;

import java.io.*;
import java.util.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

public class AdminMemUpdateAction implements Action {
	public ActionForward execute(HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String type = request.getParameter("type");

		int result = 0; String lnk = ""; 
		AdminMemService memberservice = new AdminMemService();

		if (type.equals("byforce")) {
			result = memberservice.getRidOfMember(request);
			lnk = "../close2.jsp";
		} else if (type.equals("up")) {
			result = memberservice.updateMember(request);
			lnk = "../close2.jsp";
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
