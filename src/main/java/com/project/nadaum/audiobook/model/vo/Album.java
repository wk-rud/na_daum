package com.project.nadaum.audiobook.model.vo;

import java.io.Serializable;
import java.util.Date;
import java.util.List;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;


@Data
@NoArgsConstructor
@ToString(callSuper=true)
public class Album extends AlbumEntity implements Serializable{

	
	private static final long serialVersionUID = 6498154507783817520L;

	private List<AlbumAttachment> attachments;
	
	public Album(String code, String title, String provider,String content,String creator,int price, Date regDate, String playTime, String kind,
			List<AlbumAttachment> attachments) {
		super(code, title, provider, content, creator, price,regDate,playTime,kind);
		this.attachments = attachments;
	}
	 
}
