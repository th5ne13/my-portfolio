package svc;

import static db.JdbcUtil.*;
import java.sql.Connection;
import java.util.*;
import javax.servlet.http.*;
import dao.*;
import vo.*;

public class StatMemService {
	// 공지사항의 목록 개수를 리턴하는 메소드
	public int getStatMemListCount(String where) {
		int rcount = 0;
		StatMemDAO statMemDAO = StatMemDAO.getInstance();
		Connection conn = getConnection();
		statMemDAO.setConnection(conn);
		rcount = statMemDAO.getStatMemListCount(where);
		close(conn);
		return rcount;
	}

	// 회원들의 목록을 ArrayList형태로 리턴하는 메소드
	public ArrayList<MemberInfo> getStatMemList(String where, int cpage, int limit) {
		ArrayList<MemberInfo> statMemList = new ArrayList<MemberInfo>();
		StatMemDAO statMemDAO = StatMemDAO.getInstance();
		Connection conn = getConnection();
		statMemDAO.setConnection(conn);
		statMemList = statMemDAO.getStatMemList(where, cpage, limit);
		close(conn);
		return statMemList;
	}	
}
