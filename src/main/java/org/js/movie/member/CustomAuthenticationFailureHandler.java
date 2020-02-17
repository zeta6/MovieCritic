package org.js.movie.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Getter
@Setter
@Slf4j
public class CustomAuthenticationFailureHandler implements AuthenticationFailureHandler {

	private String memberId;
	private String memberPw;
	private String errorMsg;
	private String defaultFailureUrl;
	
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		
		/*
		 * String errormsg = null;
		 * 
		 * if(exception instanceof BadCredentialsException) { errormsg =
		 * MessageUtils.getMessage("error.BadCredentials"); } else if(exception
		 * instanceof InternalAuthenticationServiceException) { errormsg =
		 * MessageUtils.getMessage("error.BadCredentials"); } else if(exception
		 * instanceof DisabledException) { errormsg =
		 * MessageUtils.getMessage("error.Disaled"); } else if(exception instanceof
		 * CredentialsExpiredException) { errormsg =
		 * MessageUtils.getMessage("error.CredentialsExpired"); }
		 */
		
		
		request.setAttribute("tryId", request.getParameter(memberId));
		request.setAttribute("tryPassword", request.getParameter(memberPw));
		request.setAttribute("errorMsg", exception.getMessage());
		
		
		
		log.info("getRequestDispatcher 경로확인 : " + request.getRequestDispatcher(""));
		log.info("forward전");
		
		request.getRequestDispatcher("/member/login?match=false").forward(request, response);
		 
		/* response.sendRedirect(defaultFailureUrl);  정보 유지 x*/

		log.info("forward후");
	}

}
