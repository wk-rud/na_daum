package com.project.nadaum.member.model.service;

import java.util.List;
import java.util.Map;

import com.project.nadaum.common.vo.Attachment;
import com.project.nadaum.member.model.vo.Member;

public interface MemberService {

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

	int updateMemberProfile(Member member);

	List<Map<String, Object>> selectAllHelpTitle(String value);

	List<Map<String, Object>> selectHelpByInput(String title);

	Map<String, Object> selectOneSelectedHelp(String code);

	List<Map<String, Object>> selectSearchMemberNickname(String value);

	Member selectOneMemberNicknameNotMe(Map<String, Object> nicknames);

	Map<String, Object> selectFollower(Map<String, Object> nicknames);

	Map<String, Object> selectFollowing(Map<String, Object> nicknames);

	Map<String, Object> selectFriend(Map<String, Object> nicknames);

	int updateRequestFriend(Map<String, Object> nicknames);

	int insertFriend(Map<String, Object> nicknames);

	int insertAlarm(Map<String, Object> alarm);

	int deleteRequestFriend(Map<String, Object> nicknames);

	int deleteFriend(Map<String, Object> nicknames);

	int insertRequestFriend(Map<String, Object> nicknames);

	Attachment selectMemberProfile(Member member);

	int updateMemberNickname(Member member);

	Member selectOneMemberByEmail(Map<String, Object> map);

	Member selectOneMemberByIdEmail(Map<String, Object> map);

	int updateMemberPassword(Map<String, Object> map);

	Member selectOneMemberByPhone(Map<String, Object> map);

	Member selectOneMemberByIdPhone(Map<String, Object> map);

	int insertMemberHelp(Map<String, Object> map);

	List<Map<String, Object>> selectHelpOneCategory(Map<String, Object> param);

	int countHelpOneCategoryCount(String category);

	List<Map<String, Object>> selectLikesCheck(Map<String, Object> param);

	int insertHelpLike(Map<String, Object> map);

	int deleteHelpLike(Map<String, Object> map);

	List<Map<String, Object>> selectMostHelp();



}
