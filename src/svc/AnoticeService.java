package svc;

import static db.JdbcUtil.*;
import java.sql.Connection;
import java.util.*;
import javax.servlet.http.*;
import dao.*;
import vo.*;

public class AnoticeService {
	// 공지사항의 목록 개수를 리턴하는 메소드
	public int getListCount(String where) {
		int rcount = 0;
		AnoticeDAO anoticeDAO = AnoticeDAO.getInstance();
		Connection conn = getConnection();
		anoticeDAO.setConnection(conn);
		rcount = anoticeDAO.getListCount(where);
		close(conn);
		return rcount;
	}

	// 공지사항의 목록을 ArrayList형태로 리턴하는 메소드
	public ArrayList<AnoticeInfo> getNoticeList(String where, int cpage, int limit) {
		ArrayList<AnoticeInfo> anoticeList = new ArrayList<AnoticeInfo>();
		AnoticeDAO anoticeDAO = AnoticeDAO.getInstance();
		Connection conn = getConnection();
		anoticeDAO.setConnection(conn);
		anoticeList = anoticeDAO.getNoticeList(where, cpage, limit);
		close(conn);
		return anoticeList;
	}

	// 공지사항 등록결과와 글번호를 String형으로 리턴하는 메소드
	public String insertNotice(HttpServletRequest request) {
		AnoticeDAO anoticeDAO = AnoticeDAO.getInstance();
		Connection conn = getConnection();
		anoticeDAO.setConnection(conn);
		String nlResult = anoticeDAO.insertNotice(request);
		int result = Integer.parseInt(nlResult.substring(0, nlResult.indexOf(':')));
		if (result == 1) { commit(conn); }
		else { rollback(conn); }
		close(conn);
		return nlResult;
	}
	
	
	// 특정 공지사항 글 하나를 리턴하는 메소드
	public AnoticeInfo getNotice(int num) {
		AnoticeInfo anoticeInfo = null;
		AnoticeDAO anoticeDAO = AnoticeDAO.getInstance();
		Connection conn = getConnection();
		anoticeDAO.setConnection(conn);
		anoticeInfo = anoticeDAO.getNotice(num);
		close(conn);
		return anoticeInfo;
	}
	
	// 공지사항 게시글에 대한 수정결과를 int형으로 리턴하는 메소드
	public int updateNotice(HttpServletRequest request) {
		AnoticeDAO anoticeDAO = AnoticeDAO.getInstance();
		Connection conn = getConnection();
		anoticeDAO.setConnection(conn);
		int result = anoticeDAO.updateNotice(request);
		if (result == 1) { commit(conn); }
		else { rollback(conn); }
		close(conn);
		return result;
	}
}
