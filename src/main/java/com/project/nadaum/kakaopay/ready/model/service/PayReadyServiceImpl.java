package com.project.nadaum.kakaopay.ready.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.nadaum.kakaopay.ready.model.dao.PayReadyDao;
import com.project.nadaum.kakaopay.ready.model.vo.PayAuth;
import com.project.nadaum.kakaopay.ready.model.vo.PayReady;

@Service
public class PayReadyServiceImpl implements PayReadyService {

	@Autowired
	private PayReadyDao payReadyDao;
	
	@Override
	public int insertPayReady(PayReady payReady) {
		int result = payReadyDao.insertPayReady(payReady);
		return result;
	}

	@Override
	public int insertPayAuth(PayAuth payAuth) {
		int result = payReadyDao.insertPayAuth(payAuth);
		return result;
	}

}
