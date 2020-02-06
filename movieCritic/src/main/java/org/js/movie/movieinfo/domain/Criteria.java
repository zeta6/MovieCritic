package org.js.movie.movieinfo.domain;

//특정 페이지 조회용
//커맨드객체
public class Criteria {

	private int nowPage;	//현재 페이지 번호
	private int perPageNumber;	//페이지당 게시글 수
	
	public Criteria() {
		this.nowPage = 1;
		this.perPageNumber = 7;
	}	//페이지당 게시글수, 현재 페이지 번호의 값이 필요한데 이를 기본 생성자에서 초기화해줌으로써 해결.
	
	public int getPageStart() {
		return(this.nowPage-1)*perPageNumber;
	}
	
	public int getNowPage() {
		return nowPage;
	}
	
	public void setNowPage(int nowPage) {
		if(nowPage <= 0) {
			this.nowPage = 1;
		} else {
			this.nowPage = nowPage;
		}
	}
	
	public int getPerPageNumber() {
		return perPageNumber;
	}
	
	public void setPerPageNumber(int perPageNumber) {
		this.perPageNumber = perPageNumber;
	}
	
	
}
