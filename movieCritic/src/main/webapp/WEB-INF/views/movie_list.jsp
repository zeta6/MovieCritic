<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="/resources/css/common.css"/>
<title>Browse movie</title>
<style>

#middle_wrapper{
	width:100%;
	height:400px;
	border:1px solid blue;
}

#select_wrapper{
	display:flex;
	justify-content:space-around;
	align-items:center;
	width: 1000px;
	margin-top: 50px;
	margin-left: 310px;
	border:1px solid blue;
}

#genre{
	width:250px;
	height:30px;
	
}

#timeframe{
	width:250px;
	height:30px;
}

#sort{
	width:250px;
	height:30px;
}

. select_box{

}

.select_label{
	display:block;
	padding-bottom:5px;
}

</style>

</head>

<body>

<!-- 절대경로 -->
<c:set var="rootPath" value="${pageContext.request.contextPath}"/>

<div id="site_layout">

	<!--movieCri-->
	<!-- 상단 메뉴 wrapper-->

	<div id="top_menu_wrapper">
		<!-- 상단 메뉴 -->
		<div id="top_menu">
			<!--상단 왼쪽 메뉴 -->
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
			<!-- 상단 왼쪽 메뉴 끝 -->
			
			<!-- 상단 오른쪽 메뉴 -->
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
			<!-- 상단 오른쪽 메뉴 끝 -->
		</div>
		<!-- 상단 메뉴 끝 -->
	</div>
	<!-- 상단 메뉴 wrapper 끝-->

	<div id="middle_wrapper">
		<h1 style="width:100%;padding-top:100px;padding-left:340px;">Browse Movie</h1>
		
		<div id="select_wrapper">

			<div id="select1">
				<label for="genre" class="select_label">Genre</label>
				<select name="genre" id="genre" class="select_box">
					<option value="">All Genre</option>
					<option value="Action">Action</option>
					<option value="Drama">Drama</option>
					<option value="Fantasy">Fantasy</option>
				</select>
			</div>

			<div id="select2">
				<label for="timeframe" class="select_label">Timeframe</label>
				<select name="timeframe" id="timeframe" class="select_box">
					<option value="">All Time</option>
					<option value="2019">2019</option>
					<option value="2018">2018</option>
					<option value="2017">2017</option>
				</select>
			</div>

			<div id="select3">
				<label for="sort" class="select_label">Sort</label>
				<select name="sort" id="sort" class="select_box">
					<option value="score">Score</option>
					<option value="A_Z">A-Z</option>
					<option value="release_date">Release Date</option>
				</select>
			</div>
		</div>
	</div>
</div>
</body>
</html>