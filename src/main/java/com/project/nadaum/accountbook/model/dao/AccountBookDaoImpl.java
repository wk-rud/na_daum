package com.project.nadaum.accountbook.model.dao;

import java.util.List;
import java.util.Map;

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
	public List<AccountBook> selectAllAccountList(String id) {
		return session.selectList("accountbook.selectAllAccountList", id);
	}

	@Override
	public int deleteAccount(String code) {
		return session.delete("accountbook.deleteAccount", code);
	}

	@Override
	public List<AccountBook> monthlyTotalIncome(String id) {
		return session.selectList("accountbook.monthlyTotalIncome", id);
	}

	@Override
	public String monthlyAccount(String id) {
		return session.selectOne("accountbook.monthlyAccount", id);
	}

	@Override
	public List<AccountBook> incomeExpenseFilter(Map<String, Object> map) {
		return session.selectList("accountbook.incomeExpenseFilter", map);
	}
	
	

}
