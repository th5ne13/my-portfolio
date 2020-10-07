package action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import svc.*;
import vo.*;

public class PerBoardViewAction implements Action {

	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		int num = Integer.parseInt(request.getParameter("num"));
		
		PerBoardService perBoardService = new PerBoardService();
		
		PerBoardInfo perBoardInfo = perBoardService.getPerBoard(num);
		if (perBoardInfo == null) {		// 게시글 정보가 없으면
			response.setContentType("html/text; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('잘못된 경로로 들어오셨습니다.');");
			out.println("history.back();");
			out.println("</script>");
		}
				
		request.setAttribute("perBoardInfo", perBoardInfo);
		
		ActionForward forward = new ActionForward();
		forward.setPath("/bbs/perBoardView.jsp");
		
		return forward;
	}

}
