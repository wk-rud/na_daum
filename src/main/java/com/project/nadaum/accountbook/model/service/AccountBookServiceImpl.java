package com.project.nadaum.accountbook.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.nadaum.accountbook.model.dao.AccountBookDao;
import com.project.nadaum.accountbook.model.vo.AccountBook;
import com.project.nadaum.accountbook.model.vo.AccountBookChart;

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
	public int deleteAccount(Map<String, Object> code) {
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
	public List<AccountBook> incomeExpenseFilter(Map<String, Object> map) {
		return accountBookDao.incomeExpenseFilter(map);
	}

	@Override
	public List<AccountBook> searchList(Map<String, Object> map) {
		return accountBookDao.searchList(map);
	}

	@Override
	public List<Map<String,Object>> chartValue(Map<String,Object> param) {
		return accountBookDao.chartValue(param);
	}

	@Override
	public int countAccountList(Map<String, Object> param) {
		return accountBookDao.countAccountList(param);
	}

	@Override
	public List<Map<String,Object>> detailMonthlyChart(Map<String, Object> map) {
		return accountBookDao.detailMonthlyChart(map);
	}

	@Override
	public List<AccountBook> monthlyCountList(Map<String, Object> param) {
		return accountBookDao.monthlyCountList(param);
	}

	@Override
	public List<Map<String, Object>> categoryChart(Map<String, Object> map) {
		return accountBookDao.categoryChart(map);
	}

	
	
	
	
	
}
