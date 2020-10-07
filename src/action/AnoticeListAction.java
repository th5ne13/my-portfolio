package action;

import java.util.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

public class AnoticeListAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String schType = request.getParameter("schType");	// 검색 조건
		String keyword = request.getParameter("keyword");	// 검색어
		String where = "";
		if (schType != null && !schType.equals("") && 
			keyword != null && !keyword.equals("")) {
			if (schType.equals("tc")) {	// 제목 + 내용 검색일 경우
				where = " and (al_matchtype like '%" + keyword + "%'";
				where += " or al_addr2 like '%" + keyword + "%') ";
			} else {	// 제목이나 내용 검색일 경우
				where = " and al_" + schType + " like '%" + keyword + "%' ";
				// 나중에 select 컨트롤 안 옵션의 value값을 addr1 혹은 addr2로 지정하기
			}
		}

		ArrayList<AnoticeInfo> anoticeList = new ArrayList<AnoticeInfo>();
		int cpage = 1;	// 현재 페이지 번호를 저장할 변수
		int limit = 10;	// 한 페이지에서 보여줄 공지사항 개수. 페이지 크기
		if (request.getParameter("cpage") != null) {
			cpage = Integer.parseInt(request.getParameter("cpage"));
		}

		AnoticeService noticeService = new AnoticeService();
		int rcount = noticeService.getListCount(where);
		anoticeList = noticeService.getNoticeList(where, cpage, limit);

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
		request.setAttribute("anoticeList", anoticeList);

		ActionForward forward = new ActionForward();
		forward.setPath("/player/applyBoard.jsp");

		return forward;
	}
}
