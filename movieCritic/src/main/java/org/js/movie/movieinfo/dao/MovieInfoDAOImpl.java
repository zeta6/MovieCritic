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
	
	
	@Override
	public void updateMovieInfo(MovieInfoVO vo) {
		sql.update("MovieInfoMapper.updateMovie", vo);
	}
	
	@Override
	public List<MovieInfoVO> indexList() {
	
		return sql.selectList("MovieInfoMapper.index_list");
	}
	
	@Override
	public List<MovieInfoVO> indexList2(){

		return sql.selectList("MovieInfoMapper.index_list2");
	}
	
	//movie list
	@Override
	public List<MovieInfoVO> list(HashMap<String, String> conditions) {

		return sql.selectList("MovieInfoMapper.list", conditions);
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
	public int countTotalList(HashMap<String, String> conditions) {

		return sql.selectOne("MovieInfoMapper.countTotalList", conditions);
	}
	
	@Override
	public List<MovieInfoVO> getConditionalList(HashMap<String, String> conditions){
		
		return sql.selectList("MovieInfoMapper.get_conditional_list", conditions);
	}

	@Override
	public List<MovieInfoVO> searchByTitle(String searchKeyword){
		return sql.selectList("MovieInfoMapper.search_by_title", searchKeyword);
	}

	@Override
	public void deleteMovie(int movieId) {
		
		sql.delete("MovieInfoMapper.delete", movieId);
	}
}

