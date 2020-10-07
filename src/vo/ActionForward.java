package vo;

// 작업 후 이동할 위치와 방식에 대해 처리하는 클래스
public class ActionForward {
	private String path;
	private boolean redirect;									// 선언하고 아무 값도 넣지 않으면 boolean의 기본값은 false

	public ActionForward() {}									// 매개변수가 없는 default 생성자
	
	public ActionForward(String path, boolean redirect) {		// 생성자
		this.path = path;
		this.redirect = redirect;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public boolean isRedirect() {
		return redirect;
	}

	public void setRedirect(boolean redirect) {
		this.redirect = redirect;
	}	
	
}
