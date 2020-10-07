package svc;

import static db.JdbcUtil.*;
import java.sql.Connection;
import java.util.*;
import javax.servlet.http.*;
import dao.*;
import vo.*;

public class RnoticeService {
	// 공지사항의 목록 개수를 리턴하는 메소드
	public int getListCount(String where) {
		int rcount = 0;
		RnoticeDAO rnoticeDAO = RnoticeDAO.getInstance();
		Connection conn = getConnection();
		rnoticeDAO.setConnection(conn);
		rcount = rnoticeDAO.getListCount(where);
		close(conn);
		return rcount;
	}

	// 공지사항의 목록을 ArrayList형태로 리턴하는 메소드
	public ArrayList<RnoticeInfo> getNoticeList(String where, int cpage, int limit) {
		ArrayList<RnoticeInfo> rnoticeList = new ArrayList<RnoticeInfo>();
		RnoticeDAO rnoticeDAO = RnoticeDAO.getInstance();
		Connection conn = getConnection();
		rnoticeDAO.setConnection(conn);
		rnoticeList = rnoticeDAO.getNoticeList(where, cpage, limit);
		close(conn);
		return rnoticeList;
	}

	// 공지사항 등록결과와 글번호를 String형으로 리턴하는 메소드
	public String insertNotice(HttpServletRequest request) {
		RnoticeDAO rnoticeDAO = RnoticeDAO.getInstance();
		Connection conn = getConnection();
		rnoticeDAO.setConnection(conn);
		String nlResult = rnoticeDAO.insertNotice(request);
		int result = Integer.parseInt(nlResult.substring(0, nlResult.indexOf(':')));
		if (result == 1) { commit(conn); }
		else { rollback(conn); }
		close(conn);
		return nlResult;
	}
	
	
	// 특정 공지사항 글 하나를 리턴하는 메소드
	public RnoticeInfo getNotice(int num) {
		RnoticeInfo rnoticeInfo = null;
		RnoticeDAO rnoticeDAO = RnoticeDAO.getInstance();
		Connection conn = getConnection();
		rnoticeDAO.setConnection(conn);
		rnoticeInfo = rnoticeDAO.getNotice(num);
		close(conn);
		return rnoticeInfo;
	}
	
	// 공지사항 게시글에 대한 수정결과를 int형으로 리턴하는 메소드
	public int updateNotice(HttpServletRequest request) {
		RnoticeDAO rnoticeDAO = RnoticeDAO.getInstance();
		Connection conn = getConnection();
		rnoticeDAO.setConnection(conn);
		int result = rnoticeDAO.updateNotice(request);
		if (result > 0) { commit(conn); }
		else { rollback(conn); }
		close(conn);
		return result;
	}
	
}
