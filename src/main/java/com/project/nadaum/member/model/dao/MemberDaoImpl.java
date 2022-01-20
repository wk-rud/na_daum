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

	@Override
	public List<Member> selectAllNotInMe(Member member) {
		return session.selectList("member.selectAllNotInMe", member);
	}

	@Override
	public List<Map<String, Object>> selectAllFriend(Member member) {
		return session.selectList("member.selectAllFriend", member);
	}

	@Override
	public List<Map<String, Object>> selectAllRequestFriend(Member member) {
		return session.selectList("member.selectAllRequestFriend", member);
	}

	@Override
	public List<Map<String, Object>> selectAllRequestFriendByMe(Member member) {
		return session.selectList("member.selectAllRequestFriendByMe", member);
	}

	@Override
	public int updateMemberProfile(Member member) {
		return session.update("member.updateMemberProfile", member);
	}

	@Override
	public List<Map<String, Object>> selectAllHelpTitle(String value) {
		return session.selectList("member.selectAllHelpTitle", value);
	}

	@Override
	public List<Map<String, Object>> selectHelpByInput(String title) {
		return session.selectList("member.selectHelpByInput", title);
	}

	@Override
	public Map<String, Object> selectOneSelectedHelp(String code) {
		return session.selectOne("member.selectOneSelectedHelp", code);
	}

	@Override
	public List<Map<String, Object>> selectSearchMemberNickname(String value) {
		return session.selectList("member.selectSearchMemberNickname", value);
	}

	@Override
	public Member selectOneMemberNicknameNotMe(Map<String, Object> nicknames) {
		return session.selectOne("member.selectOneMemberNicknameNotMe", nicknames);
	}

	@Override
	public Map<String, Object> selectFollower(Map<String, Object> nicknames) {
		return session.selectOne("member.selectFollower", nicknames);
	}

	@Override
	public Map<String, Object> selectFollowing(Map<String, Object> nicknames) {
		return session.selectOne("member.selectFollowing", nicknames);
	}

	@Override
	public Map<String, Object> selectFriend(Map<String, Object> nicknames) {
		return session.selectOne("member.selectFriend", nicknames);
	}

	@Override
	public int updateRequestFriend(Map<String, Object> nicknames) {
		return session.update("member.updateRequestFriend", nicknames);
	}

	@Override
	public int insertFriend(Map<String, Object> nicknames) {
		return session.insert("member.insertFriend", nicknames);
	}

	@Override
	public int insertAlarm(Map<String, Object> alarm) {
		return session.insert("member.insertAlarm", alarm);
	}

	@Override
	public int deleteRequestFriend(Map<String, Object> nicknames) {
		return session.delete("member.deleteRequestFriend", nicknames);
	}

	@Override
	public int deleteFriend(Map<String, Object> nicknames) {
		return session.delete("member.deleteFriend", nicknames);
	}

	@Override
	public int insertRequestFriend(Map<String, Object> nicknames) {
		return session.insert("member.insertRequestFriend", nicknames);
	}

	@Override
	public Map<String, Object> selectOneMemberAndAttachment(Member member) {
		return session.selectOne("member.selectOneMemberAndAttachment", member);
	}

	
	
	

}
