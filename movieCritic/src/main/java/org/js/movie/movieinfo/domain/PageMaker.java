package org.js.movie.movieinfo.domain;

public class PageMaker {
	
	private Criteria criteria;	//페이지 기본값 생성자용
	private int totalCount;	//총 게시글 수
	private int startPage;	//시작 페이지
	private int endPage;	//끝 페이지
	private boolean prev;	//이전
	private boolean next;	//다음
	private int displayPageNumber = 10; //화면에 보여질 페이지번호 개수
	
	
	public Criteria getCriteria() {
		return criteria;
	}
	
	public void setCriteria(Criteria criteria) {
		this.criteria = criteria;
	}
	
	public int getTotalCount() {
		return totalCount;
	}
	
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		calcPage();
	}
	
	private void calcPage() {
		
		endPage = (int) (Math.ceil(criteria.getNowPage() / (double) displayPageNumber) * displayPageNumber);
		// 끝페이지번호 = (현재페이지/보여줄 페이지번호개수)의 반올림 * 보여줄 페이지 번호 개수
		
		startPage = (endPage - displayPageNumber) + 1;	//	시작페이지 번호
		if(startPage <= 0) {
			startPage = 1;
		}
		
		int tempEndPage = (int) (Math.ceil(totalCount / (double) criteria.getPerPageNumber()));	// 가상 끝 페이지 
		if(endPage > tempEndPage) {
			endPage = tempEndPage;
		}
		prev = startPage == 1 ? false : true;
		next = endPage * criteria.getPerPageNumber() <totalCount ? true : false;
	}

	public int getStartPage() {
		return startPage;
	}
	
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	
	public int getEndPage() {
		return endPage;
	}
	
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	
	public boolean isPrev() {
		return prev;
	}
	
	public void setPrev(boolean prev) {
		this.prev = prev;
	}
	
	public boolean isNext() {
		return next;
	}
	
	public void setNext(boolean next) {
		this.next = next;
	}
	
	public int getDisplayPageNumber() {
		return displayPageNumber;
	}
	public void setDisplayPageNumber(int displayPageNumber) {
		this.displayPageNumber = displayPageNumber;
	}

}
