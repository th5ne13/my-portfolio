package action;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.http.*;
import svc.*;
import vo.*;

public class BoardViewAction implements Action {

	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		int num = Integer.parseInt(request.getParameter("num"));	// 글번호를 int형으로 변환하여 저장
		
		BoardService boardService = new BoardService();
		BoardReplyService boardReplyService = new BoardReplyService();
		
		int result = boardService.updateRead(num);
		
		BoardInfo boardInfo = boardService.getBoard(num);
		if (boardInfo == null) {		// 게시글 정보가 없으면
			response.setContentType("html/text; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('잘못된 경로로 들어오셨습니다.');");
			out.println("history.back();");
			out.println("</script>");
		}

		ArrayList<ReplyInfo> replyList = new ArrayList<ReplyInfo>();
		replyList = boardReplyService.getReplyList(num);
				
		request.setAttribute("boardInfo", boardInfo);
		request.setAttribute("replyList", replyList);
		// 필요한 데이터들은 request객체의 속성으로 담아서 가져감
		// 단, Dispatcher 방식일 경우에만 사용가능
		
		ActionForward forward = new ActionForward();
		forward.setPath("/bbs/boardView.jsp");			// request에 객체를 담아가므로 디스패쳐방식으로 가야함.(리다이렉트 방식은 Attribute 못가져감)		
		
		return forward;
	}

}
