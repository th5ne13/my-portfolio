package controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.Enumeration;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import action.*;
import vo.ActionForward;

@WebServlet("*.page")
public class PageController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public PageController() {
        super();
    }
	protected void doProc(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String RequestURI = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = RequestURI.substring(contextPath.length());
		
		Action action = null;
		ActionForward forward = null;
		
		if (command.equals("/bannerView.page")) {
			action = new BannerViewAction();
			try {
				forward = action.execute(request, response);
			} catch(Exception e) { e.printStackTrace(); }
			
		} else if (command.equals("/bannerProc.page")) {
			String uploadPath = "D:\\jjh\\jsp\\work\\greenGround\\WebContent\\admin\\img";
			MultipartRequest multi = new MultipartRequest(request, uploadPath, 10 * 1024 * 1024, "UTF-8", new DefaultFileRenamePolicy());
			
			String bannerTime = multi.getParameter("bannerTime");
			request.setAttribute("bannerTime", bannerTime);
						
			Enumeration files = multi.getFileNames();
			while (files.hasMoreElements()) {
				String file = (String)files.nextElement();
			    String fileName = multi.getFilesystemName(file);		//이름을 이용해 저장된 파일이름을 가져옴
			    if (fileName == null)		fileName = multi.getParameter("img" + file.substring(4));
			    if (fileName.equals(""))	fileName = "noimage";
			    String imgName = multi.getOriginalFileName(file);		//이름을 이용해 본래 파일이름을 가져옴
			    if (imgName == null)	imgName = multi.getParameter("img" + file.substring(4));
			    if (imgName.equals(""))	imgName = "noimage";
			    request.setAttribute("save" + file, fileName);
				request.setAttribute(file, imgName);
			}
			action = new BannerProcAction();
			try {
				forward = action.execute(request, response);
			} catch(Exception e) { e.printStackTrace(); }
			
		} else if (command.equals("/view.page")) {
			action = new PageInfoViewAction();
			try {
				forward = action.execute(request, response);
			} catch(Exception e) { e.printStackTrace(); }
		} else if (command.equals("/up.page")) {
			action = new PageInfoViewAction();
			try {
				forward = action.execute(request, response);
				forward.setPath("/admin/page/pageInfoUp.jsp");
			} catch(Exception e) { e.printStackTrace(); }
			
		} else if (command.equals("/proc.page")) {
			String uploadPath = "D:\\jjh\\jsp\\work\\greenGround\\WebContent\\admin\\img";
			MultipartRequest multi = new MultipartRequest(request, uploadPath, 10 * 1024 * 1024, "UTF-8", new DefaultFileRenamePolicy());
			
			String btype = multi.getParameter("btype");
			String title = multi.getParameter("title");
			String content = multi.getParameter("content");
			request.setAttribute("btype", btype);
			request.setAttribute("title", title);
			request.setAttribute("content", content);
			
		    String fileName = multi.getFilesystemName("img");		//이름을 이용해 저장된 파일이름을 가져옴
		    if (fileName == null)		fileName = multi.getParameter("orgImg");
		    if (fileName.equals(""))	fileName = "noimage";
		    String imgName = multi.getOriginalFileName("img");		//이름을 이용해 본래 파일이름을 가져옴
		    if (imgName == null)		imgName = multi.getParameter("orgSaveImg");
		    if (imgName.equals(""))	imgName = "noimage";
		    request.setAttribute("saveimg", fileName);
			request.setAttribute("img", imgName);
			action = new PageInfoProcAction();
			try {
				forward = action.execute(request, response);
			} catch(Exception e) { e.printStackTrace(); }
		}

		// 기능 실행 후 이동할 페이지에 대한 if문
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
				System.out.println("오류다오류");
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
