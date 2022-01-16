package com.project.nadaum.member.model.service;

import java.util.List;
import java.util.Map;

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


}
