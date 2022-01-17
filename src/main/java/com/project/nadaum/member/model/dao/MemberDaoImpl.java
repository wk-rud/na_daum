package com.project.nadaum.member.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.nadaum.member.model.vo.Member;

@Repository
public class MemberDaoImpl implements MemberDao {
	
	@Autowired
	private SqlSessionTemplate session;

	@Override
	public Member selectOneMember(String id) {
		return session.selectOne("member.selectOneMember", id);
	}

	@Override
	public int insertMember(Member member) {
		return session.insert("member.insertMember", member);
	}

	@Override
	public int confirmMember(Map<String, String> map) {
		return session.update("member.confirmMember", map);
	}

	@Override
	public int insertRole(Member member) {
		return session.insert("member.insertRole", member);
	}

	@Override
	public int updateMember(Member member) {
		return session.update("member.updateMember", member);
	}

	@Override
	public List<Map<String, Object>> selectAllAlarm(Member member) {
		return session.selectList("member.selectAllAlarm", member);
	}

	@Override
	public List<Map<String, Object>> selectAllMyQuestions(Member member) {
		return session.selectList("member.selectAllMyQuestions", member);
	}

	@Override
	public List<Map<String, Object>> selectAllMembersQuestions() {
		return session.selectList("member.selectAllMembersQuestions");
	}

	@Override
	public int insertKakaoMember(Map<String, Object> map) {
		return session.insert("member.insertKakaoMember", map);
	}

	@Override
	public Member selectOneMemberNickname(String nickname) {
		return session.selectOne("member.selectOneMemberNickname", nickname);
	}

	@Override
	public List<Map<String, Object>> selectAllAnnouncement(Map<String, Object> param) {
		return session.selectList("member.selectAllAnnouncement", param);
	}

	@Override
	public int countAllAnnouncementList() {
		return session.selectOne("member.countAllAnnouncementList");
	}

	

}
