package svc;

import static db.JdbcUtil.*;
//JdbcUtil클래스의 static 메소드들을 인스턴스 생성없이 바로 사용가능.
//db.JdbcUtil.*; 의 뜻 : JdbcUtil 안에있는 모든 메소드를 의미
import java.sql.*;

import javax.servlet.http.HttpServletRequest;

import dao.FindDAO;
import vo.MemberInfo;

public class FindService {
	
	// ID 찾는 메소드
	public MemberInfo getInfoFind(String uname, String question, String answer) {
		FindDAO findDAO = FindDAO.getInstance();
		Connection conn = getConnection();
		findDAO.setConnection(conn);
		MemberInfo id = findDAO.getInfoFind(uname, question, answer);
		close(conn);
		return id;
	}

	// 비밀번호 찾는 메소드
	public MemberInfo getInfoFindPwd(String uid, String uname, String question, String answer) {
		FindDAO findDAO = FindDAO.getInstance();
		Connection conn = getConnection();
		findDAO.setConnection(conn);
		MemberInfo pwd = findDAO.getInfoFindPwd(uid, uname, question, answer);
		close(conn);
		return pwd;
	}

	// 비밀번호 변경 메소드
	public int setPwd(HttpServletRequest request) {
		int result = 0;
		FindDAO findDAO = FindDAO.getInstance();
		Connection conn = getConnection();
		findDAO.setConnection(conn);
		result = findDAO.setPwd(request);
		if(result == 1) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);
		return result;
	}
}