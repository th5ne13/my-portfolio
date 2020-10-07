package action;

import java.util.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

public class StatMemListAction implements Action {
	public ActionForward execute(HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		// 검색어관련 request를 위한 캐릭터 인코딩

		String where = "";
		
		ArrayList<MemberInfo> statMemList = new ArrayList<MemberInfo>();
		
		HttpSession session = request.getSession();
			
		// 공지사항 목록을 저장하기 위한 컬렉션으로 NoticeInfo형 인스턴스만 저장됨
		int cpage = 1;	// 현재 페이지 번호를 저장할 변수
		int limit = 10;	// 한 페이지에서 보여줄 공지사항 개수. 페이지 크기
		if (request.getParameter("cpage") != null) {
		// 받아온 페이지 번호가 있으면 String에서 int형 데이터로 변형
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

		// request객체에 새로운 속성을 추가
		// 이동할 곳으로 request와 response객체를 공유하기 위해 Dispatcher방식 사용

		ActionForward forward = new ActionForward();
		forward.setPath("/admin/memberStatistics.jsp");

		return forward;
	}
}
