package action;
// 제일먼저 import하기

import java.util.*; // Arraylist사용하기 위해서
import javax.servlet.RequestDispatcher;
import javax.servlet.http.*; // request, response 사용하기 위해서
import svc.*;
import vo.*;

public class AGroundListAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {// 인터페이스 이므로 접근제어지시자가 없으면 무조건 public  	
		request.setCharacterEncoding("utf-8");
		// 검색어 관련 request를 위한 캐릭터 인코딩
		String schType = request.getParameter("schType"); // 검색조건
		String keyword = request.getParameter("keyword"); // 검색기능
		String where = "";
		if (schType != null  && !schType.equals("") && keyword != null  && !keyword.equals("")) {	// 검색어가 있으면
			// 객체가 null인지 여부와 무엇이 들어있는지 검사하는 조건에서는 null인지 여부를 먼저 검사해야 함(에러해결방법-실수조심)	
			if (schType.equals("jibeon")) {	// 검색조건이 '제목+내용'이면	
				where = " and gl_" + schType + " like '%" + keyword + "%' ";
			} else if (schType.equals("grdname")) {
				where = " and gl_" + schType + " like '%" + keyword + "%' ";
			} else if (schType.equals("name")) {
				where = " and gl_" + schType + " like '%" + keyword + "%' ";
			}
		}

		ArrayList<GroundListInfo> adminGroundList = new ArrayList<GroundListInfo>();
		// 공지사항 목록을 저장하기 위한 컬렉션으로 NoticeInfo형 인스턴스만 저장됨
		int cpage = 1;	// 현재 페이지 번호를 저장할 변수
		int limit = 3; // 한 페이지에서 보여줄 공지사항 개수. 페이지 크기

		if (request.getParameter("cpage") != null) {
			cpage = Integer.parseInt(request.getParameter("cpage"));
		}
		
		GroundReqService groundReqService = new GroundReqService();
		int rcount = groundReqService.getListCount(where);	// 글개수
		adminGroundList = groundReqService.getGroundList(where, cpage, limit); // cpage, limit가 있어야 내가 원하는 목록만 선택하여 가져올 수 있음
		
		int mpage = (int)((double)rcount / limit + 0.95); // 전체페이지
		int spage = (((int)((double)cpage / 10 + 0.9)) - 1) * 10 + 1; // 시작페이지
		int epage = spage + 10 - 1; // 종료페이지
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
		request.setAttribute("adminGroundList", adminGroundList);
		
		ActionForward forward = new ActionForward();
		forward.setPath("/admin/groundRequest/adminGrdList.jsp");
		
		return forward;
	}
}
