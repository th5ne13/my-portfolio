package svc;

import static db.JdbcUtil.*;
import java.sql.Connection;
import java.util.*;
import javax.servlet.http.*;
import dao.*;
import vo.*;

public class MemberRequestService {
	// 공지사항 등록결과와 글번호를 String형으로 리턴하는 메소드
	public String insertRequest(HttpServletRequest request) {
		RequestDAO requestDAO = RequestDAO.getInstance();
		Connection conn = getConnection();
		requestDAO.setConnection(conn);
		String nlResult = requestDAO.insertRequest(request);
		int result = Integer.parseInt(nlResult.substring(0, nlResult.indexOf(':')));
		if (result == 1) { commit(conn); }
		else { rollback(conn); }
		close(conn);
		return nlResult;
	}
	
	// 공지사항의 목록 개수를 리턴하는 메소드
	public int getListCount(String where) {
		int rcount = 0;
		RequestDAO requestDAO = RequestDAO.getInstance();
		Connection conn = getConnection();
		requestDAO.setConnection(conn);
		rcount = requestDAO.getListCount(where);
		close(conn);
		return rcount;
	}

	// 공지사항의 목록을 ArrayList형태로 리턴하는 메소드
	public ArrayList<PlayerInfo> getRecruitList(String where, int cpage, int limit) {
		ArrayList<PlayerInfo> recruitList = new ArrayList<PlayerInfo>();
		RequestDAO requestDAO = RequestDAO.getInstance();
		Connection conn = getConnection();
		requestDAO.setConnection(conn);
		recruitList = requestDAO.getRecruitList(where, cpage, limit);
		close(conn);
		return recruitList;
	}
	
	public ArrayList<PlayerInfo> getViewRecruitList(String where, int cpage, int limit) {
		ArrayList<PlayerInfo> recruitViewList = new ArrayList<PlayerInfo>();
		RequestDAO requestDAO = RequestDAO.getInstance();
		Connection conn = getConnection();
		requestDAO.setConnection(conn);
		recruitViewList = requestDAO.getViewRecruitList(where, cpage, limit);
		close(conn);
		return recruitViewList;
	}	
	// 공지사항 게시글에 대한 수정결과를 int형으로 리턴하는 메소드
	public int updateNotice(String reqnum, String btntype) {
		RequestDAO requestDAO = RequestDAO.getInstance();
		Connection conn = getConnection();
		requestDAO.setConnection(conn);
		int result = requestDAO.updateNotice(reqnum, btntype);
		if (result > 0) { commit(conn); }
		else { rollback(conn); }
		close(conn);
		return result;
	}
	
	// 공지사항 게시글에 대한 삭제 결과를 int형으로 리턴하는 메소드
	public int deleteNotice(String reqnum, String btntype, String mlid) {
		RequestDAO requestDAO = RequestDAO.getInstance();
		Connection conn = getConnection();
		requestDAO.setConnection(conn);
		int result = requestDAO.deleteNotice(reqnum, btntype, mlid);
		if (result > 0) { commit(conn); }
		else { rollback(conn); }
		close(conn);
		return result;
	}
}

