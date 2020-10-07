package dao;

import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import vo.MemberInfo;

import static db.JdbcUtil.*;

public class JoinDAO {
	private static JoinDAO joinDAO;
	private Connection conn;
	
	private JoinDAO() {
	}
	
	public static JoinDAO getInstance() {
		if (joinDAO == null) {
			joinDAO = new JoinDAO();
		}
		return joinDAO;
	}

	public void setConnection(Connection conn) {
		this.conn = conn;
	}

	public int setMemberJoin(HttpServletRequest request) {
		// 회원가입 처리를 위한 DB작업을 하는 메소드
		// 가입 시 필요한 데이터들을 얻기 위해 request객체를 매개변수로 받아 옴
		int result = 0;	// DB작업 후 영향을 받은 레코드 개수를 저장할 변수(리턴값)
		Statement stmt = null;
		
		try {
			// request객체의 사용에는 예외처리가 필요하므로 try문 안에서 작업
			request.setCharacterEncoding("utf-8");
			String uid = request.getParameter("uid").toLowerCase().trim();
			String pwd = request.getParameter("pwd").toLowerCase().trim();
			String uname = request.getParameter("uname").trim();
			String m1 = request.getParameter("m1");
			String m2 = request.getParameter("m2");
			String m3 = request.getParameter("m3");
			String addr1 = request.getParameter("addr1");
			String addr2 = request.getParameter("addr2");
			String [] position = request.getParameterValues("position");
			String question = request.getParameter("question");
			String answer = request.getParameter("answer");
			// request로 받는 데이터들 중 사용자가 직접 입력하는 데이터들은 반드시
			// trim()메소드로 불필요한 공백을 제거 한 후 받아야함
			// ID같은 정보는 대소문자 구별을 하지 않는 경우 소문자로 변환하여 받음
			
			String positionSlt = "";			
			for (int i = 0; i < position.length; i++) {
				if (i == (position.length -1 )) {
					positionSlt += position[i];
					// 마지막 value값일 경우 뒤에 , 안붙임
				} else {
					positionSlt += position[i] + ",";
				}
			}
			String phone = m1 + "-" + m2 + "-" + m3;
			String sql = "insert into t_member_list (ml_id, ml_pwd, ml_name, ml_phone, ml_addr1, ml_addr2, ml_position, ml_question, ml_answer) "
					+ "values('" + uid + "', '" + pwd + "', '" + uname + "', '" + phone + "', '" + addr1 + "', '" + addr2 + "', '" + positionSlt + "', '" + question + "', '" + answer + "')";
			System.out.println(sql);
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			// insert문이므로 executeUpdate()메소드로 실행함
			// 결과는 insert된 레코드의 개수로 일반적으로 1이 나와야 정상
		} catch (Exception e) {
			System.out.println("setMemberJoin()메소드에서 오류 발생");
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
	


	public int joinUpdate(HttpServletRequest request) {
		int result = 0;
		Statement stmt = null;

		try {
			request.setCharacterEncoding("utf-8");
			HttpSession session = request.getSession();
			MemberInfo memberInfo = (MemberInfo) session.getAttribute("memberInfo");
			String uid = memberInfo.getMl_id();

			String pwd = request.getParameter("pwd").toLowerCase().trim();
			String m1 = request.getParameter("m1");
			String m2 = request.getParameter("m2");
			String m3 = request.getParameter("m3");
			String addr1 = request.getParameter("addr1");
			String addr2 = request.getParameter("addr2");
			String [] position = request.getParameterValues("position");
			String question = request.getParameter("question");
			String answer = request.getParameter("answer");

			String phone = m1 + "-" + m2 + "-" + m3;
			String chk = "";
			if (position == null) {
				chk = "";
			} else {
				for (int i = 0; i < position.length; i++) {
					if (i == (position.length -1 )) {
						chk += position[i];
					} else {
						chk += position[i] + ",";
					}
				}
			}

			String sql = "update t_member_list set ml_pwd = '" + pwd + "', ml_phone = '" + phone
					+ "', ml_addr1 = '" + addr1 + "', ml_addr2 = '" + addr2 + "', ml_position = '" + chk + "', ml_question = '" + question;
			sql += "', ml_answer = '" + answer + "' where ml_id = '" + uid + "' ";
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			if (result == 1) {
				memberInfo.setMl_pwd(pwd);
				memberInfo.setMl_phone(phone);
				memberInfo.setMl_addr1(addr1);
				memberInfo.setMl_addr2(addr2);
				memberInfo.setMl_position(chk);
				memberInfo.setMl_question(question);
				memberInfo.setMl_answer(answer);
			}

		} catch (Exception e) {
			System.out.println("joinUpdate() 에서 오류발생");
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

	public int joinDel(HttpServletRequest request) {
		int result = 0;
		Statement stmt = null;

		try {
			request.setCharacterEncoding("utf-8");
			HttpSession session = request.getSession();
			MemberInfo memberInfo = (MemberInfo) session.getAttribute("memberInfo");
			String uid = memberInfo.getMl_id();
			String n = "n";
			String [] why = request.getParameterValues("why");
			String reason = "";
			if (why == null) {
				reason = "";
			} else {
				for (int i = 0; i < why.length; i++) {
					if (i == (why.length -1 )) {
						reason += why[i];
					} else {
						reason += why[i] + ",";
					}
				}
			}

			String sql = "update t_member_list set ml_isrun = 'n', ml_reason = '" + reason + "' where ml_id = '" + uid + "' ";
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			if (result == 1) {
				memberInfo.setMl_isrun(n);
				memberInfo.setMl_reason(reason);
			}

		} catch (Exception e) {
			System.out.println("joinDel() 에서 오류 발생2");
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