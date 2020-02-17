package org.js.movie.movieinfo.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.js.movie.movieinfo.domain.Criteria;
import org.js.movie.movieinfo.domain.MovieInfoVO;

public interface MovieInfoDAO {
	
	//update
	public void updateMovieInfo(MovieInfoVO vo);
	
	
	// index movie list
	
	public List<MovieInfoVO> indexList();
	
	public List<MovieInfoVO> indexList2();	
	
//	movie list (paging)
	public List<MovieInfoVO> list(HashMap<String, String> conditions);
	
	public List<MovieInfoVO> listAll();
	
//	movie info
	public MovieInfoVO view(int movieId);
	
//	movie write
	public void write(MovieInfoVO vo);
	
	public int countTotalList(HashMap<String, String> conditions);
	
	public List<MovieInfoVO> getConditionalList(HashMap<String, String> conditions);

	public List<MovieInfoVO> searchByTitle(String searchKeyword);
	
	public void deleteMovie(int movieId);
	
}
