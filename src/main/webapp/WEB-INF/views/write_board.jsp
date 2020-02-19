<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="/resources/css/jquerys.css">

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<%-- <meta id="_csrf" name="_csrf" content="${_csrf.token}" /> --%> 

<title> Write Board</title>
<script src="/resources/css/common.js"></script>
<script src="/resources/jquery/jquery-3.4.1.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>


<style>

#main_write_area{
	border:1px solid blue;
	margin:2% 10% 5% 10%;
}


#input_table {
	width:70%;
	margin:1% 15% 2% 15%;
	border: 1px solid #444444;
	border-collapse: collapse;
}

#input_table  td {
	border: 1px solid #444444;
	padding: 10px;
	width:15%;
	word-break:break-all;
}

#input_table td:nth-child(2n+1){
	background:#fee;
	width:30%;
}

#submit_btn_area{
	padding: 10px 0px 0px 575px;
	border: 1px solid red;
}

#submit_inner{
	background:transparent;
	background:#fbb;
	color:#000;
	border: 1px solid black;
}

/* 20200117 write_board.jsp movieImg 업로드 위해 추가함 - ohjin */
.select_img img { 
	margin:20px 0; 
}

</style>

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>


</head>
<body>

<!-- 절대 경로 -->
<c:set var="rootPath" value="${pageContext.request.contextPath}"/>

<div id="site_layout">

	<!-- 상단 메뉴-->

   <div id="top_menu_wrapper">
	<div id="top_menu">

		<nav id="top_menu1">
		<ul id="left_menu">
		
			<li class="left_menu">		
		<a href="/"><img src="/resources/image/logo.jpg" alt="MovieCritic"></a>
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
					<div id="searchResultsListDiv" onerror="this.style.visibility='hidden'"></div>
			
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


	<!-- 글쓰기 폼 시작-->

	<div id ="main_wrapper">
	<h2 style="text-align:center; margin-top:30px;">게시글 작성</h2>

		<div id="main_write_area">		

			<form method="post" enctype="multipart/form-data" action="/write_board?${_csrf.parameterName}=${_csrf.token}" onsubmit="return checkForm()">
			<%--컨트롤러에 인자가 안들어오는것 같은데.. csrf값은 확실히 나왔고. --%>
			
				<table id="input_table">
	
					<tr>
						<td> Title  </td>
						<td><input type="text" name="title" style="width:50%;" /> </td>
					</tr>
					<tr>
						<td> Starring  </td>
						<td><textarea name="starring" style="width:80%;"></textarea></td>
					</tr>
					<tr>
						<td> Genre  </td>
						<td><input type="text" name="genre"> </td>
					</tr>
					<tr>
						<td> Director  </td>
						<td><input type="text" name="director"> </td>
					</tr>
					<tr>
						<td> Runtime  </td>
						<td><input type="text" name="runtime" > </td>
					</tr>
					
					<tr>
						<td> Release Date  </td>
						<td><input id="datepicker" type="text" name="releaseDate"></td>
					</tr>
					<tr>
						<td> Summary  </td>
						<td><textarea cols="70" rows="10" maxlength="500" name="summary"></textarea> </td>
					</tr>
					<tr>
						<td>
						<div style="margin: 10px 0;">
 							<label for="poster">Poster</label>
 							<%= request.getRealPath("/") %>
						</div>
 						</td>
 						<td>
 							<input type="file" id="poster" name="file" />
 							<div class="select_img"><img src="" /></div>
 						</td>
 					</tr>
 					<tr> 
						<td>
						<div style="margin: 10px 0;">
 							<label for="stillCuts">StillCuts</label>
 						</div>
 						</td>
 						<td>
 							<input multiple="multiple" type="file" id="stillCuts" name="file" />
 							 <!-- for문을 교체!! -->
						
 							<div class="select_img2"><img src="" /></div>
 							<div class="select_img3"><img src="" /></div>
 							<div class="select_img4"><img src="" /></div>
						</td>
					</tr>
					
				</table>
				

				<div id="submit_btn_area">
					<input type="submit" value="저장"/>
					<sec:csrfInput/>
				</div>
				

			
	
			</form>
		</div>

	

	<!--글쓰기 폼 끝-->
	</div>

</div>
<script>


//check form releaseDate
var checkForm = function(){
	if(document.getElementById('datepicker').value == ""){
	document.getElementById('datepicker').disabled ='true';
	}
	return ture;
}


$(document).ready(function(){
	
	$("#datepicker").datepicker({
		changeYear: true,
		changeMonth: true,
	  	dateFormat: "mm/dd/yy",
	  	showOn: "both",
	  	buttonImage: "/resources/image/calendar.gif"
		});

	//search box activation		
	SCBoxActivation();	
	
	//upload image preview
	imagePreview();

	
})	

	
</script>

</body>
</html>