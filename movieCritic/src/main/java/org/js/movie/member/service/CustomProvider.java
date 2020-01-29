package org.js.movie.member.service;

import java.util.List;

import org.js.movie.member.dao.CustomService;
import org.js.movie.member.domain.CustomMemberVO;
import org.js.movie.member.domain.Role;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class CustomProvider implements AuthenticationProvider {
	
	@Autowired
	private CustomService service;

	@Autowired
	private 
	BCryptPasswordEncoder passwordEncoder;
	
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {

		log.info("CustomProvider 진입");
		
		String username = (String) authentication.getPrincipal(); // 입력한memberId 
		String password = (String) authentication.getCredentials(); //Object -> String 
		//passwordEncoder.encode(password) 입력한 pw 암호화
		
		CustomMemberVO member = (CustomMemberVO) service.loadUserByUsername(username);
		
		if(!matchPassword(passwordEncoder.encode(password), member.getPassword())) {
            throw new BadCredentialsException(username);
        }
 
        if(!member.isEnabled()) {
            throw new BadCredentialsException(username);
        }
		
        log.info("pw check 완료 // role 처리 진입");

		List<Role> authorities = (List<Role>) member.getAuthorities();
		
		log.info("authorities 확인 : " +authorities.toString());
		
		return new UsernamePasswordAuthenticationToken(member, password, authorities);
	}
	
	private boolean matchPassword(String loginPwd, String password) {
        return loginPwd.equals(password);
    }

	@Override
	public boolean supports(Class<?> authentication) {

		return UsernamePasswordAuthenticationToken.class.isAssignableFrom(authentication);
	}

}
