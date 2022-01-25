package com.project.nadaum.audiobook.model.dao;

import java.util.List;
import java.util.Map;

import com.project.nadaum.audiobook.model.vo.Album;
import com.project.nadaum.audiobook.model.vo.AlbumAttachment;

public interface AlbumDao {

	List<Album> selectAlbumList(Map<String, Object> param);

	int selectTotalContent();

	int insertAlbum(Album album);

	int insertAttachment(AlbumAttachment attach);

	Album selectOneAlbum(String code);

	List<AlbumAttachment> selectAttachmentListByAlbumCode(String code);

	Album selectOnBoardCollection(String code);

	AlbumAttachment selectOneAtttachment(String code);

}
