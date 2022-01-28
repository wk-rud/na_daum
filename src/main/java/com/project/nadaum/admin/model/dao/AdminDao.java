package com.project.nadaum.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.springframework.security.core.authority.SimpleGrantedAuthority;

import com.project.nadaum.admin.model.vo.Help;
import com.project.nadaum.member.model.vo.Member;
import com.project.nadaum.member.model.vo.MemberRole;

public interface AdminDao {

	List<Help> selectAllHelp(Map<String, Object> param);

	String selectHelpLikes(Map<String, Object> codeMap);

	Help selectOneHelp(Map<String, Object> map);

	int updateHelpAnswer(Help help);

	int countAllHelp();

	List<Member> selectAllMember(Map<String, Object> param);

	int insertAnnouncement(Map<String, Object> map);

	int updateAnnouncement(Map<String, Object> map);

	int deleteHelp(Map<String, Object> map);

	int deleteLikes(Map<String, Object> map);

	int deleteAnnouncement(Map<String, Object> map);

	int updateEnabled(Map<String, Object> map);

	int insertRole(Map<String, Object> map);

	int deleteRole(Map<String, Object> map);

	List<MemberRole> selectAllMemberRole(Member m);

	int countAllMember(Map<String, Object> param);

}
