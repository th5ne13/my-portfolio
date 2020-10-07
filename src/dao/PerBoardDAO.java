package dao;

import java.io.*;
import java.sql.*;
import java.util.ArrayList;
import javax.servlet.http.*;
import vo.*;
import javax.servlet.ServletException;
import static db.JdbcUtil.*;

public class PerBoardDAO {

	private static PerBoardDAO perBoardDAO;	
	private Connection conn;	
	
	private PerBoardDAO() {}						// private default 생성자 -> 외부에서 인스턴스 생성 불가					

	public static PerBoardDAO getInstance() {		// 인스턴스를 생성하여 리턴하는 메소드 -> 하나만 만들어서 쓰고 여러개 생성하지 말라는 의미 -> 싱글톤방식
		if (perBoardDAO == null) {		 
			perBoardDAO = new PerBoardDAO();
		}
		
		return perBoardDAO;
	}
	
	public void setConnection(Connection conn) {		
		this.conn = conn;
	}
	
	
	// 1:1 게시판 글 목록을 ArrayList<PerBoardInfo> 형태로 리턴하는 메소드
	public ArrayList<PerBoardInfo> getPerBoardList(String where, String mlid) {
		ArrayList<PerBoardInfo> perBoardList  = new ArrayList<PerBoardInfo>(20);

		Statement stmt = null;
		ResultSet rs = null;
		PerBoardInfo perBoardInfo = null;
		try {
			String sql = "select * from t_qna_list where ql_isview = 'y' and ml_id =  '" + mlid + "' " + where;
			sql += " order by ql_num desc ";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {					// 없을 경우 처리가 필요 없기 때문에 if문 없이 바로 while문 사용 가능
				perBoardInfo = new PerBoardInfo();
				// 하나의 게시글 데이터를 담기위한 boardInfo 인스턴스 생성
				
				perBoardInfo.setQl_num(rs.getInt("ql_num"));
				perBoardInfo.setMl_id(rs.getString("ml_id"));
				perBoardInfo.setQl_cata(rs.getString("ql_cata"));
				perBoardInfo.setQl_title(rs.getString("ql_title"));
				perBoardInfo.setQl_content(rs.getString("ql_content"));
				perBoardInfo.setQl_date(rs.getString("ql_date"));
				perBoardInfo.setQl_ip(rs.getString("ql_ip"));
				perBoardInfo.setQl_status(rs.getString("ql_status"));
				perBoardInfo.setQl_isview(rs.getString("ql_isview"));
				perBoardInfo.setQl_adate(rs.getString("ql_adate"));
				perBoardInfo.setQl_status(rs.getString("ql_status"));
				perBoardInfo.setAl_num(rs.getInt("al_num"));
				perBoardInfo.setQl_answer(rs.getString("ql_answer"));
				perBoardInfo.setQl_lastdate(rs.getString("ql_lastdate"));
				perBoardInfo.setLast_al_num(rs.getInt("last_al_num"));
								
				// 생성된 인스턴스에 데이터 채우기
				
				perBoardList.add(perBoardInfo);		
				// 공지사항 목록을 담을 ArrayList에 생성한 인스턴스를 넣음
			}
			
		} catch(Exception e) {
			System.out.println("getPerBoardList() 메소드 오류");
			e.printStackTrace();			
		} finally {
			close(rs);
			close(stmt);
		}
		return perBoardList;	
	}
	
	
	// 1:1 게시판 게시글 하나를 PerBoardInfo 형태로 리턴하는 메소드
	public PerBoardInfo getPerBoard(int num) {
		PerBoardInfo perBoardInfo = null;		// 지정한 공지사항 글 데이터를 저장하기 위한 인스턴스
		Statement stmt = null;				// DB에 쿼리를 실행시키기 위해 생성하는 객체(DB에 쿼리문을 날려줌)
		ResultSet rs = null;				// 쿼리를 실행하고 결과를 담아오기 위해 생성
		try {
			String sql = "select * from t_qna_list where ql_num = " + num;
			stmt = conn.createStatement();	// 쿼리를 실행할 준비 완료
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				perBoardInfo = new PerBoardInfo();
				// 하나의 게시글 데이터를 담기위한 NoticeInfo 인스턴스 생성
				
				perBoardInfo.setQl_num(rs.getInt("ql_num"));
				perBoardInfo.setMl_id(rs.getString("ml_id"));
				perBoardInfo.setQl_title(rs.getString("ql_title"));
				perBoardInfo.setQl_content(rs.getString("ql_content"));
				perBoardInfo.setQl_date(rs.getString("ql_date"));
				perBoardInfo.setQl_ip(rs.getString("ql_ip"));
				perBoardInfo.setQl_status(rs.getString("ql_status"));
				perBoardInfo.setQl_isview(rs.getString("ql_isview"));
				perBoardInfo.setQl_answer(rs.getString("ql_answer"));
				perBoardInfo.setQl_adate(rs.getString("ql_adate"));
				perBoardInfo.setAl_num(rs.getInt("al_num"));
				perBoardInfo.setQl_cata(rs.getString("ql_cata"));
				perBoardInfo.setQl_lastdate(rs.getString("ql_lastdate"));
				perBoardInfo.setLast_al_num(rs.getInt("last_al_num"));
				// 생성된 인스턴스에 데이터 채우기
			}				
		} catch(Exception e) {
			System.out.println("getPerBoard() 메소드 오류");
			e.printStackTrace();			
		} finally {
			close(rs);
			close(stmt);
		}					
			 
		return perBoardInfo;					
	}
	
	// 1:1 게시판 새 글을 등록시키고 그 결과(글 번호와 글 개수)를 String으로 리턴하는 메소드 메소드
	public String insertPerBoard(HttpServletRequest request) {
		int result = 0, qlnum = 1;
		String qlResult = "";
		Statement stmt = null;
		ResultSet rs = null;		// 글번호를 만들어야 하므로 ResultSet필요
		try {
			String sql = "select max(ql_num) + 1 from t_qna_list";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next())	qlnum = rs.getInt(1);
			
			sql = "insert into t_qna_list (ql_num, ml_id, ql_cata, ql_title, ql_content, ql_ip) "
					+ " values (" + qlnum + ", '" + request.getParameter("mlid") + "', '"
					+ request.getParameter("qlCata") + "', '"
					+ request.getParameter("title") + "', '"
					+ request.getParameter("content") + "', '"
					+ "127.0.0.0.1')";	
			result = stmt.executeUpdate(sql);
			qlResult = result + ":" + qlnum;
			
		} catch(Exception e) {
			System.out.println("insertPerBoard() 메소드 오류");
			e.printStackTrace();			
		} finally {
			close(stmt);
		}		
		
		return qlResult;
	}
	
	// 공지사항을 수정하는 메소드
	public int updatePerBoard(HttpServletRequest request) {
		int result = 0;
		Statement stmt = null;
		try {
			String num = request.getParameter("num");
			String title = request.getParameter("title").trim().replaceAll("'", "''");
			String content = request.getParameter("content").trim().replaceAll("'", "''");
			String qlCata = request.getParameter("qlCata");
			String sql = "update t_qna_list set ";
			sql += " ql_title = '" + title + "', ";
			sql += " ql_content = '" + content + "', ";
			sql += " ql_cata = '" + qlCata + "' ";
			sql += "where ql_num = " + num;
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			
		} catch(Exception e) {
			System.out.println("updatePerBoard() 메소드 오류");
			e.printStackTrace();			
		} finally {
			close(stmt);
		}		
		
		return result;
	}

	// 1:1 질문 글을 삭제하는 메소드
	public int deletePerBoard(HttpServletRequest request) {
		int result = 0;
		Statement stmt = null;
		try {
			String num = request.getParameter("num");
			String sql = "delete from t_qna_list where ql_num = " + num;
			System.out.println(sql);
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			
		} catch(Exception e) {
			System.out.println("deleteNotice() 메소드 오류");
			e.printStackTrace();			
		} finally {
			close(stmt);
		}		
		
		return result;
	}


	// 어드민 화면에서 1:1 게시판의 목록을 ArrayList형태로 리턴하는 메소드
	public ArrayList<PerBoardInfo> getPerBoardList(String amid) {
		ArrayList<PerBoardInfo> perBoardList  = new ArrayList<PerBoardInfo>(20);

		Statement stmt = null;
		ResultSet rs = null;
		PerBoardInfo perBoardInfo = null;
		try {
			String sql = "select * from t_qna_list order by ql_status, ql_num";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {					// 없을 경우 처리가 필요 없기 때문에 if문 없이 바로 while문 사용 가능
				perBoardInfo = new PerBoardInfo();
				// 하나의 게시글 데이터를 담기위한 boardInfo 인스턴스 생성
				
				perBoardInfo.setQl_num(rs.getInt("ql_num"));
				perBoardInfo.setMl_id(rs.getString("ml_id"));
				perBoardInfo.setQl_cata(rs.getString("ql_cata"));
				perBoardInfo.setQl_title(rs.getString("ql_title"));
				perBoardInfo.setQl_content(rs.getString("ql_content"));
				perBoardInfo.setQl_date(rs.getString("ql_date"));
				perBoardInfo.setQl_ip(rs.getString("ql_ip"));
				perBoardInfo.setQl_status(rs.getString("ql_status"));
				perBoardInfo.setQl_isview(rs.getString("ql_isview"));
				perBoardInfo.setQl_adate(rs.getString("ql_adate"));
				perBoardInfo.setQl_status(rs.getString("ql_status"));
				perBoardInfo.setQl_answer(rs.getString("ql_answer"));
				perBoardInfo.setAl_num(rs.getInt("al_num"));
				perBoardInfo.setQl_lastdate(rs.getString("ql_lastdate"));
				perBoardInfo.setLast_al_num(rs.getInt("last_al_num"));
								
				// 생성된 인스턴스에 데이터 채우기
				
				perBoardList.add(perBoardInfo);		
				// 공지사항 목록을 담을 ArrayList에 생성한 인스턴스를 넣음
			}
			
			
		} catch(Exception e) {
			System.out.println("getPerBoardList() 어드민 메소드 오류");
			e.printStackTrace();			
		} finally {
			close(rs);
			close(stmt);
		}
		return perBoardList;	
	}

	// 어드민 화면에서 1:1 게시판 게시글에 대한 답변/수정결과를 int형으로 리턴하는 메소드
	public int adminUpdatePerBoard(HttpServletRequest request, String alid) {
		int result = 0;
		Statement stmt = null;
		try {
			System.out.println("ㅎㅇ");
			int qlNum = Integer.parseInt(request.getParameter("qlNum"));
			int odNum = Integer.parseInt(request.getParameter("odNum"));
			String answer = request.getParameter("answer" + odNum).trim().replaceAll("'", "''");
			String sql = "update t_qna_list set ql_answer = '" + answer + "', ql_adate = now(), ql_status = 'y' where ql_num = " + qlNum;
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			
		} catch(Exception e) {
			System.out.println("adminUpdatePerBoard() 메소드 오류");
			e.printStackTrace();			
		} finally {
			close(stmt);
		}		
		
		return result;
	}
	
	
	
}
