package org.js.movie.review.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.js.movie.movieinfo.domain.Criteria;
import org.js.movie.review.domain.ReviewVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("ReviewDAO")
public class ReviewDAOImpl implements ReviewDAO {

	//마이바티스 sql
	@Autowired
	private SqlSession sql;
	
	//리뷰 조회
	@Override
	public List<ReviewVO> readReview(int movieId) {
		return sql.selectList("ReviewMapper.readReview", movieId);
	}

	@Override
	public void insertReview(ReviewVO vo) {
		
		sql.insert("ReviewMapper.insertReview", vo);
	}

	@Override
	public List<Map<String, Object>> pagingList(Criteria criteria) {

		return sql.selectList("ReviewMapper.pagingReview", criteria);
	}

	@Override
	public int countTotalList(int movieId) {

		return sql.selectOne("ReviewMapper.countTotalList", movieId);
	}

}
