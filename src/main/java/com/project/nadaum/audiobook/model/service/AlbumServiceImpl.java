package com.project.nadaum.audiobook.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.nadaum.audiobook.model.dao.AlbumDao;
import com.project.nadaum.audiobook.model.vo.Album;
import com.project.nadaum.audiobook.model.vo.AlbumAttachment;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class AlbumServiceImpl implements AlbumService{

	@Autowired
	private AlbumDao albumDao;

	@Override
	public List<Album> selectAlbumList(Map<String, Object> param) {
		
		return albumDao.selectAlbumList(param);
	}

	@Override
	public int selectTotalContent() {
		return albumDao.selectTotalContent();
	}

	@Override
	public int insertAlbum(Album album) {
		int result= albumDao.insertAlbum(album);
		log.debug("albumNo={}",album.getClass());
		List<AlbumAttachment> attachments = album.getAttachments();
		if(attachments !=null) {
			for(AlbumAttachment attach : attachments) {
				attach.setAlbumCode(album.getCode());
				result= insertAttachment(attach);
			}
		}
		return result;
	}

	@Override
	public int insertAttachment(AlbumAttachment attach) {
		return albumDao.insertAttachment(attach);
	}

	@Override
	public Album selectOneAlbum(String code) {
		
		Album album = albumDao.selectOneAlbum(code);
	
		List<AlbumAttachment> attachments = albumDao.selectAttachmentListByAlbumCode(code);
		
		album.setAttachments(attachments);
		return album;
	}

	@Override
	public Album selectOnAlbumCollection(String code) {
		return albumDao.selectOnBoardCollection(code);
	}

	@Override
	public AlbumAttachment selectOneAtttachment(String code) {
		return albumDao.selectOneAtttachment(code);
	}
}
