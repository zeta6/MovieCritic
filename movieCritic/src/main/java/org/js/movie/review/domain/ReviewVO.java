package org.js.movie.review.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReviewVO {

	
	private int reviewId;
	private int movieId;
	private String content;
	private String writer;
	private Date registerDate;
	private int rating;

}