package com.project.nadaum.diary.model.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.nadaum.diary.model.dao.DiaryDao;

@Service
public class DiaryServiceImpl implements DiaryService {
	
	@Autowired
	private DiaryDao diaryDao;

	@Override
	public int insertDiary(Map<String, Object> map) {
		return diaryDao.insertDiary(map);
	}

	@Override
	public int emotionNo(String emotion) {
		return diaryDao.emotionNo(emotion);
	}

}
