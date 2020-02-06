package org.js.movie.movieinfo.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.js.movie.movieinfo.domain.Criteria;
import org.js.movie.movieinfo.domain.MovieInfoVO;

public interface MovieInfoDAO {
	
//	movie list (paging)
	public List<Map<String, Object>> list(Criteria criteria);
	
	public List<MovieInfoVO> listAll();
	
//	movie info
	public MovieInfoVO view(int movieId);
	
//	movie write
	public void write(MovieInfoVO vo);
	
	public int countTotalList();
	
	public List<MovieInfoVO> getConditionalList(HashMap<String, String> conditions);

	public List<MovieInfoVO> searchByTitle(String searchKeyword);
	
	
}
