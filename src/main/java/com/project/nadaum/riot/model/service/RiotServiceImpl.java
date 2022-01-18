package com.project.nadaum.riot.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.nadaum.riot.model.dao.RiotDao;
import com.project.nadaum.riot.model.vo.Summoner;


@Service
public class RiotServiceImpl implements RiotService {
	
	@Autowired
	private RiotDao riotDao;

	@Override
	public int insertSummoner(Summoner summoner) {
		
		return riotDao.insertSummoner(summoner);
	}

}
