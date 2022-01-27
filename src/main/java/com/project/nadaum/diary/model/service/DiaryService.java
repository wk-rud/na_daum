package com.project.nadaum.diary.model.service;

import java.util.Map;

public interface DiaryService {

	int insertDiary(Map<String, Object> map);

	int emotionNo(String emotion);

}
