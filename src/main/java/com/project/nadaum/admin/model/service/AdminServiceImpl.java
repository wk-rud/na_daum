package com.project.nadaum.admin.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.nadaum.admin.model.dao.AdminDao;
import com.project.nadaum.admin.model.vo.Help;
import com.project.nadaum.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(rollbackFor=Exception.class)
@Slf4j
public class AdminServiceImpl implements AdminService {

	@Autowired
	private AdminDao adminDao;

	@Override
	public List<Help> selectAllHelp(Map<String, Object> param) {
		List<Help> listMap = adminDao.selectAllHelp(param);
		log.debug("listMapSize = {}", listMap.size());
		Map<String, Object> codeMap = new HashMap<>();		
		for(int i = 0; i < listMap.size(); i++) {
			if(listMap.get(i).getCode() != null) {
				codeMap.put("code", listMap.get(i).getCode());
				log.debug("codeMap = {}", codeMap);
				String likes = adminDao.selectHelpLikes(codeMap);
				if(likes != null)
					listMap.get(i).setCount(likes);
				else
					listMap.get(i).setCount("0");
			}
			if(listMap.get(i).getACode() != null) {
				Map<String, Object> anLikes = new HashMap<>();
				codeMap.put("code", listMap.get(i).getACode());
				String aLikes = adminDao.selectHelpLikes(codeMap);
				if(aLikes != null)
					listMap.get(i).setACount(aLikes);
				else
					listMap.get(i).setACount("0");
			}else {
				listMap.get(i).setACount("0");
			}
		}
		return listMap;
	}

	@Override
	public Help selectOneHelp(Map<String, Object> map) {
		return adminDao.selectOneHelp(map);
	}

	@Override
	public int updateHelpAnswer(Help help) {
		return adminDao.updateHelpAnswer(help);
	}

	@Override
	public int insertHelpAnswer(Help help) {
		return adminDao.insertHelpAnswer(help);
	}

	@Override
	public int countAllHelp() {
		return adminDao.countAllHelp();
	}

	@Override
	public List<Member> selectAllMember() {
		return adminDao.selectAllMember();
	}
	
	
	
}
