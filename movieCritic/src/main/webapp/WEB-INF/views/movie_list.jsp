<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%-- uri에 jsp 유무 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="/resources/css/common.css"/>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="/resources/jquery/jquery-3.4.1.min.js"></script>
<title>Browse movie</title>
<style>

#middle_wrapper{
	width:100%;
	max-height:80%;
}

#select_wrapper{
	display:flex;
	justify-content:space-around;
	align-items:center;
	width: 60%;
	margin-top: 50px;
	margin-left: 18%;
}

#board_wrapper{
	display:flex;
	justify-content:space-around;
	align-items:center;
	width: 60%;
	margin-top: 50px;
	margin-left: 18%;


}

table{
	width:100%;		/* width, height를 비율로 정의하는 것은 부모요소에 영향을 받음  */
	height:60%;
}
td{
	text-align:left;
	padding-left: 10px;
}

tr:nth-child(n+2):hover{		/* tr,td행은 1부터 시작. n은 0부터..*/
	background:#fff9f2;
}

th, td:nth-child(n){
	border-bottom:1px solid #ccc;
}

th{
	padding-bottom:13px;	
}

th:nth-of-type(1), th:nth-of-type(2){
	text-align:center;
}

td:nth-of-type(1){
	text-align:center;
	width:5%;
	height:2%;
}
td:nth-of-type(2){
	width:5%;
	height:2%;

}
td:nth-of-type(3){
	width:40%;
	height:2%;
}
td:nth-of-type(4){
	width:20%;
	height:2%;
}
td:nth-of-type(5){
	width:20%;
	height:2%;
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


.select_label{
	display:block;
	padding-bottom:5px;
}

.rating_circle_average{
    border-radius: 50%;
    height: 28px;
    width: 28px;
    text-align: center;
    background-color: #eee;
    color:#fff;
    cursor:pointer;
    float:left;
    margin:12px 0px 12px 12px;
    font-size:14px;
    font-weight:1000px;
    padding-top:5px;
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
		<h1 style="width:100%;padding-top:50px;padding-left:18%;">Browse Movie</h1>
		
		<!-- select Wrapper 시작 -->
		<div id="select_wrapper">

			<div id="select1">
				<label for="genre" class="select_label">Genre</label>
				<select name="genre" id="genreSelect" class="select_option">
					<option value="">All Genre</option>
					<option value="Action">Action</option>
					<option value="Drama">Drama</option>
					<option value="Fantasy">Fantasy</option>
				</select>
			</div>

			<div id="select2">
				<label for="timeframe" class="select_label">Release Date</label>
				<select name="timeframe" id="releaseDateCondition" class="select_option">
					<option value="">All Time</option>
					<option value="2019">2019</option>
					<option value="2018">2018</option>
					<option value="2017">2017</option>
				</select>
			</div>

			<div id="select3">
				<label for="sort" class="select_label">Sort</label>
				<select name="sort" id="sortCondition" class="select_option">
					<option value="score">Score</option>
					<option value="A_Z">A-Z</option>
					<option value="release_date">Release Date</option>
				</select>
			</div>
		</div>
		<!-- select Wrapper 끝 -->
		
		<div id="board_wrapper">

			<table id="tableBoard">
				<tr>
					<th>Number</th><th>Score</th><th>Title</th><th>Genre</th><th>Release Date</th>
				</tr>
<%--${((criteria.nowPage)-1)*criteria.perPageNumber+status.count} --%>		
					<c:forEach items="${list}" var="list" varStatus="status"> 
					<tr>
						<td>${((criteria.nowPage)-1)*criteria.perPageNumber+status.count}</td>
						<td>
							<div class="rating_circle_average" style="margin-right:20px;font-weight:bold;">
								<fmt:formatNumber value="${list.scoreAverage}" pattern="0.0"/>
							</div>
						</td>
						<td><a href="/movie_info/view?movieId=${list.movieId}">${list.title}</a></td>
						<td>${list.genre}</td>
						<td><fmt:formatDate value="${list.releaseDate}" pattern="yyyy.MM.dd"/></td>
					</tr>
					</c:forEach>		
			</table>
		</div>
		
				<div style="margin:5% 0 5% 40%;">
					<ul class="btn-group pagination">
			    		<c:if test="${pageMaker.prev}">
			    		<li>
			        		<a href='<c:url value="/movie_list?nowPage=${pageMaker.startPage-1 }"/>' role="button" class="btn btn-default btn-sm">><i class="fa fa-chevron-left"></i></a>
			    		</li>
			    		</c:if>
			    		
			    		<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="pageNumber">
			    		<li>
			        		<a href='<c:url value="/movie_list?nowPage=${pageNumber}"/>'><i class="fa">${pageNumber}</i></a>
			    		</li>
			    		</c:forEach>
			    
			    		<c:if test="${pageMaker.next && pageMaker.endPage >0 }">
			   			<li>
			        		<a href='<c:url value="/movie_list?nowPage=${pageMaker.endPage+1}"/>' role="button" class="btn btn-default btn-sm">><i class="fa fa-chevron-right"></i></a>
			    		</li>
			    		</c:if>
					</ul>
				</div>
	</div>
	<!-- middle Wrapper 끝 -->
	
	
</div>

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
			  
			}
			<!--검색-->
$(document).ready(function(){
	$(".select_option").change(function(){
		var genre = $("#genreSelect").val();
		var releaseDate = $("#releaseDateCondition").val();
		var sortCondition = $("#sortCondition").val();
		
		var conditionData = { "genre": genre, "releaseDate": releaseDate, "sortCondition":sortCondition };
				
		$.ajax({
            url:"movie_list.getConditionalList",
            type: 'GET',
            data: conditionData,
            datatype: "json",
            success: function(data){
            	
					var html = "<tr>\
						<th>Number</th><th>Title</th><th>Genre</th><th>Release Date</th>\
						</tr>";
					for (var i=0; i<data.length; i++){
						html += "<tr><td>${status.count}</td><td>"	+data[i].title+"</td><td>"+
						data[i].genre+"</td><td>"+data[i].releaseDate+"</td></tr>";
					}
					
         			$("#tableBoard").html(html);	
			}
        })
	})
})
			<!--검색-->
</script>
</body>
</html>