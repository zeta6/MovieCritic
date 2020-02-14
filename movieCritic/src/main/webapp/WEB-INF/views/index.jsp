<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Welcome MovieCritic</title>
<link rel="stylesheet" type="text/css" href="/resources/css/common.css">
<script src="/resources/jquery/jquery-3.4.1.min.js"></script>
<style>

#posters{
	display:flex;
	justify-content:center;
	align-items:center;
}

div[id^=movie]{
	margin-left:10px;
	margin-top: 30px;
}

#board{
	display:flex;
	justify-content:center;
	align-items:center;
}



section[id^=board]{
	margin-left: 100px;
	margin-right: 100px;
}

.line{
	border-bottom: 2px solid lightgray;
}

#searchResultsListDiv{
	width: 10%;
	position:absolute;
	background-color:white;
}
#searchResultsListDiv:hover{
box-shadow : rgba(0,0,0,0.5) 0 0 0 9999px;

z-index : 100;
}

#searchResultsListDiv span:hover{
	background:#eee;
}

tr,td,th {

	text-align:left;
	padding-right:80px;
}

.rating_circle_average{
    border-radius: 50%;
    height: 20px;
    width: 24px;
    text-align: center;
    background-color: #eee;
    color:#fff;
    cursor:pointer;
    float:left;
    margin:0px 0px 0px 12px;
    font-size:12px;
    font-weight:1000px;
    padding-top: 3px;
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
		<a href="${rootPath}"><img src="/resources/image/logo.jpg" alt="MovieCritic"></a>
		</li>
		<li class="left_menu">
			<a href="${rootPath}/movie_list" class="top_text1">Browse Movies</a>
				
				<ul id="genre_sub">			<!-- select 기준 적용된 페이지 호출.. -->
					<li class="left_inner_menu"><a href="/movie_list?genre=Action" class="top_text3">Action</a></li>
					<li class="left_inner_menu"><a href="/movie_list?genre=Drama" class="top_text3">Drama</a></li>
					<li class="left_inner_menu"><a href="/movie_list?genre=Fantasy" class="top_text3">Fantasy</a></li>
				</ul>
				
		</li>
		</ul>
		</nav>
		<nav id="top_menu2">
			
			<div id="form" class="right_menu">
	
					
					<input type="text" placeholder="Search" class="top_text2" id="search" autocomplete="off">
					<div id="searchResultsListDiv"></div>
			
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
	
	<div id="main_wrapper">

	<!-- 영화 포스터-->		
	<div id="posters">
		<c:forEach items="${list2}" var="list2" begin="0" end="3">
			<div>
			<a href="/movie_info/view?movieId=${list2.movieId}">
				<img src="${list2.thumbNail}">
			</a>		
			</div>
		</c:forEach>
	</div>
	<!-- 영화 포스터 끝-->


<!-- 하단 게시판-->
	<div id="board">

		<section id="board_now">
		<h2 class="line">AVAILABLE NOW</h2>
		<table>			
			<tbody>
	
				<c:forEach items="${list}" var="list">
					<tr>
						<td>
							<div class="rating_circle_average" style="margin-right:20px;font-weight:bold;">
								<fmt:formatNumber value="${list.scoreAverage}" pattern="0.0"/>
							</div>
						</td>
						<td><span style="cursor:pointer; margin-right:20px;" onclick="location.href='/movie_info/view?movieId=${list.movieId}'">${list.title}</span></td>
						<td><span style="cursor:pointer;" onclick="location.href='/movie_info/view?movieId=${list.movieId}'"><fmt:formatDate value="${list.releaseDate}" pattern="yyyy.MM.dd"/></span></td>
					</tr>
				</c:forEach>
					<tr>
						<td>
						</td>
						<td>
						</td>
						<td>
						<div style="float:right; cursor:pointer;" onclick="location.href='/movie_list?sortCondition=releaseDate'">>view more</div>
						</td>
					</tr>	
  		 	</tbody>
  		 </table>
			
			
		</section>
		
		<section id="board_review">
		<h2 class="line">Recent Most Popular</h2>
				<table>			
			<tbody>
	
				<c:forEach items="${list2}" var="list2">
					<tr>
						<td>
							<div class="rating_circle_average" style="margin-right:20px;font-weight:bold;">
								<fmt:formatNumber value="${list2.scoreAverage}" pattern="0.0"/>
							</div>
						</td>
						<td><span style="cursor:pointer; margin-right:20px;" onclick="location.href='/movie_info/view?movieId=${list2.movieId}'">${list2.title}</span></td>
						<td><span style="cursor:pointer;" onclick="location.href='/movie_info/view?movieId=${list2.movieId}'"><fmt:formatDate value="${list2.releaseDate}" pattern="yyyy.MM.dd"/></span></td>
					</tr>
				</c:forEach>
					<tr>
						<td>
						</td>
						<td>
						</td>
						<td>
						<div style="float:right; cursor:pointer;" onclick="location.href='/movie_list?sortCondition=score&releaseDate=last90days'">>view more</div>
						</td>
					</tr>	
  		 	</tbody>
  		 </table>
	</section>
	</div>
	<!-- 하단 게시판 끝-->
	
	</div>
	<!-- main wrapper -->
</div>


<script type="text/javascript">

	
function hide(){
    var searchResultsListDiv = document.getElementById("searchResultsListDiv");
    searchResultsListDiv.style.display = "none";
}

function show(){
    var searchResultsListDiv = document.getElementById("searchResultsListDiv");
    searchResultsListDiv.style.display = "block";
}


$(document).ready(function(){
	

    var oldVal;
	
	var scoreAverageDIV= document.getElementsByClassName("rating_circle_average");
	console.log("scoreAverageDIV="+scoreAverageDIV);
	for(var i=0; i < scoreAverageDIV.length; i++){
		var scoreAverage = scoreAverageDIV[i].innerHTML;
		if(scoreAverage <=3 && scoreAverage >=0){
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
    
    $("#searchResultsListDiv").mouseover(function(){
    	$("#search").blur();
    	
    })
    $("#search").on("propertychange change keyup paste input", function() {
		
        var currentVal = $(this).val();
        if(currentVal == oldVal) {
            return;
        }else{
            $.ajax({
                url:"movie_list.search",
                type: "GET",
                data: {"searchKeyword" : currentVal},
                datatype: 'json',
                success: function(data){
                	show();
                    var searchedList = data;
                    var html = "";
                    for(i=0; i<searchedList.length; i++){
                        html += "<span style='cursor:pointer; line-height:35px;' onclick='location.href=\"/movie_info/view?movieId="+
                        		searchedList[i].movieId+"\"'>" +
                        		searchedList[i].title + "</span><br/>";
                    }			
                 
                    var searchResultsListDiv = document.getElementById("searchResultsListDiv");
                    searchResultsListDiv.innerHTML = html;
                    
                    if( currentVal === ""){
                    	hide();	
                    }
                    
                }
            })
    	}

	}) 

})


</script>

</body>
</html>
