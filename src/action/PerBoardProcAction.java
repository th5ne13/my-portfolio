package action;

import java.io.*;
import java.util.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

public class PerBoardProcAction implements Action {

	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String wtype = request.getParameter("wtype");
		HttpSession session = request.getSession();
		MemberInfo mem = (MemberInfo)session.getAttribute("memberInfo");
		AdminInfo adminInfo = (AdminInfo)session.getAttribute("adminInfo");
		
		int result = 0, qlnum = 0;
		String lnk = "", qlResult = "", mlid = "", alid = "";
		PerBoardService perBoardService = new PerBoardService();
		
		if (mem == null) {
			response.setContentType("html/text; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('로그인을 한 이후 이용이 가능합니다.');");
			out.println("history.back();");
			out.println("</script>");
		} else {		
			mlid = mem.getMl_id();	
			if (wtype.equals("in")) {			// 1:1 게시판 글 등록이면
				qlResult = perBoardService.insertPerBoard(request);
				result = Integer.parseInt(qlResult.substring(0, qlResult.indexOf(':')));
				qlnum = Integer.parseInt(qlResult.substring(qlResult.indexOf(':') + 1));
				lnk = "perView.board?num=" + qlnum;
				
			} 	else if (wtype.equals("up")) {	// 1:1 글 수정이면
				result = perBoardService.updatePerBoard(request);			
				String num = request.getParameter("num");
				lnk = "perView.board?num=" + num;
				
			}	else if (wtype.equals("del")) {	// 1:1 글 삭제이면 
				result = perBoardService.deletePerBoard(request);
				lnk = "per.board";
			}
		}		

		if (adminInfo == null) {
			response.setContentType("html/text; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('로그인을 한 이후 이용이 가능합니다.');");
			out.println("history.back();");
			out.println("</script>");
		} else {			
			alid = adminInfo.getAl_id();
			result = perBoardService.adminUpdatePerBoard(request, alid);
			lnk = "perView.adminBoard";	
		}

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
