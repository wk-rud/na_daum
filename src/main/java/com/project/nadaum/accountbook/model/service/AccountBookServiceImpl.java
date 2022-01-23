package com.project.nadaum.accountbook.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.nadaum.accountbook.model.dao.AccountBookDao;
import com.project.nadaum.accountbook.model.vo.AccountBook;

@Service
public class AccountBookServiceImpl implements AccountBookService {
	
	@Autowired
	private AccountBookDao accountBookDao;

	@Override
	public int insertAccount(AccountBook account) {
		return accountBookDao.insertAccount(account);
	}

	@Override
	public List<AccountBook> selectAllAccountList() {
		return accountBookDao.selectAllAccountList();
	}

	@Override
	public int deleteAccount(String code) {
		return accountBookDao.deleteAccount(code);
	}
	
	
	

}
