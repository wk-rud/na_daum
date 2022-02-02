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
public class Album extends AlbumInfo implements Serializable{

	
	private static final long serialVersionUID = 1L;

	private List<AlbumImg> albumImgs;
	private List<AlbumTrack> albumTracks;
	
	public Album(String code,String kind, String title, String provider,String content,String creator, Date regDate, String playTime, int playCount
			,String status,List<AlbumImg> albumImgs, List<AlbumTrack> albumTracks) {
		super(code, kind, title, provider, content, creator,regDate,playTime,playCount,status);
		this.albumImgs=albumImgs;
		this.albumTracks = albumTracks;
	}
	 
}
