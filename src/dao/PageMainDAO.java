package dao;

import java.sql.*;
import javax.servlet.http.*;
import vo.*;
import static db.JdbcUtil.*;

public class PageMainDAO {
	
	private static PageMainDAO pageMainDAO;	
	private Connection conn;	
	
	private PageMainDAO() {}				

	public static PageMainDAO getInstance() {
		if (pageMainDAO == null) {		 
			pageMainDAO = new PageMainDAO();
		}
		
		return pageMainDAO;
	}
	
	public void setConnection(Connection conn) {		
		this.conn = conn;
	}

	
	// 배너 정보를 리턴하는 메소드
	public PageMainInfo getBanner() {
		PageMainInfo bannerInfo = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select * from t_pagemain_list ";
			stmt = conn.createStatement();	// 쿼리를 실행할 준비 완료
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				bannerInfo = new PageMainInfo();

				bannerInfo.setPl_bimg1(rs.getString("pl_bimg1"));
				bannerInfo.setPl_bimg2(rs.getString("pl_bimg2"));
				bannerInfo.setPl_bimg3(rs.getString("pl_bimg3"));
				bannerInfo.setPl_bimg4(rs.getString("pl_bimg4"));
				bannerInfo.setPl_bimg5(rs.getString("pl_bimg5"));
				bannerInfo.setPl_savebimg1(rs.getString("pl_savebimg1"));
				bannerInfo.setPl_savebimg2(rs.getString("pl_savebimg2"));
				bannerInfo.setPl_savebimg3(rs.getString("pl_savebimg3"));
				bannerInfo.setPl_savebimg4(rs.getString("pl_savebimg4"));
				bannerInfo.setPl_savebimg5(rs.getString("pl_savebimg5"));
				bannerInfo.setPl_bimgtime(rs.getInt("pl_bimgtime"));
								
			}				
		} catch(Exception e) {
			System.out.println("getBanner() 메소드 오류");
			e.printStackTrace();			
		} finally {
			close(rs);
			close(stmt);
		}					 
		return bannerInfo;			
	}
	
	// 배너 정보를 수정하고 그 결과를 리턴하는 메소드
	public int updateBanner(HttpServletRequest request) {
		int result = 0;
		Statement stmt = null;
		try {
			request.setCharacterEncoding("utf-8");
			String bannerTime = (String)request.getAttribute("bannerTime");
			String img1 = (String)request.getAttribute("file1");
			String img2 = (String)request.getAttribute("file2");
			String img3 = (String)request.getAttribute("file3");
			String img4 = (String)request.getAttribute("file4");
			String img5 = (String)request.getAttribute("file5");
			String saveImg1 = (String)request.getAttribute("savefile1");
			String saveImg2 = (String)request.getAttribute("savefile2");
			String saveImg3 = (String)request.getAttribute("savefile3");
			String saveImg4 = (String)request.getAttribute("savefile4");
			String saveImg5 = (String)request.getAttribute("savefile5");
			
			String sql = "update t_pagemain_list set pl_bimgtime = '" + bannerTime + 
					"', pl_bimg1 = '" + img1 + "', pl_bimg2 = '" + img2 + "', pl_bimg3 = '" + img3 + 
					"', pl_bimg4 = '" + img4 + "', pl_bimg5 = '" + img5 +  
					"', pl_savebimg1 = '" + saveImg1 + "', pl_savebimg2 = '" + saveImg2 + "', pl_savebimg3 = '" + saveImg3 + 
					"', pl_savebimg4 = '" + saveImg4 + "', pl_savebimg5 = '" + saveImg5 + "' ";
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
		} catch (Exception e) {
			System.out.println("updateBanner() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}		
		return result;
	}
	
	// 홈페이지 기본 정보를 리턴하는 메소드
	 public PageMainInfo getInfo(String btype) {
		PageMainInfo introInfo = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select pl_" + btype + "title, pl_" + btype + "img, pl_" + btype + "saveimg, "
					+ "pl_" + btype + "content from t_pagemain_list ";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				introInfo = new PageMainInfo();

				if (btype.equals("intro")) {
					introInfo.setPl_introtitle(rs.getString("pl_introtitle"));
					introInfo.setPl_introimg(rs.getString("pl_introimg"));
					introInfo.setPl_introsaveimg(rs.getString("pl_introsaveimg"));
					introInfo.setPl_introcontent(rs.getString("pl_introcontent"));
				} else if (btype.equals("per")) {
					introInfo.setPl_pertitle(rs.getString("pl_pertitle"));
					introInfo.setPl_perimg(rs.getString("pl_perimg"));
					introInfo.setPl_persaveimg(rs.getString("pl_persaveimg"));
					introInfo.setPl_percontent(rs.getString("pl_percontent"));					
				} else if (btype.equals("use")) {
					introInfo.setPl_usetitle(rs.getString("pl_usetitle"));
					introInfo.setPl_useimg(rs.getString("pl_useimg"));
					introInfo.setPl_usesaveimg(rs.getString("pl_usesaveimg"));
					introInfo.setPl_usecontent(rs.getString("pl_usecontent"));					
				} else if (btype.equals("pay")) {
					introInfo.setPl_paytitle(rs.getString("pl_paytitle"));
					introInfo.setPl_payimg(rs.getString("pl_payimg"));
					introInfo.setPl_paysaveimg(rs.getString("pl_paysaveimg"));
					introInfo.setPl_paycontent(rs.getString("pl_paycontent"));					
				} 				
					introInfo.setBtype(btype);
			}				
		} catch(Exception e) {
			System.out.println("getInfo() 메소드 오류");
			e.printStackTrace();			
		} finally {
			close(rs);
			close(stmt);
		}					 		
		return introInfo;
	 }
	 
	 // 홈페이지 기본 정보를 수정하고 결과를 리턴하는 메소드
	 public int upInfo(HttpServletRequest request) {
		int result = 0;
		Statement stmt = null;
		try {
			request.setCharacterEncoding("utf-8");
			String btype = (String)request.getAttribute("btype");
			String img = (String)request.getAttribute("img");
			String saveimg = (String)request.getAttribute("saveimg");
			String title = (String)request.getAttribute("title");
			String content = (String)request.getAttribute("content");
			String sql = "";
			
			sql = "update t_pagemain_list set pl_" + btype + "title = '" + title + "', pl_" + btype + "content = '" + content +
					"', pl_" + btype + "img = '" + img + "', pl_" + btype + "saveimg = '" + saveimg + "' ";
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);			
		} catch (Exception e) {
			System.out.println("upInfo()메소드 오류 : " + e);
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		
		return result;		 
	 }
	
}














