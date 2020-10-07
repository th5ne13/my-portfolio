package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import action.*;
import vo.*;

@WebServlet("*.member")
public class AdminMemController extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
    public AdminMemController() { super(); }

	protected void doProc(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String RequestURI = request.getRequestURI();
		
		String contextPath = request.getContextPath();

		String command = RequestURI.substring(contextPath.length());
		System.out.println(command);
		Action action = null;
		ActionForward forward = null; 
		if (command.equals("/list.member")) { 
			action = new AdminMemListAction();			
			try {
				forward = action.execute(request, response);
				forward.setPath("/admin/adminmember.jsp");

			} catch(Exception e) { e.printStackTrace(); }	
			
		} else if (command.equals("/deleted.member")) { 
			action = new AdminDeletedMemList();
			try {
				forward = action.execute(request, response);
				forward.setPath("/admin/adminDeletedMember.jsp");

			} catch(Exception e) { e.printStackTrace(); }	
			
		} else if (command.equals("/admin/update.member")) {
			action = new AdminMemUpdateAction();				
			try {
				forward = action.execute(request, response);
				// forward.setPath("list.member");
				// 반드시 servlet 주소로 접근하기
				System.out.println(forward.getPath());
				
			} catch(Exception e) { e.printStackTrace(); }					
		} else if (command.equals("/statistics.member")) {
			System.out.println(command);
			action = new StatMemListAction();			
			try {
				forward = action.execute(request, response);
			} catch(Exception e) { e.printStackTrace(); }	
		} else if (command.equals("/statsearch.member")) {
			System.out.println(command);
			action = new StatSearchMemListAction();			
			try {
				forward = action.execute(request, response);
			} catch(Exception e) { e.printStackTrace(); }	
		}
		
		// 기능 실행 후 이동할 페이지에 대한 if문
		if (forward != null) {
			if (forward.isRedirect()) {
				response.sendRedirect(forward.getPath());
				// history에 쌓여 '뒤로 가기'가 가능한 이동
			} else {
				RequestDispatcher dispatcher = 
					request.getRequestDispatcher(forward.getPath());
				dispatcher.forward(request, response);
				// history에 쌓이지 않아 '뒤로 가기'가 불가능한 이동(url불변)
				// request와 response 객체를 공유하여 사용할 수 있음
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
