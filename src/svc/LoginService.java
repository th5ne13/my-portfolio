package svc;

import static db.JdbcUtil.*;		// JdbcUtil 클래스를 static으로 import 하였으므로 인스턴스 없이 메소드들을 바로 호출 가능 
									// JdbcUtil.* -> JdbcUtil 안에 있는 모든 메소드 사용 가능 
import java.sql.*;
import dao.LoginDAO;				// DAO : 쿼리를 만들어서 주로 일을하는 파일
import vo.*;

// 로그인 관련 비즈니스 로직을 처리하는 파일
public class LoginService {
	// 회원 로그인 서비스
	public MemberInfo getLoginMember(String uid, String pwd) {
		LoginDAO loginDAO = LoginDAO.getInstance();		// LoginDAO 형태의 loginDAO 인스턴스를 선언, singletone 방식을 사용하여 바로 인스턴스를 담음
		Connection conn = getConnection();				// 상속받지 않고 import를 한 이유는 JdbcUtil과 LoginService의 성격이 전혀 다르기 때문
														// 코드 재활용, 쉽게 쓰기 위해 상속을 하지 말아야 함
		loginDAO.setConnection(conn);					// loginDAO 인스턴스에서 사용할 Connection 객체 지정
		MemberInfo loginMember = loginDAO.getLoginMember(uid, pwd);		// uid와 pwd를 이용하여 쿼리를 실행 후 결과를 받아옴
		close(conn);									// 쿼리 작업이 끝났으므로 Connection객체를 닫아줌
		
		return loginMember;
	}
	
	// 어드민 로그인 서비스
	public AdminInfo getLoginAdmin(String aid, String pwd) {
		LoginDAO loginDAO = LoginDAO.getInstance();
		Connection conn = getConnection();
		loginDAO.setConnection(conn);
		AdminInfo adminMember = loginDAO.getLoginAdmin(aid, pwd);
		close(conn);
		
		return adminMember;
		
	}
	
	// 어드민 DashBoard에서 보여줄 사이트 정보
	public SiteInfo getSiteInfo() {
		LoginDAO loginDAO = LoginDAO.getInstance();
		Connection conn = getConnection();
		loginDAO.setConnection(conn);
		SiteInfo siteInfo = loginDAO.getSiteInfo();
		close(conn);
		
		return siteInfo;
		
	}
}
