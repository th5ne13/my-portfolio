package dao;

import java.io.*;
import java.sql.*;
import java.util.ArrayList;
import javax.servlet.http.*;
import javax.servlet.ServletException;
import static db.JdbcUtil.*;
import vo.*;

public class RnoticeDAO {
	private static RnoticeDAO rnoticeDAO;
	private Connection conn;

	private RnoticeDAO() {}

	public static RnoticeDAO getInstance() {
		if (rnoticeDAO == null) {
			rnoticeDAO = new RnoticeDAO();
		}

		return rnoticeDAO;
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
			String sql = "select count(*) from t_recruit_list where 1=1 " + where;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
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
	public ArrayList<RnoticeInfo> getNoticeList(String where, int cpage, int limit) {
		ArrayList<RnoticeInfo> rnoticeList = new ArrayList<RnoticeInfo>();
		Statement stmt = null;
		ResultSet rs = null;
		RnoticeInfo rnoticeInfo = null;
		try {
			int start = (cpage - 1) * limit;
			String sql = "select * from t_recruit_list where 1=1 " + where;
			sql += " order by rl_num desc limit " + start + ", " + limit;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				rnoticeInfo = new RnoticeInfo();
				// 하나의 게시글 데이터를 담기 위한 NoticeInfo 인스턴스 생성

				rnoticeInfo.setRl_num(rs.getInt("rl_num"));
				rnoticeInfo.setRl_recruitnum(rs.getInt("rl_recruitnum"));
				rnoticeInfo.setMl_id(rs.getString("ml_id"));
				rnoticeInfo.setRl_date(rs.getString("rl_date"));
				rnoticeInfo.setRl_isview(rs.getString("rl_isview"));
				rnoticeInfo.setRl_ip(rs.getString("rl_ip"));
				rnoticeInfo.setRl_addr1(rs.getString("rl_addr1"));
				rnoticeInfo.setRl_addr2(rs.getString("rl_addr2"));
				rnoticeInfo.setRl_matchtype(rs.getString("rl_matchtype"));
				rnoticeInfo.setRl_name(rs.getString("rl_name"));
				rnoticeInfo.setRl_phone(rs.getString("rl_phone"));
				rnoticeInfo.setRl_matchdate(rs.getString("rl_matchdate"));
				rnoticeInfo.setRl_matchtime(rs.getString("rl_matchtime"));
				rnoticeInfo.setRl_level(rs.getString("rl_level"));
				rnoticeInfo.setRl_position(rs.getString("rl_position"));
				rnoticeInfo.setRl_isend(rs.getString("rl_isend"));
				rnoticeInfo.setRl_content(rs.getString("rl_content"));
				// 생성된 인스턴스에 데이터 채우기

				rnoticeList.add(rnoticeInfo);
				// 공지사항 목록을 담을 ArrayList에 생성한 인스턴스를 넣음
			}
		} catch(Exception e) {
			System.out.println("getNoticeList() 메소드에서 오류 발생");
		} finally {
			close(rs);
			close(stmt);
		}

		return rnoticeList;
	}
	
	// 새 공지사항을 등록시키는 메소드
	public String insertNotice(HttpServletRequest request) {
		int result = 0, nlnum = 1;
		String nlResult = "";
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select max(rl_num) + 1 from t_recruit_list";
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
			int recruitnum = Integer.parseInt(request.getParameter("recruitnum"));
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
			
			sql = "insert into t_recruit_list (ml_id, rl_addr1, ";
			sql += "rl_addr2, rl_matchtype, rl_name, rl_phone, rl_matchdate, ";
			sql += " rl_matchtime, rl_recruitnum, rl_level, rl_position, rl_isend, rl_content) values ";
			sql += "('" + mlid + "' , '" + addr1 + "', '" + addr2 + "', '" + matchtype + "', '" + name + "', '" + phonetotal + "', '" + matchdate + "', '" + matchtime + "', " + recruitnum + ", '" + level + "', '" + chk + "', '" + isend + "', '" + content + "') "; 	
			
			
			
			
			result = stmt.executeUpdate(sql);
			if (result > 0) {
				sql = "update t_member_list set ml_recruitcnt = ml_recruitcnt + 1 where ml_id = '" + mlid + "'";			
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
	public RnoticeInfo getNotice(int num) {
		RnoticeInfo rnoticeInfo = null;
		// 지정한 공지사항 글 데이터를 저장하기 위한 인스턴스
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select * from t_recruit_list where rl_num = " + num;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				rnoticeInfo = new RnoticeInfo();
				// 하나의 게시글 데이터를 담기 위한 NoticeInfo 인스턴스 생성

				rnoticeInfo.setRl_num(rs.getInt("rl_num"));
				rnoticeInfo.setRl_recruitnum(rs.getInt("rl_recruitnum"));
				rnoticeInfo.setMl_id(rs.getString("ml_id"));
				rnoticeInfo.setRl_date(rs.getString("rl_date"));
				rnoticeInfo.setRl_isview(rs.getString("rl_isview"));
				rnoticeInfo.setRl_addr1(rs.getString("rl_addr1"));
				rnoticeInfo.setRl_addr2(rs.getString("rl_addr2"));
				rnoticeInfo.setRl_matchtype(rs.getString("rl_matchtype"));
				rnoticeInfo.setRl_name(rs.getString("rl_name"));
				rnoticeInfo.setRl_phone(rs.getString("rl_phone"));
				rnoticeInfo.setRl_matchdate(rs.getString("rl_matchdate"));
				rnoticeInfo.setRl_matchtime(rs.getString("rl_matchtime"));
				rnoticeInfo.setRl_level(rs.getString("rl_level"));
				rnoticeInfo.setRl_position(rs.getString("rl_position"));
				rnoticeInfo.setRl_isend(rs.getString("rl_isend"));
				rnoticeInfo.setRl_content(rs.getString("rl_content"));
				
				// 생성된 인스턴스에 데이터 채우기
			}
		} catch(Exception e) {
			System.out.println("getNotice() 수정 메소드에서 오류 발생");
		} finally {
			close(rs);
			close(stmt);
		}

		return rnoticeInfo;
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
			int recruitnum = Integer.parseInt(request.getParameter("recruitnum"));
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
			
			String sql = "update t_recruit_list set rl_addr1 = '"
			+ addr1 + "',  rl_addr2 = '" + addr2 + "', rl_matchtype = '" + matchtype +"', rl_name = '" + name +"', rl_phone = '" + phonetotal + "', rl_matchdate = '" + matchdate + "', rl_matchtime = '" + matchtime + "', rl_recruitnum = '" + recruitnum + "', rl_level = '" + level + "', rl_position = '" + chk + "', rl_isend = '" + isend + "', rl_content = '" + content + "' "
			+ "where rl_num = " + num ; 
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
