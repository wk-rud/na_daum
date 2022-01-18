package com.project.nadaum.member.model.dao;

import java.util.List;
import java.util.Map;

import com.project.nadaum.member.model.vo.Member;

public interface MemberDao {

	Member selectOneMember(String id);

	int insertMember(Member member);

	int confirmMember(Map<String, String> map);

	int insertRole(Member member);

	int updateMember(Member member);

	List<Map<String, Object>> selectAllAlarm(Member member);

	List<Map<String, Object>> selectAllMyQuestions(Member member);

	List<Map<String, Object>> selectAllMembersQuestions();

	int insertKakaoMember(Map<String, Object> map);

	Member selectOneMemberNickname(String nickname);

	List<Map<String, Object>> selectAllAnnouncement(Map<String, Object> param);

	int countAllAnnouncementList();

	List<Member> selectAllNotInMe(Member member);

	List<Map<String, Object>> selectAllFriend(Member member);

	List<Map<String, Object>> selectAllRequestFriend(Member member);

	List<Map<String, Object>> selectAllRequestFriendByMe(Member member);

	int insertRequestFriend(Map<String, Object> param);

	int updateRequestFriend(Map<String, Object> param);

	int insertFriend(Map<String, Object> param);

	int deleteRequestFriend(Map<String, Object> param);

	int deleteFriend(Map<String, Object> param);



}
