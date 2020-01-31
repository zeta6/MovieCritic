package org.js.movie;

import javax.servlet.http.HttpServletRequest;

import org.js.movie.movieinfo.service.MovieInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
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
		

		return "index";
	}
}
//
