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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="/resources/jquery/jquery-3.4.1.min.js"></script>
<script src="/resources/css/common.js"></script>
<title>Browse movie</title>
<style>

#middle_wrapper{
	width:100%;
	max-height:75%;
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

.paging_ul{
	text-align:center;
	padding-top: 30px;
	padding-right:6%;
}
.paging_li{
	display:inline;
	vertical-align:middle;
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
			<img src="/resources/image/logo.jpg" alt="MovieCritic" onclick="goIndex()">
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
	
	<div id="main_wrapper" style="border: 1px solid black;">
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
				<select name="releaseDateCondition" id="releaseDateCondition" class="select_option">
					<option value="">All Time</option>
					<option value="last90days">last90days</option>
					<option value="2020">2020</option>
					<option value="2019">2019</option>
					<option value="2018">2018</option>
					<option value="2017">2017</option>
				</select>
			</div>

			<div id="select3">
				<label for="sort" class="select_label">Sort</label>
				<select name="sortCondition" id="sortCondition" class="select_option">
					<option value="release_date">Release Date</option>
					<option value="A_Z">A-Z</option>
					<option value="score">Score</option>
				</select>
			</div>
		</div>
		<!-- select Wrapper 끝 -->
		
		<div id="board_wrapper">

			<table id="tableBoard">
		
			</table>
		
		</div>
		<div>
			<ul id="pagingUL" class="paging_ul">
			    		
			</ul>
		</div>
		
		<!-- paging wrapper -->
		
				
	</div>
	<!-- middle Wrapper 끝 -->
	
	
</div>

<script type="text/javascript">


var currentPageNum = 0;
var currentGenre;
var currentReleaseDate;
var currentSortCondition;

var coloring = function coloring(){
	var scoreAverageDIV= document.getElementsByClassName("rating_circle_average");
	for(var i=0; i < scoreAverageDIV.length; i++){
		var scoreAverage = scoreAverageDIV[i].innerHTML;
		if(scoreAverage <= 3 && scoreAverage >= 0){
			scoreAverageDIV[i].style.backgroundColor = "red";
		}
		else if(scoreAverage <=6){
			scoreAverageDIV[i].style.backgroundColor = "orange";
		}
		else if(scoreAverage <=10){
			scoreAverageDIV[i].style.backgroundColor = "#1aff00";
		}
		else if(scoreAverage == ""){
			scoreAverageDIV[i].style.backgroundColor = "#000";
		}
	}
};

var setPageNum = function setPageNum(pageNum){
	currentPageNum = (pageNum - 1)*10;
	getpage();	
};

var getpage= function(){
	
	var genre = $("#genreSelect").val();
	var releaseDate = $("#releaseDateCondition").val();
	var sortCondition = $("#sortCondition").val();
	var pageNum = currentPageNum;
	
	if (genre != currentGenre || releaseDate != currentReleaseDate || sortCondition != currentSortCondition){
		pageNum = 0
	}
	
	var conditionData = { "genre": genre, "releaseDate": releaseDate, "sortCondition":sortCondition, "pageNum":pageNum };
		
	currentGenre = genre;
	currentReleaseDate = releaseDate;
	currentSortCondition = sortCondition;
		
	$.ajax({
    	url:"movie_list.getPageTotal",
        type: 'GET',
        data: conditionData,
        datatype: "integer",
        success: function(data){
        	
  				var html = "";
  				var pno = (pageNum/10)+1;
  				pno = pno - 4
  				
  				if(pno>1){
  					html+="<li style='margin-right:30px;' type=button class='btn btn-default color-blue paging_li' onclick='setPageNum(this.innerHTML)')>1</li>";
  				}
  				if(pno<=0){
  					pno = 1;
  				}
  				
				for (var i=0; i<9 && pno*10 <= data; i++){
					html += "<li type=button class='btn btn-default color-blue paging_li' onclick='setPageNum(this.innerHTML)')>"+pno+"</li>";					
					pno = pno + 1;
				}
				if (pno*10 <=data){
					html += "<li style='margin-left:30px' type=button class='btn btn-default color-blue paging_li' onclick='setPageNum(this.innerHTML)')>"+Math.floor((data/10)+1)+"</li>";		
				}
				
  			$("#pagingUL").html(html);
        }
	}) 	
			
	$.ajax({
        url:"movie_list.getConditionalList",
        type: 'GET',
        data: conditionData,
        datatype: "json",
        success: function(data){
				var html = "<tr>\
					<th>Number</th><th>Score</th><th>Title</th><th>Genre</th><th>Release Date</th>\
					</tr>";
					
				var len = data.length;	
				pageNum = Number(pageNum);
				var no = pageNum + 1;	
				for (var i=0; i<len; i++){
					var scoreAverage = data[i].scoreAverage;
					scoreAverage = scoreAverage.toFixed(1);
				
					var date = new Date(data[i].releaseDate);
					var year = date.getFullYear();
					var month = date.getMonth()+1;
					var day = date.getDate();
					if(month < 10){
				        month = "0"+month;
				    }
				    if(day < 10){
				        day = "0"+day;
				    }
				    var release = year+"-"+month+"-"+day;
							
					html += "<tr><td>"+no+"</td>" +
                        "<td><div class='rating_circle_average' style='margin-right:20px;font-weight:bold;'>" +
                        scoreAverage+"</div></td>"+
                        "<td><span style='cursor:pointer;line-height:35px;' onclick='location.href=\"/movie_info/view?movieId="+
                        data[i].movieId+"\"'>" + 
                        data[i].title+"</span></td><td>"+data[i].genre+"</td><td>"+release+"</td></tr>";
                        
                        no = no+1;
					}
				
				$("#tableBoard").html(html);
				
				coloring();
   		  }
    })
};


$(document).ready(function(){
	$("#genreSelect option[value='${genre}']").attr("selected", "selected");
	$("#releaseDateCondition option[value='${releaseDate}']").attr("selected", "selected");
	$("#sortCondition option[value='${sortCondition}']").attr("selected", "selected");
	
	getpage();
	coloring();
	SCBoxActivation();	

	$(".select_option").change(function(){
		getpage();
	})	
})
	


</script>
</body>
</html>