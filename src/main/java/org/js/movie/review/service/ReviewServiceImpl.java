package org.js.movie.review.service;

import java.util.List;
import java.util.Map;

import org.js.movie.movieinfo.domain.Criteria;
import org.js.movie.review.dao.ReviewDAO;
import org.js.movie.review.domain.ReviewVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("ReviewService")
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	private ReviewDAO dao;
	
	
	//리뷰 조회
	@Override
	public List<ReviewVO> readReview(int movieId) {

		return dao.readReview(movieId);
	}


	@Override
	public void insertReview(ReviewVO vo) {
		
		dao.insertReview(vo);
		
	}


	@Override
	public List<Map<String, Object>> pagingList(Criteria criteria) {

		return dao.pagingList(criteria);
	}


	@Override
	public int countTotalList(int movieId) {

		return dao.countTotalList(movieId);
	}


	@Override
	public void deleteReview(int reviewId) {
		
		dao.deleteReview(reviewId);
	}


	@Override
	public void deleteReviewAll(int movieId) {
		
		dao.deleteReviewAll(movieId);
	}
	
	@Override	
	public void updateReview(ReviewVO reviewVO) {
		dao.updateReview(reviewVO);
	}

	
	
}
	