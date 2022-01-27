package com.project.nadaum.diary.model.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class DiaryDaoImpl implements DiaryDao {

	@Autowired
	SqlSessionTemplate session;

	@Override
	public int insertDiary(Map<String, Object> map) {
		return session.insert("diary.insertDiary", map);
	}

	@Override
	public int emotionNo(String emotion) {
		return session.selectOne("diary.emotionNo", emotion);
	}

}
