package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import action.*;
import vo.*;

@WebServlet("*.notice")
public class RnoticeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
    public RnoticeController() { super(); }

	protected void doProc(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String RequestURI = request.getRequestURI();
		
		String contextPath = request.getContextPath();

		String command = RequestURI.substring(contextPath.length());
		
			Action action = null;
			ActionForward forward = null; 
			System.out.println(command);

			if (command.equals("/list.notice")) { 
				action = new RnoticeListAction();
				try {
					forward = action.execute(request, response);
				} catch(Exception e) { e.printStackTrace(); }
				
			} else if (command.equals("/in.notice")) {
				forward = new ActionForward();
				forward.setPath("/player/recruitForm.jsp?wtype=in");
			
			} else if (command.equals("/proc.notice")) {
				action = new RnoticeProcAction();
				try {
					forward = action.execute(request, response);
				} catch(Exception e) { e.printStackTrace(); }
				
			} else if (command.equals("/up.notice")) {
				action = new RnoticeViewAction();
				try {
					forward = action.execute(request, response);
					forward.setPath("/player/recruitForm.jsp?wtype=up");
				} catch(Exception e) { e.printStackTrace(); }
				
			} else if (command.equals("/view.notice")) {
				action = new RnoticeViewAction();
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
