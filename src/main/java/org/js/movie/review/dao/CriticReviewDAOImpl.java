package org.js.movie.review.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.js.movie.movieinfo.domain.Criteria;
import org.js.movie.review.domain.CriticReviewVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("CriticReviewDAO")
public class CriticReviewDAOImpl implements CriticReviewDAO {

	//마이바티스 sql
	@Autowired
	private SqlSession sql;
	
	//리뷰 조회
	@Override
	public List<CriticReviewVO> readCriticReview(int movieId) {
		return sql.selectList("CriticReviewMapper.readReview", movieId);
	}

	@Override
	public void insertCriticReview(CriticReviewVO vo) {
		
		sql.insert("CriticReviewMapper.insertReview", vo);
	}

	@Override
	public List<Map<String, Object>> pagingList(Criteria criteria) {

		return sql.selectList("CriticReviewMapper.pagingReview", criteria);
	}

	@Override
	public int countTotalList(int movieId) {

		return sql.selectOne("CriticReviewMapper.countTotalList", movieId);
	}

	@Override
	public void deleteCriticReview(int criticReviewId) {
		
		sql.delete("CriticReviewMapper.deleteReview", criticReviewId);
	}

	@Override
	public void deleteCriticReviewAll(int movieId) {

		sql.delete("CriticReviewMapper.deleteReviewAll", movieId);
	}

	@Override
	public void updateCriticReview(CriticReviewVO criticReviewVO) {
		sql.update("CriticReviewMapper.updateReview", criticReviewVO);
	}
}
