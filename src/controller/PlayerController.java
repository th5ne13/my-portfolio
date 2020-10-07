package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import action.*;
import vo.*;

@WebServlet("*.request")
public class PlayerController extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
    public PlayerController() { super(); }

	protected void doProc(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String RequestURI = request.getRequestURI();		
		String contextPath = request.getContextPath();
		String command = RequestURI.substring(contextPath.length());
		
		Action action = null;
		ActionForward forward = null;
		System.out.println(command);
		if (command.equals("/recruit.request")) {
			action = new MemberRequestAction();
			try {
				forward = action.execute(request, response);
			} catch(Exception e) { e.printStackTrace(); }
		} else if (command.equals("/list.request")) {
			action = new MemberListAction();
			try {
				forward = action.execute(request, response);
			} catch(Exception e) { e.printStackTrace(); }
			
		} else if (command.equals("/view.request")) {
			action = new ViewListAction();
			try {
				forward = action.execute(request, response);
			} catch(Exception e) { e.printStackTrace(); }
		
		} else if(command.equals("/up.request")) {
			action = new MemberRequestAction();
			try {
				forward = action.execute(request, response);
			} catch(Exception e) { e.printStackTrace(); }	
		} else if(command.equals("/del.request")) {	
			action = new MemberRequestAction();
			try {
				forward = action.execute(request, response);
			} catch(Exception e) { e.printStackTrace(); }	
		}
		
		System.out.println(request.getParameter("btype"));		
		System.out.println(forward.getPath());
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
