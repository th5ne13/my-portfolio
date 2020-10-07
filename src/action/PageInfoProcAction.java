package action;

import java.io.*;
import java.util.*;
import javax.servlet.http.*;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import svc.*;
import vo.*;

public class PageInfoProcAction implements Action {

	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		int result = 0;
		String btype = (String)request.getAttribute("btype");
		
		PageInfoService pageInfoService = new PageInfoService();		
		result = pageInfoService.upInfo(request);
		

		ActionForward forward = new ActionForward();
		if (result == 1) {
			forward.setRedirect(true); 				// sendRedirect 방식으로 이동시킴
			forward.setPath("view.page?btype=" + btype);
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
