package org.js.movie.member.domain;

import org.springframework.security.core.GrantedAuthority;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
public class Role implements GrantedAuthority {
	
	private static final long serialVersionUID =1L;
	
	private String memberId;
	private String role;

	
	@Override
	public String getAuthority() {
		
		return this.role;
	}

}
