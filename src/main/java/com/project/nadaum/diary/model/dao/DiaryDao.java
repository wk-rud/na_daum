package com.project.nadaum.diary.model.dao;

import java.util.Map;

public interface DiaryDao {

	int insertDiary(Map<String, Object> map);

	int emotionNo(String emotion);

}
