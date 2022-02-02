package com.project.nadaum.audiobook.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AlbumInfo implements Serializable{


	private static final long serialVersionUID = 6498154507783817520L;

	private String code;
	private String kind;
	private String title;	
	private String provider;
	private String content;
	private String creator;
	private Date regDate;
	private String playTime;
	private int playCount;
	private String status;
//	private int price;
	 
}
