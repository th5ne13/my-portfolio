package dao;

import java.sql.*;
import vo.*;
import static db.JdbcUtil.*;

public class LoginDAO {
	private static LoginDAO loginDAO;
	private Connection conn;
	private LoginDAO() {}

	public static LoginDAO getInstance() {
		if (loginDAO == null) {
			loginDAO = new LoginDAO();
		}

		return loginDAO;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	// 회원 로그인
	public MemberInfo getLoginMember(String uid, String pwd) {		
		MemberInfo loginMember = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = "select * from t_member_list where ml_id = '" + uid + "' and ml_pwd = '" + pwd + "' and ml_isrun = 'y'";
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			if (rs.next()) {
				loginMember = new MemberInfo();
				loginMember.setMl_num(rs.getInt("ml_num"));
				loginMember.setMl_id(rs.getString("ml_id"));
				loginMember.setMl_pwd(rs.getString("ml_pwd"));
				loginMember.setMl_name(rs.getString("ml_name"));
				loginMember.setMl_phone(rs.getString("ml_phone"));
				loginMember.setMl_addr1(rs.getString("ml_addr1"));
				loginMember.setMl_addr2(rs.getString("ml_addr2"));
				loginMember.setMl_position(rs.getString("ml_position"));
				loginMember.setMl_question(rs.getString("ml_question"));
				loginMember.setMl_answer(rs.getString("ml_answer"));
				loginMember.setMl_date(rs.getString("ml_date"));
				loginMember.setMl_isrun(rs.getString("ml_isrun"));
				loginMember.setMl_lastlogin(rs.getString("ml_lastlogin"));
				loginMember.setMl_membertype(rs.getString("ml_membertype"));
				loginMember.setGl_code(rs.getString("gl_code"));
				loginMember.setMl_editor(rs.getString("ml_editor"));
				loginMember.setMl_uptime(rs.getString("ml_uptime"));
				loginMember.setMl_pay(rs.getInt("ml_pay"));
				loginMember.setMl_boardcnt(rs.getInt("ml_boardcnt"));
				loginMember.setMl_applycnt(rs.getInt("ml_applycnt"));
				loginMember.setMl_recruitcnt(rs.getInt("ml_recruitcnt"));
				loginMember.setMl_revcnt(rs.getInt("ml_revcnt"));
				loginMember.setMl_reason(rs.getString("ml_reason"));
				
			}
		} catch(Exception e) {
			System.out.println("getLoginMember() 메소드 오류");
			e.printStackTrace();
		} finally {
			try {
				close(rs);
				close(stmt);				
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return loginMember;
	}
	
	// Admin 로그인
	public AdminInfo getLoginAdmin(String aid, String pwd) {		
		AdminInfo loginAdmin = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = "select * from t_admin_list where al_id = '" + aid + "' and al_pwd = '" + pwd + "' and al_isrun = 'y'";
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			if (rs.next()) {
				loginAdmin = new AdminInfo();
				loginAdmin.setAl_num(rs.getInt("al_num"));
				loginAdmin.setAl_id(rs.getString("al_id"));
				loginAdmin.setAl_pwd(rs.getString("al_pwd"));
				loginAdmin.setAl_name(rs.getString("al_name"));
				loginAdmin.setAl_phone(rs.getString("al_phone"));
				loginAdmin.setAl_email(rs.getString("al_email"));
				loginAdmin.setAl_isrun(rs.getString("al_isrun"));
				loginAdmin.setAl_date(rs.getString("al_date"));
				loginAdmin.setReg_al_num(rs.getInt("reg_al_num"));
				
			}
		} catch(Exception e) {
			System.out.println("getLoginAdmin() 메소드 오류");
			e.printStackTrace();
		} finally {
			try {
				close(rs);
				close(stmt);				
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return loginAdmin;
	}

	
	// 어드민 DashBoard에서 보여줄 사이트 정보
	public SiteInfo getSiteInfo() {
		SiteInfo siteInfo = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = "select count(*) from t_ground_list where datediff(now(), gl_request) < 7";
		try {
			stmt = conn.createStatement();
			siteInfo = new SiteInfo();
			
			rs = stmt.executeQuery(sql);			
			rs.next();
			siteInfo.setGrdCntWeek(rs.getInt(1));
			
			sql = "select count(*) from t_ground_list";
			rs = stmt.executeQuery(sql);			
			rs.next();
			siteInfo.setGrdCnt(rs.getInt(1));
			
			sql = "select count(*) from t_member_list";
			rs = stmt.executeQuery(sql);			
			rs.next();
			siteInfo.setMemCnt(rs.getInt(1));
			
			sql = "select count(*) from t_member_list where datediff(now(), ml_date) < 7";
			rs = stmt.executeQuery(sql);			
			rs.next();
			siteInfo.setMemCntWeek(rs.getInt(1));
			
			sql = "select count(*) from t_ground_list where gl_isview = 'r'";
			rs = stmt.executeQuery(sql);			
			rs.next();
			siteInfo.setNewGrdReq(rs.getInt(1));
			
			sql = "select count(*) from t_qna_list where ql_status = 'n'";
			rs = stmt.executeQuery(sql);			
			rs.next();
			siteInfo.setNewPerBoard(rs.getInt(1));	
			
			
		} catch(Exception e) {
			System.out.println("getSiteInfo() 메소드 오류");
			e.printStackTrace();
		} finally {
			try {
				close(rs);
				close(stmt);				
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return siteInfo;
		
	}

}