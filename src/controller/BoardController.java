package controller;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import action.*;
import vo.*;

@WebServlet("*.board")
public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public BoardController() {
        super();
    }

	protected void doProc(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String RequestURI = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = RequestURI.substring(contextPath.length());
		
		Action action = null;
		ActionForward forward = null;
		System.out.println(command);
		
		if (command.equals("/list.board")) {			// 국내/해외 게시판 리스트
			action = new BoardListAction();
			try {
				forward = action.execute(request, response);
			} catch(Exception e) { e.printStackTrace(); }
			
		} else if (command.equals("/in.board")) {		// 국내/해외 게시판 글 등록
			forward = new ActionForward();
			forward.setPath("/bbs/boardForm.jsp?wtype=in");				
		} else if (command.equals("/proc.board")) {		// 국내/해외 게시판 (등록/수정/삭제)처리 작업
			action = new BoardProcAction();
			try {
				forward = action.execute(request, response);
			} catch(Exception e) { e.printStackTrace(); }
			
		} else if (command.equals("/view.board")) {		// 국내/해외 게시판 보기 작업
			action = new BoardViewAction();
			try {
				forward = action.execute(request, response);
			} catch(Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/up.board")) {		// 국내/해외 게시판 수정 작업
			action = new BoardViewAction();
			try {
				forward = action.execute(request, response);
				forward.setPath("/bbs/boardForm.jsp?wtype=up");
			} catch(Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/replyIn.board")) {	// 댓글 등록
			action = new BoardProcAction();
			try {
				forward = action.execute(request, response);
			} catch(Exception e) { e.printStackTrace(); }
		} else if (command.equals("/replyProc.board")) {		// 댓글 (등록/수정/삭제)처리 작업
			action = new BoardProcAction();
			try {
				forward = action.execute(request, response);
			} catch(Exception e) { e.printStackTrace(); }				
		} else if (command.equals("/per.board")) {	// 1:1 게시판 리스트
			action = new PerListAction();
			try {
				forward = action.execute(request, response);
			} catch(Exception e) { e.printStackTrace(); }
			
		} else if (command.equals("/perView.board")) {	// 1:1 게시판 보기 작업
			action = new PerBoardViewAction();
			try {
				forward = action.execute(request, response);
			} catch(Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/perIn.board")) {	// 1:1 글 등록
			forward = new ActionForward();
			forward.setPath("/bbs/perBoardForm.jsp?wtype=in");		
			
		} else if (command.equals("/perProc.board")) {	// 1:1 글 (등록/수정/삭제)처리 작업이면
			action = new PerBoardProcAction();
			try {
				forward = action.execute(request, response);
			} catch(Exception e) { e.printStackTrace(); }
			
		} else if (command.equals("/adminPerProc.board")) {	// 1:1 글 답변 작업이면(어드민)
			action = new PerBoardProcAction();
			try {
				forward = action.execute(request, response);
			} catch(Exception e) { e.printStackTrace(); }
			
		} else if (command.equals("/perUp.board")) {	// 1:1 글 수정 작업이면
			action = new PerBoardViewAction();
			try {
				forward = action.execute(request, response);
				forward.setPath("/bbs/perBoardForm.jsp?wtype=up");
			} catch(Exception e) {
				e.printStackTrace();
			}
		} 
		
		if (forward != null) {
			try {
				if (forward.isRedirect()) {
					response.sendRedirect(forward.getPath());
				} else {
					RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
					dispatcher.forward(request, response);
				}
			} catch(Exception e) {
				System.out.println("오류다오류");
				e.printStackTrace();
			} 
		}
		
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		doProc(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		doProc(request, response);
	}

}
