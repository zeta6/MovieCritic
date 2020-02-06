package org.js.movie.member.domain;

import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter //jsp 로그인 표현할 때 getMemberId가 없어서 추가함.
@Setter
@NoArgsConstructor   //Mybatis
@ToString
public class CustomMemberVO implements UserDetails {

	private static final long serialVersionUID = 1L; //ctrl+1 로 값을 생성.
	
	private String memberId;
	private String memberPw;
	private String email;
	private String phoneNumber;
	private String nickname;
	private List<Role> authorities;
	private boolean accountNonExpired = true;
	private boolean accountNonLocked =true;
	private boolean credentialsNonExpired = true;
	private boolean enabled = true;

	//my_page 정보 표시로 추가함. getter,setter 없어도 nickname이 나옴.
	public String getEmail() {
		return this.email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getPhoneNumber() {
		return this.phoneNumber;
	}
	
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	
	
	//id, pw, enabled를 vo에 설정하는 생성자
	public CustomMemberVO(MemberVO vo) {
		
		this.memberId = vo.getMemberId();
		this.memberPw = vo.getMemberPw();
		this.enabled = vo.getEnabled()==1? true : false;  //int -> boolean 처리
	}
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		
		return authorities;
	}

	@Override
	public String getPassword() {
		
		return this.memberPw;
	}

	@Override
	public String getUsername() {
		
		return this.memberId; //함수호출은 getUsername()이지만 리턴값은 memberId로.
	}

	@Override
	public boolean isAccountNonExpired() {
		
		return accountNonExpired;
	}

	@Override
	public boolean isAccountNonLocked() {

		return accountNonLocked;
	}

	@Override
	public boolean isCredentialsNonExpired() {

		return credentialsNonExpired;
	}

	@Override
	public boolean isEnabled() {

		return enabled;
	}

}
