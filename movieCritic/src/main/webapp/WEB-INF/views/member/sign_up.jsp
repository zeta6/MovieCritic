<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign Up -MovieCritic</title>
<link rel="stylesheet" type="text/css" href="/resources/css/common.css">
<script src="/resources/jquery/jquery-3.4.1.min.js"></script>
<style>

#login_box{
	border : 1px solid lightgray;
	max-width:290px;
	max-height:700px;
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
			<input type="text" placeholder=" Nickname" class="login" name="nickname" id="nickname">
			<span id="nickCheck"></span>
		</div>
	
	
		<div id="id_box">
			<input type="text" placeholder=" ID" class="login" name="memberId" id="memberId">
			<span id="idCheck"></span>
		</div>
		
		<div id="pw_box">
			<input type="password" placeholder=" Password" class="login" name="memberPw" id="memberPw">
			<span id="pwCheck"></span>
		</div>
	
		<div id="email_box">
			<input type="text" placeholder=" Email" class="login" name="email" id="email">
			<span id="emailCheck"></span>
		</div>
		
		<div id="phone_number_box">
			<input type="text" placeholder=" Phone Number" class="login" name="phoneNumber" id="phoneNumber">
			<span id="phoneCheck"></span>
		</div>
	
	
	
		<article>
			<input type="submit" id="create_account_btn" value="Create Account"/>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> <!-- csrf -->
		</article>
	</form>

	<div id="foot" style="padding:10px;"><span>By clicking Register, you indicate that you have read and understand our Privacy Policy and Terms of Use and represent that you are at least 13 years of age.</span></div>

</section>

</div>

<script>

var idCheck = /^[0-9a-zA-Z]{4,12}$/;
var pwCheck = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*()\-\[\]?<>\;])*([A-Za-z\d!@#$%^&*()\-\[\]?<>;]){8,20}$/;
var nickCheck = /^[a-zA-Z]{2,12}$/;
var emailCheck = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/;
var phoneCheck = /^01([0|1|6|7|8|9]?)?([0-9]{3,4})?([0-9]{4})$/;

$('#memberId').blur(function(){
	console.log('hi');
	alert('hi');
    if(idCheck.test($('#memberId').val())){
		console.log('true');
		$('#idCheck').text('');
		return true;
    } else {
		console.log('false');
		$('#idCheck').text(' number or Alphabet only from 4 to12 characters');
		$('#idCheck').css('color', 'red');
		$('#idCheck').css('font-size', '12px');
		return false;
    }
});

$('#memberPw').blur(function(){
    if(pwCheck.test($('#memberPw').val())){
		console.log('true');
		$('#pwCheck').text('');
		return true;
    } else {
		console.log('false');
		$('#pwCheck').text(' at least one number and (capital or small letter) and special characters only 4~12 characters');
		$('#pwCheck').css('color', 'red');
		$('#pwCheck').css('font-size', '12px');
		return false;
    }
});

$('#nickname').blur(function(){
   	if(nickCheck.test($('#nickname').val())){
		console.log('true');
		$('#nickCheck').text('');
		return true;
    } else {
		console.log('false');
		$('#nickCheck').text(' number or Alphabet only 2~12characters');
		$('#nickCheck').css('color', 'red');
		$('#nickCheck').css('font-size', '12px');
		return false;
    }
});

$('#email').blur(function(){
    if(emailCheck.test($('#email').val())){
		console.log('true');
		$('#emailCheck').text('');
		return true;
    } else {
		console.log('false');
		$('#emailCheck').text(' please check your email');
		$('#emailCheck').css('color', 'red');
		$('#emailCheck').css('font-size', '12px');
		return false;
    }
});


$('#phoneNumber').blur(function(){
    if(phoneCheck.test($('#phoneNumber').val())){
		console.log('true');
		$('#phoneCheck').text('');
		return true;
    } else {
		console.log('false');
		$('#phoneCheck').text(' please check your phone number');
		$('#phoneCheck').css('color', 'red');
		$('#phoneCheck').css('font-size', '12px');
		return false;
    }
});

</script>

</body>
</html>