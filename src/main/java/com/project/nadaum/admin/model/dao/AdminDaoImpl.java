package com.project.nadaum.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Repository;

import com.project.nadaum.admin.model.vo.Help;
import com.project.nadaum.member.model.vo.Member;
import com.project.nadaum.member.model.vo.MemberRole;

@Repository
public class AdminDaoImpl implements AdminDao {

	@Autowired
	private SqlSessionTemplate session;

	@Override
	public List<Help> selectAllHelp(Map<String, Object> param) {
		int offset = (int) param.get("offset");
		int limit = (int) param.get("limit");
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("admin.selectAllHelp", null, rowBounds);
	}

	@Override
	public String selectHelpLikes(Map<String, Object> codeMap) {
		return session.selectOne("admin.selectHelpLikes", codeMap);
	}

	@Override
	public Help selectOneHelp(Map<String, Object> map) {
		return session.selectOne("admin.selectOneHelp", map);
	}

	@Override
	public int updateHelpAnswer(Help help) {
		return session.update("admin.updateHelpAnswer", help);
	}

	@Override
	public int countAllHelp() {
		return session.selectOne("admin.countAllHelp");
	}

	@Override
	public List<Member> selectAllMember(Map<String, Object> param) {
		int offset = (int) param.get("offset");
		int limit = (int) param.get("limit");
		RowBounds rowBounds = new RowBounds(offset, limit);
		Member member = (Member) param.get("member");
		return session.selectList("admin.selectAllMember", member, rowBounds);
	}

	@Override
	public int insertAnnouncement(Map<String, Object> map) {
		return session.insert("admin.insertAnnouncement", map);
	}

	@Override
	public int updateAnnouncement(Map<String, Object> map) {
		return session.update("admin.updateAnnouncement", map);
	}

	@Override
	public int deleteHelp(Map<String, Object> map) {
		return session.delete("admin.deleteHelp", map);
	}

	@Override
	public int deleteLikes(Map<String, Object> map) {
		return session.delete("admin.deleteLikes", map);
	}

	@Override
	public int deleteAnnouncement(Map<String, Object> map) {
		return session.delete("admin.deleteAnnouncement", map);
	}

	@Override
	public int updateEnabled(Map<String, Object> map) {
		return session.update("admin.updateEnabled", map);
	}

	@Override
	public int insertRole(Map<String, Object> map) {
		return session.insert("admin.insertRole", map);
	}

	@Override
	public int deleteRole(Map<String, Object> map) {
		return session.delete("admin.deleteRole", map);
	}

	@Override
	public List<MemberRole> selectAllMemberRole(Member member) {
		return session.selectList("admin.selectAllMemberRole", member);
	}

	@Override
	public int countAllMember(Map<String, Object> param) {
		return session.selectOne("admin.countAllMember", param);
	}
	
	
	
}
