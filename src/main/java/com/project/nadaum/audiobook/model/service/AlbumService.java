package com.project.nadaum.audiobook.model.service;

import java.util.List;
import java.util.Map;

import com.project.nadaum.audiobook.model.vo.Album;
import com.project.nadaum.audiobook.model.vo.AlbumComment;
import com.project.nadaum.audiobook.model.vo.AlbumInfo;
import com.project.nadaum.audiobook.model.vo.AlbumImg;
import com.project.nadaum.audiobook.model.vo.AlbumTrack;

public interface AlbumService {

	// 목록 페이징

	int selectTotalContent();

	List<AlbumInfo> selectListAlbumInfo(Map<String, Object> param);

	
	//앨범 전체
	
	int insertAlbum(Album album);
	
	int updateAlbum(Album album);

	Album selectOneAlbumCollection(String code);

	/*
	 * AlbumInfo
	 */
	
	int updateAlbumInfo(AlbumInfo album);

	int deleteAlbum(String code);

	AlbumInfo selectOneAlbumInfo(String code);
	
	List<AlbumInfo> selectListAlbumInfo();

	/*
	 * AlbumTrack CRUD
	 */
	
	int insertAlbumTrack(AlbumTrack altrk);
	
	int insertAlbumTracks(List<AlbumTrack> list);

	int updateAlbumTrack(AlbumTrack altrk);

	int deleteAlbumTrack(int[] no);

	AlbumTrack selectOneAlbumTrack(Map<String, Object> param);

	List<AlbumTrack> selectListAlbumTrack(String code);

	/*
	 * AlbumImg CRUD
	 */

	int insertAlbumImg(AlbumImg attach);
	
	int insertAlbumImgs(List<AlbumImg> imgList);

	int updateAlbumImg(AlbumImg attach);

	int deleteAlbumImg(AlbumImg attach);

	AlbumImg selectOneAlbumImg(AlbumImg imgAttach);

	List<AlbumImg> selectListAlbumImg(String code);
	
	
	// Album Comment

	int insertAlbumComment(AlbumComment comment);

	int updateAlbumComment(AlbumComment comment);

	int deleteAlbumComment(AlbumComment comment);

	AlbumComment selectOneAlbumComment(AlbumComment comment);
	
	List<AlbumComment> selectListAlbumComment(String code);
	
	List<AlbumComment> selectListAlbumComment(Map<String, Object> param);
	
	// AlbumInfo Search

	List<AlbumInfo> selectListAlbumInfoByWord(String[] search);

	List<AlbumInfo> selectListAlbumInfoByType(Map<String, Object> param);

	List<AlbumInfo> selectListAlbumInfoByKind(String kind);

	List<AlbumInfo> selectListAlbumInfoByProvider(String provider);

	List<AlbumInfo> selectListAlbumInfoByCreator(String creator);

	List<Map<String,Object>> selectListAlbum(Map<String, Object> param);

	
}
