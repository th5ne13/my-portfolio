package svc;

import static db.JdbcUtil.*;
import java.sql.Connection;
import javax.servlet.http.HttpServletRequest;

import dao.GroundReqDAO;
import dao.PageMainDAO;
import vo.PageMainInfo;

public class PageInfoService {

	// 홈페이지 기본 정보를 리턴하는 메소드
	 public PageMainInfo getInfo(String btype) {
		PageMainInfo pageMainInfo = null;
		PageMainDAO pageMainDAO = PageMainDAO.getInstance();
		Connection conn = getConnection();
		pageMainDAO.setConnection(conn);		
		pageMainInfo = pageMainDAO.getInfo(btype);				
		close(conn);		 
		return pageMainInfo;
	 }
	 
	 // 홈페이지 기본 정보를 수정하고 결과를 리턴하는 메소드
	 public int upInfo(HttpServletRequest request) {
		int result = 0;
		PageMainDAO pageMainDAO = PageMainDAO.getInstance();
		Connection conn = getConnection();
		pageMainDAO.setConnection(conn);		
		result = pageMainDAO.upInfo(request);	
		if (result == 1) { commit(conn); } 
		else { rollback(conn); }			
		close(conn);		 
		return result;		 
	 }
}
