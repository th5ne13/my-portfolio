package action;

import javax.servlet.http.*;
import vo.ActionForward;

//�������̽����� �����ϴ� ��� ������ �ڵ����� public static final
public interface Action {		
	ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception;
}

