package action;

import java.io.*;
import java.util.*;
import javax.servlet.http.*;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import svc.*;
import vo.*;

public class GroundProcAction implements Action {

	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String wtype = (String)request.getAttribute("wtype");
		int result = 0;
		String lnk = "";
		GroundReqService groundReqService = new GroundReqService();
		System.out.println("프록액션 : " + wtype);
		
		if (wtype.equals("in")) {				// 구장 제휴 신청이면
			result = groundReqService.insertGround(request);
			lnk = "start.jsp";			
		} else if (wtype.equals("up")) {		// 구장 수정 요청이면
			result = groundReqService.updateGround(request);
			lnk = "start.jsp";
		} else if (wtype.equals("admin")) {
			result = groundReqService.updateGround(request);
			lnk = "adminGrdList.groundReq";			
		}
		

		ActionForward forward = new ActionForward();
		if (result == 1) {
			forward.setRedirect(true); 				// sendRedirect 방식으로 이동시킴
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
