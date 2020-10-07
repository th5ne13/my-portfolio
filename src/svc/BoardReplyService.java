package svc;

import static db.JdbcUtil.*;
import java.sql.Connection;
import java.util.*;
import javax.servlet.http.*;
import dao.*;
import vo.*;

public class BoardReplyService {
//	
//	// 게시판의 목록 개수를 리턴하는 메소드
//	public int getListCount(String where) {
//		int rcount = 0;
//		BoardDAO boardDAO = BoardDAO.getInstance();
//		Connection conn = getConnection();
//		boardDAO.setConnection(conn);		
//		rcount = boardDAO.getListCount(where);				
//		close(conn);		
//		return rcount;		
//	}	

	// 게시판의 목록을 ArrayList형태로 리턴하는 메소드
	public ArrayList<ReplyInfo> getReplyList(int num) {
		ArrayList<ReplyInfo> replyList = new ArrayList<ReplyInfo>();
		BoardReplyDAO boardReplyDAO = BoardReplyDAO.getInstance();
		Connection conn = getConnection();
		boardReplyDAO.setConnection(conn);		
		replyList = boardReplyDAO.getReplyList(num);				
		close(conn);
		
		return replyList;		
	}
	
	// 댓글의 등록결과와 번호를 를 String형으로 리턴하는 메소드
	public String insertBoardReply(HttpServletRequest request) {
		BoardReplyDAO boardReplyDAO = BoardReplyDAO.getInstance();
		Connection conn = getConnection();
		boardReplyDAO.setConnection(conn);		
		String blResult = boardReplyDAO.insertBoardReply(request);
		int result = Integer.parseInt(blResult.substring(0, blResult.indexOf(':')));
		if (result == 1) { commit(conn); }
		else { rollback(conn); }
		close(conn);
		return blResult;
	}
	
	// 댓글에 대한 수정결과를 int형으로 리턴하는 메소드
	public int updateBoardReply(HttpServletRequest request) {
		BoardReplyDAO boardReplyDAO = BoardReplyDAO.getInstance();
		Connection conn = getConnection();
		boardReplyDAO.setConnection(conn);
		int result = boardReplyDAO.updateBoardReply(request);
		if (result == 1) { commit(conn); }
		else { rollback(conn); }
		close(conn);
		return result;
	}
	
	// 댓글을 삭제한 후 결과를 int형으로 리턴하는 메소드
	public int deleteBoardReply(HttpServletRequest request) {
		BoardReplyDAO boardReplyDAO = BoardReplyDAO.getInstance();
		Connection conn = getConnection();
		boardReplyDAO.setConnection(conn);
		int result = boardReplyDAO.deleteBoardReply(request);
		if (result == 1) { commit(conn); }
		else { rollback(conn); }
		close(conn);
		return result;
	}
	
	// 특정 댓글 하나를 리턴하는 메소드
	 public ReplyInfo getReply(int num) {
		 ReplyInfo replyInfo = null;
		 BoardReplyDAO boardReplyDAO = BoardReplyDAO.getInstance();
		Connection conn = getConnection();
		boardReplyDAO.setConnection(conn);		
		replyInfo = boardReplyDAO.getReply(num);				
		close(conn);
		 
		 return replyInfo;
	 }
		
//	// 게시판 게시글에 조회수를 증가시킨 후 결과를 int형으로 리턴하는 메소드
//	public int updateRead(int num) {
//		BoardDAO boardDAO = BoardDAO.getInstance();
//		Connection conn = getConnection();
//		boardDAO.setConnection(conn);
//		int result = boardDAO.updateRead(num);
//		if (result == 1) { commit(conn); }
//		else { rollback(conn); }
//		close(conn);
//		return result;
//	}

}
