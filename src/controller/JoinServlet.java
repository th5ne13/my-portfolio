package controller;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.JoinService;

@WebServlet("*.join")
public class JoinServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public JoinServlet() {
        super();
    }

	protected void doProc(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String RequestURI = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = RequestURI.substring(contextPath.length());
		
		if (command.equals("/in.join")) {
			JoinService joinService = new JoinService();
			int result = joinService.setMemberJoin(request);
			if (result == 1) {
				response.sendRedirect("loginForm.jsp");
			} else {
				response.setContentType("text/html; charset=utf-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('회원가입에 실패했습니다.');");
				out.println("history.back();");
				out.println("</script>");
			}
		}
		if (command.equals("/up.join")) {
			JoinService joinService = new JoinService();
			String kind = request.getParameter("kind");
			int result = 0;
			if (kind.equals("up")) {
				result = joinService.joinUpdate(request);
			} else if (kind.equals("del")) {
				result = joinService.joinDel(request);
				HttpSession session = request.getSession();
				session.invalidate();
			}
			
			if (result == 1) {
				response.sendRedirect("start.jsp");
			} else {
				response.setContentType("text/html; charset=utf-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('회원정보 수정/탈퇴에 실패했습니다.');");
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