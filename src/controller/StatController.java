package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import action.*;
import vo.ActionForward;

@WebServlet("*.stat")
public class StatController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public StatController() {
        super();
    }

	protected void doProc(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String RequestURI = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = RequestURI.substring(contextPath.length());
		
		Action action = null;
		ActionForward forward = null;
		
		if (command.equals("/sale.stat")) {
			action = new SaleStatAction();
			try {
				forward = action.execute(request, response);
			} catch(Exception e) { e.printStackTrace(); }			
		} else if (command.equals("/saleBran.stat")) {
			action = new SaleStatBranAction();
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
