<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="/resources/css/common.css"/>
<title>My Page</title>
<script src="/resources/jquery/jquery-3.4.1.min.js"></script>
<style>

#main_setting_area{
	margin: 70px 300px 100px;
	border: 1px solid white;
	font-size: 13px;
	width:50%;
	height:100%;
}

.main_inner_area{
	border-bottom: 1px solid #aaa;
	padding:30px 7px;
	height: 80px;
	padding-left:15px;
}

.content_left_area{
	float:left;
	padding-left: 5px;
	width: 20%;
}

.content_right_area{
	float:left;
	padding-left: 25px;
	width:20%px;
}

input {
	margin-bottom:8px;
	
	background: white;
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


<div id="main_setting_area">

	<h3>ACCOUNT SETTINGS</h3>

	<form name="myPageForm" action="${rootPath}/member/updateMyPage" method="post">
	<div class="main_inner_area">
		<div class="content_left_area">PROFILE IMAGE</div>

		<div class="content_right_area"><img src="${rootPath}/resources/image/profile.png"></div>
		
		<div class="content_right_area"><input type="file" value="파일 선택" id="profile"></div>

  								</div>

	<div class="main_inner_area">
		<div class="content_left_area">NICKNAME</div>
		<div class="content_right_area">
			<input type="text" placeholder="change" value="<sec:authentication property="principal.nickname"/>" id="nickname" name="nickname">
			<span id="nickCheck"></span>
		</div>
		
	</div>

	<div class="main_inner_area">
		<div class="content_left_area">ID</div>
		
		<div class="content_right_area"> <sec:authentication property="principal.username" /> </div>
	</div>

	<div class="main_inner_area">
		<div class="content_left_area">PW</div>
	
		<div class="content_right_area">								<%--binding 위해서 id명 memberPw로 변경 --%>
			<div>
				<input type="password" placeholder="current password" id="memberPw">
				<span id="currentPw"></span>
			</div> 

			<div>
				<input type="password" placeholder="new password" id="newPassword">
				<span id="newCheck"></span>
			</div>
			<div>
				<input type="password" placeholder="verify password" id="verifyPassword" name="memberPw">
				<span id="verifyCheck"></span>
			</div>
			
		</div>
	</div>

	<div class="main_inner_area">
		<div class="content_left_area">EMAIL</div>

		<div class="content_right_area"> 
			<div>
				<input type="text" value="<sec:authentication property="principal.email" />" id="email" name="email"/>
				<span id="emailCheck"></span>
			</div> 
		</div>
	</div>

	<div class="main_inner_area">
		<div class="content_left_area">PHONE</div>

		<div class="content_right_area">
			<div>
				<input type="text" value="<sec:authentication property="principal.phoneNumber"/>" id="phoneNumber" name="phoneNumber"/>
				<span id="phoneCheck"></span>
			</div>  
		</div>
	</div>
	
	<sec:csrfInput/>
	<button type="button" onclick="changeInfo()" style="display:inline-block; float:right; background-color:orange;font-weight:bold;">change</button>
	<button type="button" style="display:inline-block; float:left; background-color:yellow;font-weight:bold;" onclick="deactive()">deactivate</button>
	</form>
	
</div>

<!--main_setting.. 끝-->

</div>
<!--site_layout 끝-->
<!-- 스크립트 위치가 너무 중요하다.. 위치에 따라서 실행이 되고 안되고. -->
<script>
var pwCheck = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*()\-\[\]?<>\;])*([A-Za-z\d!@#$%^&*()\-\[\]?<>;]){8,20}$/;
var nickCheck = /^[a-zA-Z0-9]{2,12}$/;
var emailCheck = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/;
var phoneCheck = /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/;

var changeInfo = function(){
		var myPageForm = document.myPageForm;
		var nickname = myPageForm.nickname.value;
		var memberPw = myPageForm.memberPw.value;
		var email = myPageForm.email.value;
		var phoneNumber = myPageForm.phoneNumber.value;
		
		if(!nickname || !email || !phoneNumber){
			console.log("memberPw check: " + memberPw);
			alert("please fill in all blanks ")
		} else{
			myPageForm.submit();
		}
	};

var deactive = function(){
	if(confirm("deactive?") == true){
		location.href="/member/deactivate";
	}
	else{
		return;
	}	
};

$(document).ready(function(){
	
	$("#profile").change(function(){
			if(this.files && this.files[0]) {
			var reader = new FileReader;
			reader.onload = function(data) {
					$(".content_right_area img").attr("src", data.target.result).width(100).height(100);
					$(".content_right_area").css("display", "inline-block");
			}
	    	reader.readAsDataURL(this.files[0]);
			}
		});
	
	$("#memberPw").blur(function(){
		var currentPw = $("#memberPw").val();
		$.ajax({
				url:"/member/my_page/passwordCheck",
				type:"GET",
				data:{"memberPw":currentPw},
				datatype:"String",
				success: function(msg){
					console.log("success");
					$("#currentPw").text(msg);
					$("#currentPw").css("color", "red");	//자바스크립트 .style <-> jquery .css
					if(msg=="currentPassword is authenticated !"){
						console.log("authenticated");
						$('#newPassword').prop('disabled', false);
						$('#verifyPassword').prop('disabled', false);
						$('#newPassword').focus();
					} else{
						console.log('not authenticated')
						$('#newPassword').prop('disabled', true);
						$('#verifyPassword').prop('disabled', true);
					}
				}
			
		});
	});
	
	$('#newPassword').blur(function(){
		var pwCheck = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*()\-\[\]?<>\;])*([A-Za-z\d!@#$%^&*()\-\[\]?<>;]){8,20}$/;
	    if(pwCheck.test($('#newPassword').val())){
			console.log('true');
			$('#verifyPassword').prop('disabled', false);
			$('#newCheck').text('');
			
			return true;
	    } else {
			console.log('false');
			$('#newCheck').text(' at least one number and (capital or small letter) and special characters only 4~12 characters');
			$('#newCheck').css('color', 'red');
			$('#newCheck').css('font-size', '12px');
			$('#verifyPassword').prop('disabled', true);
			return false;
	    }
	});
	
	
	/* ajax에서 데이터 보낼 타입이 리스트인지 json인지 ,,, 컨트롤러에서 인자를 받을 타입이 json인지 리스트인지 명확하게 정해서 방향을 설정해야함 . */
	$("#verifyPassword").blur(function(){
		var newPassword = $("#newPassword").val();
		var verifyPassword = $("#verifyPassword").val();
		console.log(verifyPassword);
		$.ajax({
			url:"/member/my_page/verifyPassword",
			type:"GET",
			data:{"newPassword" : newPassword,
				  "verifyPassword" : verifyPassword
				  },
			dataType:'text',	//String 에러.. text로 고치니까 됨 		object mapper 이용해서 변환을 해줘야함.. ""이 빠짐. 
			success: function(data){
				console.log("success");
				$("#verifyCheck").text(data);
				$("#verifyCheck").css("color", "red");

			},
			error: function(request, status, error){
				console.log("fail");
				console.log("code : "+request.status+ "\n" + "message: " + request.	responseText + "\n" + "error : "+ error);
			}
		});

		
	});
	
	
	$('#nickname').blur(function(){
		console.log('nickname in');
	   	if(nickCheck.test($('#nickname').val())){
			console.log('true');
			$('#nickCheck').text('');
			return true;
	    } else {
			console.log('false');
			$('#nickCheck').text(' number or Alphabet only 2~12characters');
			$('#nickCheck').css('color', 'red');
			$('#nickCheck').css('font-size', '12px');
			return false;
	    }
	});

	$('#email').blur(function(){
	    if(emailCheck.test($('#email').val())){
			console.log('true');
			$('#emailCheck').text('');
			return true;
	    } else {
			console.log('false');
			$('#emailCheck').text(' please check your email');
			$('#emailCheck').css('color', 'red');
			$('#emailCheck').css('font-size', '12px');
			$('#email').focus();
			return false;
	    }
	});


	$('#phoneNumber').blur(function(){
	    if(phoneCheck.test($('#phoneNumber').val())){
			console.log('true');
			$('#phoneCheck').text('');
			return true;
	    } else {
			console.log('false');
			$('#phoneCheck').text(' please check your phone number');
			$('#phoneCheck').css('color', 'red');
			$('#phoneCheck').css('font-size', '12px');
			$('#phoneNumber').focus();
			return false;
	    }
	});
	
})

</script>
<%-- 정보 수정 후에 다시 로그인해야 정보가 업데이트 됨 --%>

</body>

</html>