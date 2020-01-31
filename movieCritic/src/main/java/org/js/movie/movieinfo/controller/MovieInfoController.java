package org.js.movie.movieinfo.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.List;

import javax.annotation.Resource;

import org.js.movie.movieinfo.domain.MovieInfoVO;
import org.js.movie.movieinfo.service.MovieInfoService;
import org.js.movie.movieinfo.utils.UploadFileUtils;
import org.js.movie.review.domain.ReviewVO;
import org.js.movie.review.service.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MovieInfoController {

	
	@Autowired
	MovieInfoService movieInfoService;
	
	@Autowired
	ReviewService reviewService;
	
	@Resource(name="uploadPath")
	private String uploadPath;
	
	@RequestMapping (value = "/movie_list", method = RequestMethod.GET)
	public String getMovieList() {
		
		return "movie_list";
	}
	
	@RequestMapping (value = "/movie_info", method = RequestMethod.GET)
	public void getMovieInfo(@RequestParam("movieId") int movieId, Model model) throws Exception {
		
	
		MovieInfoVO vo = movieInfoService.view(movieId);
		
		log.info("####movie_info get####");
		model.addAttribute("view", vo);
		
		List<ReviewVO> reviewList = reviewService.readReview(movieId);
		model.addAttribute("reviewList", reviewList);
	}
	
	@RequestMapping (value ="/write_board", method = RequestMethod.GET)
	public String getMovieWrite() {
		
		log.info("######write_board get######");
		
		return "write_board";
	}
	
	@RequestMapping(value = "/write_board", method = RequestMethod.POST)
	public String postWrite(MovieInfoVO vo, MultipartHttpServletRequest mtpRequest) 
													throws IOException, Exception {
		List<MultipartFile> fileList = mtpRequest.getFiles("file");
		
		int count = 0;
		
			
		log.info("########### write_board post 진입");
		
		String imgUploadPath = uploadPath + File.separator + "movieImage";
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		log.info("ymdPath : " + ymdPath);
		String fileName = null;

		for (MultipartFile mf : fileList) {
			
		if(mf != null) {
		 fileName =  UploadFileUtils.fileUpload(imgUploadPath, mf.getOriginalFilename(), mf.getBytes(), ymdPath); 
		} else {
		 fileName = uploadPath + File.separator + "images" + File.separator + "none.png";
		}

		if(count==0) {
			vo.setPoster(File.separator + "movieImage" + ymdPath + File.separator + fileName);
			vo.setThumbNail(File.separator + "movieImage" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);
		}
		else if(count==1) {
			vo.setStillCut1(File.separator + "movieImage" + ymdPath + File.separator + fileName);
		}
		else if(count==2) {
			vo.setStillCut2(File.separator + "movieImage" + ymdPath + File.separator + fileName);			
		}
		else if(count==3) {
			log.info("stillCut3");
			vo.setStillCut3(File.separator + "movieImage" + ymdPath + File.separator + fileName);
			log.info(vo.getStillCut3());
		}
		count++;
		
		log.info("vo: " +vo);
		}// for문 끝
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		log.info(principal.toString());
		vo.setWriter(principal.toString());
		movieInfoService.write(vo);
	
		return "movie_list";
	
	}
}
