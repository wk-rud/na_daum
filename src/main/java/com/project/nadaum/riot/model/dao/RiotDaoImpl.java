package com.project.nadaum.riot.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.nadaum.riot.model.vo.Summoner;

@Repository
public class RiotDaoImpl implements RiotDao {

	
	@Autowired
	private SqlSessionTemplate session;
	
	@Override
	public int insertSummoner(Summoner summoner) {
		
		return session.insert("riot.insertSummoner",summoner);
	}

}
