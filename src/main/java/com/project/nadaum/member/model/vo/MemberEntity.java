package com.project.nadaum.member.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MemberEntity implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String id;
	private String password;
	private String name;
	private String email;
	private String address;
	private Date regDate;
	private String phone;
	private String nickname;
	private String[] hobby;
	private Search search;
	private String introduce;
	private Date birthday;
	private String authKey;
	private boolean enabled;
	private String profile;
	private String loginType;
	private String profileStatus;

}
