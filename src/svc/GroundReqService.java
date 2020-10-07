package svc;

import static db.JdbcUtil.*;	// JdbcUtil클래스의 static 메소드들을 바로 사용가능(JdbcUtil안에 모든 메소드를 사용하겠다라는 의미)
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import dao.*;
import vo.*;	

public class GroundReqService {
	
	// 구장을 등록하고 그 결과를 int로 리턴하는 메소드
	public int insertGround(HttpServletRequest request) {
		int result = 0;
		GroundReqDAO groundReqDAO = GroundReqDAO.getInstance();
		Connection conn = getConnection();
		groundReqDAO.setConnection(conn);
		result = groundReqDAO.insertGround(request);
		if (result == 1) { commit(conn); } 
		else { rollback(conn); }
		close(conn);			
		return result;
	}
	
	// 내구장관리 수정결과를 리턴하는 메소드
	public int updateGround(HttpServletRequest request) {				
		GroundReqDAO groundReqDAO = GroundReqDAO.getInstance();
		Connection conn = getConnection();
		groundReqDAO.setConnection(conn);
		int result = groundReqDAO.updateGround(request);			
		if (result == 1) {	
			commit(conn);	
		} else {			
			rollback(conn); 
		}
		close(conn);				
		return result;
	}
	
	// 하나의 구장 정보를 리턴하는 메소드
	public GroundListInfo getGround(String glcode, String date) {
		GroundListInfo groundListInfo = null;
		GroundReqDAO groundReqDAO = GroundReqDAO.getInstance();
		Connection conn = getConnection();
		groundReqDAO.setConnection(conn);		
		groundListInfo = groundReqDAO.getGround(glcode, date);				
		close(conn);
		 
		return groundListInfo;		
	}
	
	// 여러 구장의 리스트를 ArrayList 형태로 리턴하는 매소드
	public ArrayList<GroundListInfo> getGroundList(HttpServletRequest request, String memAddr) {
		ArrayList<GroundListInfo> groundList  = new ArrayList<GroundListInfo>();
		GroundReqDAO groundReqDAO = GroundReqDAO.getInstance();
		Connection conn = getConnection();
		groundReqDAO.setConnection(conn);		
		groundList = groundReqDAO.getGroundList(request, memAddr);				
		close(conn);
		
		return groundList;			
	}
	
	// 여러 구장의 리스트를 ArrayList 형태로 리턴하는 매소드
	public ArrayList<GroundListInfo> getBranList() {
		ArrayList<GroundListInfo> branList  = new ArrayList<GroundListInfo>();
		GroundReqDAO groundReqDAO = GroundReqDAO.getInstance();
		Connection conn = getConnection();
		groundReqDAO.setConnection(conn);		
		branList = groundReqDAO.getBranList();				
		close(conn);
		
		return branList;			
	}

	// (어드민) 구장리스트를 ArrayList 형태로 리턴하는 매소드
	public ArrayList<GroundListInfo> getGroundList(String where, int cpage, int limit) {
		ArrayList<GroundListInfo> adminGroundList = new ArrayList<GroundListInfo>();
		GroundReqDAO groundReqDAO = GroundReqDAO.getInstance();
		Connection conn = getConnection();
		groundReqDAO.setConnection(conn);
		adminGroundList = groundReqDAO.getGroundList(where, cpage, limit);
		close(conn);

		return adminGroundList;
	}
	
	// 해당 구장의 예약 현황 정보를 리턴하는 메소드
	public ArrayList<GroundRevInfo> getGrdRev(String glcode, String date) {
		ArrayList<GroundRevInfo> grdRevList = new ArrayList<GroundRevInfo>();
		GroundReqDAO groundReqDAO = GroundReqDAO.getInstance();
		Connection conn = getConnection();
		groundReqDAO.setConnection(conn);		
		grdRevList = groundReqDAO.getGrdRev(glcode, date);	
		close(conn);
		return grdRevList;		
	}
	
	// 해당 회원의 예약 현황 정보를 리턴하는 메소드
	public ArrayList<GroundRevInfo> getGrdRev(String mlid) {
		ArrayList<GroundRevInfo> grdRevList = new ArrayList<GroundRevInfo>();
		GroundReqDAO groundReqDAO = GroundReqDAO.getInstance();
		Connection conn = getConnection();
		groundReqDAO.setConnection(conn);		
		grdRevList = groundReqDAO.getGrdRev(mlid);	
		close(conn);
		return grdRevList;		
	}
	
	// 하나의 예약 정보를 삭제하고 그 결과를 리턴하는 메소드
	public int delReserveGrd(HttpServletRequest request) {
		int result = 0;
		GroundReqDAO groundReqDAO = GroundReqDAO.getInstance();
		Connection conn = getConnection();
		groundReqDAO.setConnection(conn);
		result = groundReqDAO.delReserveGrd(request);
		if (result == 1) { commit(conn); } 
		else { rollback(conn); }
		close(conn);			
		return result;		
	}
	
	// 모든 회원의 예약 현황 정보를 리턴하는 메소드(admin용)
	public ArrayList<GroundRevInfo> getGrdRev(String where, int cpage, int limit, String ltype) {
		ArrayList<GroundRevInfo> grdRevList = new ArrayList<GroundRevInfo>();
		GroundReqDAO groundReqDAO = GroundReqDAO.getInstance();
		Connection conn = getConnection();
		groundReqDAO.setConnection(conn);		
		grdRevList = groundReqDAO.getGrdRev(where, cpage, limit, ltype);	
		close(conn);
		return grdRevList;		
	}

	
	// 예약 현황의 목록 개수를 리턴하는 메소드
	public int getListCount(String where) {
		int rcount = 0;
		GroundReqDAO groundReqDAO = GroundReqDAO.getInstance();
		Connection conn = getConnection();
		groundReqDAO.setConnection(conn);		
		rcount = groundReqDAO.getListCount(where);				
		close(conn);		
		return rcount;		
	}	
}
