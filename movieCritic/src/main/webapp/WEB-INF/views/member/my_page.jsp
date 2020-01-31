<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="/resources/css/common.css"/>
<title>My Page</title>

<style>

#main_setting_area{
	margin: 70px 300px 100px;
	border: 1px solid white;
	font-size: 13px;
	width:50%;
	height:100%;
}

.main_inner_area{
	border-bottom: 1px solid #aaa;
	padding:30px 7px;
	height: 80px;
	padding-left:15px;
}

.content_left_area{
	float:left;
	padding-left: 5px;
	width: 20%;
}

.content_right_area{
	float:left;
	padding-left: 25px;
	width:20%px;
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
		<a href="../${rootPath}"><img src="/resources/image/logo.webp" alt="OpenCritic"></a>
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
			<sec:authorize access="hasAuthority('ROLE_ADMIN')">
				<div id="admin_write" class="right_menu">
					<a href="${rootPath}/write_board" class="top_text2">Write</a>
				</div>
			</sec:authorize>	


		</nav>

	</div>
   </div>
	<!-- 상단 메뉴 끝-->


<div id="main_setting_area">

	<h3>ACCOUNT SETTINGS</h3>

	<div class="main_inner_area">
		<div class="content_left_area">PROFILE IMAGE</div>

		<div class="content_right_area"><img src="${rootPath}/resources/image/profile.png"></div>

		<div class="content_right_area" style="clear:both; padding-left:200px"><input type="file" value="파일 선택"></div>
	</div>

	<div class="main_inner_area">
		<div class="content_left_area">NICKNAME</div>

		<div class="content_right_area"> <input type="text" placeholder="now"> </div>
	</div>

	<div class="main_inner_area">
		<div class="content_left_area">ID</div>

		<div class="content_right_area"> current_id </div>
	</div>

	<div class="main_inner_area">
		<div class="content_left_area">PW</div>
	
		<div class="content_right_area">
			<div><input type="password" placeholder="current password"></div>
			<div><input type="password" placeholder="new password"></div>
			<div><input type="password" placeholder="verify password"></div>
		</div>
	</div>

	<div class="main_inner_area">
		<div class="content_left_area">EMAIL</div>

		<div class="content_right_area"> current email </div>
	</div>

	<div class="main_inner_area">
		<div class="content_left_area">PHONE</div>

		<div class="content_right_area"> current phone </div>
	</div>


</div>

<!--main_setting.. 끝-->

</div>
<!--site_layout 끝-->

</body>

</html>