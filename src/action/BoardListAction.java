package action;

import java.util.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

public class BoardListAction implements Action {

	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		// 검색어 관련 request를 위한 캐릭터 인코딩
		String schType = request.getParameter("schType");	// 검색조건
		String keyword = request.getParameter("keyword");	// 검색어
		String btype = request.getParameter("btype");		// 게시판종류
		String where = " and bl_boardtype = '" + btype + "' ";
		
		if (schType != null && !schType.equals("") && keyword != null && !keyword.equals("")) {
			if (schType.equals("tc")) {
				where += " and (bl_title like '%" + keyword + "%' or bl_content like '%" + keyword + "%') ";
			} else {
				where += " and bl_" + schType + " like '%" + keyword + "%'";
			}
		}
		
		ArrayList<BoardInfo> boardList = new ArrayList<BoardInfo>();
		// 공지사항 목록을 저장하기 위한 컬렉션으로 BoardInfo형 인스턴스만 저장됨
		int cpage = 1;		// 현재 페이지 번호를 저장할 변수
		int limit = 10;		// 한 페이지에서 보여줄 공지사항 개수. 페이지 크기
		
		if (request.getParameter("cpage") != null) {					// 받아온 페이지 번호가 있으면 String에서 Int형 데이터로 변형
			cpage = Integer.parseInt(request.getParameter("cpage"));
		}
		
		BoardService boardService = new BoardService();
		int rcount = boardService.getListCount(where);
		boardList = boardService.getBoardList(where, cpage, limit);
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
		request.setAttribute("boardList", boardList);
		// request객체에 새로운 속성을 추가
		// 이동할 곳으로 request객체와 response객체를 공유하기 위해 Dispatcher방식 사용(Redirect는 공유하지 않고 그냥 보냄)
		
		ActionForward forward = new ActionForward();
		forward.setPath("/bbs/boardList.jsp");
		
		return forward;
	}
}
