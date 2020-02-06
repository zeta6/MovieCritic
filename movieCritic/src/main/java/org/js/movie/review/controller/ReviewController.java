package org.js.movie.review.controller;

import org.js.movie.movieinfo.domain.MovieInfoVO;
import org.js.movie.movieinfo.service.MovieInfoService;
import org.js.movie.review.domain.ReviewVO;
import org.js.movie.review.service.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ReviewController {

	@Autowired
	ReviewService reviewService;
	
	@Autowired
	MovieInfoService movieInfoService;
	
	@RequestMapping(value = "/view_review", method=RequestMethod.GET)
	public String getViewReview(ReviewVO reviewVO, Model model) {
		log.info("리뷰 목록 및 작성 페이지 진입");
		
		MovieInfoVO vo = movieInfoService.view(reviewVO.getMovieId());
		log.info("vo : "+ vo.toString());
		model.addAttribute("view", vo);
		
		return "view_review";
	}
	//movieId 값을 받와야하해서 경로에 movieId를 포함시키는게 나을지.. 아니면 다른방법?
	@RequestMapping(value= "/view_review", method=RequestMethod.POST)
	public String postViewReview(Model model, ReviewVO reviewVO) {
		// movieId에 해당하는 값이 없음 로직 추가.. get방식으로 불러올 때 로 넣고 
		//post에서는 input hidden으로 보내는 걸로 함. reviewVO에 바인딩됨. 커맨드객체
		//content도 바인딩, writer는 직접 넣어주고, rating
		
		reviewVO.setWriter(SecurityContextHolder.getContext().getAuthentication().getName());
		log.info("writer :" + reviewVO.getWriter());
		log.info("reviewVO : " + reviewVO.toString());
		reviewService.insertReview(reviewVO);
		
		return "redirect:../view_review?movieId="+reviewVO.getMovieId();
	}
}
