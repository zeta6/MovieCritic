package org.js.movie.review.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ReviewController {

	@RequestMapping(value = "/view_review", method=RequestMethod.GET)
	public String getViewReview() {
		
		log.info("리뷰 목록 및 작성 페이지 진입");
		return "view_review";
	}
	//movieId 값을 받와야하해서 경로에 movieId를 포함시키는게 나을지.. 아니면 다른방법?
	@RequestMapping(value= "/view_reivew", method=RequestMethod.POST)
	public void postViewReview() {
		
		
	}
}
