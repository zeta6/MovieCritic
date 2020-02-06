package org.js.movie.movieinfo.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.js.movie.movieinfo.dao.MovieInfoDAO;
import org.js.movie.movieinfo.domain.Criteria;
import org.js.movie.movieinfo.domain.MovieInfoVO;
import org.springframework.stereotype.Service;

@Service("MovieInfoService")
public class MovieInfoServiceImpl implements MovieInfoService {

	@Inject
	private MovieInfoDAO dao;
	
	@Override
	public List<MovieInfoVO> listAll(){
		
		return dao.listAll();
	}
	
	@Override
	public List<Map<String, Object>> list(Criteria criteria) {

		return dao.list(criteria);
	}
	
	@Override
	public MovieInfoVO view(int movieId) {
		
		return dao.view(movieId);
	}
	
	@Override
	public void write(MovieInfoVO vo) {
		dao.write(vo);
	}

	@Override
	public int countTotalList() {

		return dao.countTotalList();
	}

}
