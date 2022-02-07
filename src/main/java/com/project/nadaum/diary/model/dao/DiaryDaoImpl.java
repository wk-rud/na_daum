package com.project.nadaum.diary.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.nadaum.diary.model.vo.Diary;

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

	@Override
	public List<Diary> recentlyDiary(Map<String, Object> map) {
		return session.selectList("diary.recentlyDiary", map);
	}

	@Override
	public Diary diaryDetail(String code) {
		return session.selectOne("diary.diaryDetail", code);
	}

	@Override
	public Map<String, Object> emotion(int emotionNo) {
		return session.selectOne("diary.emotion", emotionNo);
	}

	@Override
	public int updateDiary(Map<String, Object> map) {
		return session.update("diary.updateDiary", map);
	}

	@Override
	public int deleteDiary(String code) {
		return session.delete("diary.deleteDiary", code);
	}

	@Override
	public List<Diary> monthChange(Map<String, Object> map) {
		return session.selectList("diary.monthChange", map);
	}

	@Override
	public List<Diary> diarySearch(Map<String, Object> map) {
		return session.selectList("diary.diarySearch", map);
	}

}
