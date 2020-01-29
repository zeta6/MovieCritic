package org.js.movie.member.dao;

import java.util.ArrayList;
import java.util.List;

import org.js.movie.member.domain.CustomMemberVO;
import org.js.movie.member.domain.Role;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CustomService implements UserDetailsService {

	@Autowired
	private MemberDAO dao;
	
	//DB에 role을 저장한다.
	private void insertRole(CustomMemberVO cMember) {
		
		dao.insertRole(cMember);
	}
	
	@Override
	public UserDetails loadUserByUsername(String memberId) throws UsernameNotFoundException {
		
		log.info("CustomService 진입");
		CustomMemberVO cMember = dao.login(memberId);
				
		if(memberId == "admin" && cMember.getAuthorities()== null) {
			
			log.info("admin Authorities : " + cMember.getAuthorities());
			
			Role adminRole = new Role();
			adminRole.setRole("ROLE_ADMIN");
			List<Role> roles = new ArrayList<Role>();
			roles.add(adminRole);
			cMember.setAuthorities(roles);
			log.info("adminRole: " + adminRole.toString());
			
			insertRole(cMember);
				
		} else if(memberId == "admin" && cMember.getAuthorities() != null) {
			log.info("권한이 이미 있음");
		}
		
		if(memberId != "admin" && memberId != null) {
			
			log.info("user Authorities : " + cMember.getAuthorities());
			
			Role userRole = new Role();
			userRole.setRole("ROLE_USER");
			List<Role> roles = new ArrayList<Role>();
			roles.add(userRole);
			cMember.setAuthorities(roles);                  //authorities를 중간에 설정? 아니면 db에서 조회? 
			log.info("userRole : " + userRole.toString());		
			
			insertRole(cMember);
		} else if(memberId != "admin" && memberId != null && cMember.getAuthorities() != null) {
			log.info("권한이 이미 있음");
		}
		
		if(cMember==null) {
			log.info("회원이 아님");
			throw new UsernameNotFoundException(memberId);
	    }
		return cMember;
	}

}
