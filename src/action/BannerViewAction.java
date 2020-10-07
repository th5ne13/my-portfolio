package action;

import java.io.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import svc.BannerService;
import vo.ActionForward;
import vo.PageMainInfo;

public class BannerViewAction implements Action {

	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");

		BannerService bannerService = new BannerService();		
		PageMainInfo bannerInfo = bannerService.getBanner();
		request.setAttribute("bannerInfo", bannerInfo);
		
		ActionForward forward = new ActionForward();
		forward.setPath("/admin/page/bannerView.jsp");		
		
		return forward;
	}
}
