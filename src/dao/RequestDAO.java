package dao;

import java.io.*;
import java.sql.*;
import java.util.ArrayList;
import javax.servlet.http.*;

import org.apache.catalina.connector.Request;

import javax.servlet.ServletException;
import static db.JdbcUtil.*;
import vo.*;

public class RequestDAO {
	private static RequestDAO requestDAO;
	private Connection conn;

	private RequestDAO() {}

	public static RequestDAO getInstance() {
		if (requestDAO == null) {
			requestDAO = new RequestDAO();
		}

		return requestDAO;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}

	// 새 요청을 등록시키는 메소드
	public String insertRequest(HttpServletRequest request) {
		int result = 0, nlnum = 1;
		String nlResult = "";
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select max(req_num) + 1 from t_request_status_list";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			System.out.println(sql);

			if (rs.next())	nlnum = rs.getInt(1);
			String reqtype = request.getParameter("reqtype");
			String memid = request.getParameter("memid");
			String upid = request.getParameter("upid");
			String num = request.getParameter("num");
			String num2 = "";
			String reqstatus = request.getParameter("reqstatus");
			String matchtype = request.getParameter("matchtype");
			String addr = request.getParameter("addr").trim();
			String plan = request.getParameter("plan");
			int recruitnum = 0;
			String name = request.getParameter("name");
			String date = request.getParameter("date");
			String lastnum;
			String isrecruit = "";
			System.out.println(recruitnum);
			System.out.println(reqtype);
			System.out.println(memid);
			
			if (reqtype.equals("A")) {
				lastnum = "A";	// 용병지원이면 마지막 문자 A
			} else {			
				lastnum = "R";	// 용병모집이면 마지막 문자 R
				recruitnum = Integer.parseInt(request.getParameter("recruitnum"));
			}	
			
			String reqnum = "1" + memid + num + lastnum;

			sql = "insert into t_request_status_list (req_num, req_type, ";
			sql += "ml_id, req_postid, req_boardnum, req_status, req_matchtype, ";
			sql += " req_addr2, req_matchdate, req_recruitnum, req_postname, req_date) values ";
			sql += "('" + reqnum + "' , '" + reqtype + "', '" + memid + "', '" + upid + "', '" + num + "', '" + reqstatus + "', '" + matchtype + "', '" + addr + "', '" + plan + "', '" + recruitnum + "', '" + name + "', '" + date + "') "; 	
						
			System.out.println(sql);
			result = stmt.executeUpdate(sql);
			
			String resnum = "2" + memid + num + lastnum; // lastsnum 은 용병모집일시 1 지원일시 2
			
			sql = "insert into t_response_status_list (res_num, res_type, ";
			sql += "req_num, ml_id, res_postid, res_boardnum, res_status, res_matchtype, ";
			sql += " res_addr2, res_matchdate, res_recruitnum, res_postname, res_date) values ";
			sql += "('" + resnum + "' , '" + reqtype + "', '" + reqnum + "', '" + memid + "', '" + upid + "', '" + num + "', '" + reqstatus + "', '" + matchtype + "', '" + addr + "', '" + plan + "', '" + recruitnum + "', '" + name + "', '" + date + "') "; 	
			System.out.println(sql);
			result = stmt.executeUpdate(sql);	
			
			nlResult = result + ":" + nlnum;
			System.out.println(nlResult);
		} catch(Exception e) {
			System.out.println("insertRequest() 메소드에서 오류 발생");
		} finally {
			close(rs);
			close(stmt);
		}
		return nlResult;
	}
	
	// 공지사항 게시물들 중 검색되는 전체 개수를 리턴하는 메소드
	public int getListCount(String where) {
		int rcount = 0;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select count(*) from t_recruit_list where 1=1 " + where;			
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();	// if문을 사용하지 않는 것은 count()결과이므로 무조건 결과값이 존재하므로
			rcount = rs.getInt(1);
		} catch(Exception e) {
			System.out.println("getListCount() 메소드에서 오류 발생");
		} finally {
			close(rs);
			close(stmt);
		}
		return rcount;
	}

	// 공지사항의 목록을 ArrayList형태로 리턴하는 메소드
	public ArrayList<PlayerInfo> getRecruitList(String where, int cpage, int limit) {
		ArrayList<PlayerInfo> recruitList = new ArrayList<PlayerInfo>();
		Statement stmt = null;
		ResultSet rs = null;
		PlayerInfo rplayerInfo = null;
		try {
			int start = (cpage - 1) * limit;
			String sql = "select res_type, a.req_num, b.res_num, a.ml_id, a.req_postid, b.res_postid, a.req_matchtype, a.req_addr2, a.req_matchdate, a.req_recruitnum, a.req_postname, a.req_date, a.req_status from t_request_status_list a, t_response_status_list b where a.req_num = b.req_num ";
			sql += " order by a.req_date desc limit " + start + ", " + limit; 
			stmt = conn.createStatement();
			System.out.println(sql);
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				rplayerInfo = new PlayerInfo();
				// 하나의 게시글 데이터를 담기 위한 NoticeInfo 인스턴스 생성

				rplayerInfo.setRes_type(rs.getString("res_type"));
				rplayerInfo.setReq_num(rs.getString("req_num"));
				rplayerInfo.setRes_num(rs.getString("res_num"));
				rplayerInfo.setMl_id(rs.getString("ml_id"));
				rplayerInfo.setReq_postid(rs.getString("req_postid"));
				rplayerInfo.setRes_postid(rs.getString("res_postid"));
				rplayerInfo.setReq_matchtype(rs.getString("req_matchtype"));
				rplayerInfo.setReq_addr2(rs.getString("req_addr2"));
				rplayerInfo.setReq_matchdate(rs.getString("req_matchdate"));
				rplayerInfo.setReq_recruitnum(rs.getInt("req_recruitnum"));
				rplayerInfo.setReq_postname(rs.getString("req_postname"));
				rplayerInfo.setReq_date(rs.getString("req_date"));
				rplayerInfo.setReq_status(rs.getString("req_status"));

				recruitList.add(rplayerInfo);
				// 공지사항 목록을 담을 ArrayList에 생성한 인스턴스를 넣음
			}
		} catch(Exception e) {
			System.out.println("getRecruitList() 메소드에서 오류 발생");
		} finally {
			close(rs);
			close(stmt);
		}

		return recruitList;
	}
	
	public ArrayList<PlayerInfo> getViewRecruitList(String where, int cpage, int limit) {
		ArrayList<PlayerInfo> recruitViewList = new ArrayList<PlayerInfo>();
		Statement stmt = null;
		ResultSet rs = null;
		PlayerInfo rplayerInfo = null;
		try {
			int start = (cpage - 1) * limit;
			String sql = "select res_type, a.req_num, b.res_num, a.ml_id, a.req_postid, b.res_postid, a.req_matchtype, a.req_addr2, a.req_matchdate, a.req_recruitnum, a.req_postname, a.req_date, a.req_status from t_request_status_list a, t_response_status_list b where a.req_num = b.req_num ";
			sql += " order by a.req_date desc"; 
			stmt = conn.createStatement();
			System.out.println(sql);
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				rplayerInfo = new PlayerInfo();
				// 하나의 게시글 데이터를 담기 위한 NoticeInfo 인스턴스 생성

				rplayerInfo.setRes_type(rs.getString("res_type"));
				rplayerInfo.setReq_num(rs.getString("req_num"));
				rplayerInfo.setRes_num(rs.getString("res_num"));
				rplayerInfo.setMl_id(rs.getString("ml_id"));
				rplayerInfo.setReq_postid(rs.getString("req_postid"));
				rplayerInfo.setRes_postid(rs.getString("res_postid"));
				rplayerInfo.setReq_matchtype(rs.getString("req_matchtype"));
				rplayerInfo.setReq_addr2(rs.getString("req_addr2"));
				rplayerInfo.setReq_matchdate(rs.getString("req_matchdate"));
				rplayerInfo.setReq_recruitnum(rs.getInt("req_recruitnum"));
				rplayerInfo.setReq_postname(rs.getString("req_postname"));
				rplayerInfo.setReq_date(rs.getString("req_date"));
				rplayerInfo.setReq_status(rs.getString("req_status"));

				recruitViewList.add(rplayerInfo);
				// 공지사항 목록을 담을 ArrayList에 생성한 인스턴스를 넣음
			}
		} catch(Exception e) {
			System.out.println("getViewRecruitList() 메소드에서 오류 발생");
		} finally {
			close(rs);
			close(stmt);
		}

		return recruitViewList;
	}
	
	
	// 공지사항을 수정하는 메소드
	public int updateNotice(String reqnum, String btntype) {
		int result = 0;
		Statement stmt = null;
		Statement stmt2 = null;
		try {
			String sql = "";
			String sql2 = "";
			if(btntype.equals("A")) {
				sql = "update t_response_status_list set res_status = 'Y' where req_num = '" + reqnum + "' ";
				sql2 = "update t_request_status_list set req_status = 'Y' where req_num = '" + reqnum + "' ";
			} else {
				sql = "update t_response_status_list set res_status = 'D' where req_num = '" + reqnum + "' ";
				sql2 = "update t_request_status_list set req_status = 'D' where req_num = '" + reqnum + "' ";

			}

			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			result = stmt.executeUpdate(sql2);
		} catch(Exception e) {
			System.out.println("updateNotice() 메소드에서 오류 발생");
		} finally {
			close(stmt2);
			close(stmt);
		}

		return result;
	}
	
	// 공지사항을 삭제하는 메소드
	public int deleteNotice(String reqnum, String btntype, String mlid) {
		int result = 0;
		Statement stmt = null;
		Statement stmt2 = null;
		try {
			String sql = "";
			String sql2 = "";
			sql = "delete from t_response_status_list where req_num = '" + reqnum + "' ";
			sql2 = "delete from t_request_status_list where req_num = '" + reqnum + "' ";
			
			System.out.println(sql);
			System.out.println(sql2);
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			result = stmt.executeUpdate(sql2);
			
		} catch(Exception e) {
			System.out.println("updateNotice() 메소드에서 오류 발생");
		} finally {
			close(stmt2);
			close(stmt);
		}

		return result;
	}
}
