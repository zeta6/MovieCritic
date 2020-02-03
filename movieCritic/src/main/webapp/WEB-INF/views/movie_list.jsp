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
<title>Browse movie</title>
<style>

#middle_wrapper{
	width:100%;
	max-height:80%;
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

#board_wrapper{
	display:flex;
	justify-content:space-around;
	align-items:center;
	width: 1000px;
	margin-top: 50px;
	margin-left: 310px;
	border:1px solid blue;

}

table{
	width:100%;		/* width, height를 비율로 정의하는 것은 부모요소에 영향을 받음  */
	height:60%;
}
td,th{
	text-align:left;
	padding-left: 20px;
}

td:nth-child(n+1){

	border:1px solid red;
}

td:nth-of-type(1){
	width:10%;
	height:2%;
}
td:nth-of-type(2){
	width:35%;
	height:2%;
}
td:nth-of-type(3){
	width:20%;
	height:2%;
}
td:nth-of-type(4){
	width:35%;
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
		
		<!-- select Wrapper 시작 -->
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
		<!-- select Wrapper 끝 -->
		
		<div id="board_wrapper">
	
			<table>
				<tr>
					<th>Number</th><th>Title</th><th>Genre</th><th>Release Date</th>
				</tr>
			<%--서버에서 넘어온 변수 두개 사용하는 방법 --%>
				<c:forEach items="${list}" var="list" varStatus="status"> <%-- items 에는 속성명을 적어줌 --%>
					<tr>
						<td>${boardNumber[status.index]}</td>
						<td><a href="/movie_info/view?movieId=${list.movieId}">${list.title}</a></td>
						<td>${list.genre}</td>
						<td><fmt:formatDate value="${list.releaseDate}" pattern="yyyy.MM.dd"/></td>
					</tr>
				</c:forEach>
			
							<%--<c:forEach items="${list}" var="list" varStatus="status"> items 에는 속성명을 적어줌  (varStatus로 처리하는 법)
							<tr>
								<td>${status.count}</td><td>${list.title}</td><td>${list.genre}</td><td>${list.registerDate}</td>
							</tr>
							</c:forEach>--%>		
			</table>
		</div>
	</div>
	<!-- middle Wrapper 끝 -->
	
	
</div>
</body>
</html>