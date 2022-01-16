package com.project.nadaum.audiobook.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.nadaum.audiobook.model.dao.AudioBookDao;

@Service
public class AudioBookServiceImpl implements AudioBookService{

	@Autowired
	private AudioBookDao audioBookDao;
}
