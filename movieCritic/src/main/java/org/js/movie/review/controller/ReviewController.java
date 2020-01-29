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
}
