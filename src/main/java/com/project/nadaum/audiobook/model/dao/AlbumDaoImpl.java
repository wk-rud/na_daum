package com.project.nadaum.audiobook.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.nadaum.audiobook.model.vo.Album;
import com.project.nadaum.audiobook.model.vo.AlbumComment;
import com.project.nadaum.audiobook.model.vo.AlbumImg;
import com.project.nadaum.audiobook.model.vo.AlbumInfo;
import com.project.nadaum.audiobook.model.vo.AlbumTrack;

@Repository
public class AlbumDaoImpl implements AlbumDao {

	@Autowired
	private SqlSessionTemplate session;

	

	// paging
	@Override
	public int selectTotalContent() {
		return session.selectOne("album.selectTotalContent");
	}
	
	@Override
	public List<AlbumInfo> selectListAlbumInfo(Map<String, Object> param) {
		int offset = (int) param.get("offset");
		int limit = (int) param.get("limit");
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("album.selectListAlbumInfo", null, rowBounds);
	}
	
	@Override
	public List<AlbumInfo> selectListAlbumInfo(){
		return session.selectList("album.selectListAlbumInfo");
	}
	
	
	//앨범
	@Override
	public int insertAlbumInfo(AlbumInfo albumInfo) {
		return session.insert("album.insertAlbumInfo", albumInfo);
	}
	
	@Override
	public int updateAlbumInfo(AlbumInfo album) {
		return session.update("album.updateAlbumInfo",album);
	}

	@Override
	public AlbumInfo selectOneAlbumInfo(String code) {
		return session.selectOne("album.selectOneAlbumInfo", code);
	}

	@Override
	public Album selectOneAlbumCollection(String code) {
		return session.selectOne("album.selectOneAlbumCollection", code);
	}
	
	
	@Override
	public int deleteAlbum(String code) {
		return session.delete("album.deleteAlbumInfo",code);
	}

	//트랙
	@Override
	public int insertAlbumTrack(AlbumTrack altrk) {
		return session.insert("album.insertAlbumTrack", altrk);
	}
	
	@Override
	public int insertAlbumTracks(List<AlbumTrack> list) {
		return session.insert("album.insertAlbumTracks", list);
	}

	@Override
	public int updateAlbumTrack(AlbumTrack altrk) {
		return session.update("album.updateAlbumTrack",altrk);
	}
	
	@Override
	public int updateAlbumTracks(List<AlbumTrack> trackList) {
		return session.update("album.updateAlbumTracks",trackList);
	}
	//--작업중
	@Override
	public int deleteAlbumTrack(int[] delArray) {
		return session.delete("album.deleteAlbumTrack",delArray);
	}
	
	@Override
	public AlbumTrack selectOneAlbumTrack(Map<String, Object> param) {
		return session.selectOne("album.selectOneAlbum", param);
	}
	
	@Override
	public List<AlbumTrack> selectListAlbumTrack(String code) {
		return session.selectList("album.selectListAlbumTrack", code);
	}

	//이미지
	
	@Override
	public int insertAlbumImg(AlbumImg imgAttach) {
		return session.insert("album.insertAlbumImg",imgAttach);
	}
	@Override
	public int insertAlbumImgs(List<AlbumImg> imgList) {
		return session.insert("album.insertAlbumImgs",imgList);
	}
	//작업중--
	@Override
	public int updateAlbumImg(AlbumImg imgAttach) {
		return session.update("album.updateAlbumImg",imgAttach);
	}
	@Override
	public int updateAlbumImgs(List<AlbumImg> imgAttachs) {
		return session.update("album.updateAlbumImgs",imgAttachs);
	}
	
	@Override
	public int deleteAlbumImg(AlbumImg imgAttach) {
		return session.delete("album.deleteAlbumImg",imgAttach);
	}
	
	@Override
	public AlbumImg selectOneAlbumImg(AlbumImg imgAttach) {
		return session.selectOne("album.selectOneAlbumImg",imgAttach);
	}
	
	@Override
	public List<AlbumImg> selectListAlbumImg(String code){
		return session.selectList("album.selectListAlbumImg",code);
	}
	
	//댓글
	
	@Override
	public int insertAlbumComment(AlbumComment comment) {
		return session.insert("album.insertAlbumComment",comment);
	}
	
	@Override
	public int updateAlbumComment(AlbumComment comment) {
		return session.update("album.updateAlbumComment",comment);
	}
	
	@Override
	public int deleteAlbumComment(AlbumComment comment) {
		return session.delete("album.deleteAlbumComment",comment);
	}
	
	@Override
	public AlbumComment selectOneAlbumComment(AlbumComment comment) {
		return session.selectOne("album.selectOneAlbumComment",comment);
	}
	
	@Override
	public List<AlbumComment> selectListAlbumComment(String code){
		return session.selectList("album.selectListAlbumComment",code);
	}
	
	@Override
	public List<AlbumComment> selectListAlbumComment(Map<String,Object>param){
		int offset = (int) param.get("offset");
		int limit = (int) param.get("limit");
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("album.selectListAlbumComment",null,rowBounds);
	}
	
//페이징쿼리	
//	  @Override 
//	public List<AlbumComment>selectListAlbumCommentByPage(Map<String,Object>param){
//	   return session.selectList("album.selectListAlbumCommentByPage",param); 
//	}
	 
	
	//검색
	@Override
	public List<AlbumInfo> selectListAlbumInfoByWord(String[] search) {
		return session.selectList("album.selectListAlbumInfoByWord",search);
	}
	@Override
	public List<AlbumInfo> selectListAlbumInfoByKind(String kind){
		return session.selectList("album.selectListAlbumInfoByKind",kind);
	}
	
	@Override
	public List<AlbumInfo> selectListAlbumInfoByProvider(String provider){
		return session.selectList("album.selectListAlbumInfoByProvider",provider);
	}
	
	@Override
	public List<AlbumInfo> selectListAlbumInfoByCreator(String creator){
		return session.selectList("album.selectListAlbumInfoByCreator",creator);
	}
	
	@Override
	public List<AlbumInfo> selectListAlbumInfoByType(Map<String, Object> param) {
		return session.selectList("album.selectListAlbumInfoByType",param);
	}

	@Override
	public List<Map<String,Object>> selectListAlbum(Map<String, Object> param) {
		return session.selectList("album.selectListAlbum");
	}

}
