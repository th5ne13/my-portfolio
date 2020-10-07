package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.BoardListAction;
import action.BoardProcAction;
import action.BoardViewAction;
import action.PerBoardProcAction;
import action.PerBoardViewAction;
import action.PerListAction;
import vo.ActionForward;

@WebServlet("*.adminBoard")
public class AdminBoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdminBoardController() {
        super();
    }

	protected void doProc(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String RequestURI = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = RequestURI.substring(contextPath.length());
		
		Action action = null;
		ActionForward forward = null;
		
		if (command.equals("/perView.adminBoard")) {				// 1:1게시판 목록 보기
			action = new PerListAction();
			try {
				forward = action.execute(request, response);
			} catch(Exception e) { e.printStackTrace(); }			
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
