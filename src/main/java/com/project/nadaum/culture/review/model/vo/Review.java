package com.project.nadaum.culture.review.model.vo;

import java.io.Serializable;
import java.util.Date;

import com.project.nadaum.culture.show.model.vo.Culture;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Review implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String code;
	private String title;
	private String content;
	private String category;
	private int readCount;
	private Date regDate;
	private String id;
	
	
}
