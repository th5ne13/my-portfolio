package dao;

import java.io.IOException;
import java.sql.*; // 
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import vo.*;
import static db.JdbcUtil.*;

public class GroundReqDAO {
	private static GroundReqDAO groundReqDAO;
	private Connection conn;
	private GroundReqDAO() {}

	public static GroundReqDAO getInstance() {	
		if (groundReqDAO == null) {	
			groundReqDAO = new GroundReqDAO();
		}
		
		return groundReqDAO;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	String[] addr = {"종로구", "중구", "용산구", "성동구",	"광진구", "동대문구", "중랑구", "성북구", "강북구", "도봉구", "노원구", "은평구",
			 "서대문구", "마포구", "양천구", "강서구", "구로구", "금천구",	"영등포구",	"동작구", "관악구",	"서초구", "강남구", "송파구", "강동구" };
	String[] code = {"sa", "sb", "sc", "sd", "se", "sf", "sg", "sh", "si", "sj", "sk", "sl", "sm", "sn", "so", "sp", "sq", "sr", "ss", "st", "su", "sv", "sw", "sx", "sy"};
	
	
	public int insertGround(HttpServletRequest request) {
		
		int result = 0;	
		Statement stmt = null; 
		ResultSet rs = null;
		try {
		request.setCharacterEncoding("utf-8");	
		
		String grdname = ((String)request.getAttribute("grdname")).toLowerCase().trim();
		String name =((String)request.getAttribute("name")).trim();
		String p1 = (String)request.getAttribute("p1");
		String p2 = (String)request.getAttribute("p2");
		String p3 = (String)request.getAttribute("p3");		
		String zipcode = (String)request.getAttribute("zipcode");
		String jibeon = (String)request.getAttribute("jibeon");
		String addrdtl = (String)request.getAttribute("addrdtl");
		
		String wdcost = (String)request.getAttribute("wdcost");
		String wkcost = (String)request.getAttribute("wkcost");
			
		String isparking = (String)request.getAttribute("isparking");
		String iscoldhot = (String)request.getAttribute("iscoldhot");
		String isshower = (String)request.getAttribute("isshower");
		String isvest = (String)request.getAttribute("isvest");
		String isfootshoes = (String)request.getAttribute("isfootshoes");
		String isball = (String)request.getAttribute("isball");
		
		String grdsizewidth = (String)request.getAttribute("grdsizewidth");
		String grdsizeheight = (String)request.getAttribute("grdsizeheight");	
		String isLawn = (String)request.getAttribute("isLawn");		
		String infoAndRule = (String)request.getAttribute("infoAndRule");			
		String phone = p1 + "-" + p2 + "-" + p3;			
		
		String weekdaySltChk = (String)request.getAttribute("weekdaySltChk");
		String weekdayTimeChk = (String)request.getAttribute("weekdayTimeChk");
		String weekendSltChk = (String)request.getAttribute("weekendSltChk");
		String weekendTimeChk = (String)request.getAttribute("weekendTimeChk");
		String matchTypeChk = (String)request.getAttribute("matchTypeChk");
		String waterChk = (String)request.getAttribute("waterChk");	
		
		String img1 = (String)request.getAttribute("file1");
		String img2 = (String)request.getAttribute("file2");
		String img3 = (String)request.getAttribute("file3");
		String img4 = (String)request.getAttribute("file4");
		String img5 = (String)request.getAttribute("file5");
		String img6 = (String)request.getAttribute("file6"); 
		String saveImg1 = (String)request.getAttribute("savefile1");
		String saveImg2 = (String)request.getAttribute("savefile2");
		String saveImg3 = (String)request.getAttribute("savefile3");
		String saveImg4 = (String)request.getAttribute("savefile4");
		String saveImg5 = (String)request.getAttribute("savefile5");
		String saveImg6 = (String)request.getAttribute("savefile6");
		String mlid = request.getParameter("mlid");
		System.out.println("mlid는 " + mlid);
		String gu = (String)request.getAttribute("gu");
		
		
		int num = 25;
		for (int i = 0; i < addr.length; i++) {
			if (gu.equals(addr[i])) {
				num = i;
				break;
			}
		}
		
		String glcode = code[num];
		String sql = "select lpad(count(gl_code)+1, 6, '" + glcode + "000') from t_ground_list where gl_code like '%" + glcode + "%' ";
		stmt = conn.createStatement();
		System.out.println(sql);
		rs = stmt.executeQuery(sql);
		rs.next();
		String newGlcode = rs.getString(1);
		System.out.println(newGlcode);
		sql = "insert into t_ground_list " + 
					"(gl_code, gl_grdname, gl_phone, gl_name, " + 
					" gl_zipcode, gl_jibeon, gl_addrdtl, gl_weekdayslt, " + 					
					" gl_weekendslt, gl_weekdaytime, gl_weekendtime, gl_wdcost, " + 
					" gl_wkcost, gl_matchtype, gl_parking, gl_coldhot, gl_rentball, gl_rentvest, gl_pshoes, gl_shower, " + 				
					 " gl_img1, gl_saveimg1, gl_img2, gl_saveimg2, gl_img3, gl_saveimg3, gl_img4, gl_saveimg4, gl_img5, gl_saveimg5, gl_img6, gl_saveimg6, "
					 + " gl_size1, gl_size2, gl_floor, gl_water, gl_rule) values " + 
				
				
				 "('" + newGlcode + "', '"+grdname+"', '"+phone+"', '"+name+"', '"+zipcode+"',  '"+jibeon+"', '"+addrdtl+"', " +  
				" '"+weekdaySltChk+"', '"+weekendSltChk+"', '"+weekdayTimeChk+"', '"+weekendTimeChk+"', '"+wdcost+"', '"+wkcost+"', " + 
				" '"+matchTypeChk+"', '"+isparking+"', '"+iscoldhot+"', '"+isball+"', '"+isvest+"', '"+isfootshoes+"', '"+isshower+"', " +  
				" '"+img1+"', '"+saveImg1+"', '"+img2+"', '"+saveImg2+"', '"+img3+"', '"+saveImg3+"', '"+img4+"', '"+saveImg4+"', '"+img5+"', '"+saveImg5+"', '"+img6+"', '"+saveImg6+"', " +  
				" '"+grdsizewidth+"', '"+grdsizeheight+"', '"+isLawn+"', '"+waterChk+"', '"+infoAndRule+"')"; 
		
		System.out.println(sql);
		result = stmt.executeUpdate(sql);
		System.out.println(result);
		if (result == 1) {
			sql = "update t_member_list set ml_membertype = 'o', gl_code = '" + newGlcode +"' where ml_id = '" + request.getAttribute("mlid") +"' ";
			System.out.println("여기가 문젠가 : " + sql);
			result = stmt.executeUpdate(sql);
		} else {
			return result;
		}
			
		} catch(Exception e) {
			System.out.println("insertGround()메소드오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}				
		return result;
	}
	
		public int updateGround(HttpServletRequest request) {
			int result = 0;	
			Statement stmt = null; 
					
			try {

				request.setCharacterEncoding("utf-8");	
				String wtype = (String)request.getAttribute("wtype");
				System.out.println(wtype);
				
				String glcode = ((String)request.getAttribute("glcode"));
				String grdname = ((String)request.getAttribute("grdname")).toLowerCase().trim();
				String name =((String)request.getAttribute("name")).trim();;
				String p1 = (String)request.getAttribute("p1");
				String p2 = (String)request.getAttribute("p2");
				String p3 = (String)request.getAttribute("p3");		
				String zipcode = (String)request.getAttribute("zipcode");
				String jibeon = (String)request.getAttribute("jibeon");
				String addrdtl = (String)request.getAttribute("addrdtl");
				
				String wdcost = (String)request.getAttribute("wdcost");
				String wkcost = (String)request.getAttribute("wkcost");
					
				String isparking = (String)request.getAttribute("isparking");
				String iscoldhot = (String)request.getAttribute("iscoldhot");
				String isshower = (String)request.getAttribute("isshower");
				String isvest = (String)request.getAttribute("isvest");
				String isfootshoes = (String)request.getAttribute("isfootshoes");
				String isball = (String)request.getAttribute("isball");
				
				String grdsizewidth = (String)request.getAttribute("grdsizewidth");
				String grdsizeheight = (String)request.getAttribute("grdsizeheight");	
				String isLawn = (String)request.getAttribute("isLawn");		
				String infoAndRule = (String)request.getAttribute("infoAndRule");			
				String phone = p1 + "-" + p2 + "-" + p3;			
				
				String weekdaySltChk = (String)request.getAttribute("weekdaySltChk");
				String weekdayTimeChk = (String)request.getAttribute("weekdayTimeChk");
				String weekendSltChk = (String)request.getAttribute("weekendSltChk");
				String weekendTimeChk = (String)request.getAttribute("weekendTimeChk");
				String matchTypeChk = (String)request.getAttribute("matchTypeChk");
				String waterChk = (String)request.getAttribute("waterChk");	
				
				String img1 = (String)request.getAttribute("file1");
				String img2 = (String)request.getAttribute("file2");
				String img3 = (String)request.getAttribute("file3");
				String img4 = (String)request.getAttribute("file4");
				String img5 = (String)request.getAttribute("file5");
				String img6 = (String)request.getAttribute("file6"); 
				String saveImg1 = (String)request.getAttribute("savefile1");
				String saveImg2 = (String)request.getAttribute("savefile2");
				String saveImg3 = (String)request.getAttribute("savefile3");
				String saveImg4 = (String)request.getAttribute("savefile4");
				String saveImg5 = (String)request.getAttribute("savefile5");
				String saveImg6 = (String)request.getAttribute("savefile6");
				
				String gu = (String)request.getAttribute("gu");
		

				String sql = " update t_ground_list set " + 
						"gl_code = '"+glcode+"', gl_grdname = '"+grdname+"', gl_phone = '"+phone+"', gl_name = '"+name+"', " 
						+ "gl_zipcode = '"+zipcode+"', gl_jibeon = '"+jibeon+"', gl_addrdtl = '"+addrdtl+"', "
						+ "gl_weekdayslt = '"+weekdaySltChk+"', gl_weekendslt = '"+weekendSltChk+"', gl_weekdaytime = '"+weekdayTimeChk+"', "
						+ "gl_weekendtime = '"+weekendTimeChk+"',gl_wdcost = '"+wdcost+"', gl_wkcost = '"+wkcost+"', "
						+ "gl_matchtype = '"+matchTypeChk+"', gl_parking = '"+isparking+"', gl_coldhot = '"+iscoldhot+"', "					
						+ "gl_rentball = '"+isball+"', gl_rentvest = '"+isvest+"', gl_pshoes = '"+isfootshoes+"', "					
						+ "gl_shower = '"+isshower+"', gl_img1 = '"+img1+"', gl_saveimg1 = '"+saveImg1+"', "					
						+ "gl_img2 = '"+img2+"', gl_saveimg2 = '"+saveImg2+"', gl_img3 = '"+img3+"', "					
						+ "gl_saveimg3 = '"+saveImg3+"', gl_img4 = '"+img4+"', gl_saveimg4 = '"+saveImg4+"', "					
						+ "gl_img5 = '"+img5+"', gl_saveimg5 = '"+saveImg5+"', gl_img6 = '"+img6+"', "					
						+ "gl_saveimg6 = '"+saveImg6+"', gl_size1 = '"+grdsizewidth+"', gl_size2 = '"+grdsizeheight+"', "		
						+ "gl_floor = '"+isLawn+"', gl_water = '"+waterChk+"', gl_rule = '"+infoAndRule+"', ";
				if (wtype.equals("admin"))	sql += " gl_isview = 'y' ";
						sql += " where gl_code = '" +request.getAttribute("glcode")+"' ";
				stmt = conn.createStatement();
				result = stmt.executeUpdate(sql);
			
			} catch(Exception e) {
				System.out.println("updateGround()메소드오류");
				e.printStackTrace();
			} finally {
				close(stmt);
			}				
			return result;
		
		}	
	
	
	public GroundListInfo getGround(String glcode, String date) {
		GroundListInfo groundListInfo = null;
		String revTime = "";
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select * from t_ground_list where gl_code = '" + glcode + "'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				groundListInfo = new GroundListInfo();

				groundListInfo.setGl_grdname(rs.getString("gl_grdname"));
				groundListInfo.setGl_code(glcode);
				groundListInfo.setGl_phone(rs.getString("gl_phone"));
				groundListInfo.setGl_name(rs.getString("gl_name"));
				groundListInfo.setGl_zipcode(rs.getString("gl_zipcode"));
				groundListInfo.setGl_jibeon(rs.getString("gl_jibeon"));
				groundListInfo.setGl_addrdtl(rs.getString("gl_addrdtl"));
				groundListInfo.setGl_weekdayslt(rs.getString("gl_weekdayslt"));
				groundListInfo.setGl_weekendslt(rs.getString("gl_weekendslt"));
				groundListInfo.setGl_weekdaytime(rs.getString("gl_weekdaytime"));
				groundListInfo.setGl_weekendtime(rs.getString("gl_weekendtime"));
				groundListInfo.setGl_wdcost(rs.getInt("gl_wdcost"));
				groundListInfo.setGl_wkcost(rs.getInt("gl_wkcost"));
				groundListInfo.setGl_matchtype(rs.getString("gl_matchtype"));
				groundListInfo.setGl_parking(rs.getString("gl_parking"));
				groundListInfo.setGl_coldhot(rs.getString("gl_coldhot"));
				groundListInfo.setGl_rentball(rs.getString("gl_rentball"));
				groundListInfo.setGl_rentvest(rs.getString("gl_rentvest"));
				groundListInfo.setGl_pshoes(rs.getString("gl_pshoes"));
				groundListInfo.setGl_shower(rs.getString("gl_shower"));
				groundListInfo.setGl_img1(rs.getString("gl_img1"));
				groundListInfo.setGl_saveimg1(rs.getString("gl_saveimg1"));
				groundListInfo.setGl_img2(rs.getString("gl_img2"));
				groundListInfo.setGl_saveimg2(rs.getString("gl_saveimg2"));
				groundListInfo.setGl_img3(rs.getString("gl_img3"));
				groundListInfo.setGl_saveimg3(rs.getString("gl_saveimg3"));
				groundListInfo.setGl_img4(rs.getString("gl_img4"));
				groundListInfo.setGl_saveimg4(rs.getString("gl_saveimg4"));
				groundListInfo.setGl_img5(rs.getString("gl_img5"));
				groundListInfo.setGl_saveimg5(rs.getString("gl_saveimg5"));
				groundListInfo.setGl_img6(rs.getString("gl_img6"));
				groundListInfo.setGl_saveimg6(rs.getString("gl_saveimg6"));
				groundListInfo.setGl_size1(rs.getInt("gl_size1"));
				groundListInfo.setGl_size2(rs.getInt("gl_size2"));
				groundListInfo.setGl_floor(rs.getString("gl_floor"));
				groundListInfo.setGl_water(rs.getString("gl_water"));
				groundListInfo.setGl_rule(rs.getString("gl_rule"));	

				ArrayList<GroundRevInfo> grdRevList = new ArrayList<GroundRevInfo>();
				grdRevList = getGrdRev(rs.getString("gl_code"), date);
				if (grdRevList.size() > 0) {
					for(int i = 0; i < grdRevList.size(); i++) {
						GroundRevInfo grdRev = grdRevList.get(i);
						revTime += grdRev.getGr_time();
					}
				}				
				groundListInfo.setRevTime(revTime);				
			}				
		} catch(Exception e) {
			System.out.println("getGround()메소드오류");
			e.printStackTrace();			
		} finally {
			close(rs);
			close(stmt);
		}					
		return groundListInfo;			
	}	
	
	public ArrayList<GroundListInfo> getGroundList(String where, int cpage, int limit) {
		ArrayList<GroundListInfo> adminGroundList  = new ArrayList<GroundListInfo>();
		Statement stmt = null;
		ResultSet rs = null;
		GroundListInfo groundInfo = null;
		try {
			int start = (cpage - 1) * limit;				
			String sql = "select * from t_ground_list where 1=1 " + where;
			sql += " order by gl_num desc limit " + start + ", " + limit;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);			
			while (rs.next()) {	
				groundInfo = new GroundListInfo();
				
				groundInfo.setGl_code(rs.getString("gl_code"));
				groundInfo.setGl_grdname(rs.getString("gl_grdname"));
				groundInfo.setGl_phone(rs.getString("gl_phone"));
				groundInfo.setGl_name(rs.getString("gl_name"));
				groundInfo.setGl_zipcode(rs.getString("gl_zipcode"));
				groundInfo.setGl_jibeon(rs.getString("gl_jibeon"));
				groundInfo.setGl_addrdtl(rs.getString("gl_addrdtl"));
				groundInfo.setGl_weekdayslt(rs.getString("gl_weekdayslt"));
				groundInfo.setGl_weekendslt(rs.getString("gl_weekendslt"));
				groundInfo.setGl_weekdaytime(rs.getString("gl_weekdaytime"));
				groundInfo.setGl_weekendtime(rs.getString("gl_weekendtime"));
				groundInfo.setGl_wdcost(rs.getInt("gl_wdcost"));
				groundInfo.setGl_wkcost(rs.getInt("gl_wkcost"));
				groundInfo.setGl_matchtype(rs.getString("gl_matchtype"));
				groundInfo.setGl_parking(rs.getString("gl_parking"));
				groundInfo.setGl_coldhot(rs.getString("gl_coldhot"));
				groundInfo.setGl_rentball(rs.getString("gl_rentball"));
				groundInfo.setGl_rentvest(rs.getString("gl_rentvest"));
				groundInfo.setGl_pshoes(rs.getString("gl_pshoes"));
				groundInfo.setGl_shower(rs.getString("gl_shower"));
				groundInfo.setGl_img1(rs.getString("gl_img1"));
				groundInfo.setGl_saveimg1(rs.getString("gl_saveimg1"));
				groundInfo.setGl_img2(rs.getString("gl_img2"));
				groundInfo.setGl_saveimg2(rs.getString("gl_saveimg2"));
				groundInfo.setGl_img3(rs.getString("gl_img3"));
				groundInfo.setGl_saveimg3(rs.getString("gl_saveimg3"));
				groundInfo.setGl_img4(rs.getString("gl_img4"));
				groundInfo.setGl_saveimg4(rs.getString("gl_saveimg4"));
				groundInfo.setGl_img5(rs.getString("gl_img5"));
				groundInfo.setGl_saveimg5(rs.getString("gl_saveimg5"));
				groundInfo.setGl_img6(rs.getString("gl_img6"));
				groundInfo.setGl_saveimg6(rs.getString("gl_saveimg6"));
				groundInfo.setGl_size1(rs.getInt("gl_size1"));
				groundInfo.setGl_size2(rs.getInt("gl_size2"));
				groundInfo.setGl_floor(rs.getString("gl_floor"));
				groundInfo.setGl_water(rs.getString("gl_water"));
				groundInfo.setGl_rule(rs.getString("gl_rule"));
				groundInfo.setGl_isview(rs.getString("gl_isview"));
				groundInfo.setAlter_id(rs.getString("alter_id"));			
			
				adminGroundList.add(groundInfo);		
			}
			
		} catch(Exception e) {
			System.out.println("getGroundList()메소드오류");
			e.printStackTrace();			
		} finally {
			close(rs);
			close(stmt);
		}
		
		return adminGroundList;			
	}	
	
	public ArrayList<GroundListInfo> getBranList() {
		ArrayList<GroundListInfo> branList  = new ArrayList<GroundListInfo>();
		Statement stmt = null;
		ResultSet rs = null;
		GroundListInfo groundInfo = null;
		try {				
			String sql = "select gl_grdname from t_ground_list";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);			
			while (rs.next()) {
				groundInfo = new GroundListInfo();
				
				groundInfo.setGl_grdname(rs.getString("gl_grdname"));			
				branList.add(groundInfo);		
			}
			
		} catch(Exception e) {
			System.out.println("getBranList() 메소드오류");
			e.printStackTrace();			
		} finally {
			close(rs);
			close(stmt);
		}
		
		return branList;			
	}	

	public ArrayList<GroundListInfo> getGroundList(HttpServletRequest request, String memAddr) {
		ArrayList<GroundListInfo> groundList  = new ArrayList<GroundListInfo>();
		Statement stmt = null;
		ResultSet rs = null;
		GroundListInfo groundInfo = null;
		try {
			request.setCharacterEncoding("utf-8");
			String schTxt = request.getParameter("schTxt");
			String schGu = request.getParameter("schGu");
			String date = request.getParameter("schDate");
			if (date == null || date.equals(""))	date = request.getParameter("date");
			String revTime = "";
			String where = " where gl_jibeon like '%"+schGu+"%' and (gl_jibeon like '%"+schTxt+"%' or gl_addrdtl like '%"+schTxt+"%' or gl_grdname like '%"+schTxt+"%')";
			String sql = "select * from t_ground_list " + where + " order by gl_num desc ";
			if ((schTxt == null || schTxt.equals("")) && (schGu == null || schGu.equals("")))	{
				sql = "select * from t_ground_list order by gl_jibeon like '%"+memAddr+"%' desc";
			}
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				groundInfo = new GroundListInfo();
				
				groundInfo.setGl_grdname(rs.getString("gl_grdname"));
				groundInfo.setGl_phone(rs.getString("gl_phone"));
				groundInfo.setGl_name(rs.getString("gl_name"));
				groundInfo.setGl_zipcode(rs.getString("gl_zipcode"));
				groundInfo.setGl_jibeon(rs.getString("gl_jibeon"));
				groundInfo.setGl_addrdtl(rs.getString("gl_addrdtl"));
				groundInfo.setGl_weekdayslt(rs.getString("gl_weekdayslt"));
				groundInfo.setGl_weekendslt(rs.getString("gl_weekendslt"));
				groundInfo.setGl_weekdaytime(rs.getString("gl_weekdaytime"));
				groundInfo.setGl_weekendtime(rs.getString("gl_weekendtime"));
				groundInfo.setGl_wdcost(rs.getInt("gl_wdcost"));
				groundInfo.setGl_wkcost(rs.getInt("gl_wkcost"));
				groundInfo.setGl_matchtype(rs.getString("gl_matchtype"));
				groundInfo.setGl_parking(rs.getString("gl_parking"));
				groundInfo.setGl_coldhot(rs.getString("gl_coldhot"));
				groundInfo.setGl_rentball(rs.getString("gl_rentball"));
				groundInfo.setGl_rentvest(rs.getString("gl_rentvest"));
				groundInfo.setGl_pshoes(rs.getString("gl_pshoes"));
				groundInfo.setGl_shower(rs.getString("gl_shower"));
				groundInfo.setGl_img1(rs.getString("gl_img1"));
				groundInfo.setGl_saveimg1(rs.getString("gl_saveimg1"));
				groundInfo.setGl_img2(rs.getString("gl_img2"));
				groundInfo.setGl_saveimg2(rs.getString("gl_saveimg2"));
				groundInfo.setGl_img3(rs.getString("gl_img3"));
				groundInfo.setGl_saveimg3(rs.getString("gl_saveimg3"));
				groundInfo.setGl_img4(rs.getString("gl_img4"));
				groundInfo.setGl_saveimg4(rs.getString("gl_saveimg4"));
				groundInfo.setGl_img5(rs.getString("gl_img5"));
				groundInfo.setGl_saveimg5(rs.getString("gl_saveimg5"));
				groundInfo.setGl_img6(rs.getString("gl_img6"));
				groundInfo.setGl_saveimg6(rs.getString("gl_saveimg6"));
				groundInfo.setGl_size1(rs.getInt("gl_size1"));
				groundInfo.setGl_size2(rs.getInt("gl_size2"));
				groundInfo.setGl_floor(rs.getString("gl_floor"));
				groundInfo.setGl_water(rs.getString("gl_water"));
				groundInfo.setGl_rule(rs.getString("gl_rule"));
				groundInfo.setGl_code(rs.getString("gl_code"));
				ArrayList<GroundRevInfo> grdRevList = new ArrayList<GroundRevInfo>();
				grdRevList = getGrdRev(rs.getString("gl_code"), date);
				if (grdRevList.size() > 0) {
					for(int i = 0; i < grdRevList.size(); i++) {
						GroundRevInfo grdRev = grdRevList.get(i);
						revTime += grdRev.getGr_time();
					}
				}				
				groundInfo.setRevTime(revTime);
				
				groundList.add(groundInfo);		
			}
			
		} catch(Exception e) {
			System.out.println("getGroundList() 메소드오류");
			e.printStackTrace();			
		} finally {
			close(rs);
			close(stmt);
		}
		
		return groundList;			
	}

	
	public ArrayList<GroundRevInfo> getGrdRev(String glcode, String date) {
		ArrayList<GroundRevInfo> grdRevList = new ArrayList<GroundRevInfo>();
		Statement stmt = null;
		ResultSet rs = null;
		GroundRevInfo grdRev = null;
		try {
			String sql = "select * from t_ground_rev where gr_cancle = 'n' and gl_code = '" + glcode + "' and gr_date = '" + date + "' ";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				grdRev = new GroundRevInfo();
				grdRev.setGr_num(rs.getInt("gr_num"));
				grdRev.setGr_cost(rs.getInt("gr_cost"));
				grdRev.setGr_code(rs.getString("gr_code"));
				grdRev.setGr_date(rs.getString("gr_date"));
				grdRev.setGr_time(rs.getString("gr_time"));
				grdRev.setGl_code(rs.getString("gl_code"));
				grdRev.setMl_id(rs.getString("ml_id"));		

				grdRevList.add(grdRev);		
			}
		} catch (Exception e) {
			System.out.println("getGrdRev() �޼ҵ� ����");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}		 
		return grdRevList;		
	}	
	
	public ArrayList<GroundRevInfo> getGrdRev(String mlid) {
		ArrayList<GroundRevInfo> grdRevList = new ArrayList<GroundRevInfo>();
		Statement stmt = null;
		ResultSet rs = null;
		GroundRevInfo grdRev = null;
		try {
			String sql = "select * from t_ground_rev where ml_id = '" + mlid + "' ";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				grdRev = new GroundRevInfo();
				grdRev.setGr_num(rs.getInt("gr_num"));
				grdRev.setGr_cost(rs.getInt("gr_cost"));
				grdRev.setGr_code(rs.getString("gr_code"));
				grdRev.setGr_date(rs.getString("gr_date"));
				grdRev.setGr_time(rs.getString("gr_time"));
				grdRev.setGl_code(rs.getString("gl_code"));
				grdRev.setMl_id(rs.getString("ml_id"));		
				grdRev.setGr_name(rs.getString("gr_name"));
				grdRev.setGr_revdate(rs.getString("gr_revdate"));
				grdRev.setGr_cancle(rs.getString("gr_cancle"));
				grdRev.setRevtime(useTime(rs.getString("gr_time")));

				grdRevList.add(grdRev);		
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}		
		
		return grdRevList;		
	}
	
	public int delReserveGrd(HttpServletRequest request) {
		int result = 0;
		Statement stmt = null;
		
		try {
			request.setCharacterEncoding("utf-8");
			String mlid = request.getParameter("mlid");
			String grcode = request.getParameter("grcode");
			String cost = request.getParameter("cost");			
			String sql = "update t_ground_rev set gr_cancle = 'y' where gr_code = '" + grcode + "' ";
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			
			if (result == 1) {
				sql = "update t_member_list set ml_revcnt = ml_revcnt - 1, ml_pay = ml_pay - '" + cost + "' where ml_id = '" + mlid + "' ";
				result = stmt.executeUpdate(sql);
			}
		} catch (Exception e) {
			System.out.println("delReserveGrd() 메소드오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}		
		return result;		
	}
	
	public ArrayList<GroundRevInfo> getGrdRev(String where, int cpage, int limit, String ltype) {
		ArrayList<GroundRevInfo> grdRevList = new ArrayList<GroundRevInfo>();
		Statement stmt = null;
		ResultSet rs = null;
		GroundRevInfo grdRev = null;
		try {
			int start = (cpage - 1) * limit;
			
			String sql = "select * from t_ground_rev where 1=1 " + where;
			if (ltype.equals("c")) {
				sql += " and gr_cancle = 'y' ";
			} else if (ltype.equals("a")) { 
				sql += " and gr_cancle = 'n' ";
			}
			sql += " order by gr_num desc limit " + start + ", " + limit;
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				grdRev = new GroundRevInfo();
				grdRev.setGr_num(rs.getInt("gr_num"));
				grdRev.setGr_cost(rs.getInt("gr_cost"));
				grdRev.setGr_code(rs.getString("gr_code"));
				grdRev.setGr_date(rs.getString("gr_date"));
				grdRev.setGr_time(rs.getString("gr_time"));
				grdRev.setGl_code(rs.getString("gl_code"));
				grdRev.setMl_id(rs.getString("ml_id"));		
				grdRev.setGr_name(rs.getString("gr_name"));
				grdRev.setGr_revdate(rs.getString("gr_revdate"));
				grdRev.setGr_cancle(rs.getString("gr_cancle"));
				grdRev.setRevtime(useTime(rs.getString("gr_time")));
				grdRev.setMl_phone(rs.getString("ml_phone"));
				grdRev.setGr_pay(rs.getString("gr_pay"));

				grdRevList.add(grdRev);		
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}		
		
		return grdRevList;		
	}
	
	public int getListCount(String where) {
		int rcount = 0;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select count(*) from t_ground_rev where 1=1 " + where;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
			rcount = rs.getInt(1);
		} catch(Exception e) {
			System.out.println("getListCount() 메소드오류");
			e.printStackTrace();			
		} finally {
			close(rs);
			close(stmt);
		}			
		return rcount;
	}	
	
	
	
	private String useTime(String t) {
		String time = "";
		if (t.equals("a"))		time += " 08:00 ~ 10:00 ";
		else if (t.equals("b"))	time += " 10:00 ~ 12:00 ";
		else if (t.equals("c"))	time += " 12:00 ~ 14:00 ";
		else if (t.equals("d"))	time += " 14:00 ~ 16:00 ";
		else if (t.equals("e"))	time += " 16:00 ~ 18:00 ";
		else if (t.equals("f"))	time += " 18:00 ~ 20:00 ";
		else if (t.equals("g"))	time += " 20:00 ~ 22:00 ";
		
		return time;
	}
}

