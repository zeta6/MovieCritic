package org.js.movie.review.dao;

import java.util.List;
import java.util.Map;

import org.js.movie.movieinfo.domain.Criteria;
import org.js.movie.review.domain.CriticReviewVO;

public interface CriticReviewDAO {
	
	//리뷰 조회
	public List<CriticReviewVO> readCriticReview(int movieId);
	
	//리뷰 작성
	public void insertCriticReview(CriticReviewVO vo);
	
	//리뷰 페이징
	public List<Map<String, Object>> pagingList(Criteria criteria);
	
	//총 개수
	public int countTotalList(int movieId);
	
	//리뷰 삭제
	public void deleteCriticReview(int CriticReviewId);
	
	//게시글 리뷰 삭제
	public void deleteCriticReviewAll(int movieId);
	
	public void updateCriticReview(CriticReviewVO CriticReviewVO);
}

