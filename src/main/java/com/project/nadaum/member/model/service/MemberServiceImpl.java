package com.project.nadaum.member.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.nadaum.member.model.dao.MemberDao;
import com.project.nadaum.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;

	@Override
	public Member selectOneMember(String id) {
		return memberDao.selectOneMember(id);
	}

	@Override
	public int insertMember(Member member) {
		return memberDao.insertMember(member);
	}

	@Override
	public int confirmMember(Map<String, String> map) {
		return memberDao.confirmMember(map);
	}

	@Override
	public int insertRole(Member member) {
		return memberDao.insertRole(member);
	}

	@Override
	public int updateMember(Member member) {
		return memberDao.updateMember(member);
	}

	@Override
	public List<Map<String, Object>> selectAllAlarm(Member member) {
		return memberDao.selectAllAlarm(member);
	}

	@Override
	public List<Map<String, Object>> selectAllMyQuestions(Member member) {
		return memberDao.selectAllMyQuestions(member);
	}

	@Override
	public List<Map<String, Object>> selectAllMembersQuestions() {
		return memberDao.selectAllMembersQuestions();
	}

	@Override
	public int insertKakaoMember(Map<String, Object> map) {
		return memberDao.insertKakaoMember(map);
	}

	@Override
	public Member selectOneMemberNickname(String nickname) {
		return memberDao.selectOneMemberNickname(nickname);
	}

	@Override
	public List<Map<String, Object>> selectAllAnnouncement(Map<String, Object> param) {
		return memberDao.selectAllAnnouncement(param);
	}

	@Override
	public int countAllAnnouncementList() {
		return memberDao.countAllAnnouncementList();
	}

	@Override
	public List<Member> selectAllNotInMe(Member member) {
		return memberDao.selectAllNotInMe(member);
	}

	@Override
	public List<Map<String, Object>> selectAllFriend(Member member) {
		return memberDao.selectAllFriend(member);
	}

	@Override
	public List<Map<String, Object>> selectAllRequestFriend(Member member) {
		return memberDao.selectAllRequestFriend(member);
	}

	@Override
	public List<Map<String, Object>> selectAllRequestFriendByMe(Member member) {
		return memberDao.selectAllRequestFriendByMe(member);
	}

	@Override
	public int insertRequestFriend(Map<String, Object> param) {
		return memberDao.insertRequestFriend(param);
	}

	@Override
	public int updateRequestFriend(Map<String, Object> param) {
		return memberDao.updateRequestFriend(param);
	}

	@Override
	public int insertFriend(Map<String, Object> param) {
		return memberDao.insertFriend(param);
	}

	@Override
	public int deleteRequestFriend(Map<String, Object> param) {
		return memberDao.deleteRequestFriend(param);
	}

	@Override
	public int deleteFriend(Map<String, Object> param) {
		return memberDao.deleteFriend(param);
	}

	
	
	
}
