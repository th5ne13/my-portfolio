package controller;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpSession;				// jsp는 만들어져있지만 servlet에서는 만들어서 사용해야 함

import action.SaleStatAction;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import vo.*;
import svc.GroundRevService;
import svc.LoginService;

@WebServlet("*.login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public LoginServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");		
		String RequestURI = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = RequestURI.substring(contextPath.length());
		
		if (command.equals("/member.login")) {
			LoginService loginService = new LoginService();
			String uid = request.getParameter("uid");	
			String pwd = request.getParameter("pwd");		
			MemberInfo memberInfo = loginService.getLoginMember(uid, pwd);
		
			if (memberInfo != null) {
				HttpSession session = request.getSession();
				session.setAttribute("memberInfo", memberInfo);
				response.sendRedirect("start.jsp");
			} else {
				response.setContentType("text/html; charset=utf-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('아이디와 비밀번호를 확인하세요.');");
				out.println("history.back();");
				out.println("</script>");
			}
		} else if (command.equals("/admin.login")) {
			LoginService loginService = new LoginService();
			String aid = request.getParameter("aid");	
			String pwd = request.getParameter("pwd");	
			AdminInfo adminInfo = loginService.getLoginAdmin(aid, pwd);
		
			if (adminInfo != null) {
				SiteInfo siteInfo = loginService.getSiteInfo();
				HttpSession session = request.getSession();
				session.setAttribute("adminInfo", adminInfo);
				session.setAttribute("siteInfo", siteInfo);				

				ArrayList<GroundRevInfo> grdRevList = new ArrayList<GroundRevInfo>();
				GroundRevService groundRevService = new GroundRevService();
				grdRevList = groundRevService.grdRevStatList();
				session.setAttribute("grdRevList", grdRevList);
				response.sendRedirect("admin/index.jsp");
			} else {
				response.setContentType("text/html; charset=utf-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('아이디와 비밀번호를 확인하세요11.');");
				out.println("history.back();");
				out.println("</script>");
			}		
		}
	}
}