package action;

import java.io.*;
import java.util.*;
import javax.servlet.http.*;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import svc.*;
import vo.*;

public class GroundViewAction implements Action {

	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		request.setCharacterEncoding("utf-8");
		String glcode = (String)request.getParameter("glcode");

		String date = (String)request.getParameter("date");
		String memAddr = "";
		GroundReqService groundReqService = new GroundReqService();
		HttpSession session = request.getSession();
		MemberInfo mem = (MemberInfo)session.getAttribute("memberInfo");
		if (mem != null)	memAddr = mem.getMl_addr1();
		AdminInfo adminInfo = (AdminInfo)session.getAttribute("adminInfo");
				
		GroundListInfo groundListInfo = groundReqService.getGround(glcode, date);
		if (glcode == null || glcode.equals("")) {
			ArrayList<GroundListInfo> groundList = new ArrayList<GroundListInfo>();
			groundList = groundReqService.getGroundList(request, memAddr);
			request.setAttribute("date", date);
			request.setAttribute("groundList", groundList);
			session.setAttribute("groundList", groundList);
		} else {
			request.setAttribute("groundListInfo", groundListInfo);
			session.setAttribute("groundListInfo", groundListInfo);
		}

		BannerService bannerService = new BannerService();		
		PageMainInfo bannerInfo = bannerService.getBanner();
		request.setAttribute("bannerInfo", bannerInfo);

		if (groundListInfo == null) {		// 제휴구장 정보가 없으면
			response.setContentType("html/text; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('잘못된 경로로 들어오셨습니다.');");
			out.println("history.back();");
			out.println("</script>");
		}
		
		ActionForward forward = new ActionForward();
		if (adminInfo != null) 	forward.setPath("/admin/groundRequest/adminGroundReqForm.jsp?wtype=up");
		else					forward.setPath("/groundRequest/groundReqForm.jsp?wtype=up");
		
		return forward;
		
	}
}
