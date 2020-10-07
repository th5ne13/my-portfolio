package dao;

import java.io.*;
import java.sql.*;
import java.util.ArrayList;
import javax.servlet.http.*;
import vo.*;
import javax.servlet.ServletException;
import static db.JdbcUtil.*;

public class BoardDAO {
	
	private static BoardDAO boardDAO;	
	private Connection conn;	
	
	private BoardDAO() {}					

	public static BoardDAO getInstance() {
		if (boardDAO == null) {		 
			boardDAO = new BoardDAO();
		}
		
		return boardDAO;
	}
	
	public void setConnection(Connection conn) {		
		this.conn = conn;
	}
	
	// 국내/해외 게시판 게시물들 중 검색되는(where절 조건으로) 전체 개수를 리턴하는 메소드
	public int getListCount(String where) {
		int rcount = 0;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select count(*) from t_board_list where bl_isview = 'y' " + where;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();	
			rcount = rs.getInt(1);
		} catch(Exception e) {
			System.out.println("getListCount() 메소드 오류");
			e.printStackTrace();			
		} finally {
			close(rs);
			close(stmt);
		}			
		return rcount;
	}
	

	// 국내/해외 게시판 게시물들의 목록을 ArrayList<BoardInfo>형태로 리턴하는 메소드
	public ArrayList<BoardInfo> getBoardList(String where, int cpage, int limit) {
		ArrayList<BoardInfo> boardList  = new ArrayList<BoardInfo>(20);

		Statement stmt = null;
		ResultSet rs = null;
		BoardInfo boardInfo = null;
		try {
			int start = (cpage - 1) * limit;
			String sql = "select * from t_board_list where bl_isview = 'y' " + where;
			sql += " order by bl_num desc limit " + start + ", " + limit;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				boardInfo = new BoardInfo();
				
				boardInfo.setBl_num(rs.getInt("bl_num"));
				boardInfo.setMl_id(rs.getString("ml_id"));
				boardInfo.setBl_boardtype(rs.getString("bl_boardtype"));
				boardInfo.setBl_title(rs.getString("bl_title"));
				boardInfo.setBl_replycnt(rs.getInt("bl_replycnt"));
				boardInfo.setBl_content(rs.getString("bl_content"));
				boardInfo.setBl_read(rs.getInt("bl_read"));
				boardInfo.setBl_isview(rs.getString("bl_isview"));
				boardInfo.setBl_ip(rs.getString("bl_ip"));
				boardInfo.setBl_date(rs.getString("bl_date"));
				
				boardList.add(boardInfo);		
			}
			
		} catch(Exception e) {
			System.out.println("getBoardList() 메소드 오류");
			e.printStackTrace();			
		} finally {
			close(rs);
			close(stmt);
		}
		return boardList;	
	}
	
	// 게시판 새 글을 등록시키는 메소드
	public String insertBoard(HttpServletRequest request) {
		int result = 0, blnum = 1;
		String blResult = "";
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select max(bl_num) + 1 from t_board_list";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next())	blnum = rs.getInt(1);
			
			sql = "insert into t_board_list (bl_num, ml_id, bl_boardtype, bl_title, bl_content, bl_ip) ";
			sql += " values (" + blnum + ", '";
			sql += request.getParameter("mlid") + "', '";
			sql += request.getParameter("btype") + "', '";
			sql += request.getParameter("title").trim().replaceAll("'", "''") + "', '";
			sql += request.getParameter("content").trim().replaceAll("'", "''") + "', '";
			sql += " 127.0.0.0.1') ";
			result = stmt.executeUpdate(sql);
			if (result == 1) {
				sql = "update t_member_list set ml_boardcnt = ml_boardcnt + 1 where ml_id = '" + request.getParameter("mlid") + "' ";
				result = stmt.executeUpdate(sql);
				blResult = result + ":" + blnum;
			}
			
			
		} catch(Exception e) {
			System.out.println("insertBoard() 메소드 오류");
			e.printStackTrace();			
		} finally {
			close(rs);
			close(stmt);
		}		
		
		return blResult;
	}
	
	
	// 게시글을 수정하는 메소드
	public int updateBoard(HttpServletRequest request) {
		int result = 0;
		Statement stmt = null;
		try {
			String num = request.getParameter("num");
			String title = request.getParameter("title").trim().replaceAll("'", "''");
			String content = request.getParameter("content").trim().replaceAll("'", "''");
			String sql = "update t_board_list set ";
			sql += " bl_title = '" + title + "', ";
			sql += " bl_content = '" + content + "' ";
			sql += "where bl_num = " + num;
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			
		} catch(Exception e) {
			System.out.println("updateBoard() 메소드 오류");
			e.printStackTrace();			
		} finally {
			close(stmt);
		}		
		
		return result;
	}
	
	// 게시글을 삭제하는 메소드
	public String deleteBoard(HttpServletRequest request) {
		String blResult = "";
		int result = 0;
		Statement stmt = null;
		try {
			String mlid = request.getParameter("mlid");
			String num = request.getParameter("num");
			String btype = request.getParameter("btype");
			String sql = "update t_board_list set bl_isview = 'n' where bl_num = " + num;
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			if (result == 1) {
				sql = "update t_member_list set ml_boardcnt = ml_boardcnt - 1 where ml_id = '" + mlid + "' ";
				result = stmt.executeUpdate(sql);
				blResult = result + ":" + btype;
			}
			
		} catch(Exception e) {
			System.out.println("deleteBoard() 메소드 오류");
			e.printStackTrace();			
		} finally {
			close(stmt);
		}		
		
		return blResult;
	}
	
	
	// 특정 게시판 글 하나를 리턴하는 메소드
	public BoardInfo getBoard(int num) {
		BoardInfo boardInfo = null;		// 지정한 공지사항 글 데이터를 저장하기 위한 인스턴스
		Statement stmt = null;				// DB에 쿼리를 실행시키기 위해 생성하는 객체(DB에 쿼리문을 날려줌)
		ResultSet rs = null;				// 쿼리를 실행하고 결과를 담아오기 위해 생성
		try {
			String sql = "select * from t_board_list where bl_num = " + num;
			stmt = conn.createStatement();	// 쿼리를 실행할 준비 완료
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				boardInfo = new BoardInfo();

				boardInfo.setMl_id(rs.getString("ml_id"));
				boardInfo.setBl_num(rs.getInt("bl_num"));
				boardInfo.setBl_title(rs.getString("bl_title"));
				boardInfo.setBl_content(rs.getString("bl_content"));
				boardInfo.setBl_read(rs.getInt("bl_read"));
				boardInfo.setBl_date(rs.getString("bl_date"));
				boardInfo.setBl_boardtype(rs.getString("bl_boardtype"));
								
			}				
		} catch(Exception e) {
			System.out.println("getBoard() 메소드 오류");
			e.printStackTrace();			
		} finally {
			close(rs);
			close(stmt);
		}					
			 
		return boardInfo;			
	}
	
	// 게시글의 조회수를 증가시키는 메소드
	public int updateRead(int num) {
		int result = 0;
		Statement stmt = null;
		try {
			String sql = "update t_board_list set bl_read = bl_read + 1 where bl_num = " + num;
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			
		} catch(Exception e) {
			System.out.println("updateRead() 메소드 오류");
			e.printStackTrace();			
		} finally {
			close(stmt);
		}			
		return result;
	}
	
}
