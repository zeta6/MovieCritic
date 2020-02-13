package org.js.movie.movieinfo.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.js.movie.member.domain.CustomMemberVO;
import org.js.movie.movieinfo.domain.Criteria;
import org.js.movie.movieinfo.domain.MovieInfoVO;
import org.js.movie.movieinfo.domain.PageMaker;
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
import org.springframework.web.bind.annotation.ResponseBody;
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
	
	@RequestMapping(value="/movie_info/view?movieId=${view.movieId}/deletion", method=RequestMethod.GET)
	public String getMovieInfoDeletion(@RequestParam("movieId") int movieId) {
		
		reviewService.
		
		
		return "movie_list";
	}
	
	@RequestMapping(value="/editMovieInfo", method=RequestMethod.POST)
	public String postEditMovieInfo(MovieInfoVO vo, MultipartHttpServletRequest mtpRequest) throws IOException, Exception {
		
		List<MultipartFile> fileList = mtpRequest.getFiles("file");
		
		int count = 0;
		
		log.info("########### edit MovieInfo post 진입");
		
		String imgUploadPath = uploadPath + File.separator + "movieImage";
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		log.info("ymdPath : " + ymdPath);
		String fileName = null;

		for (MultipartFile mf : fileList) {
			
		if(mf.isEmpty()) {
			log.info("empty file");
			count++;
			continue;
		}
		fileName =  UploadFileUtils.fileUpload(imgUploadPath, mf.getOriginalFilename(), mf.getBytes(), ymdPath);
		
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
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();	//provider가 리턴하는 값에 따라 달라짐.
		log.info(principal.toString());
		CustomMemberVO putWriter = (CustomMemberVO) principal;
		vo.setWriter(putWriter.getMemberId());
		log.info("update 전 확인 : " + vo.toString());
		

		movieInfoService.updateMovieInfo(vo);
		
		
		String strMovieId = "redirect:movie_info/view?movieId="+String.valueOf(vo.getMovieId());
		
		log.info("strMovieId="+strMovieId);
		
		return strMovieId;
	
		
	}
	
	
	
	@RequestMapping (value = "/movie_list.search", method = RequestMethod.GET)
	@ResponseBody
	public List<MovieInfoVO> searchByTitle(@RequestParam(value = "searchKeyword", defaultValue="") String searchKeyword,
						Model model){
		
		searchKeyword = searchKeyword +"%";
		log.info("searchKeyword="+searchKeyword);

		List<MovieInfoVO> list = movieInfoService.searchByTitle(searchKeyword);
		
		return list;
	
	}
	
	@RequestMapping (value = "/movie_list.getConditionalList", method = RequestMethod.GET)
	@ResponseBody
	public List<MovieInfoVO> getConditionalList(@RequestParam(value = "genre", defaultValue="") String genre,
						@RequestParam(value = "releaseDate", defaultValue="") String releaseDate,
						@RequestParam(value = "sortCondition", defaultValue="") String sortCondition,
						Model model) {

		
		log.info("genre="+genre);
		log.info("releaseDate="+releaseDate);
		log.info("sortCondition="+sortCondition);
		
		HashMap<String, String> conditions = new HashMap<String, String>();
		conditions.put("genre", genre);
		conditions.put("releaseDate", releaseDate);
		conditions.put("sortCondition", sortCondition);
		
		log.info("conditions="+conditions);
		
		List<MovieInfoVO> list = new ArrayList<MovieInfoVO>();
		list =  movieInfoService.getConditionalList(conditions);
	
		return list;
		
		
	}
	
	// 커맨드 객체, requestparam..
	//@RequestParam(value="nowPage", defaultValue="1") int nowPage,  HashMap 
	@RequestMapping (value = "/movie_list", method = RequestMethod.GET)
	public String getMovieList(Model model, Criteria criteria) throws Exception {
		
		log.info("#####################movie_list get");
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCriteria(criteria);//시작페이지 , 페이지당 게시글수 초기화
		log.info("##########");
		pageMaker.setTotalCount(movieInfoService.countTotalList()); //총 게시글 수 초기화

		log.info("totalCount : " + pageMaker.getTotalCount());
		List<Map<String, Object>> infoList = movieInfoService.list(criteria); //리스트 불러오기
		

		int maxBoardNumber = infoList.size();
		log.info("Max boardNumber :" + maxBoardNumber);
		
		log.info("################## list 확인: " + infoList);

		model.addAttribute("list", infoList);

		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("criteria", criteria);
		
		return "movie_list";
	}
	
	@RequestMapping (value = "/movie_info/view", method = RequestMethod.GET)
	public String getMovieInfo(@RequestParam("movieId") int movieId, Model model) throws Exception {
		log.info("####movie_info get####");
		
		MovieInfoVO vo = movieInfoService.view(movieId);
		log.info("vo : "+ vo.toString());
		

		model.addAttribute("view", vo);
		
		List<ReviewVO> reviewList = reviewService.readReview(movieId);
		log.info("reviewList: " + reviewList);
		
		if(!reviewList.equals(null)) {
		int totalCount = reviewList.size();
		log.info("totalCount  : " + totalCount);
		int positiveCount=0;
		int mixedCount=0;
		int negativeCount=0;
		int totalScore=0;
		
		for(ReviewVO revList : reviewList) {
			totalScore += revList.getRating();
			
			if(revList.getRating() < 4) {
				negativeCount++;
			}
			else if(4<=revList.getRating() && revList.getRating()<=6) {
				mixedCount++;
			}
			else if(7<=revList.getRating() && revList.getRating()<=10) {
				positiveCount++;
			}
		}
		int maxCount = Math.max(negativeCount, Math.max(positiveCount, mixedCount));
		double scoreAverage = Math.round((totalScore*10.0/totalCount))/10.0;

		log.info("totalScore : " + totalScore);
		log.info("negative: " + negativeCount);
		log.info("positive : " + positiveCount);
		log.info("mixed : " + mixedCount);
		log.info("scoreAverage: " + scoreAverage);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("negativeCount", negativeCount);
		model.addAttribute("mixedCount", mixedCount);
		model.addAttribute("positiveCount", positiveCount);
		model.addAttribute("maxCount", maxCount);
		model.addAttribute("scoreAverage", scoreAverage);
		model.addAttribute("reviewList", reviewList);

		} else {
			log.info("reviewList : " + reviewList.toString()); 
		}
			
		return "movie_info";	//page 404로 void에서 string으로 교체
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
		log.info("releaseDate : " + vo.getReleaseDate());
		String imgUploadPath = uploadPath + File.separator + "movieImage";
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		log.info("ymdPath : " + ymdPath);
		String fileName = null;

		for (MultipartFile mf : fileList) {
			
		if(mf.isEmpty()) {
			log.info("empty");
			count++;
			continue;
		}
		
		fileName =  UploadFileUtils.fileUpload(imgUploadPath, mf.getOriginalFilename(), mf.getBytes(), ymdPath); 
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
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();	//provider가 리턴하는 값에 따라 달라짐.
		log.info(principal.toString());
		CustomMemberVO putWriter = (CustomMemberVO) principal;
		vo.setWriter(putWriter.getMemberId());
		movieInfoService.write(vo);
	
		return "redirect:../";
	
	}
	//@RequestParam 주소(경로)에서 해당하는 이름의 값을 찾아서 엮어줌.

}
