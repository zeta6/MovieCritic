package org.js.movie.review.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.js.movie.movieinfo.domain.Criteria;
import org.js.movie.review.domain.ReviewVO;

public interface ReviewDAO {
	
	//리뷰 조회
	public List<ReviewVO> readReview(int movieId);
	
	//리뷰 작성
	public void insertReview(ReviewVO vo);
	
	//리뷰 페이징
	public List<Map<String, Object>> pagingList(Criteria criteria);
	
	//총 개수
	public int countTotalList(int movieId);
	
	//리뷰 삭제
	public void deleteReview(int reviewId);
	
	//게시글 리뷰 삭제
	public void deleteReviewAll(int movieId);
	
	public void updateReview(ReviewVO reviewVO);
	
	public int checkDupe(HashMap<String, String> dupeCheck);
}
