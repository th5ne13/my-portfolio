package svc;

import static db.JdbcUtil.*;
import java.sql.Connection;
import java.util.*;
import javax.servlet.http.*;
import dao.*;
import vo.*;

public class PerBoardService {
	
	// 1:1 게시판의 목록을 ArrayList형태로 리턴하는 메소드
	public ArrayList<PerBoardInfo> getPerBoardList(String where, String mlid) {
		ArrayList<PerBoardInfo> perBoardList  = new ArrayList<PerBoardInfo>(20);
		PerBoardDAO perBoardDAO = PerBoardDAO.getInstance();
		Connection conn = getConnection();
		perBoardDAO.setConnection(conn);		
		perBoardList = perBoardDAO.getPerBoardList(where, mlid);				
		close(conn);
		
		return perBoardList;		
	}
	
	// 1:1 게시판 등록결과와 글번호를 를 String형으로 리턴하는 메소드
	public String insertPerBoard(HttpServletRequest request) {
		PerBoardDAO perBoardDAO = PerBoardDAO.getInstance();
		Connection conn = getConnection();
		perBoardDAO.setConnection(conn);		
		String qlResult = perBoardDAO.insertPerBoard(request);
		int result = Integer.parseInt(qlResult.substring(0, qlResult.indexOf(':')));
		if (result == 1) { commit(conn); }
		else { rollback(conn); }
		close(conn);
		return qlResult;
	}
	
	// 1:1 게시판 게시글에 대한 수정결과를 int형으로 리턴하는 메소드
	public int updatePerBoard(HttpServletRequest request) {
		PerBoardDAO perBoardDAO = PerBoardDAO.getInstance();
		Connection conn = getConnection();
		perBoardDAO.setConnection(conn);
		int result = perBoardDAO.updatePerBoard(request);
		if (result == 1) { commit(conn); }
		else { rollback(conn); }
		close(conn);
		return result;
	}
	
	// 1:1 게시판 게시글을 삭제한 후 결과를 int형으로 리턴하는 메소드
	public int deletePerBoard(HttpServletRequest request) {
		PerBoardDAO perBoardDAO = PerBoardDAO.getInstance();
		Connection conn = getConnection();
		perBoardDAO.setConnection(conn);
		int result = perBoardDAO.deletePerBoard(request);
		if (result == 1) { commit(conn); }
		else { rollback(conn); }
		close(conn);
		return result;
	}
//	
	// 특정 1:1 게시글 하나를 리턴하는 메소드
	 public PerBoardInfo getPerBoard(int num) {
		PerBoardInfo perBoardInfo = null;
		PerBoardDAO perBoardDAO = PerBoardDAO.getInstance();
		Connection conn = getConnection();
		perBoardDAO.setConnection(conn);		
		perBoardInfo = perBoardDAO.getPerBoard(num);				
		close(conn);
		 
		 return perBoardInfo;
	 }

		
	// 어드민 화면에서 1:1 게시판의 목록을 ArrayList형태로 리턴하는 메소드
	public ArrayList<PerBoardInfo> getPerBoardList(String amid) {
		ArrayList<PerBoardInfo> perBoardList  = new ArrayList<PerBoardInfo>(20);
		PerBoardDAO perBoardDAO = PerBoardDAO.getInstance();
		Connection conn = getConnection();
		perBoardDAO.setConnection(conn);		
		perBoardList = perBoardDAO.getPerBoardList(amid);
		close(conn);
		
		return perBoardList;		
	}
	
	// 어드민 화면에서 1:1 게시판 게시글에 대한 답변/수정결과를 int형으로 리턴하는 메소드
	public int adminUpdatePerBoard(HttpServletRequest request, String alid) {
		PerBoardDAO perBoardDAO = PerBoardDAO.getInstance();
		Connection conn = getConnection();
		perBoardDAO.setConnection(conn);
		int result = perBoardDAO.adminUpdatePerBoard(request, alid);
		if (result == 1) { commit(conn); }
		else { rollback(conn); }
		close(conn);
		return result;
	}

}
