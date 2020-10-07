package controller;

import java.io.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import svc.*;
import vo.*;

@WebServlet("*.find")
public class IdFindServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public IdFindServlet() {
        super();
    }

    protected void doProc(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("utf-8");
    	
		String RequestURI = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = RequestURI.substring(contextPath.length());
		
		String uid = request.getParameter("uid");
    	String uname = request.getParameter("uname");
    	String question = request.getParameter("question");
    	String answer = request.getParameter("answer");
    	System.out.println(command);
    	FindService findService = new FindService();
    	
		if (command.equals("/id.find")) {
			MemberInfo id = findService.getInfoFind(uname, question, answer);
			if (id != null) {
				request.setAttribute("MemberInfo", id);

				RequestDispatcher dispatcher = request.getRequestDispatcher("member/idShow.jsp");
				dispatcher.forward(request, response);
			} else {
				response.setContentType("text/html; charset=utf-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('해당하는ID가 없거나 정보를 잘못 입력하셨습니다.');");
				out.println("history.back();");
				out.println("</script>");
			}
		}
		
		if (command.equals("/pwd.find")) {
			MemberInfo pwd = findService.getInfoFindPwd(uid, uname, question, answer);
			if (pwd != null) {
				request.setAttribute("MemberInfo", pwd);

				RequestDispatcher dispatcher = request.getRequestDispatcher("member/pwdShow.jsp");
				dispatcher.forward(request, response);
			} else {
				response.setContentType("text/html; charset=utf-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('회원정보를 잘못입력하셨습니다.');");
				out.println("history.back();");
				out.println("</script>");
			}
		}
		
		if (command.equals("/newpwd.find")) {
			int result = findService.setPwd(request);
			if (result == 1) {
				response.sendRedirect("start.jsp");
			} else {
				response.setContentType("text/html; charset=utf-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('비밀번호 변경에 실패했습니다.');");
				out.println("history.back();");
				out.println("</script>");
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
