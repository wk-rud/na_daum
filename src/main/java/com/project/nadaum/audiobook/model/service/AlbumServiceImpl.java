package com.project.nadaum.audiobook.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.nadaum.audiobook.model.dao.AlbumDao;

@Service
public class AlbumServiceImpl implements AlbumService{

	@Autowired
	private AlbumDao audioBookDao;
}
