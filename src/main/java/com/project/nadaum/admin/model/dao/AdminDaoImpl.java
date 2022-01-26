package com.project.nadaum.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.nadaum.admin.model.vo.Help;
import com.project.nadaum.member.model.vo.Member;

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
	public int insertHelpAnswer(Help help) {
		return session.update("admin.insertHelpAnswer", help);
	}

	@Override
	public int countAllHelp() {
		return session.selectOne("admin.countAllHelp");
	}

	@Override
	public List<Member> selectAllMember() {
		return session.selectList("admin.selectAllMember");
	}
	
	
	
}
