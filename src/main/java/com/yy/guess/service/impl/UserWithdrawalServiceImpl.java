package com.yy.guess.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.yy.guess.mapper.TradeFlowMapper;
import com.yy.guess.mapper.UserMapper;
import com.yy.guess.mapper.UserWithdrawalMapper;
import com.yy.guess.po.TradeFlow;
import com.yy.guess.po.UserWithdrawal;
import com.yy.guess.po.enums.TradeType;
import com.yy.guess.service.UserWithdrawalService;
import com.yy.fast4j.QueryCondition;

@Repository("userWithdrawalService")
@Transactional
public class UserWithdrawalServiceImpl implements UserWithdrawalService {
    @Autowired
    private UserWithdrawalMapper mapper;
    
    @Autowired
    private UserMapper um;
    
    @Autowired
    private TradeFlowMapper tfm;

    @Override
    public void add(UserWithdrawal obj) {
        mapper.add(obj);
    }

    @Override
    public void delete(int id) {
        mapper.delete(id);
    }

    @Override
    public void update(UserWithdrawal obj) {
        mapper.update(obj);
    }

    @Override
    public UserWithdrawal find(QueryCondition qc) {
        return mapper.find(qc);
    }

    @Override
    public UserWithdrawal findById(int id) {
        return mapper.findById(id);
    }

    @Override
    public List<UserWithdrawal> query(QueryCondition qc) {
        return mapper.query(qc);
    }

    @Override
    public int getCount(QueryCondition qc) {
        return mapper.getCount(qc);
    }
    /*****************************************************************分隔线************************************************************************/

	@Override
	public void withdrawal(UserWithdrawal obj) {
		double preBalance = um.getBalance(obj.getUserId());
		
		mapper.add(obj); //保存提款对象
		
		//保存流水对象
		TradeFlow tf = new TradeFlow();
		tf.setUserId(obj.getUserId());
		tf.setUserName(obj.getUserName());
		tf.setPreBalance(preBalance);
		tf.setAmount(0 - obj.getAmount());
		tf.setType(TradeType.提现);
		tfm.add(tf);
		
		um.plusBalance(0 - obj.getAmount(), obj.getUserId()); //更改余额
	}
}
