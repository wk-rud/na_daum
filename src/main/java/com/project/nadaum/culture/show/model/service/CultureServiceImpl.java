package com.project.nadaum.culture.show.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.nadaum.culture.show.model.dao.CultureDao;
import com.project.nadaum.culture.show.model.vo.Culture;
import com.project.nadaum.memo.model.service.MemoServiceImpl;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class CultureServiceImpl implements CultureService {

	@Autowired
	private CultureDao cultureDao;
	@Override
	public List<Culture> selectCultureList() {
		return cultureDao.selectMemoList();
	}

}
