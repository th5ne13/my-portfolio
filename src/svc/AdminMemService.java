package svc;

import static db.JdbcUtil.*;
import java.sql.Connection;
import java.util.*;
import javax.servlet.http.*;
import dao.*;
import vo.*;

public class AdminMemService {
	// 공지사항의 목록 개수를 리턴하는 메소드
	public int getListCount(String where) {
		int rcount = 0;
		AdminMemDAO adminMemDAO = AdminMemDAO.getInstance();
		Connection conn = getConnection();
		adminMemDAO.setConnection(conn);
		rcount = adminMemDAO.getListCount(where);
		close(conn);
		return rcount;
	}

	// 회원들의 목록을 ArrayList형태로 리턴하는 메소드
	public ArrayList<MemberInfo> getMemberList(String where, int cpage, int limit) {
		ArrayList<MemberInfo> memberList = new ArrayList<MemberInfo>();
		AdminMemDAO adminMemDAO = AdminMemDAO.getInstance();
		Connection conn = getConnection();
		adminMemDAO.setConnection(conn);
		memberList = adminMemDAO.getMemberList(where, cpage, limit);
		close(conn);
		return memberList;
	}
	
	// 탈퇴한 회원들의 목록을 ArrayList형태로 리턴하는 메소드
	public ArrayList<MemberInfo> getDeletedMemList(String where, int cpage, int limit) {
		ArrayList<MemberInfo> deletedMemberList = new ArrayList<MemberInfo>();
		AdminMemDAO adminMemDAO = AdminMemDAO.getInstance();
		Connection conn = getConnection();
		adminMemDAO.setConnection(conn);
		deletedMemberList = adminMemDAO.getDeletedMemList(where, cpage, limit);
		close(conn);
		return deletedMemberList;
	}
	
	// 강제로회원탈퇴시켜버리는 메소드
	public int getRidOfMember(HttpServletRequest request) {
		AdminMemDAO adminMemDAO = AdminMemDAO.getInstance();
		Connection conn = getConnection();
		adminMemDAO.setConnection(conn);
		int result = adminMemDAO.getRidOfMember(request);
		if (result > 0) { commit(conn); }
		else { rollback(conn); }
		close(conn);
		return result;
	}	
	
	// 회원정보를 수정하는 메소드
	public int updateMember(HttpServletRequest request) {
		AdminMemDAO adminMemDAO = AdminMemDAO.getInstance();
		Connection conn = getConnection();
		adminMemDAO.setConnection(conn);
		int result = adminMemDAO.updateMember(request);
		if (result > 0) { commit(conn); }
		else { rollback(conn); }
		close(conn);
		return result;
	}	
}
