package com.project.nadaum.accountbook.model.service;

import java.util.List;
import java.util.Map;

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
	public List<AccountBook> selectAllAccountList(String id) {
		return accountBookDao.selectAllAccountList(id);
	}

	@Override
	public int deleteAccount(String code) {
		return accountBookDao.deleteAccount(code);
	}

	@Override
	public List<AccountBook> monthlyTotalIncome(String id) {
		return accountBookDao.monthlyTotalIncome(id);
	}

	@Override
	public String monthlyAccount(String id) {
		return accountBookDao.monthlyAccount(id);
	}

	@Override
	public Map<String, String> income_expense_filter(String id, String income_expense) {
		return accountBookDao.income_expense_filter(id, income_expense);
	}
	
	
	
	

}
