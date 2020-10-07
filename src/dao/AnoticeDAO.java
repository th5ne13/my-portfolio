package dao;

import java.io.*;
import java.sql.*;
import java.util.ArrayList;
import javax.servlet.http.*;
import javax.servlet.ServletException;
import static db.JdbcUtil.*;
import vo.*;

public class AnoticeDAO {
	private static AnoticeDAO anoticeDAO;
	private Connection conn;

	private AnoticeDAO() {}

	public static AnoticeDAO getInstance() {
		if (anoticeDAO == null) {
			anoticeDAO = new AnoticeDAO();
		}

		return anoticeDAO;
	}

	public void setConnection(Connection conn) {
		this.conn = conn;
	}

	// 공지사항 게시물들 중 검색되는 전체 개수를 리턴하는 메소드
	public int getListCount(String where) {
		int rcount = 0;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select count(*) from t_apply_list where 1=1 " + where;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();	// if문을 사용하지 않는 것은 count()결과이므로 무조건 결과값이 존재하므로
			rcount = rs.getInt(1);
		} catch(Exception e) {
			System.out.println("getListCount() 메소드에서 오류 발생");
		} finally {
			close(rs);
			close(stmt);
		}

		return rcount;
	}

	// 공지사항의 목록을 ArrayList형태로 리턴하는 메소드
	public ArrayList<AnoticeInfo> getNoticeList(String where, int cpage, int limit) {
		ArrayList<AnoticeInfo> anoticeList = new ArrayList<AnoticeInfo>();
		Statement stmt = null;
		ResultSet rs = null;
		AnoticeInfo anoticeInfo = null;
		try {
			int start = (cpage - 1) * limit;
			String sql = "select * from t_apply_list where 1=1 " + where;
			sql += " order by al_num desc limit " + start + ", " + limit;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				anoticeInfo = new AnoticeInfo();
				// 하나의 게시글 데이터를 담기 위한 NoticeInfo 인스턴스 생성

				anoticeInfo.setAl_num(rs.getInt("al_num"));
				anoticeInfo.setMl_id(rs.getString("ml_id"));
				anoticeInfo.setAl_date(rs.getString("al_date"));
				anoticeInfo.setAl_isview(rs.getString("al_isview"));
				anoticeInfo.setAl_ip(rs.getString("al_ip"));
				anoticeInfo.setAl_addr1(rs.getString("al_addr1"));
				anoticeInfo.setAl_addr2(rs.getString("al_addr2"));
				anoticeInfo.setAl_matchtype(rs.getString("al_matchtype"));
				anoticeInfo.setAl_name(rs.getString("al_name"));
				anoticeInfo.setAl_phone(rs.getString("al_phone"));
				anoticeInfo.setAl_matchdate(rs.getString("al_matchdate"));
				anoticeInfo.setAl_matchtime(rs.getString("al_matchtime"));
				anoticeInfo.setAl_level(rs.getString("al_level"));
				anoticeInfo.setAl_position(rs.getString("al_position"));
				anoticeInfo.setAl_isend(rs.getString("al_isend"));
				anoticeInfo.setAl_content(rs.getString("al_content"));
				// 생성된 인스턴스에 데이터 채우기

				anoticeList.add(anoticeInfo);
				// 공지사항 목록을 담을 ArrayList에 생성한 인스턴스를 넣음
			}
		} catch(Exception e) {
			System.out.println("getNoticeList() 메소드에서 오류 발생");
		} finally {
			close(rs);
			close(stmt);
		}

		return anoticeList;
	}
	
	// 새 공지사항을 등록시키는 메소드
	public String insertNotice(HttpServletRequest request) {
		int result = 0, nlnum = 1;
		String nlResult = "";
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select max(al_num) + 1 from t_apply_list";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next())	nlnum = rs.getInt(1);
			
			String phonetotal = ""; 

			String mlid = request.getParameter("mid");
			String addr1 = request.getParameter("addr1");
			String addr2 = request.getParameter("addr2");
			String matchtype = request.getParameter("matchtype");
			String name = request.getParameter("name");
			String phone = request.getParameter("phone");
			String phone2 = request.getParameter("phone2").trim();
			String phone3 = request.getParameter("phone3").trim();
			String matchdate = request.getParameter("matchdate");
			String matchtime = request.getParameter("matchtime");
			String level = request.getParameter("level");
			String[] position = request.getParameterValues("position");
			String isend = request.getParameter("isend");
			String content = request.getParameter("content");
			String chk = "";

			if (position == null) {
				chk = "";
			} else {
				for (int i = 0; i < position.length; i++) {		
					if (i == (position.length - 1)) {
						chk += position[i];
					} else {
						chk += position[i] + ",";
					}
				}
			}
			
			
			phonetotal = phone + phone2 + phone3;
			
			sql = "insert into t_apply_list (ml_id, al_addr1, ";
			sql += "al_addr2, al_matchtype, al_name, al_phone, al_matchdate, ";
			sql += " al_matchtime, al_level, al_position, al_isend, al_content) values ";
			sql += "('" + mlid + "' , '" + addr1 + "', '" + addr2 + "', '" + matchtype + "', '" + name + "', '" + phonetotal + "', '" + matchdate + "', '" + matchtime + "', '" + level + "', '" + chk + "', '" + isend + "', '" + content + "') "; 	
						
			
			result = stmt.executeUpdate(sql);
			if (result > 0) {
				sql = "update t_member_list set ml_applycnt = ml_applycnt + 1 where ml_id = '" + mlid + "'";			
			}
			
			result = stmt.executeUpdate(sql);
			nlResult = result + ":" + nlnum;
		} catch(Exception e) {
			System.out.println("insertNotice() 메소드에서 오류 발생");
		} finally {
			close(rs);
			close(stmt);
		}

		return nlResult;
	}

	// 특정 공지사항 글 하나를 리턴하는 메소드
	public AnoticeInfo getNotice(int num) {
		AnoticeInfo anoticeInfo = null;
		// 지정한 공지사항 글 데이터를 저장하기 위한 인스턴스
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select * from t_apply_list where al_num = " + num;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				anoticeInfo = new AnoticeInfo();
				// 하나의 게시글 데이터를 담기 위한 NoticeInfo 인스턴스 생성

				anoticeInfo.setAl_num(rs.getInt("al_num"));
				anoticeInfo.setMl_id(rs.getString("ml_id"));
				anoticeInfo.setAl_date(rs.getString("al_date"));
				anoticeInfo.setAl_isview(rs.getString("al_isview"));
				anoticeInfo.setAl_addr1(rs.getString("al_addr1"));
				anoticeInfo.setAl_addr2(rs.getString("al_addr2"));
				anoticeInfo.setAl_matchtype(rs.getString("al_matchtype"));
				anoticeInfo.setAl_name(rs.getString("al_name"));
				anoticeInfo.setAl_phone(rs.getString("al_phone"));
				anoticeInfo.setAl_matchdate(rs.getString("al_matchdate"));
				anoticeInfo.setAl_matchtime(rs.getString("al_matchtime"));
				anoticeInfo.setAl_level(rs.getString("al_level"));
				anoticeInfo.setAl_position(rs.getString("al_position"));
				anoticeInfo.setAl_isend(rs.getString("al_isend"));
				anoticeInfo.setAl_content(rs.getString("al_content"));
				
				// 생성된 인스턴스에 데이터 채우기
			}
		} catch(Exception e) {
			System.out.println("getNotice() 수정 메소드에서 오류 발생");
		} finally {
			close(rs);
			close(stmt);
		}

		return anoticeInfo;
	}
	
	// 공지사항을 수정하는 메소드
	public int updateNotice(HttpServletRequest request) {
		int result = 0;
		Statement stmt = null;
		try {
			
			String phonetotal = ""; 

			String num = request.getParameter("num");
			String addr1 = request.getParameter("addr1");
			String addr2 = request.getParameter("addr2");
			String matchtype = request.getParameter("matchtype");
			String name = request.getParameter("name");
			String phone = request.getParameter("phone");
			String phone2 = request.getParameter("phone2").trim();
			String phone3 = request.getParameter("phone3").trim();
			String matchdate = request.getParameter("matchdate");
			String matchtime = request.getParameter("matchtime");
			String level = request.getParameter("level");
			String[] position = request.getParameterValues("position");
			String isend = request.getParameter("isend");
			String content = request.getParameter("content");

			String chk = "";

			if (position == null) {
				chk = "";
			} else {
				for (int i = 0; i < position.length; i++) {		
					if (i == (position.length - 1)) {
						chk += position[i];
					} else {
						chk += position[i] + ",";
					}
				}
			}
			phonetotal = phone + phone2 + phone3;
			
			String sql = "update t_apply_list set al_addr1 = '"
			+ addr1 + "',  al_addr2 = '" + addr2 + "', al_matchtype = '" + matchtype +"', al_name = '" + name +"', al_phone = '" + phonetotal + "', al_matchdate = '" + matchdate + "', al_matchtime = '" + matchtime + "', al_level = '" + level + "', al_position = '" + chk + "', al_isend = '" + isend + "', al_content = '" + content + "' "
			+ "where al_num = " + num ; 
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
		} catch(Exception e) {
			System.out.println("updateNotice() 메소드에서 오류 발생");
		} finally {
			close(stmt);
		}

		return result;
	}

}
