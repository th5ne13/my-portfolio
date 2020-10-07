package action;

import java.util.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

public class RnoticeListAction implements Action {
	public ActionForward execute(HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String schType = request.getParameter("schType");
		String keyword = request.getParameter("keyword");
		String where = "";
		if (schType != null && !schType.equals("") && 
			keyword != null && !keyword.equals("")) {
			if (schType.equals("tc")) {
				where = " and (rl_matchtype like '%" + keyword + "%'";
				where += " or rl_addr2 like '%" + keyword + "%') ";
			} else {
				where = " and rl_" + schType + " like '%" + keyword + "%' ";
			}
		}

		ArrayList<RnoticeInfo> rnoticeList = new ArrayList<RnoticeInfo>();
		int cpage = 1;
		int limit = 10;
		if (request.getParameter("cpage") != null) {
			cpage = Integer.parseInt(request.getParameter("cpage"));
		}

		RnoticeService noticeService = new RnoticeService();
		int rcount = noticeService.getListCount(where);
		rnoticeList = noticeService.getNoticeList(where, cpage, limit);

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
		request.setAttribute("rnoticeList", rnoticeList);

		ActionForward forward = new ActionForward();
		forward.setPath("/player/recruitBoard.jsp");

		return forward;
	}
}
