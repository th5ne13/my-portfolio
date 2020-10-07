package action;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.GroundReqService;
import vo.*;

public class ReserveViewAction implements Action {

	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		AdminInfo adminInfo = (AdminInfo)session.getAttribute("adminInfo");
		String alid = "";

		if (adminInfo == null) {
			response.setContentType("html/text; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('로그인해주세요');");
			out.println("location.href='/admin/index.jsp'");
			out.println("</script>");
		} else {
			alid = adminInfo.getAl_id();			
		}
		
		String mlid = request.getParameter("mlid");
		String schType = request.getParameter("schType");
		String keyword = request.getParameter("keyword");
		String ltype = request.getParameter("ltype");
		String where = "";
		if (schType != null && !schType.equals("") && keyword != null && !keyword.equals("")) {
				where = " and " + schType + " like '%" + keyword + "%'";
		}
		int cpage = 1;
		int limit = 10;
		
		if (request.getParameter("cpage") != null) {	
			cpage = Integer.parseInt(request.getParameter("cpage"));
		}
		
		GroundReqService groundReqService = new GroundReqService();
		ActionForward forward = new ActionForward();
		
		ArrayList<GroundRevInfo> grdRevList = new ArrayList<GroundRevInfo>();
		int rcount = groundReqService.getListCount(where);
		
		grdRevList = groundReqService.getGrdRev(mlid);
		request.setAttribute("grdRevList", grdRevList);
		forward.setPath("/member/groundRevView.jsp");		
		if (alid != null && !alid.equals("")) {
			grdRevList = groundReqService.getGrdRev(where, cpage, limit, ltype);
			request.setAttribute("grdRevList", grdRevList);	
			forward.setPath("/member/groundRevView.jsp");		
		}	

		int mpage = (int)((double)rcount / limit + 0.95);
		int spage = (((int)((double)cpage / 10 + 0.9)) - 1) * 10 + 1;
		int epage = spage + 10 - 1;
		
		if (epage > mpage)	epage = mpage;
		
		PageInfo pageInfo = new PageInfo();
		pageInfo.setCpage(cpage);
		pageInfo.setEpage(epage);
		pageInfo.setMpage(mpage);
		pageInfo.setRcount(rcount);
		pageInfo.setSpage(spage);	
		pageInfo.setSchType(schType);
		pageInfo.setKeyword(keyword);
		
		request.setAttribute("pageInfo", pageInfo);		

		if (grdRevList == null) {
			response.setContentType("html/text; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('잘못된 경로로 들어오셨습니다.');");
			out.println("history.back();");
			out.println("</script>");
		}
		
		
		return forward;
		
	}

}
