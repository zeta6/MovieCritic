<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Movie Review</title>
<link rel="stylesheet" type="text/css" href="/resources/css/common.css"/>
<style>

#main_wrapper_area{
	border:1px solid red;
	width:43vw;
	min-height:500px;
	margin:40px auto;
}


#score_distribution{
	list-style-type:none;
	
}

.inner_header{
	background:#fffaf2;
	color:black;
	font-size:13px;
}

.review_area{
	background:#fffaf2;
	border:1px solid purple;
	margin-top:20px;
}

.ratingCircle{
    border-radius: 50%;
    height: 28px;
    width: 28px;
    text-align: center;
    background-color: #000;
    color:white;
    cursor:pointer;
}

#review_menu_list{
	list-style-type:none;
	display:flex;
	justify-content:flex-end;
	align-items:center
	border:1px solid blue;
	margin-top:-30px;
	font-size:14px;
}

.review_menu_item{
	padding-right:8px;
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
			<a href="/movie_list" class="top_text1">Genre</a>
				
				<ul id="genre_sub">			<!-- select 기준 적용된 페이지 호출.. -->
					<li class="left_inner_menu"><a href="#" class="top_text3">Action</a></li>
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



<!-- 컨텐츠 시작-->

<div id="main_wrapper_area">

	<h1> <a href="movie_info/view?movieId=${view.movieId}">${view.title}</a> </h1>
	<h5> ${view.genre} | <fmt:formatDate value="${view.releaseDate}" pattern="yyyy.MM.dd"/> </h5>
	
	<!-- middle menu bar-->
	<div>		
			
		<div>
			<div style="float:left;">
				<div style="float:left;"> 점수표시</div>
				<h4 style="float:left;">User Score</h4>
				<h5>based on ?Ratings</h5>					
			</div>
				
			<div style="margin-left:300px;">
				<div>User score distribution</div>
				<ul id="score_distribution">
					<li>Positive: </li>
					<li>Mixed: </li>
					<li>Negative: </li>
				</ul>
			</div>
		</div>			
		
	</div>
	<!-- middle menu end-->

	<!-- 리뷰 입력 -->
	<div class="review_area">
		<div class="inner_header">
			<h3> REVIEW THIS MOVIE</h3>
 
				<div style="display: flex;">
				    <div id="ratingCircle_0" class="ratingCircle">0</div>
				    <div id="ratingCircle_1" class="ratingCircle">1</div>
				    <div id="ratingCircle_2" class="ratingCircle">2</div>
				    <div id="ratingCircle_3" class="ratingCircle">3</div>
				    <div id="ratingCircle_4" class="ratingCircle">4</div>
				    <div id="ratingCircle_5" class="ratingCircle">5</div>
				    <div id="ratingCircle_6" class="ratingCircle">6</div>
				    <div id="ratingCircle_7" class="ratingCircle">7</div>
				    <div id="ratingCircle_8" class="ratingCircle">8</div>
				    <div id="ratingCircle_9" class="ratingCircle">9</div>
				    <div id="ratingCircle_10" class="ratingCircle">10</div>
				</div>
				
				<script>
				window.onload = function(){
				    var markScore;  
				    for(var x=0; x<=10; x++){
				        var circle = document.querySelectorAll(".ratingCircle")[x];
				        circle.onmouseover = function(e){
				            var score = this.innerHTML;
				            for(var i=0; i <= score; i++) {
				                if(i<4 ) {
				                    var id = "ratingCircle_" + i;
				                    document.getElementById(id).style.backgroundColor = "red";
				                }else if( i < 7){
				                    var id = "ratingCircle_" + i;
				                    document.getElementById(id).style.backgroundColor = "orange";
				                }else if ( i< 11){
				                    var id = "ratingCircle_" + i;
				                    document.getElementById(id).style.backgroundColor = "greenyellow";
				                }
				            }
				        }
				        circle.onmouseout = function(e){
				            if(markScore == null){
				                var score = this.innerHTML;
				                for(var i=0; i <= score; i++) {
				                    var id = "ratingCircle_" + i;
				                    document.getElementById(id).style.backgroundColor = "#ccc";
				                }
				            }else{
				                for(var i=10; i >markScore; i--){
				                    var id = "ratingCircle_" + i;
				                    document.getElementById(id).style.backgroundColor = "#ccc";
				                }
				                
				            }
				            console.log("markScore="+markScore);
				        }
				        circle.onclick = function(e){
				            markScore = this.innerHTML;
				            document.getElementById("markRating").value = markScore;
				            console.log("markScore="+markScore);
				        }
				    }
				}
				</script>
		</div>

		<div>
			<form action="/view_review" method="post"> 
				<textarea cols="100" rows="5" maxlength="500" name="content"></textarea>	<%--name에 정해진 값은 변수로 요청에 파라미터를 보냄 --%>
				<input type="hidden" value="${view.movieId}" name="movieId"/>
				<input type ="hidden" name="rating" id="markRating" />
				<input type="submit" value="submit"/>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			</form>
		</div>

	</div>
	<!-- 리뷰 입력 끝 -->

	<!-- 유저 리뷰 목록-->
	<div class="review_area">

			<h4> USER REVIEWS</h4>
			<ul id="review_menu_list">
				<li class="review_menu_item">By score </li>
				<li class="review_menu_item">By date </li>
			</ul>
		
		
			
		

		<!--jstl 사용 forEach-->
		<div style="margin:10px; background:#fff; border:1px solid blue;">
			<div style="border:1px solid red;margin-left:10px;float:left;">10점</div>
			<div style="border: 1px solid green; max-width:780px;margin-left:7px;">
				<div style="float:left;">User</div>   <div style="float:right;">Date</div>
				<div style="margin-left:40px;">Content,,,,,,,,,,,,,,,,,,,,,,,,,,,gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg,</div>
			</div>
		</div>

	</div>
	<!-- 유저 리뷰 목록 끝-->

</div>

<!-- 컨텐츠 끝-->
</div>
<!-- 전체 레이아웃 끝-->
</body>
</html>


