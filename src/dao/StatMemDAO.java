package dao;

import java.io.*;
import java.sql.*;
import java.util.ArrayList;
import javax.servlet.http.*;
import javax.servlet.ServletException;
import static db.JdbcUtil.*;
import vo.*;

public class StatMemDAO {
	
	private static StatMemDAO statMemDAO;
	private Connection conn;

	private StatMemDAO() {}

	public static StatMemDAO getInstance() {
		if (statMemDAO == null) {
			statMemDAO = new StatMemDAO();
		}

		return statMemDAO;
	}

	public void setConnection(Connection conn) {
		this.conn = conn;
	}

	public int getStatMemListCount(String where) {
		int rcount = 0;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select count(*) from t_member_list where 1=1 " + where;
			stmt = conn.createStatement();
			System.out.println(sql);
			rs = stmt.executeQuery(sql);
			System.out.println(sql);
			rs.next();	
			rcount = rs.getInt(1);
		} catch(Exception e) {
			System.out.println("getStatMemListCount() �޼ҵ忡�� ���� �߻�");
		} finally {
			close(rs);
			close(stmt);
		}

		return rcount;
	}

	public ArrayList<MemberInfo> getStatMemList(String where, int cpage, int limit) {
		ArrayList<MemberInfo> statMemList = new ArrayList<MemberInfo>();
		Statement stmt = null;
		ResultSet rs = null;
		MemberInfo statmemInfo = null;
		try {
			int start = (cpage - 1) * limit;
			String sql = "select * from t_member_list where 1=1 " + where;
			sql += " order by ml_num desc limit " + start + ", " + limit;
			stmt = conn.createStatement();
			System.out.println(sql);
			rs = stmt.executeQuery(sql);
			System.out.println(sql);

			while (rs.next()) {
				statmemInfo = new MemberInfo();
				
				statmemInfo.setMl_num(rs.getInt("ml_num"));
				statmemInfo.setMl_id(rs.getString("ml_id"));
				statmemInfo.setMl_pwd(rs.getString("ml_pwd"));
				statmemInfo.setMl_name(rs.getString("ml_name"));
				statmemInfo.setMl_phone(rs.getString("ml_phone"));
				statmemInfo.setMl_addr1(rs.getString("ml_addr1"));
				statmemInfo.setMl_addr2(rs.getString("ml_addr2"));
				statmemInfo.setMl_position(rs.getString("ml_position"));
				statmemInfo.setMl_question(rs.getString("ml_question"));
				statmemInfo.setMl_answer(rs.getString("ml_answer"));
				statmemInfo.setMl_date(rs.getString("ml_date"));
				statmemInfo.setMl_isrun(rs.getString("ml_isrun"));
				statmemInfo.setMl_lastlogin(rs.getString("ml_lastlogin"));
				statmemInfo.setMl_membertype(rs.getString("ml_membertype"));
				statmemInfo.setGl_code(rs.getString("gl_code"));
				statmemInfo.setMl_editor(rs.getString("ml_editor"));
				statmemInfo.setMl_uptime(rs.getString("ml_uptime"));
				statmemInfo.setMl_reason(rs.getString("ml_reason"));
				statmemInfo.setMl_pay(rs.getInt("ml_pay"));
				statmemInfo.setMl_boardcnt(rs.getInt("ml_boardcnt"));
				statmemInfo.setMl_applycnt(rs.getInt("ml_applycnt"));
				statmemInfo.setMl_recruitcnt(rs.getInt("ml_recruitcnt"));
				statmemInfo.setMl_revcnt(rs.getInt("ml_revcnt"));

				statMemList.add(statmemInfo);
			}

		} catch(Exception e) {
			System.out.println("getStatMemList()메소드오류");
		} finally {
			close(rs);
			close(stmt);
		}

		return statMemList;
	}

}
