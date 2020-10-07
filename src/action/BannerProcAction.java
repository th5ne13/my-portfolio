package action;

import java.io.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

public class BannerProcAction implements Action {

	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		int result = 0, nlnum = 0;
		String lnk = "";
		BannerService bannerService = new BannerService();
		
		result = bannerService.updateBanner(request);
		lnk = "bannerView.page";

		ActionForward forward = new ActionForward();
		if (result == 1) {
			forward.setRedirect(true);
			forward.setPath(lnk);
		} else {
			response.setContentType("html/text; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('작업에 실패했습니다.');");
			out.println("history.back();");
			out.println("</script>");
		}
		
		return forward;	
	}

}
