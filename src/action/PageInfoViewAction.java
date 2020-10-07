package action;

import java.io.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import svc.PageInfoService;
import vo.ActionForward;
import vo.PageMainInfo;

public class PageInfoViewAction implements Action {

	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String btype = request.getParameter("btype");
		
		PageInfoService pageInfoService = new PageInfoService();
		
		PageMainInfo pageMainInfo = pageInfoService.getInfo(btype);
		request.setAttribute("pageMainInfo", pageMainInfo);	

		ActionForward forward = new ActionForward();	
		forward.setPath("/admin/page/pageInfoView.jsp");
		return forward;
	}

}
