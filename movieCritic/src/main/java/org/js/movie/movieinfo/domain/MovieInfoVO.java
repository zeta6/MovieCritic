package org.js.movie.movieinfo.domain;


import java.util.Date;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
public class MovieInfoVO {	
	
	private int movieId;
	private String title;
	private String starring;
	private String summary;
	private String genre;
	private String writer;
	private Date registerDate;
	private int viewCount;
	private String stillCut1;
	private String stillCut2;
	private String stillCut3;
	private String thumbNail;
	private String poster;
	private Date releaseDate;
}	
