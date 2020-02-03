<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/resources/css/common.css"/>
<style>

#main_area{
	width:100vw;
	height:50vh;
	max-height:500px;
	background:black;
	color:white;
	display:flex;
	justify-content:center;
	align-items:space-center;
}

#main_info_area{
	border: 3px solid yellow;
	margin: 50px 0 0 0;

}

.main_info_text{
	padding: 15px 0 15px 0;
	border-bottom: 1px solid lightgray;
	width: 450px;
}

#main_trailer_area{
	border: 3px solid green;
	width:700px;
	height: 350px;
	margin: 50px 0 0 15px;
}

#middle_area{
	margin: 100px 0 0 400px;


}


#middle_poster_area{
	float:left;
	border: 1px solid blue;
}

#middle_detail_area{
	float:left;
	border: 1px solid purple;
	margin-left: 50px;
	width:550px;
	word-break:break-all;

}

#bottom_area{
	clear:both;
	margin: 100px 0 0 400px;
	padding-top:50px;
	
}

#movie_score{
	float:left;
	width: 400px;
	border: 1px solid black;
	height: 700px;
}

#user_score{
	float:left;
	width: 400px;
	border: 1px solid gray;
	height: 700px;
	margin-left:20px;
}

#write_review{
	float:right;
	margin-top:-50px;
	margin-right:10px;
	border:2px solid black;
	border-radius:20px;
	color:white;
	font-size: 15px;
	background:black;
	padding:7px 20px 7px;
}

.critic_reviews{
	height: 200px;
	border-top:1px solid #aaa;
}


</style>

<script>




</script>

</head>
<body>
<!-- 절대경로 -->
<c:set var="rootPath" value="${pageContext.request.contextPath}"/>

<!--전체 레이아웃-->

<div id="site_layout">

	<!--movieCri-->
	<!-- 상단 메뉴-->

   <div id="top_menu_wrapper">
	<div id="top_menu">

		<nav id="top_menu1">
		<ul id="left_menu">
		
		<li class="left_menu">		
		<a href="${rootPath}"><img src="${rootPath}/resources/image/logo.webp" alt="OpenCritic"></a>
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

	<!-- 트레일러-->	

	<div id="main_area">
	
		<div id="main_info_area">
		
			<div class="main_info_text">
			<h1>${view.title} <span style="font-size:14px;">Year</span></h1>
			</div>

			<div class="main_info_text">
			<h3>SCORE</h3>
			</div>			

			<div class="main_info_text">
			<h3>VOTE NOW</h3>
			</div>
		</div>

		<div id="main_trailer_area">


			<img src="${rootPath}/resources/image/editor2.jpg">

		</div>

	</div>

	<!-- 트레일러 끝-->	

	<!-- 영화 정보-->

	<div id="middle_area">

		<div id="middle_poster_area">
			<img src="${list.poster}">

		</div>

		<div id="middle_detail_area">

			<h2>Movie Details and Credits</h2>
				<ul>
					<li>Starring
						<p>abcd..dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd</p>
					</li>
					<li>${view.summary}</li>
					<li>Director</li>
					<li>Genre</li>
					<li>Runtime</li>
				</ul>


		</div>


	</div>

	<!-- 영화 정보 끝-->

	<!-- 리뷰 점수-->

	<div id="bottom_area">

		<div id="movie_score">

			<h3>Movie Score</h3>
	
			<!--점수표시 이미지-->
			<div>9999
			
			</div>
			<!--점수표시 이미지 끝-->
	
			<!-- Positive ?? 보류-->		
			<div>
	
			</div>
			<!-- Positive ?? 보류-->	

			<h2>Critic Reviews</h2>

			<div class="critic_reviews">
			
			</div>
			<div class="critic_reviews">
		
			</div>
			<div class="critic_reviews">
		
			</div>

			<a href="#">SEE ALL REVIEWS</a>							

		</div>

		<div id="user_score">

			<h3>User Score</h3> <div id="write_review"><a href="${rootPath}/view_review">Write a Review</a></div>

			<!--점수표시 이미지-->
			<div>
			
			</div>
			<!--점수표시 이미지 끝-->
	
			<!-- Positive ?? 보류-->		
			<c:forEach items="${reviewList}" var="reviewList">
				<li>
  					<p>
					   작성자 : ${reviewList.writer}<br />
   					   작성 날짜 : ${reviewList.regDate}"
 					</p>
  
  					<p>${reviewList.content}</p>
 				</li>
 			</c:forEach>   
			<!-- Positive ?? 보류-->

			<h2>User Reviews</h2>

			<div class="critic_reviews">
		
			</div>
			<div class="critic_reviews">
		
			</div>
			<div class="critic_reviews">
		
			</div>

			<a href="#">SEE ALL REVIEWS</a>							


		</div>

	</div>

	<!-- 리뷰 점수 끝-->
	
	

</div>

<!--전체 레이아웃 끝-->


</body>
</html>