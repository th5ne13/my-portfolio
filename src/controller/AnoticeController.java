package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import action.*;
import vo.*;

@WebServlet("*.anotice")
public class AnoticeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
    public AnoticeController() { super(); }

	protected void doProc(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String RequestURI = request.getRequestURI();
		
		String contextPath = request.getContextPath();

		String command = RequestURI.substring(contextPath.length());
		
			Action action = null;
			ActionForward forward = null;
			if (command.equals("/list.anotice")) { 
				action = new AnoticeListAction();
				// Action클래스 인스턴스 생성 
				try {
					forward = action.execute(request, response);
				} catch(Exception e) { e.printStackTrace(); }
				
			} else if (command.equals("/in.anotice")) {
				forward = new ActionForward();
				forward.setPath("/player/applyForm.jsp?wtype=in");
			
			} else if (command.equals("/proc.anotice")) {
				action = new AnoticeProcAction();
				try {
					forward = action.execute(request, response);
				} catch(Exception e) { e.printStackTrace(); }
				
			} else if (command.equals("/up.anotice")) {
				action = new AnoticeViewAction();
				try {
					forward = action.execute(request, response);
					forward.setPath("/player/applyForm.jsp?wtype=up");
				} catch(Exception e) { e.printStackTrace(); }
				
			} else if (command.equals("/view.anotice")) {
				action = new AnoticeViewAction();
				try {
					forward = action.execute(request, response);
				} catch(Exception e) { e.printStackTrace(); }

			}
			
			if (forward != null) {
				if (forward.isRedirect()) {
					response.sendRedirect(forward.getPath());
				} else {
					RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
					dispatcher.forward(request, response);
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
