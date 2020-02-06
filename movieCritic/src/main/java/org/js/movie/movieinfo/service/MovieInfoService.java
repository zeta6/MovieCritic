package org.js.movie.movieinfo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.js.movie.movieinfo.domain.Criteria;
import org.js.movie.movieinfo.domain.MovieInfoVO;

public interface MovieInfoService {
	
	public List<Map<String, Object>> list(Criteria criteria);
	
	public List<MovieInfoVO> listAll();
	
	public MovieInfoVO view(int movieId);
	
	public void write(MovieInfoVO vo);
	
	public int countTotalList();
	
	public List<MovieInfoVO> getConditionalList(HashMap<String, String> conditions);
	
	public List<MovieInfoVO> searchByTitle(String searchKeyword);
	
}
