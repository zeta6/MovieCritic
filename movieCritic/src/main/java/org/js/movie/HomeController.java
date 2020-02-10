package org.js.movie;

import java.util.List;

import org.js.movie.movieinfo.domain.MovieInfoVO;
import org.js.movie.movieinfo.service.MovieInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class HomeController {
	
	@Autowired
	MovieInfoService service;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String getIndex(Model model) {
		
		log.info("#################### index 시작");
		
		List<MovieInfoVO> list = null;
		list = service.indexList();
		
		model.addAttribute("list", list);

		
		return "index";
	}
}
//
