package svc;

import static db.JdbcUtil.*;
import java.sql.Connection;
import javax.servlet.http.HttpServletRequest;
import dao.PageMainDAO;
import vo.PageMainInfo;

public class BannerService {

	// 배너 정보를 리턴하는 메소드
	 public PageMainInfo getBanner() {
		PageMainInfo pageMainInfo = null;
		PageMainDAO pageMainDAO = PageMainDAO.getInstance();
		Connection conn = getConnection();
		pageMainDAO.setConnection(conn);	
		pageMainInfo = pageMainDAO.getBanner();				
		close(conn);
		 
		return pageMainInfo;
	 }
		
	// 배너 정보를 수정하고 그 결과를 리턴하는 메소드
	public int updateBanner(HttpServletRequest request) {
		PageMainDAO pageMainDAO = PageMainDAO.getInstance();
		Connection conn = getConnection();
		pageMainDAO.setConnection(conn);
		int result = pageMainDAO.updateBanner(request);
		if (result == 1) { commit(conn); }
		else { rollback(conn); }
		close(conn);
		return result;
	}
}
