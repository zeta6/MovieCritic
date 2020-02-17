function goIndex(){
	location.href="/";
};

//search box activation
var SCBoxHide = function(){
    var searchResultsListDiv = document.getElementById("searchResultsListDiv");
    searchResultsListDiv.style.display = "none";
    document.getElementById("main_wrapper").style.backgroundColor = "rgba(0,0,0,0.0)";
};

var SCBoxShow = function(){
    var searchResultsListDiv = document.getElementById("searchResultsListDiv");
    searchResultsListDiv.style.display = "block";
    document.getElementById("main_wrapper").style.backgroundColor = "rgba(0,0,0,0.5)";
};

var SCBoxActivation = function(){

    var oldVal;
  
    $("#searchResultsListDiv").mouseover(function(){
    	$("#search").blur();
    })
    
    $("#site_layout").click(function(){
    	document.getElementById("main_wrapper").style.backgroundColor = "rgba(0,0,0,0.0)";
    	SCBoxHide();
    })
    
    $("#search").on("propertychange change keyup paste input", function() {
		
        var currentVal = $(this).val();
        if(currentVal == oldVal) {
            return;
        }else{
            $.ajax({
                url:"/movie_list.search",
                type: "GET",
                data: {"searchKeyword" : currentVal},
                datatype: "json",
                success: function(data){
                	if(data.length > 0){
                		SCBoxShow();
                	}
                    var searchedList = data;	
                    var html = "";
                    for(i=0; i<searchedList.length; i++){
                        html += "<div class='resultDiv' style='cursor:pointer; margin: 0; padding:10px 13px; border-bottom:0.5px solid rgba(0,0,0,0.3);' onclick='location.href=\"/movie_info/view?movieId="+
                        		searchedList[i].movieId+"\"'>" +
                        		searchedList[i].title + "</div>";
                    }			
                 
                    var searchResultsListDiv = document.getElementById("searchResultsListDiv");
                    searchResultsListDiv.innerHTML = html;
                    
                    if( currentVal == ""){
                    	SCBoxHide();
                    }
                }
            })
    	}
	})
};

//searchbox activation end

//score box coloring

var coloring = function(){
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

var RCactivation = function(){

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
	    }
	   circle.onclick = function(e){
	        markScore = this.innerHTML;
	        document.getElementById("markRating").value = markScore;
	    }
	}
};


var RCRavtivation = function(){
	
	var updateMarkScore;
	
	for(var x=10; x<=21; x++){
        var circle = document.querySelectorAll(".ratingCircle")[x];
        circle.onmouseover = function(e){
            var score = this.innerHTML;
            for(var i=0; i <= score; i++) {
                if(i<4 ) {
                    var id = "reviewCircle_" + i;
                    document.getElementById(id).style.backgroundColor = "red";
                }else if( i < 7){
                    var id = "reviewCircle_" + i;
                    document.getElementById(id).style.backgroundColor = "orange";
                }else if ( i< 11){
                    var id = "reviewCircle_" + i;
                    document.getElementById(id).style.backgroundColor = "#1aff00";
                }
            }
        }
        circle.onmouseout = function(e){
            if(updateMarkScore == null){
                var score = this.innerHTML;
                for(var i=0; i <= score; i++) {
                    var id = "reviewCircle_" + i;
                    document.getElementById(id).style.backgroundColor = "#555";
                }
            }else{
                for(var i=10; i >updateMarkScore; i--){
                    var id = "reviewCircle_" + i;
                    document.getElementById(id).style.backgroundColor = "#555";
                }
                
            }
        }
        circle.onclick = function(e){
        	updateMarkScore = this.innerHTML;
            document.getElementById("updateMarkRating").value = updateMarkScore;
    	}
    }
	
};