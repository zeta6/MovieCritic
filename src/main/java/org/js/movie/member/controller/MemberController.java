package org.js.movie.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.js.movie.member.dao.CustomService;
import org.js.movie.member.domain.CustomMemberVO;
import org.js.movie.member.domain.MemberVO;
import org.js.movie.member.service.CustomProvider;
import org.js.movie.member.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/member")
public class MemberController {

	//private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	MemberService service;
	
	@Autowired
	CustomService customService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	
	@RequestMapping(value="/deactivate", method=RequestMethod.GET)
	public String getDeactivate() {
		
		log.info("############ deactivate");
		String memberId = SecurityContextHolder.getContext().getAuthentication().getName();
		log.info(memberId);
		
		service.deleteRole(memberId);
		service.delete(memberId);
		log.info("deactivate pass");
		
		MemberVO mvo = service.selectOne(memberId);
		
		
		return "redirect:../member/logout";
	}
	
	
	//myPage Post
	@RequestMapping(value="updateMyPage", method=RequestMethod.POST)
	public String postMyPage(CustomMemberVO cMember) {
		
		log.info("post My Page 컨트롤러 진입");
		CustomMemberVO loginPrincipal = (CustomMemberVO) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if(cMember.getMemberPw().contentEquals("")) {
			cMember.setMemberPw(loginPrincipal.getMemberPw());
		} else {
			cMember.setMemberPw(passwordEncoder.encode(cMember.getMemberPw()));	
		}
		cMember.setMemberId(SecurityContextHolder.getContext().getAuthentication().getName()); //현재 로그인 중인 ID
		log.info("update check : " + cMember.toString());
		service.update(cMember);
		log.info("update 완료");
		log.info("authorities : "+ loginPrincipal.getAuthorities());
		Authentication auth = new UsernamePasswordAuthenticationToken(cMember, null, loginPrincipal.getAuthorities());
		log.info("auth updated : " + auth.toString());
		SecurityContextHolder.getContext().setAuthentication(auth);
		
		return "member/my_page";
	}
	
	//myPage Get
	@RequestMapping(value="/my_page" , method=RequestMethod.GET)
	public String getMyPage() {
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		log.info("auth 확인 " + auth.toString());
		log.info("myPage입니다.");
		log.info("getPrincipal : " + auth.getPrincipal());
		log.info("getName : " + auth.getName());
		return "member/my_page";
	}
	
	//currentPassword ajac check
	@ResponseBody	// ajax url .jsp 404 error 안뜸.
	@RequestMapping(value="/my_page/passwordCheck" , method=RequestMethod.GET)
	public String getMyPagePasswordCheck(CustomMemberVO cMember, Model model) {
		
		log.info("currentPw binding check : " + cMember.getMemberPw());
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		log.info("auth 확인 " + auth.toString());
		log.info("myPage입니다.");
		log.info("auth.getName : " + auth.getName());

		MemberVO dbMember = service.selectOne(auth.getName());
		log.info("dbMember : "+ service.selectOne(auth.getName()));
		log.info("currentPw : " + cMember.getMemberPw());
		
		if(passwordEncoder.matches(cMember.getMemberPw(), dbMember.getMemberPw())) {
			log.info("비밀번호 일치");
			String msg = "currentPassword is authenticated !";
			return msg;
		} else {
			log.info("비밀번호 불일치");
			String msg = "currentPassword is not correct ";
			return msg;
		}
		
	}
	//스프링 4.0이상 부터 jackson2를 사용.. 그이전버전은 message converter를 사용해야함.
	@ResponseBody
	@RequestMapping(value="/my_page/verifyPassword", method=RequestMethod.GET)
	public String getVerifyPassword(@RequestParam String newPassword, @RequestParam String verifyPassword) {
		
		log.info("newPassword: " + newPassword);
		log.info("verifyPassword: " + verifyPassword);
		if(newPassword.equals(verifyPassword)) {
			log.info("비밀번호 일치");
			String msg = "good job !";
			return msg;
		} else {
			log.info("비밀번호 불일치");
			String msg= "please check your passwords";
			return msg;
		}
	}
	
	
	//sign_up Get
	@RequestMapping(value="/sign_up" , method=RequestMethod.GET)
	public String getSignUp() {
		
		log.info("sign_up.do");
		return "member/sign_up";
	}
	
	//sign_up Post
	@RequestMapping(value="/sign_up" , method=RequestMethod.POST)
	public String postSignUp(MemberVO vo) {
		log.info("############ 가입처리");
		log.info("############vo: " + vo);
		
		service.insert(vo);
		log.info("############ 가입완료 잠시후 로그인");
		
		log.info("############ 로그인 성공");

		return "redirect:/";
	}
	
	@RequestMapping(value="/login", method = RequestMethod.GET)
	public String getlogin() {
		
		log.info("##################### get login");
		
		
		return "member/login";
	}

	
	@RequestMapping(value="/login", method = RequestMethod.POST)
	public String login(String memberId, HttpServletRequest req) {
		log.info("#####################post login -- MemberController");
		
		HttpSession session = req.getSession();
		
		return "member/login";
		
	}
	
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public String getLogOut(HttpSession session) {
		log.info("##################### log out" );
		session.invalidate();
		
		return "redirect:../";
	}
	
}

