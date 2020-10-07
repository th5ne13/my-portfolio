package dao;

import java.io.IOException;
import java.sql.*;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import vo.*;
import static db.JdbcUtil.*;

public class GroundRevDAO {
	private static GroundRevDAO groundRevDAO;
	private Connection conn; 
	private GroundRevDAO() {}

	public static GroundRevDAO getInstance() {	
		if (groundRevDAO == null) {	
			groundRevDAO = new GroundRevDAO();
		}
		
		return groundRevDAO;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}

	public int groundRev(HttpServletRequest request) {
		
		int result = 0;	
		Statement stmt = null; 
		ResultSet rs = null;
		try {
			request.setCharacterEncoding("utf-8");	
			String sltDay = request.getParameter("sltDay");
			String grdate = sltDay.substring(0, 10);
			String codeDay = sltDay.substring(2, 4) + sltDay.substring(5, 7) + sltDay.substring(8, 10);			
			String sql = "select lpad(count(gr_code)+1, 9, '" + codeDay + "000') from t_ground_rev where gr_code like '%" + codeDay + "%' ";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();			
			String newGrcode = rs.getString(1);
			String grtime = request.getParameter("sltTime");
			String grcost = request.getParameter("cost");
			String glcode = request.getParameter("glcode");
			String mlid = request.getParameter("mlid");
			String grname = request.getParameter("glname");
			String phone = request.getParameter("phone");
			String pay = request.getParameter("pay");
			String glAddr = request.getParameter("glAddr");
			System.out.println(glAddr);
			sql = "insert into t_ground_rev (gr_code, gr_date, gr_time, gr_cost, gl_code, ml_id, ml_phone, gr_pay, gr_addr, gr_name) values "
					+ "('" + newGrcode + "', '" + grdate +"', '" + grtime +"', '" + grcost +"', '" 
					+ glcode +"', '" + mlid + "', '" + phone + "', '" + pay + "', '" + glAddr + "', '" + grname + "')";
			result = stmt.executeUpdate(sql);
			
			if (result == 1) {
				sql = "update t_member_list set ml_revcnt = ml_revcnt + 1, ml_pay = ml_pay + '" + grcost + "' where ml_id = '" + mlid + "' ";
				result = stmt.executeUpdate(sql);
			}
		} catch(Exception e) {
			System.out.println("groundRev()메소드오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}				
		return result;
	}

}
