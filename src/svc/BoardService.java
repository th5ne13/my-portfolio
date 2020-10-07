package svc;

import static db.JdbcUtil.*;
import java.sql.Connection;
import java.util.*;
import javax.servlet.http.*;
import dao.*;
import vo.*;

public class BoardService {
	
	// 게시판의 목록 개수를 리턴하는 메소드
	public int getListCount(String where) {
		int rcount = 0;
		BoardDAO boardDAO = BoardDAO.getInstance();
		Connection conn = getConnection();
		boardDAO.setConnection(conn);		
		rcount = boardDAO.getListCount(where);				
		close(conn);		
		return rcount;		
	}	

	// 게시판의 목록을 ArrayList형태로 리턴하는 메소드
	public ArrayList<BoardInfo> getBoardList(String where, int cpage, int limit) {
		ArrayList<BoardInfo> boardList  = new ArrayList<BoardInfo>(20);
		BoardDAO boardDAO = BoardDAO.getInstance();
		Connection conn = getConnection();
		boardDAO.setConnection(conn);		
		boardList = boardDAO.getBoardList(where, cpage, limit);				
		close(conn);
		
		return boardList;		
	}
	
	// 게시판 등록결과와 글번호를 를 String형으로 리턴하는 메소드
	public String insertBoard(HttpServletRequest request) {
		BoardDAO boardDAO = BoardDAO.getInstance();
		Connection conn = getConnection();
		boardDAO.setConnection(conn);		
		String blResult = boardDAO.insertBoard(request);
		int result = Integer.parseInt(blResult.substring(0, blResult.indexOf(':')));
		if (result == 1) { commit(conn); }
		else { rollback(conn); }
		close(conn);
		return blResult;
	}
	
	// 게시판 게시글에 대한 수정결과를 int형으로 리턴하는 메소드
	public int updateBoard(HttpServletRequest request) {
		BoardDAO boardDAO = BoardDAO.getInstance();
		Connection conn = getConnection();
		boardDAO.setConnection(conn);
		int result = boardDAO.updateBoard(request);
		if (result == 1) { commit(conn); }
		else { rollback(conn); }
		close(conn);
		return result;
	}
	
	// 게시판 게시글을 삭제한 후 결과를 int형으로 리턴하는 메소드
	public String deleteBoard(HttpServletRequest request) {
		BoardDAO boardDAO = BoardDAO.getInstance();
		Connection conn = getConnection();
		boardDAO.setConnection(conn);
		String blResult = boardDAO.deleteBoard(request);
		int result = Integer.parseInt(blResult.substring(0, blResult.indexOf(':')));
		if (result == 1) { commit(conn); }
		else { rollback(conn); }
		close(conn);
		return blResult;
	}
	
	// 특정 게시글 하나를 리턴하는 메소드
	 public BoardInfo getBoard(int num) {
		BoardInfo boardInfo = null;
		BoardDAO boardDAO = BoardDAO.getInstance();
		Connection conn = getConnection();
		boardDAO.setConnection(conn);		
		boardInfo = boardDAO.getBoard(num);				
		close(conn);
		 
		 return boardInfo;
	 }
		
	// 게시판 게시글에 조회수를 증가시킨 후 결과를 int형으로 리턴하는 메소드
	public int updateRead(int num) {
		BoardDAO boardDAO = BoardDAO.getInstance();
		Connection conn = getConnection();
		boardDAO.setConnection(conn);
		int result = boardDAO.updateRead(num);
		if (result == 1) { commit(conn); }
		else { rollback(conn); }
		close(conn);
		return result;
	}
}
