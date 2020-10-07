package dao;

import static db.JdbcUtil.close;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import vo.GroundRevInfo;

public class AdminStatDAO {
	
	private static AdminStatDAO adminStatDAO;	
	private Connection conn;	
	
	private AdminStatDAO() {}					

	public static AdminStatDAO getInstance() {
		if (adminStatDAO == null) {		 
			adminStatDAO = new AdminStatDAO();
		}
		
		return adminStatDAO;
	}
	
	public void setConnection(Connection conn) {		
		this.conn = conn;
	}

	// 여러 구장의 정보를 ArrayList 형태로 리턴하는 매소드(어드민)
	public ArrayList<GroundRevInfo> grdRevStatList(String where) {
		ArrayList<GroundRevInfo> grdRevList = new ArrayList<GroundRevInfo>();

		Statement stmt = null;
		ResultSet rs = null;
		GroundRevInfo groundRevInfo = null;
		try {
			String sql = "select gr_num, gr_name, sum(gr_cost), gr_addr from t_ground_rev " + where;
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				groundRevInfo = new GroundRevInfo();
				groundRevInfo.setGr_num(rs.getInt("gr_num"));
				groundRevInfo.setGr_name(rs.getString("gr_name"));
				groundRevInfo.setGr_cost(rs.getInt("sum(gr_cost)"));
				groundRevInfo.setGr_addr(rs.getString("gr_addr"));
				
				grdRevList.add(groundRevInfo);		
			}
			
		} catch(Exception e) {
			System.out.println("grdRevStatList() 메소드 오류");
			e.printStackTrace();			
		} finally {
			close(rs);
			close(stmt);
		}
		return grdRevList;			
	}

	// 여러 구장의 정보를 ArrayList 형태로 리턴하는 매소드(어드민)
	public ArrayList<GroundRevInfo> grdRevStatList() {
		ArrayList<GroundRevInfo> grdRevList = new ArrayList<GroundRevInfo>();

		Statement stmt = null;
		ResultSet rs = null;
		GroundRevInfo groundRevInfo = null;
		try {
			String sql = "select left(gr_revdate, 10), sum(gr_cost) from t_ground_rev where gr_revdate <= now() and gr_revdate >= left(date_sub(now(), interval 7 day), 10) group by left(gr_revdate, 10) order by gr_revdate";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				groundRevInfo = new GroundRevInfo();
				groundRevInfo.setGr_revdate(rs.getString("left(gr_revdate, 10)"));
				groundRevInfo.setGr_cost(rs.getInt("sum(gr_cost)"));
				
				grdRevList.add(groundRevInfo);		
			}
			
		} catch(Exception e) {
			System.out.println("grdRevStatList() 메소드 오류");
			e.printStackTrace();			
		} finally {
			close(rs);
			close(stmt);
		}
		return grdRevList;			
	}
	
	
	// 여러 구장의 정보를 ArrayList 형태로 리턴하는 매소드(어드민)
	public ArrayList<GroundRevInfo> grdRevBranList(String where) {
		ArrayList<GroundRevInfo> grdRevBranList = new ArrayList<GroundRevInfo>();

		Statement stmt = null;
		ResultSet rs = null;
		GroundRevInfo groundRevInfo = null;
		try {
			String sql = "select * from t_ground_rev " + where;
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				groundRevInfo = new GroundRevInfo();
				groundRevInfo.setGr_num(rs.getInt("gr_num"));
				groundRevInfo.setGr_name(rs.getString("gr_name"));
				groundRevInfo.setGr_cost(rs.getInt("gr_cost"));
				groundRevInfo.setGr_addr(rs.getString("gr_addr"));
				
				grdRevBranList.add(groundRevInfo);		
			}
			
		} catch(Exception e) {
			System.out.println("getBoardList() 메소드 오류");
			e.printStackTrace();			
		} finally {
			close(rs);
			close(stmt);
		}
		return grdRevBranList;			
	}
	
}
