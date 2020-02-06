<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign Up -MovieCritic</title>
<link rel="stylesheet" type="text/css" href="/resources/css/common.css">
<style>

#login_box{
	border : 1px solid lightgray;
	width: 300px;
	height: 450px;
	margin: 200px auto;
}

h3, p{
	text-align:center;
}

p {
	background: darkblue;
	color: white;
	width: 250px;
	margin: 0 auto;
}

#or{
	text-align:center;
	margin: 5px 0 5px;
}

div[id*=_box]{
	margin-left: 25px;
	margin-top: 8px;
	
}

.login{
	width: 250px;
	height: 25px;
	border-radius: 5px;
	border : 1px solid gray;
}

#forgot{
	text-align:center;
	margin-top:10px;
}

#create_account_btn{
	text-align:center;
	background:black;
	color:white;
	width:270px;
	height:35px;
	margin: 25px 15px;
	padding-top: 3px;
}

#foot{
	text-align:center;
	font-size:12px;
}


</style>
</head>

<body>
<!-- 절대경로 -->
<c:set var="rootPath" value="${pageContext.request.contextPath}"/>

<div id="site_layout">

	<!--movieCri-->
	<!-- 상단 메뉴-->

   <div id="top_menu_wrapper">
	<div id="top_menu">

		<nav id="top_menu1">
		<ul id="left_menu">
		
		<li class="left_menu">		
		<a href="../"><img src="/resources/image/logo.webp" alt="OpenCritic"></a>
		</li>
		<li class="left_menu">
			<a href="${rootPath}/movie_list" class="top_text1">Genre</a>
				
				<ul id="genre_sub">
					<li class="left_inner_menu"><a href="# "class="top_text3">Action</a></li>
					<li class="left_inner_menu"><a href="#" class="top_text3">Comedy</a></li>
					<li class="left_inner_menu"><a href="#" class="top_text3">Drama</a></li>
				</ul>
				
		</li>
		<li class="left_menu">
			<a href="#" class="top_text1">Release Schedule</a>
		</li>
		</ul>
		</nav>
		<nav id="top_menu2">
			
			<div id="form" class="right_menu">
	
				<form action="#" method="post" class="right_menu">

					<input type="text" placeholder="Search" class="top_text2" id="search">

				</form>			
			</div>
		
					<!-- 로그인 안됐을 경우 , 로그인, 회원가입 버튼 보여줌-->
		<sec:authorize access="!isAuthenticated()">
			<div id="login" class="right_menu">
				<a href="${rootPath}/member/login" class="top_text2">Login</a>
			</div>
			<div id="sign_up" class="right_menu">
				<a href="${rootPath}/member/sign_up" class="top_text2">Sign Up</a>
			</div>
		</sec:authorize>
		
		<!-- 로그인 됐을 경우 , 로그아웃, 마이페이지 버튼 보여줌 -->

			<sec:authorize access="hasAnyAuthority('ROLE_ADMIN', 'ROLE_USER')">
			<div class="right_menu">
					<a href="${rootPath}/member/my_page">
						<img src="/resources/image/toMyPage.png"
						width="30px" height="30px">
					</a>
			</div>
			</sec:authorize>
			<sec:authorize access="isAuthenticated()">
			<div id="logout" class="right_menu">
					<a href="${rootPath}/member/logout" class="top_text2">Log Out</a>
			</div>
			</sec:authorize>

		<!-- 관리자 로그인 -->

			<sec:authorize access="hasRole('ADMIN')">
				<div id="admin_write" class="right_menu">
					<a href="${rootPath}/write_board" class="top_text2">Write</a>
				</div>
			</sec:authorize>	
		</nav>

	</div>
   </div>
	<!-- 상단 메뉴 끝-->

<section id="login_box">

	<h3> CREATE AN ACCOUNT </h3>

	<p>Continue with Facebook</p>

	<div id="or"><span>or</span></div>

	<form action="${rootPath}/member/sign_up.do" method="post">
		<div id="nickname_box">
			<input type="text" placeholder=" Nickname" class="login" name="nickname">
		</div>
	
	
		<div id="id_box">
			<input type="text" placeholder=" ID" class="login" name="memberId">
		</div>
		
		<div id="pw_box">
			<input type="password" placeholder=" Password" class="login" name="memberPw">
		</div>
	
		<div id="email_box">
			<input type="text" placeholder=" Email" class="login" name="email">
		</div>
		
		<div id="phone_number_box">
			<input type="text" placeholder=" Phone Number" class="login" name="phoneNumber">
		</div>
	
	
	
		<article>
			<input type="submit" id="create_account_btn" value="Create Account"/>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> <!-- csrf -->
		</article>
	</form>

	<div id="foot"><span>By clicking Register, you indicate that you have read and understand our Privacy Policy and Terms of Use and represent that you are at least 13 years of age.</span></div>

</section>

</div>

</body>
</html>