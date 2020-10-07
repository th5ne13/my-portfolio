package dao;

import java.sql.*;

import javax.servlet.http.HttpServletRequest;

import vo.*;
import static db.JdbcUtil.*;
public class FindDAO {
	private static FindDAO findDAO;
	private Connection conn;
	
	private FindDAO() {}

	public static FindDAO getInstance() {
		if (findDAO == null) {
			findDAO = new FindDAO();
		}
		
		return findDAO;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}

	public MemberInfo getInfoFind(String uname, String question, String answer) {
		MemberInfo id = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select * from t_member_list where ml_isrun = 'y' and ml_name = '" + uname + "' and ml_question = '" + question + "' and ml_answer = '" + answer + "'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				id = new MemberInfo();
				
				id.setMl_id(rs.getString("ml_id"));
			}
		} catch (Exception e) {
			System.out.println("getInfoFind() 메소드오류");
		} finally {
			close(rs);
			close(stmt);
		}
		return id;
	}

	public MemberInfo getInfoFindPwd(String uid, String uname, String question, String answer) {
		MemberInfo pwd = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select * from t_member_list where ml_isrun = 'y' and ml_id = '" + uid + "' and ml_name = '" + uname + "' and ml_question = '" + question + "' and ml_answer = '" + answer + "'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				pwd = new MemberInfo();
				
				pwd.setMl_pwd(rs.getString("ml_pwd"));
			}
		} catch (Exception e) {
			System.out.println("getInfoFindPwd() 메소드오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		return pwd;
	}

	public int setPwd(HttpServletRequest request) {
		int result = 0;
		Statement stmt = null;
		try {
			request.setCharacterEncoding("utf-8");
			String uid = request.getParameter("uid");
			String newpwd = request.getParameter("newpwd");
			String sql = "update t_member_list set ml_pwd = '" + newpwd + "' where ml_id = '" + uid + "'";
			
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
		} catch (Exception e) {
			System.out.println("setPwd() 메소드오류");
			e.printStackTrace();
		} finally {
			try {
				close(stmt);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}
}