package com.project.nadaum.culture.movie.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.Data;

@Data
public class MovieResponseVo implements Serializable {/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

    private int display;
    private Item[] items;
    
    @Data
    static class Item {
        public String title;
        public String link;
        public String image;
        public String subtitle;
        public Date pubDate;
        public String director;
        public String actor;
        public float userRating;
    }
}
