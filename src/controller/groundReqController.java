package controller;

import java.io.IOException;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.multipart.*;
import com.oreilly.servlet.*;

import action.*;
import vo.*;

@WebServlet("*.groundReq")
public class groundReqController extends HttpServlet {
	private static final long serialVersionUID = 1L;       
  
    public groundReqController() {
        super();       
    }

    protected void doProc(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
		request.setCharacterEncoding("utf-8");
		String RequestURI = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = RequestURI.substring(contextPath.length());
		
		Action action = null;
		ActionForward forward = null;
		
		if (command.equals("/load.groundReq")) {
			action = new GroundViewAction();
			try {
				forward = action.execute(request, response);
				forward.setPath("index.jsp");
			} catch (Exception e) {
				e.printStackTrace();
			}			
		} else if (command.equals("/more.groundReq")) {
			action = new GroundViewAction();
			try {
				forward = action.execute(request, response);
				forward.setPath("/groundRequest/groundList.jsp");
			} catch (Exception e) {
				e.printStackTrace();
			}			
		} else if (command.equals("/list.groundReq")) {
			action = new GroundViewAction();
			try {
				String schDate = request.getParameter("schDate");
				forward = action.execute(request, response);
				forward.setPath("/groundRequest/groundList.jsp?schDate=" + schDate);
			} catch (Exception e) {
				e.printStackTrace();
			}						
		} if (command.equals("/view.groundReq")) {
			action = new GroundViewAction();
			try {
				forward = action.execute(request, response);
				forward.setPath("/groundRequest/groundView.jsp");
			} catch(Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/in.groundReq")) {
			forward = new ActionForward();
			forward.setPath("/groundRequest/groundReqForm.jsp?wtype=in");
		} else if (command.equals("/adminGrdList.groundReq")) { // 어드민 구장리스트이면 
    		action = new AGroundListAction();
    		try {
    			forward = action.execute(request, response); // 이동하기 위한
    		} catch(Exception e) {
    			e.printStackTrace();
    		}
		} else if (command.equals("/adminIn.groundReq")) {
			forward = new ActionForward();
			forward.setPath("/admin/groundRequest/adminGroundReqForm.jsp?wtype=in");
			
		} else if (command.equals("/up.groundReq")) {
			action = new GroundViewAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/proc.groundReq")) {
			action = new GroundProcAction();
			try {
				String uploadPath = "C:\\kds\\jsp\\workspace\\greenground\\WebContent\\groundImg";
				MultipartRequest multi = new MultipartRequest(request, uploadPath, 10 * 1024 * 1024, "UTF-8", new DefaultFileRenamePolicy());
				String wtype = multi.getParameter("wtype");
				String mlid = multi.getParameter("mlid");
				String gu = multi.getParameter("gu");
				String[] weekdayTime = multi.getParameterValues("weekdayTime"); 
				String[] weekdaySlt = multi.getParameterValues("weekdaySlt");				
				String[] weekendTime = multi.getParameterValues("weekendTime");
				String[] weekendSlt = multi.getParameterValues("weekendSlt");
				String[] matchType = multi.getParameterValues("matchType");	
				String[] water = multi.getParameterValues("water");	
				String weekdaySltChk = "";
				if (weekdaySlt != null) {
					for (int i = 0 ; i < weekdaySlt.length ; i++) {
						if ( i == (weekdaySlt.length - 1))	weekdaySltChk += weekdaySlt[i];
						else	weekdaySltChk += weekdaySlt[i] + ",";
					}
				}				
				String weekdayTimeChk = "";
				if (weekdayTime != null) {
					for (int i = 0 ; i < weekdayTime.length ; i++) {
						if ( i == (weekdayTime.length - 1))	weekdayTimeChk += weekdayTime[i];
						else	weekdayTimeChk += weekdayTime[i] + ",";
					}		
				}								
				String weekendSltChk = "";
				if (weekendSlt != null) {
					for (int i = 0 ; i < weekendSlt.length ; i++) {
						if ( i == (weekendSlt.length - 1))	weekendSltChk += weekendSlt[i];
						else	weekendSltChk += weekendSlt[i] + ",";
					}
				}								
				String weekendTimeChk = "";
				if (weekendTime != null) {
					for (int i = 0 ; i < weekendTime.length ; i++) {
						if ( i == (weekendTime.length - 1))	weekendTimeChk += weekendTime[i];
						else	weekendTimeChk += weekendTime[i] + ",";
					}
				}								
				String matchTypeChk = "";
				if (matchType != null) {
					for (int i = 0 ; i < matchType.length ; i++) {
						if ( i == (matchType.length - 1))	matchTypeChk += matchType[i];
						else	matchTypeChk += matchType[i] + ",";
					}
				}							
				String waterChk = "";
				if (water != null) {
					for (int i = 0 ; i < water.length ; i++) {
						if ( i == (water.length - 1))	waterChk += water[i];
						else	waterChk += water[i] + ",";
					}
				}		
				request.setAttribute("wtype", wtype);
				request.setAttribute("mlid", mlid);
				request.setAttribute("gu", gu);
				request.setAttribute("weekdaySltChk", weekdaySltChk);
				request.setAttribute("weekdayTimeChk", weekdayTimeChk);
				request.setAttribute("weekendSltChk", weekendSltChk);
				request.setAttribute("weekendTimeChk", weekendTimeChk);
				request.setAttribute("matchTypeChk", matchTypeChk);
				request.setAttribute("waterChk", waterChk);
				
				Enumeration params = multi.getParameterNames();
				while (params.hasMoreElements()) {					
					String name = (String)params.nextElement();
					String value = multi.getParameter(name);
					request.setAttribute(name, value);	
				}				
				
				Enumeration files = multi.getFileNames();
				while (files.hasMoreElements()) {
					String file = (String)files.nextElement();
				    String fileName = multi.getFilesystemName(file);		//이름을 이용해 저장된 파일이름을 가져옴
				    String imgName = multi.getOriginalFileName(file);		//이름을 이용해 본래 파일이름을 가져옴
				    request.setAttribute("save" + file, fileName);
					request.setAttribute(file, imgName);
				}
				
				forward = action.execute(request, response);
			} catch(Exception e) { e.printStackTrace(); }
			
		} else if (command.equals("/time.groundReq")) {
			action = new GroundTimeAction();
			try {
				forward = action.execute(request, response);
			} catch(Exception e) { e.printStackTrace(); }	
		} else if (command.equals("/rev.groundReq")) {
			action = new GroundRevAction();
			try {
				forward = action.execute(request, response);
			} catch(Exception e) { e.printStackTrace(); }	
		}		

		if (forward != null) {
			try {
				if (forward.isRedirect()) {
					response.sendRedirect(forward.getPath());
					// history에 쌓여 '뒤로 가기'가 가능한 이동
					// request와 response 객체를 공유하지 않음
				} else {
					RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
					dispatcher.forward(request, response);
					// history에 쌓이지 않아 '뒤로 가기'가 불가능한 이동(url 불변)
					// request와 response 객체를 공유하여 사용할 수 있음
				}
			} catch(Exception e) {
				e.printStackTrace();
			} 
		}						
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		doProc(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		doProc(request, response);
	}

}
