package dao;

import java.io.*;
import java.sql.*;
import java.util.ArrayList;
import javax.servlet.http.*;
import javax.servlet.ServletException;
import static db.JdbcUtil.*;
import vo.*;

public class AdminMemDAO {
	private static AdminMemDAO adminMemDAO;
	private Connection conn;

	private AdminMemDAO() {}

	public static AdminMemDAO getInstance() {
		if (adminMemDAO == null) {
			adminMemDAO = new AdminMemDAO();
		}

		return adminMemDAO;
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
			String sql = "select count(*) from t_member_list where 1=1 " + where;
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

	// 회원들의 목록을 ArrayList형태로 리턴하는 메소드
	public ArrayList<MemberInfo> getMemberList(String where, int cpage, int limit) {
		ArrayList<MemberInfo> memberList = new ArrayList<MemberInfo>();
		Statement stmt = null;
		ResultSet rs = null;
		MemberInfo memInfo = null;
		try {
			int start = (cpage - 1) * limit;
			String sql = "select * from t_member_list where 1=1 " + where;
			sql += " order by ml_num desc limit " + start + ", " + limit;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				memInfo = new MemberInfo();
				
				memInfo.setMl_num(rs.getInt("ml_num"));
				memInfo.setMl_id(rs.getString("ml_id"));
				memInfo.setMl_pwd(rs.getString("ml_pwd"));
				memInfo.setMl_name(rs.getString("ml_name"));
				memInfo.setMl_phone(rs.getString("ml_phone"));
				memInfo.setMl_addr1(rs.getString("ml_addr1"));
				memInfo.setMl_addr2(rs.getString("ml_addr2"));
				memInfo.setMl_position(rs.getString("ml_position"));
				memInfo.setMl_question(rs.getString("ml_question"));
				memInfo.setMl_answer(rs.getString("ml_answer"));
				memInfo.setMl_date(rs.getString("ml_date"));
				memInfo.setMl_isrun(rs.getString("ml_isrun"));
				memInfo.setMl_lastlogin(rs.getString("ml_lastlogin"));
				memInfo.setMl_membertype(rs.getString("ml_membertype"));
				memInfo.setGl_code(rs.getString("gl_code"));
				memInfo.setMl_editor(rs.getString("ml_editor"));
				memInfo.setMl_uptime(rs.getString("ml_uptime"));
				memInfo.setMl_reason(rs.getString("ml_reason"));
				memInfo.setMl_pay(rs.getInt("ml_pay"));
				memInfo.setMl_boardcnt(rs.getInt("ml_boardcnt"));
				memInfo.setMl_applycnt(rs.getInt("ml_applycnt"));
				memInfo.setMl_recruitcnt(rs.getInt("ml_recruitcnt"));
				memInfo.setMl_revcnt(rs.getInt("ml_revcnt"));

				memberList.add(memInfo);
				// 공지사항 목록을 담을 ArrayList에 생성한 인스턴스를 넣음
			}

		} catch(Exception e) {
			System.out.println("getMemberList() 메소드에서 오류 발생");
		} finally {
			close(rs);
			close(stmt);
		}

		return memberList;
	}
	
	// 탈퇴한 회원들의 목록을 ArrayList형태로 리턴하는 메소드
	public ArrayList<MemberInfo> getDeletedMemList(String where, int cpage, int limit) {
		ArrayList<MemberInfo> deletedMemberList = new ArrayList<MemberInfo>();
		Statement stmt = null;
		ResultSet rs = null;
		MemberInfo deletedMemInfo = null;
		try {
			String sql = "select * from t_member_list where ml_isrun = 'n'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				deletedMemInfo = new MemberInfo();
				
				deletedMemInfo.setMl_num(rs.getInt("ml_num"));
				deletedMemInfo.setMl_id(rs.getString("ml_id"));
				deletedMemInfo.setMl_pwd(rs.getString("ml_pwd"));
				deletedMemInfo.setMl_name(rs.getString("ml_name"));
				deletedMemInfo.setMl_phone(rs.getString("ml_phone"));
				deletedMemInfo.setMl_addr1(rs.getString("ml_addr1"));
				deletedMemInfo.setMl_addr2(rs.getString("ml_addr2"));
				deletedMemInfo.setMl_position(rs.getString("ml_position"));
				deletedMemInfo.setMl_question(rs.getString("ml_question"));
				deletedMemInfo.setMl_answer(rs.getString("ml_answer"));
				deletedMemInfo.setMl_date(rs.getString("ml_date"));
				deletedMemInfo.setMl_isrun(rs.getString("ml_isrun"));
				deletedMemInfo.setMl_lastlogin(rs.getString("ml_lastlogin"));
				deletedMemInfo.setMl_membertype(rs.getString("ml_membertype"));
				deletedMemInfo.setGl_code(rs.getString("gl_code"));
				deletedMemInfo.setMl_editor(rs.getString("ml_editor"));
				deletedMemInfo.setMl_uptime(rs.getString("ml_uptime"));
				deletedMemInfo.setMl_reason(rs.getString("ml_reason"));
				deletedMemInfo.setMl_pay(rs.getInt("ml_pay"));
				deletedMemInfo.setMl_boardcnt(rs.getInt("ml_boardcnt"));
				deletedMemInfo.setMl_applycnt(rs.getInt("ml_applycnt"));
				deletedMemInfo.setMl_recruitcnt(rs.getInt("ml_recruitcnt"));
				deletedMemInfo.setMl_revcnt(rs.getInt("ml_revcnt"));

				deletedMemberList.add(deletedMemInfo);
				// 공지사항 목록을 담을 ArrayList에 생성한 인스턴스를 넣음
			}

		} catch(Exception e) {
			System.out.println("getDeletedMemList() 메소드에서 오류 발생");
		} finally {
			close(rs);
			close(stmt);
		}

		return deletedMemberList;
	}
	
	public int getRidOfMember(HttpServletRequest request) {
		int result = 0;
		Statement stmt = null;
		try {
			String mlnum = request.getParameter("mlnum"); 

			String sql = "update t_member_list set ml_isrun = 'n' where ml_num = " + mlnum ; 
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
		} catch(Exception e) {
			System.out.println("getRidOfMember() 메소드에서 오류 발생");
		} finally {
			close(stmt);
		}

		return result;
	}
	
	// 회원정보를 수정하는 메소드
	public int updateMember(HttpServletRequest request) {
		int result = 0;
		Statement stmt = null;
		try {
			request.setCharacterEncoding("utf-8");
			
			String mlnum = request.getParameter("mlnum");
			String name = request.getParameter("name");
			String p1 = request.getParameter("p1");
			String p2 = request.getParameter("p2");
			String p3 = request.getParameter("p3");
			String addr1 = request.getParameter("addr1");
			String addr2 = request.getParameter("addr2");
			String[] position = request.getParameterValues("position");
			String question = request.getParameter("question");
			String answer = request.getParameter("answer");

			String phone = p1 + "-" + p2 + "-" + p3;
			

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
			
			String sql = "update t_member_list set ml_name = '" + name + "' " 
					+ ",  ml_phone = '" + phone + "', ml_addr1 = '" + addr1 + "', ml_addr2 = '" + addr2 + "' "  
					+ ", ml_position = '" + chk + "', ml_question = '" + question + "', ml_answer = '" + answer + "' "
					+ "where ml_num =" + mlnum;
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
		} catch(Exception e) {
			System.out.println("updateMember() 메소드에서 오류 발생");
		} finally {
			close(stmt);
		}

		return result;
	}
}
