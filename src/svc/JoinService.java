package svc;

import static db.JdbcUtil.*;
import javax.servlet.http.HttpServletRequest;
import java.sql.*;
import dao.JoinDAO;

public class JoinService {

	public int setMemberJoin(HttpServletRequest request) {
		int result = 0;	// 인트형 변수를 리턴하기 위한 선언
		JoinDAO joinDAO = JoinDAO.getInstance();
		Connection conn = getConnection();
		joinDAO.setConnection(conn);
		
		result = joinDAO.setMemberJoin(request);
		
		if(result == 1) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);
		
		return result;
	}

	public int joinUpdate(HttpServletRequest request) {
		int result = 0;
		JoinDAO joinDAO = JoinDAO.getInstance();
		Connection conn = getConnection();
		joinDAO.setConnection(conn);

		result = joinDAO.joinUpdate(request);
		if (result == 1) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);

		return result;
	}

	public int joinDel(HttpServletRequest request) {
		int result = 0;
		JoinDAO joinDAO = JoinDAO.getInstance();
		Connection conn = getConnection();
		joinDAO.setConnection(conn);

		result = joinDAO.joinDel(request);
		if (result == 1) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);

		return result;
	}

}
