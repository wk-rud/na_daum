package com.project.nadaum.admin.model.service;

import java.util.List;
import java.util.Map;

import com.project.nadaum.admin.model.vo.Help;
import com.project.nadaum.member.model.vo.Member;

public interface AdminService {

	List<Help> selectAllHelp(Map<String, Object> param);

	Help selectOneHelp(Map<String, Object> map);

	int updateHelpAnswer(Help help);

	int insertHelpAnswer(Help help);

	int countAllHelp();

	List<Member> selectAllMember();

}
