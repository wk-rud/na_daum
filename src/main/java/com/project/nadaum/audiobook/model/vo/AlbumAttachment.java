package com.project.nadaum.audiobook.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AlbumAttachment implements Serializable{


	private static final long serialVersionUID = 1L;

	private int no;
	private String albumCode;
	private String originalFilename;
	private String renamedFilename;
	private Date uploadDate;
	private int downloadCount;
	private boolean status;
}
