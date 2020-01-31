package org.js.movie.member.service;

import java.util.List;

import org.js.movie.member.dao.CustomService;
import org.js.movie.member.domain.CustomMemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class CustomProvider implements AuthenticationProvider {
	
	@Autowired
	private CustomService service;

	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	public void setCustomService(CustomService service) {
		this.service = service;
	}
	
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {

		log.info("CustomProvider 진입");
		
		String username = (String) authentication.getPrincipal(); // 입력한memberId 
		log.info("authentication.getPrincipal : " + authentication.getPrincipal());
		String password = (String) authentication.getCredentials(); //Object -> String
		log.info("입력한 비밀번호 암호화 하지않음 : " + password);
		
		//passwordEncoder.encode(password) 입력한 pw 암호화 매번 값이 달라져서 입력한 비밀번호를 암호화하고 비교하는방법은 없나?
		
		CustomMemberVO cMemberProvider = (CustomMemberVO) service.loadUserByUsername(username);
		log.info("service.load 확인 : " + cMemberProvider);
		log.info("db 비번 확인 : " + cMemberProvider.getMemberPw());
		
		// Bcrypt의 .matches메소드는 암호화하지 않은 입력한 pw와 암호화된 pw를 비교해줌.
		if(!passwordEncoder.matches(password, cMemberProvider.getPassword())) {
			log.info(" Not Match Password");
            throw new BadCredentialsException(username);
        } else {
        	log.info("pass!");
        }
 
        if(!cMemberProvider.isEnabled()) {
            log.info("cMember is not enabled");
            throw new BadCredentialsException(username);
        }
		
        log.info("pw check 완료 // role 처리 진입");

		//List<Role> authorities = (List<Role>) cMember.getAuthorities();
        
        List<? extends GrantedAuthority> authorities = (List<? extends GrantedAuthority>) cMemberProvider.getAuthorities();
        log.info("authorities 확인 : " + authorities.toString());
		
		return new UsernamePasswordAuthenticationToken(username, password, cMemberProvider.getAuthorities());
	}
	
	/*
	 * private boolean matchPassword(String loginPwd, String password) { return
	 * loginPwd.equals(password); }
	 */

	@Override
	public boolean supports(Class<?> authentication) {

		return UsernamePasswordAuthenticationToken.class.isAssignableFrom(authentication);
	}

}
