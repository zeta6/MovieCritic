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
<meta id="_csrf" name="_csrf" content="${_csrf.token}" /> 

<title>Insert title here</title>
<script src="/resources/jquery/jquery-3.4.1.min.js"></script>
<style>

#main_write_area{
	border:1px solid blue;
	margin:2% 10% 5% 10%;
}


#input_table {
	margin:20px;
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
<script>
$( function() {
  $( "#datepicker" ).datepicker();
  	dateFormat: 'yyyy.mm.dd'
  	showOn: "both"
  	buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif"
} );
</script>

</head>
<body>

<!-- 절대 경로 -->
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


	<!-- 글쓰기 폼 시작-->

	
	<h2 style="text-align:center; margin-top:30px;">게시글 작성</h2>

		<div id="main_write_area">		

			<form method="post" enctype="multipart/form-data">

			
				<table id="input_table">
	
					<tr>
						<td> Title  </td>
						<td><input type="text" name="title"> </td>
					</tr>
					<tr>
						<td> Starring  </td>
						<td><input type="text" name="starring"> </td>
					</tr>
					<tr>
						<td> Genre  </td>
						<td><input type="text" name="genre"> </td>
					</tr>
					<tr>
						<td> Release Date  </td>
						<td><input type="text" name="releaseDate" id="datepicker"> </td>
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
 							<script>
  								$("#poster").change(function(){
   									if(this.files && this.files[0]) {
    									var reader = new FileReader;
    									reader.onload = function(data) {
     										$(".select_img img").attr("src", data.target.result).width(50).height(50);
     										$(".select_img").css("display", "inline-block");
    									}
								    	reader.readAsDataURL(this.files[0]);
   									}
  								});
 							</script>
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
							<script>
  								$("#stillCuts").change(function(){
   									if(this.files[0] || this.files[1] || this.files[2]) {
    									var reader1 = new FileReader;
    									var reader2 = new FileReader;
    									var reader3 = new FileReader;
    									reader1.onload = function(data) {
     										$(".select_img2 img").attr("src", data.target.result).width(50).height(50);
     										$(".select_img2").css("display", "inline-block");
     									
    									}
    									reader2.onload = function(data) {
     								
     										$(".select_img3 img").attr("src", data.target.result).width(50).height(50);
     										$(".select_img3").css("display", "inline-block");
    									}
    									reader3.onload = function(data) {
     										
     										
     										$(".select_img4 img").attr("src", data.target.result).width(50).height(50);
     										$(".select_img4").css("display", "inline-block");
    									}
								    	reader1.readAsDataURL(this.files[0]);
								    	reader2.readAsDataURL(this.files[1]);
								    	reader3.readAsDataURL(this.files[2]);
   									}
  								});
  							
 							</script>
 							<div class="select_img2"><img src="" /></div>
 							<div class="select_img3"><img src="" /></div>
 							<div class="select_img4"><img src="" /></div>
						</td>
					</tr>
					
				</table>
				

				<div id="submit_btn_area"><input type="submit" value="작성"></input></div>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

			
	
			</form>
		</div>

	

	<!--글쓰기 폼 끝-->

</div>

</body>
</html>