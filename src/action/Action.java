package action;

import javax.servlet.http.*;
import vo.ActionForward;

//인터페이스에서 선언하는 모든 변수는 자동으로 public static final
public interface Action {		
	ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception;
}

