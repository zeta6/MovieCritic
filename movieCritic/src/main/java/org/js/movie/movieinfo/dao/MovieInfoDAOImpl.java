package org.js.movie.movieinfo.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.js.movie.movieinfo.domain.Criteria;
import org.js.movie.movieinfo.domain.MovieInfoVO;
import org.springframework.stereotype.Repository;

@Repository("MovieInfoDao")
public class MovieInfoDAOImpl implements MovieInfoDAO {
	
	@Inject
	private SqlSession sql;
	
	//movie list
	@Override
	public List<Map<String, Object>> list(Criteria criteria) {

		return sql.selectList("MovieInfoMapper.list", criteria);
	}
	
	@Override
	public List<MovieInfoVO> listAll(){
		
		return sql.selectList("MovieInfoMapper.listAll");
	}
	
	//movie info
	@Override
	public MovieInfoVO view(int movieId) {
		
		return sql.selectOne("MovieInfoMapper.view", movieId);
	}

	//movie write
	@Override
	public void write(MovieInfoVO vo) {
		
		sql.insert("MovieInfoMapper.write", vo);
	}

	@Override
	public int countTotalList() {

		return sql.selectOne("MovieInfoMapper.countTotalList");
	}
	
	
	@Override
	public List<MovieInfoVO> getConditionalList(HashMap<String, String> conditions){
		
		return sql.selectList("MovieInfoMapper.get_conditional_list", conditions);
	}

	@Override
	public List<MovieInfoVO> searchByTitle(String searchKeyword){
		return sql.selectList("MovieInfoMapper.search_by_title", searchKeyword);
	}
}

