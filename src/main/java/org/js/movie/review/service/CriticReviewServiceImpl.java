package org.js.movie.review.service;

import java.util.List;
import java.util.Map;

import org.js.movie.movieinfo.domain.Criteria;
import org.js.movie.review.dao.CriticReviewDAO;
import org.js.movie.review.domain.CriticReviewVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("CriticReviewService")
public class CriticReviewServiceImpl implements CriticReviewService {

	@Autowired
	private CriticReviewDAO dao;
	
	
	//리뷰 조회
	@Override
	public List<CriticReviewVO> readCriticReview(int movieId) {

		return dao.readCriticReview(movieId);
	}


	@Override
	public void insertCriticReview(CriticReviewVO vo) {
		
		dao.insertCriticReview(vo);
		
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
	public void deleteCriticReview(int criticReviewId) {
		
		dao.deleteCriticReview(criticReviewId);
	}


	@Override
	public void deleteCriticReviewAll(int movieId) {
		
		dao.deleteCriticReviewAll(movieId);
	}
	
	@Override	
	public void updateCriticReview(CriticReviewVO criticReviewVO) {
		dao.updateCriticReview(criticReviewVO);
	}

	
	
}
