package dao;

import java.io.*;
import java.sql.*;
import java.util.ArrayList;
import javax.servlet.http.*;
import vo.*;
import javax.servlet.ServletException;
import static db.JdbcUtil.*;

public class BoardReplyDAO {
	
	private static BoardReplyDAO boardReplyDAO;	
	private Connection conn;	
	
	private BoardReplyDAO() {}					

	public static BoardReplyDAO getInstance() {
		if (boardReplyDAO == null) {		 
			boardReplyDAO = new BoardReplyDAO();
		}
		
		return boardReplyDAO;
	}
	
	public void setConnection(Connection conn) {		
		this.conn = conn;
	}
	

	// 새 댓 글을 등록시키는 메소드
	public String insertBoardReply(HttpServletRequest request) {
		int result = 0;
		String blResult = "";
		Statement stmt = null;
		try {			
			stmt = conn.createStatement();
			String sql = "insert into t_board_reply (bl_num, ml_id, br_content, br_ip) ";
			sql += " values (" + request.getParameter("blnum") + ", '";
			sql += request.getParameter("mlid") + "', '";
			sql += request.getParameter("brContent").trim().replaceAll("'", "''") + "', '";
			sql += "127.0.0.0.1') ";
			result = stmt.executeUpdate(sql);
			blResult = result + ":" + request.getParameter("blnum");
			
			sql = "update t_board_list set bl_replycnt = bl_replycnt + 1 where bl_num = " + request.getParameter("blnum");
			stmt.executeUpdate(sql);
			
		} catch(Exception e) {
			e.printStackTrace();			
		} finally {
			close(stmt);
		}		
		
		return blResult;
	}

	// 해당 게시물의 댓글 목록을 ArrayList<BoardInfo>형태로 리턴하는 메소드
	public ArrayList<ReplyInfo> getReplyList(int num) {
		ArrayList<ReplyInfo> replyList = new ArrayList<ReplyInfo>();

		Statement stmt = null;
		ResultSet rs = null;
		ReplyInfo replyInfo = null;
		try {
			String sql = "select * from t_board_reply where br_isview = 'y' and bl_num = " + num;
			sql += " order by br_num desc ";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {					// 없을 경우 처리가 필요 없기 때문에 if문 없이 바로 while문 사용 가능
				replyInfo = new ReplyInfo();
				// 하나의 게시글 데이터를 담기위한 boardInfo 인스턴스 생성
				
				replyInfo.setMl_id(rs.getString("ml_id"));
				replyInfo.setBr_content(rs.getString("br_content"));
				replyInfo.setBr_date(rs.getString("br_date"));
				replyInfo.setBr_num(rs.getInt("br_num"));
				
				// 생성된 인스턴스에 데이터 채우기
				
				replyList.add(replyInfo);		
				// 공지사항 목록을 담을 ArrayList에 생성한 인스턴스를 넣음
			}
			
		} catch(Exception e) {
			System.out.println("getReplyList() 메소드 오류");
			e.printStackTrace();			
		} finally {
			close(rs);
			close(stmt);
		}
		return replyList;	
	}
	
	
	// 댓글을 수정하는 메소드
	public int updateBoardReply(HttpServletRequest request) {
		int result = 0;
		Statement stmt = null;
		try {
			String brNum = request.getParameter("brNum");
			String brContent = request.getParameter("brContent").trim().replaceAll("'", "''");
			String sql = "update t_board_reply set ";
			sql += " br_content = '" + brContent + "' ";
			sql += "where br_num = " + brNum;
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			
		} catch(Exception e) {
			System.out.println("updateBoardReply() 메소드 오류");
			e.printStackTrace();			
		} finally {
			close(stmt);
		}		
		
		return result;
	}
	
	// 댓글을 삭제하는 메소드
	public int deleteBoardReply(HttpServletRequest request) {
		int result = 0;
		Statement stmt = null;
		try {
			String num = request.getParameter("num");
			String sql = "delete from t_board_reply where br_num = " + num;
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);

			sql = "update t_board_list set bl_replycnt = bl_replycnt - 1 where bl_num = " + request.getParameter("blnum");
			stmt.executeUpdate(sql);
			
		} catch(Exception e) {
			System.out.println("deleteBoardReply() 메소드 오류");
			e.printStackTrace();			
		} finally {
			close(stmt);
		}		
		
		return result;
	}
	
	
	// 특정 댓글 하나를 리턴하는 메소드
	public ReplyInfo getReply(int num) {
		ReplyInfo replyInfo = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select * from t_board_reply where br_num = " + num;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				replyInfo = new ReplyInfo();

				replyInfo.setBr_content(rs.getString("br_content"));
								
			}				
		} catch(Exception e) {
			System.out.println("getReply() 메소드 오류");
			e.printStackTrace();			
		} finally {
			close(rs);
			close(stmt);
		}					
			 
		return replyInfo;			
	}

}
