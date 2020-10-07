package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import svc.GroundRevService;
import vo.*;

public class SaleStatAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String allGu = request.getParameter("allGu");
		String[] schGu = request.getParameterValues("schGu");
		String schGround = request.getParameter("schGround");
		String sdate = request.getParameter("sdate");
		String edate = request.getParameter("edate");
		String payMethod = request.getParameter("payMethod");
		String where = " where 1=1 ";
		String date = sdate + " ~ " + edate;

		if (allGu == null || allGu.equals("")) {
			if (schGu != null) {
				if (schGu.length > 0) {
					where += " and ( gr_addr like '%" + schGu[0] + "%' or ";
					for (int i = 1; i < schGu.length - 1; i++) {
						where += "  gr_addr like '%" + schGu[i] + "%' or ";
					}
					where += "  gr_addr like '%" + schGu[schGu.length - 1] + "%' ) ";
				}
			}
		}
		if (schGround != null && !schGround.equals(""))		where += " and gr_name like '%" + schGround + "%' ";
		if (sdate != null && !sdate.equals(""))				where += " and gr_date >= STR_TO_DATE('" + sdate + "', '%Y-%m-%d') ";
		if (edate != null && !edate.equals(""))				where += " and gr_date <= STR_TO_DATE('" + edate + "', '%Y-%m-%d') ";
		if (payMethod != null && !payMethod.equals(""))		where += " and gr_pay = '" + payMethod + "' ";
		
		where += " group by right(left(gr_addr, 6), 3) order by sum(gr_cost) desc limit 0, 5";

		ArrayList<GroundRevInfo> grdRevList = new ArrayList<GroundRevInfo>();
		GroundRevService groundRevService = new GroundRevService();
		grdRevList = groundRevService.grdRevStatList(where);

		request.setAttribute("grdRevList", grdRevList);
		request.setAttribute("date", date);

		ActionForward forward = new ActionForward();
		forward.setPath("/admin/stat/saleStat.jsp");
		return forward;
	}
}
