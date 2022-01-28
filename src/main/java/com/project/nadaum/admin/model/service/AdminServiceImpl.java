package com.project.nadaum.admin.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.nadaum.admin.model.dao.AdminDao;
import com.project.nadaum.admin.model.vo.Help;
import com.project.nadaum.member.model.vo.Member;
import com.project.nadaum.member.model.vo.MemberRole;

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
	public int countAllHelp() {
		return adminDao.countAllHelp();
	}

	@Override
	public List<Member> selectAllMember(Map<String, Object> param) {
		List<Member> list = adminDao.selectAllMember(param);
		for(Member m : list) {
			List<MemberRole> role = adminDao.selectAllMemberRole(m);
			m.setMemberRole(role);
		}
		return list;
	}

	@Override
	public int insertAnnouncement(Map<String, Object> map) {
		return adminDao.insertAnnouncement(map);
	}

	@Override
	public int updateAnnouncement(Map<String, Object> map) {
		return adminDao.updateAnnouncement(map);
	}

	@Override
	public int deleteHelp(Map<String, Object> map) {
		int result = 0;
		result = adminDao.deleteHelp(map);
		result = adminDao.deleteLikes(map);
		return result;
	}

	@Override
	public int deleteAnnouncement(Map<String, Object> map) {
		return adminDao.deleteAnnouncement(map);
	}

	@Override
	public int updateEnabled(Map<String, Object> map) {
		return adminDao.updateEnabled(map);
	}

	@Override
	public int insertRole(Map<String, Object> map) {
		return adminDao.insertRole(map);
	}

	@Override
	public int deleteRole(Map<String, Object> map) {
		return adminDao.deleteRole(map);
	}

	@Override
	public int countAllMember(Map<String, Object> param) {
		return adminDao.countAllMember(param);
	}
	
	
	
}
