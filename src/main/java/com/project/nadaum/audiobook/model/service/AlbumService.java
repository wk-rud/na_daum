package com.project.nadaum.audiobook.model.service;

import java.util.List;
import java.util.Map;

import com.project.nadaum.audiobook.model.vo.Album;
import com.project.nadaum.audiobook.model.vo.AlbumAttachment;

public interface AlbumService {

	List<Album> selectAlbumList(Map<String, Object> param);
	
	int selectTotalContent();
	
	int insertAlbum(Album album);
	
	int insertAttachment(AlbumAttachment attach);
	
	Album selectOneAlbum(String code);
	
	Album selectOnAlbumCollection(String code);

	AlbumAttachment selectOneAtttachment(String code);

	List<Album> selectAlbumList();

}
