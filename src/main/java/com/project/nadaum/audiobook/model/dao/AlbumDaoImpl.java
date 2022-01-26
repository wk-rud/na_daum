package com.project.nadaum.audiobook.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.nadaum.audiobook.model.vo.Album;
import com.project.nadaum.audiobook.model.vo.AlbumAttachment;

@Repository
public class AlbumDaoImpl implements AlbumDao {

	@Autowired
	private SqlSessionTemplate session;
	
	@Override
	public List<Album> selectAlbumList(Map<String, Object> param) {
		int offset= (int) param.get("offset");
		int limit = (int) param.get("limit");
		RowBounds rowBounds = new RowBounds(offset,limit);
			
		return session.selectList("album.selectAlbumList", null, rowBounds);
	}

	@Override
	public int selectTotalContent() {
		return session.selectOne("album.selectTotalContent");
	}

	@Override
	public int insertAlbum(Album album) {
		
		return session.insert("album.insertAlbum",album);
	}

	@Override
	public int insertAttachment(AlbumAttachment attach) {
		return session.insert("album.insertAttachment",attach);
	}

	@Override
	public Album selectOneAlbum(String code) {
		return session.selectOne("album.selectOneAlbum",code);
	}

	@Override
	public List<AlbumAttachment> selectAttachmentListByAlbumCode(String code) {
		return session.selectOne("album.selectAttachmentListByAlbumCode",code);
	}

	@Override
	public Album selectOnBoardCollection(String code) {
		return session.selectOne("album.selectOneAlbumCollection",code);
	}

	@Override
	public AlbumAttachment selectOneAtttachment(String code) {
		return session.selectOne("album.selectOneAlbum",code);
	}

	@Override
	public List<Album> selectAlbumList() {
		return session.selectList("album.selectAlbumList");
	}

}
