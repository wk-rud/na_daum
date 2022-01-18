package com.project.nadaum.culture.show.model.service;

import java.util.List;

import com.project.nadaum.culture.show.model.vo.Culture;

public interface CultureService {

	List<Culture> selectCultureList();

	Culture selectOneCulture(String code);

}
