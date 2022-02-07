package com.project.nadaum.diary.model.service;

import java.util.List;
import java.util.Map;

import com.project.nadaum.diary.model.vo.Diary;

public interface DiaryService {

	int insertDiary(Map<String, Object> map);

	int emotionNo(String emotion);

	List<Diary> recentlyDiary(Map<String, Object> map);

	Diary diaryDetail(String code);

	Map<String, Object> emotionNo(int emotionNo);

	int updateDiary(Map<String, Object> map);

	int deleteDiary(String code);

	List<Diary> monthChange(Map<String, Object> map);

	List<Diary> diarySearch(Map<String, Object> map);

}
