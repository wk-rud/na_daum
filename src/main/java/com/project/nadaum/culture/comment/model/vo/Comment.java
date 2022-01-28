package com.project.nadaum.culture.comment.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Comment implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String code; //댓글번호
	private String apiCode; //게시글번호
	private int commentLevel;//default 1 =>댓글1, 대댓글2
	private int commentRef;//댓글이면 null, 대댓글이면 참조하는 댓글 번호(댓글 고유코드)
	private String content;
	private Date regDate;
	private int star; //별점
	private String id;
}
