package com.project.nadaum.admin.model.dao;

import java.util.List;
import java.util.Map;

import com.project.nadaum.admin.model.vo.Help;
import com.project.nadaum.member.model.vo.Member;

public interface AdminDao {

	List<Help> selectAllHelp(Map<String, Object> param);

	String selectHelpLikes(Map<String, Object> codeMap);

	Help selectOneHelp(Map<String, Object> map);

	int updateHelpAnswer(Help help);

	int insertHelpAnswer(Help help);

	int countAllHelp();

	List<Member> selectAllMember();

}
