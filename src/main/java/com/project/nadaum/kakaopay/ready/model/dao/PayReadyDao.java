package com.project.nadaum.kakaopay.ready.model.dao;

import com.project.nadaum.kakaopay.ready.model.vo.PayAuth;
import com.project.nadaum.kakaopay.ready.model.vo.PayReady;

public interface PayReadyDao {

	int insertPayReady(PayReady payReady);

	int insertPayAuth(PayAuth payAuth);

}
