package svc;

import static db.JdbcUtil.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import java.sql.*;
import java.util.ArrayList;

import dao.*;
import vo.GroundListInfo;
import vo.GroundRevInfo;	

public class GroundRevService {
	
	// 구장 예약을 하고 그 결과를 int로 리턴하는 메소드
	public int groundRev(HttpServletRequest request) {
		int result = 0;
		GroundRevDAO groundRevDAO = GroundRevDAO.getInstance();
		Connection conn = getConnection();
		groundRevDAO.setConnection(conn);
		result = groundRevDAO.groundRev(request);
		if (result == 1) { commit(conn); } 
		else { rollback(conn); }
		close(conn);			
		return result;
	}
	
	// 여러 구장의 정보를 ArrayList 형태로 리턴하는 매소드(어드민)
	public ArrayList<GroundRevInfo> grdRevStatList(String where) {
		ArrayList<GroundRevInfo> grdRevList = new ArrayList<GroundRevInfo>();
		AdminStatDAO adminStatDAO = AdminStatDAO.getInstance();
		Connection conn = getConnection();
		adminStatDAO.setConnection(conn);	
		grdRevList = adminStatDAO.grdRevStatList(where);				
		close(conn);
		
		return grdRevList;			
	}
	
	// 여러 구장의 일주일 매출을 ArrayList 형태로 리턴하는 매소드(어드민)
	public ArrayList<GroundRevInfo> grdRevStatList() {
		ArrayList<GroundRevInfo> grdRevList = new ArrayList<GroundRevInfo>();
		AdminStatDAO adminStatDAO = AdminStatDAO.getInstance();
		Connection conn = getConnection();
		adminStatDAO.setConnection(conn);	
		grdRevList = adminStatDAO.grdRevStatList();				
		close(conn);
		
		return grdRevList;			
	}
	
	// 여러 구장의 정보를 ArrayList 형태로 리턴하는 매소드(어드민)
	public ArrayList<GroundRevInfo> grdRevBranList(String where) {
		ArrayList<GroundRevInfo> grdRevBranList = new ArrayList<GroundRevInfo>();
		AdminStatDAO adminStatDAO = AdminStatDAO.getInstance();
		Connection conn = getConnection();
		adminStatDAO.setConnection(conn);		
		grdRevBranList = adminStatDAO.grdRevBranList(where);				
		close(conn);
		
		return grdRevBranList;			
	}

}
