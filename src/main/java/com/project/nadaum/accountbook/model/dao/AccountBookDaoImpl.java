package com.project.nadaum.accountbook.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.nadaum.accountbook.model.vo.AccountBook;

@Repository
public class AccountBookDaoImpl implements AccountBookDao {
	
	@Autowired
	private SqlSessionTemplate session;

	@Override
	public int insertAccount(AccountBook account) {
		return session.insert("accountbook.insertAccount", account);
	}

	@Override
	public List<AccountBook> selectAllAccountList() {
		return session.selectList("accountbook.selectAllAccountList");
	}
	
	

}
