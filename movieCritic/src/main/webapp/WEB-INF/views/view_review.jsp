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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.12.1/css/all.css">
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
<style>

#main_wrapper_area{
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

.review_input_area{
	background:#fffcf9;;
	margin-top:20px;
	padding: 8px 18px;
}

.ratingCircle{
    border-radius: 50%;
    height: 28px;
    width: 28px;
    text-align: center;
    background-color: #555;
    color:white;
    cursor:pointer;
}

#review_menu_list{
	list-style-type:none;
	display:flex;
	justify-content:flex-end;
	align-items:center;
	border:1px solid blue;
	margin-top:-30px;
	font-size:14px;
}

.review_menu_item{
	padding-right:8px;
}

.rating_circle_average{
    border-radius: 50%;
    height: 70px;
    width: 70px;
    text-align: center;
    background-color: #eee;
    color:white;
    cursor:pointer;

    margin:12px 0px 12px 12px;
    font-size:40px;
    font-weight:1000px;
}

.critic_reviews{
	height: 15%;
	border-bottom:1px solid #aaa;
	word-break:break-all;
	padding:20px 0;
}
.score_distribution_area{
	margin:0;
	padding:0;
	width:60%;
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

	<h1 style="padding:0; margin:0; display:inline;"> <a href="movie_info/view?movieId=${view.movieId}">${view.title}</a></h1>   
	<h5 style="padding:0 8px; margin:0; display:inline;">${view.genre} | <fmt:formatDate value="${view.releaseDate}" pattern="yyyy.MM.dd"/></h5>
	
	<!-- middle menu bar-->
	<div>		
			
		<div>

			<div id="score_distribution_wrapper" style="display:flex; justify-content:space-between;">

					<div style="padding-top:10px;">
						<!--점수표시 -->
						<div class="rating_circle_average">
							${scoreAverage}
						</div>
						<!--점수표시 -->
					
					</div>	
					<div style="padding-top:20px;">
						<span style="font-weight:bold;font-size:15px;line-height:40px;">
							Score Average
							<br/>
							based on ${totalCount} Ratings
						</span>
					</div>

				
				<!-- 점수 분포도 -->
				<div class="score_distribution_area">		
					<canvas id="myChart" style="width:400px; height:120px;"></canvas>
				</div>
				<!-- 점수 분포도 -->

			</div>				

		</div>			
		
	</div>
	<!-- middle menu end-->

	<!-- 리뷰 입력 -->
	<div class="review_input_area">
		<div class="inner_header">
			
			<div style="display: flex;justify-content:space-between;">
					<h5> REVIEW THIS MOVIE</h5>
		 			<h6 style="margin-right:-140px;"> VOTE NOW </h6>	
 				
				<div style="display:flex;padding:10px 0;">
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

		<div>
			<form action="/view_review" method="post"> 
				<textarea cols="95" rows="5" maxlength="500" name="content"></textarea>	<%--name에 정해진 값은 변수로 요청에 파라미터를 보냄 --%>
				<input type="hidden" value="${view.movieId}" name="movieId"/>
				<input type ="hidden" name="rating" id="markRating" />
				<input type="submit" value="submit" style="background:#555; color:white; margin-left:85%;"/>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			</form>
		</div>

	</div>
	<!-- 리뷰 입력 끝 -->

	<!-- 유저 리뷰 목록-->
	<div class="review_area" style="margin-top:5%;">

			<h2>User Reviews</h2>
	
			<c:forEach items="${list}" var="list" varStatus="status">
			<div class="critic_reviews">

			
				<div style="display:flex;">
					<div class="rating_circle_average" style="width:38px;height:38px; font-size:25px;">${list.rating}</div>
					<div style="display:flex; flex-direction:column; padding:7px 0 0 20px; width:90%; margin:6px 5px;">
	  					<div>
						 	작성자 : ${list.writer}
						 	<sec:authentication property="principal" var="principal"/>
						 	<c:if test="${list.writer eq principal.memberId}">
								<a href="/view_review?movieId=${view.movieId}/deletion" style="display:inline;">
									<span style="float:right;font-weight:bold; height:15px; font-size:12px;">
										<i class="far fa-trash-alt" style="color:black; font-weight:bold;"></i>
									</span>
								</a>
								<a href="/view_review?movieId=${view.movieId}/update" style="display:inline;">
									<span style="float:right; font-weight:bold; height:15px; font-size:12px; width:30px;">
										<i class="far fa-edit" style="color:black; font-weight:bold;"></i>
									</span>
								</a>
							</c:if>
						</div>
			
	
						<div>
	   						<span style="font-size:14px; color:#999;"><fmt:formatDate value="${list.registerDate}" pattern="yyyy.MM.dd"/></span>
	 					</div>
 					</div>
  				</div>
  					<p style="padding-left:13px;padding-bottom:30px;">${list.content}</p>
 			</div>
 			</c:forEach>
 			
			<div style="margin:5% 0 5% 40%;">
			<ul class="btn-group pagination">
	    		<c:if test="${pageMaker.prev}">
	    		<li>
	        		<a href='<c:url value="/view_review?movieId=${view.movieId}&nowPage=${pageMaker.startPage-1 }"/>' role="button" class="btn btn-default btn-sm"><i style="font-size:18px;" class="fa fa-angle-left"></i></a>
	    		</li>
	    		</c:if>
	    		
	    		<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="pageNumber">
	    		<li>
	        		<a href='<c:url value="/view_review?movieId=${view.movieId}&nowPage=${pageNumber}"/>'><i class="fa">${pageNumber}</i></a>
	    		</li>
	    		</c:forEach>
	    
	    		<c:if test="${pageMaker.next && pageMaker.endPage >0 }">
	   			<li>
	        		<a href='<c:url value="/view_review?movieId=${view.movieId}&nowPage=${pageMaker.endPage+1}"/>' role="button" class="btn btn-default btn-sm"><i style="font-size:18px;" class="fa fa-angle-right"></i></a>
	    		</li>
	    		</c:if>
			</ul>   
			</div>

	</div>
	<!-- 유저 리뷰 목록 끝-->

</div>

<!-- 컨텐츠 끝-->
</div>
<!-- 전체 레이아웃 끝-->
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
			                    document.getElementById(id).style.backgroundColor = "#555";
			                }
			            }else{
			                for(var i=10; i >markScore; i--){
			                    var id = "ratingCircle_" + i;
			                    document.getElementById(id).style.backgroundColor = "#555";
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
		responsive: false,
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


</body>
</html>


