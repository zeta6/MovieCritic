<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/resources/css/common.css"/>
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
<style>

#main_area{
	max-height:500px;
	background:black;
	color:white;
	display:flex;
	justify-content:center;
	align-items:space-center;
	width:100%;
	height:75%; /* 1vw , 1vh = viewport의 1% */
}

#main_info_area{

	margin: 5px 10px 0 0;
	width:25%;
	min-width:400px;

}

.main_info_text{
	padding-bottom: 20px;
	border-bottom: 1px solid #777;
	width: 100%;
}

div.main_info_text h1,h2,h3,h4,h5,h6 {
	padding-bottom:6px;
}

div.main_info_text div.rating_circle_average{
	margin-top:30px;
}

.ratingCircle{
    border-radius: 50%;
    height: 28px;
    width: 28px;
    text-align: center;
    background-color: #000;
    color:white;
    cursor:pointer;
    font-size:15px;
    font-weight:50px;
    margin-left:10px;
}

#main_trailer_area{
	width:700px;
	height: 350px;
	margin: 50px 0 0 15px;
}

.still_cuts{
	width:30%;
	height:50%;
}

#middle_area{
	padding: 5% 15% 20% 10%;


}


#middle_poster_area{
	float:left;
	width:30%;
	height:70%;
	margin-left:12%;
}

.posters{
	width:100%;
	height:100%;	
}

#middle_detail_area{
	float:left;
	margin-left: 50px;
	width:40%;
	height:100%;
	word-break:break-all;
	font-weight:200px;
	font-size:13px;
	line-height:25px;

}

.middle_details_text{
	font-size:15px;
	font-weight:bold;
}

#bottom_area{
	width:100%;
	overflow:hidden;
}

#bottom_area::-webkit-scrollbar, #site_layout::-webkit-scrollbar{
	display:none;
}

#movie_score{
	margin-left:15%;
	margin-top:60px;
	float:left;
	width: 25%;

}

.rating_circle_average{
    border-radius: 50%;
    height: 70px;
    width: 70px;
    text-align: center;
    background-color: #eee;
    color:white;
    cursor:pointer;
    float:left;
    margin:12px 0px 12px 12px;
    font-size:40px;
    font-weight:1000px;
}

div.score_distribution_area ul li{
	list-style-type:none;
	border:1px solid red;
	padding:0;
	width:100%;

}

.score_distribution_area{
	margin:0;
	padding:0;

	width:80%;
}

meter{
	width:75%; 
	height:17px;
	float:right; 
	padding-top:8px; 
	padding-right:3px;
}

#user_score{
	margin-top:60px;
	margin-left:50px;
	float:left;
	width: 30%;
	margin-bottom:10%;
}

#write_review{
	margin: 20px 0;
	border-radius:20px;
	font-size: 15px;
	background:black;
	padding:7px 20px 7px;
}

#write_review a{
	text-decoration:none;
	color:white;
}

.critic_reviews{
	height: 15%;
	border-top:1px solid #aaa;
	word-break:break-all;
	padding:20px 0;
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
		<a href="../${rootPath}"><img src="${rootPath}/resources/image/logo.webp" alt="OpenCritic"></a>
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
			<h1>${view.title} <span style="font-size:14px;"><fmt:formatDate value="${view.releaseDate}" pattern="yyyy"/></span></h1>
			</div>

			<div class="main_info_text" style="display:flex;">
				<div style="display:flex; flex-direction:column;">
					<h3 style="">SCORE</h3>
					<div style="word-break:break-all; width:55%;"> Mixed or average reviews based on ${totalCount} Ratings</div>
				</div> 
				<div class="rating_circle_average" style="float:right;">
					${scoreAverage}
				</div>
			</div>			
			
			<div class="main_info_text">
			<h6>VOTE NOW</h6>
			
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
				
				
			
			</div>
		</div>

		<div id="main_trailer_area">


			<img class="still_cuts" src="${view.stillCut1}">
			<img class="still_cuts" src="${view.stillCut2}">
			<img class="still_cuts" src="${view.stillCut3}">

		</div>

	</div>

	<!-- 트레일러 끝-->	

	<!-- 영화 정보-->

	<div id="middle_area">

		<div id="middle_poster_area">
			<img class="posters" src="${view.poster}">	<%--경로설정을 하지않았는데 들어가는 이유.. 톰캣 metadata? --%> 
		</div>	<%-- 프로젝트 내부에 저장하면 배포시 삭제되서 엑박뜸.. 프로젝트 외부에 폴더 만들고 server.xml에서 docBase, path 설정 --%>

		<div id="middle_detail_area">

			<h2>Movie Details and Credits</h2>
			<fmt:setLocale value="en_us"/>
			<h6><fmt:formatDate value="${view.releaseDate}" dateStyle="long"/></h6>

					<p><span class="middle_details_text">Starring : </span> 
						${view.starring}
					</p>
					<p><span class="middle_details_text">Summary : </span>
						${view.summary}
					</p>
					<p><span class="middle_details_text">Director : </span>  
						${view.director}
					</p>
					<p><span class="middle_details_text">Genre : </span>
						${view.genre}
					</p>
					<p><span class="middle_details_text">Runtime : </span>
						${view.runtime} 
					</p>



		</div>


	</div>

	<!-- 영화 정보 끝-->

	<!-- bottom_area-->

	<div id="bottom_area">
		<!-- 리뷰점수  -->
		<div id="movie_score">

			<h3>Movie Score</h3>
	
			<!--점수표시 이미지-->
			<div>
			
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
			<div id="user_score_wrapper" style="display:flex; justify-content:space-between;">
				<h3>User Score</h3> <div id="write_review"><a href="/view_review?movieId=${view.movieId}">Write a Review</a></div>
			</div>
			
			<div id="score_distribution_wrapper" style="display:flex; justify-content:space-between;">
				
				<div style="display:flex;flex-direction:column;">
					<!--점수표시 이미지-->
					<div class="rating_circle_average" style="margin-top:40px;">
					${scoreAverage}
					</div>
					<div style="font-weight:bold;font-size:15px;">
					Score Average
					</div>
					<!--점수표시 이미지 끝-->
				</div>
				
				<!-- 점수 분포도 -->
				<div class="score_distribution_area">		
					<canvas id="myChart"></canvas>
				</div>
				<!-- 점수 분포도 -->
				
				<script>
					var ctx = document.getElementById('myChart').getContext('2d');
					var chart = new Chart(ctx, {
						type:	'horizontalBar',
						data:{
							labels:	['Positive', 'Mixed', 'Negative'],
							datasets:	[{
								label : 'Preference Distribution',
								backgroundColor: [
									'rgba(50, 255, 50, 1)',
									'rgba(255, 150, 80, 1)',
									'rgba(255, 30, 30, 1)'
									],
						        borderColor: 'rgb(255, 99, 132)',
						        data: [${positiveCount}, ${mixedCount}, ${negativeCount}]
							}]
						},
						options: {
					        scales	: { //X,Y축 옵션
					            xAxes: [{
					                ticks: {
					                    beginAtZero:true  //Y축의 값이 0부터 시작
					                }
					            }]
					        }
					    }
					})
				</script>
				
			</div>
			

			
			<h2>User Reviews</h2>
	
			<c:forEach items="${reviewList}" var="reviewList" begin="0" end="5">
			<div class="critic_reviews">
					<div class="rating_circle_average" style="width:38px;height:38px; font-size:25px;">${reviewList.rating}</div>
					<div style="display:flex; flex-direction:column; padding:7px 0 0 20px;">
	  					<div>
						 	작성자 : ${reviewList.writer}
						</div>
						<div>
	   						<span style="font-size:14px; color:#999;"><fmt:formatDate value="${reviewList.registerDate}" pattern="yyyy.MM.dd"/></span>
	 					</div>
 					</div>
  
  					<p style="padding-left:8px;padding-bottom:50px;">${reviewList.content}</p>
 			</div>
 			</c:forEach>   

			<div style="text-align:center; font-size:18px; border:1.5px solid #888; padding:10px 0 10px 0; margin: 30px 30px;">
				<a href="/view_review?movieId=${view.movieId}"
				style="text-decoration:none; color:black; font-weight:bold;">SEE ALL ${totalCount} REVIEWS</a>
			</div>							
		

		</div>
		<!-- 리뷰점수 -->
	</div>
	<!-- bottom_area-->
	
	

</div>

<!--전체 레이아웃 끝-->

		<!--	div박스 아래 값을 가져오고 그값을 범위에따라 div background 색상을 삽입한다. -->
		<script>
		window.onload = function(){
			var scoreAverageDIV= document.getElementsByClassName("rating_circle_average");
			console.log("scoreAverageDIV="+scoreAverageDIV);
			for(var i=0; i < scoreAverageDIV.length; i++){
				var scoreAverage = scoreAverageDIV[i].innerHTML;
				if(scoreAverage <=3 && scoreAverage>=0){
					scoreAverageDIV[i].style.backgroundColor = "red";
				}
				else if(scoreAverage <=6){
					scoreAverageDIV[i].style.backgroundColor = "orange";
				}
				else if(scoreAverage <=10){
					scoreAverageDIV[i].style.backgroundColor = "#1aff00";
				}
				else if(scoreAverage.equals("")){
					scoreAverageDIV[i].style.backgroundColor = "#000";
				}
			}
					
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
			                    document.getElementById(id).style.backgroundColor = "#1aff00";
			                }
			            }
			        }
			        circle.onmouseout = function(e){
			            if(markScore == null){
			                var score = this.innerHTML;
			                for(var i=0; i <= score; i++) {
			                    var id = "ratingCircle_" + i;
			                    document.getElementById(id).style.backgroundColor = "#000";
			                }
			            }else{
			                for(var i=10; i >markScore; i--){
			                    var id = "ratingCircle_" + i;
			                    document.getElementById(id).style.backgroundColor = "#000";
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

</body>
</html>