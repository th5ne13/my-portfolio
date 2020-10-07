package vo;

public class PageInfo {
	private int cpage, mpage, spage, epage, rcount;
	// 현제 페이지번호, 마지막 페이지번호, 시작 및 종료 페이지번호, 전체 목록 수(글 개수)
	private String schType, keyword;
	// 검색조건, 검색어

	public int getCpage() {
		return cpage;
	}

	public void setCpage(int cpage) {
		this.cpage = cpage;
	}

	public int getMpage() {
		return mpage;
	}

	public void setMpage(int mpage) {
		this.mpage = mpage;
	}

	public int getSpage() {
		return spage;
	}

	public void setSpage(int spage) {
		this.spage = spage;
	}

	public int getEpage() {
		return epage;
	}

	public void setEpage(int epage) {
		this.epage = epage;
	}

	public int getRcount() {
		return rcount;
	}

	public void setRcount(int rcount) {
		this.rcount = rcount;
	}

	public String getSchType() {
		return schType;
	}

	public void setSchType(String schType) {
		this.schType = schType;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	
}
