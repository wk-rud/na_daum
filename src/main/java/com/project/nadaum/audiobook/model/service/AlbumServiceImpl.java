package com.project.nadaum.audiobook.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.nadaum.audiobook.model.dao.AlbumDao;
import com.project.nadaum.audiobook.model.vo.Album;
import com.project.nadaum.audiobook.model.vo.AlbumComment;
import com.project.nadaum.audiobook.model.vo.AlbumInfo;
import com.project.nadaum.audiobook.model.vo.AlbumImg;
import com.project.nadaum.audiobook.model.vo.AlbumTrack;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional
public class AlbumServiceImpl implements AlbumService {

	@Autowired
	private AlbumDao albumDao;

	// 페이징
	@Override
	public int selectTotalContent() {
		return albumDao.selectTotalContent();
	}

	@Override
	public List<AlbumInfo> selectListAlbumInfo(Map<String, Object> param) {
		return albumDao.selectListAlbumInfo(param);
	}

	// 앨범

	@Override
	public int insertAlbum(Album album) {
		int result = albumDao.insertAlbumInfo(album);

		log.debug("albumNo={}", album.getClass());

		List<AlbumTrack> albumTracks = album.getAlbumTracks();

		if (albumTracks != null) {
			for (AlbumTrack trkAttach : albumTracks) {
				trkAttach.setAlbumCode(album.getCode());
				result = insertAlbumTrack(trkAttach);
			}
		}
		//result = insertAlbumTracks(albumTracks);
		
		List<AlbumImg> albumImgs = album.getAlbumImgs();
		if (albumImgs != null) {
			for (AlbumImg imgAttach : albumImgs) {
				imgAttach.setAlbumCode(album.getCode());
				result = insertAlbumImg(imgAttach);
			}
		}
		//result = insertAlbumImgs(albumImgs);
		
		return result;
	}

	@Override
	public int deleteAlbum(String code) {
		return albumDao.deleteAlbum(code);
	}

	@Override
	public int updateAlbum(Album album) {
		int result = albumDao.updateAlbumInfo((AlbumInfo) album);
		result = albumDao.updateAlbumImgs(album.getAlbumImgs());
		result = albumDao.updateAlbumTracks(album.getAlbumTracks());
		return result;
	}

	@Override
	public int updateAlbumInfo(AlbumInfo albumInfo) {
		return albumDao.updateAlbumInfo(albumInfo);
	}

	@Override
	public Album selectOneAlbumCollection(String code) {
		return albumDao.selectOneAlbumCollection(code);
	}

	@Override
	public AlbumInfo selectOneAlbumInfo(String code) {
		AlbumInfo albumInfo = albumDao.selectOneAlbumInfo(code);
		return albumInfo;
	}

	@Override
	public List<AlbumInfo> selectListAlbumInfo() {
		return albumDao.selectListAlbumInfo();
	}

	// 트랙

	@Override
	public int insertAlbumTrack(AlbumTrack altrk) {
		return albumDao.insertAlbumTrack(altrk);
	}
	
	@Override
	public int insertAlbumTracks(List<AlbumTrack>list) {
		return albumDao.insertAlbumTracks(list);
	}

	@Override
	public int updateAlbumTrack(AlbumTrack altrk) {
		return albumDao.updateAlbumTrack(altrk);
	}

	@Override
	public int deleteAlbumTrack(int[] no) {
		return albumDao.deleteAlbumTrack(no);
	}

	@Override
	public List<AlbumTrack> selectListAlbumTrack(String code) {
		return albumDao.selectListAlbumTrack(code);
	}

	@Override
	public AlbumTrack selectOneAlbumTrack(Map<String, Object> param) {
		return albumDao.selectOneAlbumTrack(param);
	}

	// 앨범이미지
	@Override
	public int insertAlbumImg(AlbumImg imgAttach) {
		return albumDao.insertAlbumImg(imgAttach);
	}
	@Override
	public int insertAlbumImgs(List<AlbumImg> imgList) {
		return albumDao.insertAlbumImgs(imgList);
	}

	@Override
	public int updateAlbumImg(AlbumImg imgAttach) {
		return albumDao.updateAlbumImg(imgAttach);
	}

	@Override
	public int deleteAlbumImg(AlbumImg imgAttach) {
		return albumDao.deleteAlbumImg(imgAttach);
	}

	@Override
	public AlbumImg selectOneAlbumImg(AlbumImg imgAttach) {
		return albumDao.selectOneAlbumImg(imgAttach);
	}

	@Override
	public List<AlbumImg> selectListAlbumImg(String code) {
		return albumDao.selectListAlbumImg(code);
	}

	// 코멘트
	@Override
	public int insertAlbumComment(AlbumComment comment) {
		return albumDao.insertAlbumComment(comment);
	}

	@Override
	public int updateAlbumComment(AlbumComment comment) {
		return albumDao.updateAlbumComment(comment);
	}

	@Override
	public int deleteAlbumComment(AlbumComment comment) {
		return albumDao.deleteAlbumComment(comment);
	}

	@Override
	public List<AlbumComment> selectListAlbumComment(String code) {
		return albumDao.selectListAlbumComment(code);
	}

	@Override
	public AlbumComment selectOneAlbumComment(AlbumComment comment) {
		return albumDao.selectOneAlbumComment(comment);
	}

	@Override
	public List<AlbumComment> selectListAlbumComment(Map<String, Object> param) {
		return albumDao.selectListAlbumComment(param);
	}

	// 검색
	@Override
	public List<AlbumInfo> selectListAlbumInfoByWord(String[] search) {
		return albumDao.selectListAlbumInfoByWord(search);
	}

	@Override
	public List<Map<String,Object>> selectListAlbum(Map<String, Object> param) {
		return albumDao.selectListAlbum(param);
	}

	@Override
	public List<AlbumInfo> selectListAlbumInfoByType(Map<String, Object> param) {
		return albumDao.selectListAlbumInfoByType(param);
	}

	@Override
	public List<AlbumInfo> selectListAlbumInfoByKind(String kind) {
		return albumDao.selectListAlbumInfoByKind(kind);
	}

	@Override
	public List<AlbumInfo> selectListAlbumInfoByProvider(String provider) {
		return albumDao.selectListAlbumInfoByProvider(provider);
	}

	@Override
	public List<AlbumInfo> selectListAlbumInfoByCreator(String creator) {
		return albumDao.selectListAlbumInfoByCreator(creator);
	}

}
