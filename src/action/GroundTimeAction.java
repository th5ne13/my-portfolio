package action;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import svc.GroundReqService;
import vo.ActionForward;
import vo.GroundRevInfo;

public class GroundTimeAction implements Action {

	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		request.setCharacterEncoding("utf-8");
		String glcode = (String)request.getParameter("glcode");
		String date = (String)request.getParameter("date");
		String num = (String)request.getParameter("num");
		GroundReqService groundReqService = new GroundReqService();
		
		ArrayList<GroundRevInfo> grdRevList = new ArrayList<GroundRevInfo>();
		grdRevList = groundReqService.getGrdRev(glcode, date);
		request.setAttribute("grdRevList", grdRevList);
		request.setAttribute("date", date);

		if (grdRevList == null) {
			response.setContentType("html/text; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('잘못된 경로로 들어오셨습니다.');");
			out.println("history.back();");
			out.println("</script>");
		}
		
		ActionForward forward = new ActionForward();		
		forward.setPath("/groundRequest/groundRevTime.jsp");
		if (num != null && !num.equals(""))	{
			request.setAttribute("glcode", glcode);
			request.setAttribute("num", num);
			forward.setPath("/groundRequest/sendRevTime.jsp");
		}
		return forward;
		
	}

}
