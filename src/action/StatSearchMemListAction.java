package action;

import java.util.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

public class StatSearchMemListAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");	
		String name = request.getParameter("name");
		String memid = request.getParameter("memid");
		String payment1 = request.getParameter("payment1");
		String payment2 = request.getParameter("payment2");
		String lastlogin = request.getParameter("lastlogin");
		String thenumofpost1 = request.getParameter("thenumofpost1");
		String thenumofpost2 = request.getParameter("thenumofpost2");
		String addr = request.getParameter("addr");
		String thenumofrecruitment1 = request.getParameter("thenumofrecruitment1");
		String thenumofrecruitment2 = request.getParameter("thenumofrecruitment2");
		String thenumofapply1 = request.getParameter("thenumofapply1");
		String thenumofapply2 = request.getParameter("thenumofapply2");
		String where = "";

		if (name != null && !name.equals(""))									where += " and ml_name = '" + name + "' ";
		if (memid != null && !memid.equals(""))									where += " and ml_id = '" + memid + "' ";
		if (payment1 != null && !payment1.equals(""))							where += " and ml_pay >= '" + payment1 + "' ";
		if (payment2 != null && !payment2.equals(""))							where += " and ml_pay <= '" + payment2 + "' ";
		if (lastlogin != null && !lastlogin.equals(""))							where += " and ml_lastlogin >= STR_TO_DATE('" + lastlogin + "', '%Y-%m-%d') ";
		if (thenumofpost1 != null && !thenumofpost1.equals(""))					where += " and ml_boardcnt >= '" + thenumofpost1 + "' ";
		if (thenumofpost2 != null && !thenumofpost2.equals(""))					where += " and ml_boardcnt <= '" + thenumofpost2 + "' ";
		if (addr != null && !addr.equals(""))									where += " and concat(ml_addr1,' ', ml_addr2) like '%" + addr + "%' ";
		if (thenumofrecruitment1 != null && !thenumofrecruitment1.equals(""))	where += " and ml_recruitcnt >= '" + thenumofrecruitment1 + "' ";
		if (thenumofrecruitment2 != null && !thenumofrecruitment2.equals(""))	where += " and ml_recruitcnt <= '" + thenumofrecruitment2 + "' ";
		if (thenumofapply1 != null && !thenumofapply1.equals(""))				where += " and ml_applycnt >= '" + thenumofapply1 + "' ";
		if (thenumofapply2 != null && !thenumofapply2.equals(""))				where += " and ml_applycnt <= '" + thenumofapply2 + "' ";
		
	
		int cpage = 1;
		int limit = 10;
		ArrayList<MemberInfo> statMemList = new ArrayList<MemberInfo>();
		
		
		HttpSession session = request.getSession();			
		if (request.getParameter("cpage") != null) {
			cpage = Integer.parseInt(request.getParameter("cpage"));
		}

		StatMemService statMemService = new StatMemService();
		int rcount = statMemService.getStatMemListCount(where);
		statMemList = statMemService.getStatMemList(where, cpage, limit);

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

		
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("statMemList", statMemList);
		session.setAttribute("statMemList", statMemList);


		ActionForward forward = new ActionForward();
		forward.setPath("/admin/memberStatistics.jsp");

		return forward;
	}
}
