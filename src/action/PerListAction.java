package action;

import java.io.PrintWriter;
import java.util.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

public class PerListAction implements Action {

	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession();
		MemberInfo mem = (MemberInfo)session.getAttribute("memberInfo");
		AdminInfo admem = (AdminInfo)session.getAttribute("adminInfo");
		String mlid = "";
		String amid = "";
		
		String schType = request.getParameter("schType");	// �˻�����
		String keyword = request.getParameter("keyword");	// �˻���
		String where = "";
		
		if (schType != null && !schType.equals("") && keyword != null && !keyword.equals("")) {
			if (schType.equals("tc")) {
				where = " and (ql_title like '%" + keyword + "%'";
				where += " or ql_content like '%" + keyword + "%') ";
			} else {
				where = " and ql_" + schType + " like '%" + keyword + "%'";
			}
		}		
		
		ActionForward forward = new ActionForward();
		ArrayList<PerBoardInfo> perBoardList = new ArrayList<PerBoardInfo>();	
		PerBoardService perBoardService = new PerBoardService();	

		if (mem != null) {
			mlid = mem.getMl_id();			
			perBoardList = perBoardService.getPerBoardList(where, mlid);
			forward.setPath("/bbs/perBoardList.jsp");	
			if (mlid == null || mlid.equals(""))	forward.setPath("loginForm.jsp");
		} else if (admem != null) {
			amid = admem.getAl_id();
			perBoardList = perBoardService.getPerBoardList(amid);
			forward.setPath("/admin/bbs/perBoardView.jsp");
			if (amid == null || amid.equals(""))	forward.setPath("admin/index.jsp");
		}		
		request.setAttribute("perBoardList", perBoardList);
		
		
		return forward;
	}

}
