package action;

import java.io.*;
import java.util.*;
import javax.servlet.http.*;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import svc.*;
import vo.*;

public class ReservedelAction implements Action {

	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		request.setCharacterEncoding("utf-8");
		GroundReqService groundReqService = new GroundReqService();
		int result = 0;
		
		result = groundReqService.delReserveGrd(request);

		if (result == 0) {
			response.setContentType("html/text; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('잘못된 경로로 들어오셨습니다.');");
			out.println("history.back();");
			out.println("</script>");
		}

		
		ActionForward forward = new ActionForward();
		forward.setPath("list.reserve");	
		
		return forward;
		
	}

}
