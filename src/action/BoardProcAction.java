package action;

import java.io.*;
import java.util.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

public class BoardProcAction implements Action {

	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String wtype = request.getParameter("wtype");
		String btype = request.getParameter("btype");
		HttpSession session = request.getSession();
		MemberInfo mem = (MemberInfo)session.getAttribute("memberInfo");
		String mlid = mem.getMl_id();	
		if (mlid == null || mlid.equals("")) {{
			response.setContentType("html/text; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('작업에 실패했습니다.');");
			out.println("history.back();");
			out.println("</script>");
		}}
		
		int result = 0, nlnum = 0;
		String lnk = "", blResult = "";
		BoardService boardService = new BoardService();
		BoardReplyService boardReplyService = new BoardReplyService();
		
		if (wtype.equals("in")) {				// 게시판 글 등록이면
			blResult = boardService.insertBoard(request);
			result = Integer.parseInt(blResult.substring(0, blResult.indexOf(':')));
			nlnum = Integer.parseInt(blResult.substring(blResult.indexOf(':') + 1));
			lnk = "view.board?btype=" + btype + "&cpage=1&num=" + nlnum;
			
		} else if (wtype.equals("up")) {		// 게시판 글 수정이면
			result = boardService.updateBoard(request);			
			String num = request.getParameter("num");			
			String cpage = request.getParameter("cpage");
			String schType = request.getParameter("schType");
			String keyword = request.getParameter("keyword");
			String args = "?btype=" + btype + "&num=" + num + "&cpage=" + cpage + "&schType=" + schType + "&keyword=" + keyword;
			lnk = "view.board" + args;
			
		} else if (wtype.equals("del")) {		// 게시판 글 삭제이면 
			blResult = boardService.deleteBoard(request);
			result = Integer.parseInt(blResult.substring(0, blResult.indexOf(':')));
			btype = blResult.substring(blResult.indexOf(':') + 1);
			lnk = "list.board?btype=" + btype;
			
		} else if (wtype.equals("replyIn")) {	// 댓글 등록이면
			blResult = boardReplyService.insertBoardReply(request);
			result = Integer.parseInt(blResult.substring(0, blResult.indexOf(':')));
			nlnum = Integer.parseInt(blResult.substring(blResult.indexOf(':') + 1));
			lnk = "view.board?num=" + nlnum;
			
		} else if (wtype.equals("replyDel")) {		// 댓글 삭제이면 
			result = boardReplyService.deleteBoardReply(request);
			nlnum = Integer.parseInt(request.getParameter("blnum"));
			lnk = "view.board?num=" + nlnum;
			
		} else if (wtype.equals("replyUp")) {		// 게시판 글 수정이면
			result = boardReplyService.updateBoardReply(request);	
			nlnum = Integer.parseInt(request.getParameter("blnum"));
			lnk = "view.board?num=" + nlnum + "&wtype=" + wtype;
			
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
