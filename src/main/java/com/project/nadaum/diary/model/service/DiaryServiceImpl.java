package com.project.nadaum.diary.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.nadaum.diary.model.dao.DiaryDao;
import com.project.nadaum.diary.model.vo.Diary;

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

	@Override
	public List<Diary> recentlyDiary(Map<String, Object> map) {
		return diaryDao.recentlyDiary(map);
	}

	@Override
	public Diary diaryDetail(String code) {
		return diaryDao.diaryDetail(code);
	}

	@Override
	public Map<String, Object> emotionNo(int emotionNo) {
		return diaryDao.emotion(emotionNo);
	}

	@Override
	public int updateDiary(Map<String, Object> map) {
		return diaryDao.updateDiary(map);
	}

	@Override
	public int deleteDiary(String code) {
		return diaryDao.deleteDiary(code);
	}

	@Override
	public List<Diary> monthChange(Map<String, Object> map) {
		return diaryDao.monthChange(map);
	}

	@Override
	public List<Diary> diarySearch(Map<String, Object> map) {
		return diaryDao.diarySearch(map);
	}}
