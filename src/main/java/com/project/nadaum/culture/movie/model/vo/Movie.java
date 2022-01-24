package com.project.nadaum.culture.movie.model.vo;

import java.io.Serializable;
import java.util.Date;

import org.json.JSONObject;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Movie implements Serializable{/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String code; //고유코드
	private String title;
	private Date pubDate;
	private String director;
	private String actor;
	private Double userRating;
	private String imgUrl;
	
	public Movie(JSONObject itemJson) {
		this.title = itemJson.getString("title");
//		this.pubDate = itemJson.getDate("pubDate");
		this.director = itemJson.getString("director");
		this.actor = itemJson.getString("actor");
		this.userRating = itemJson.getDouble("userRating");
		this.imgUrl = itemJson.getString("imgUrl");
	}
	
}

	