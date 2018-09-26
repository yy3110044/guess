package com.yy.guess.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.yy.guess.mapper.TradeFlowMapper;
import com.yy.guess.mapper.UserMapper;
import com.yy.guess.po.TradeFlow;
import com.yy.guess.po.User;
import com.yy.guess.po.enums.TradeType;
import com.yy.guess.service.TradeFlowService;
import com.yy.guess.util.QueryResult;
import com.yy.fast4j.Page;
import com.yy.fast4j.QueryCondition;

@Repository("tradeFlowService")
@Transactional
public class TradeFlowServiceImpl implements TradeFlowService {
    @Autowired
    private TradeFlowMapper mapper;
    
    @Autowired
    private UserMapper um;

    @Override
    public void add(TradeFlow obj) {
        mapper.add(obj);
    }

    @Override
    public void delete(int id) {
        mapper.delete(id);
    }

    @Override
    public void update(TradeFlow obj) {
        mapper.update(obj);
    }

    @Override
    public TradeFlow find(QueryCondition qc) {
        return mapper.find(qc);
    }

    @Override
    public TradeFlow findById(int id) {
        return mapper.findById(id);
    }

    @Override
    public List<TradeFlow> query(QueryCondition qc) {
        return mapper.query(qc);
    }

    @Override
    public int getCount(QueryCondition qc) {
        return mapper.getCount(qc);
    }
    /*****************************************************************分隔线************************************************************************/

	@Override
	public Object[] updateBalance(double amount, TradeType type, String description, int userId) {
		User user = um.findById(userId);
		if(user == null) {
			return new Object[]{101, "不存在此用户"};
		}
		if(amount == 0) {
			return new Object[]{102, "更改金额不能为零"};
		}
		if(user.getBalance() + amount < 0) {
			return new Object[]{103, "用户余额不能小于零"};
		}
		TradeFlow flow = new TradeFlow();
		flow.setUserId(user.getId());
		flow.setUserName(user.getUserName());
		flow.setPreBalance(user.getBalance());
		flow.setAmount(amount);
		flow.setType(type);
		flow.setDescription(description);
		mapper.add(flow);
		um.plusBalance(amount, userId);
		return new Object[]{100, "更改成功"};
	}

	@Override
	public QueryResult<TradeFlow> queryByIndex(int userId, int index, Page page) {
		List<TradeFlow> list = mapper.queryByIndex(userId, index, page);
		page.setRowCount(mapper.queryByIndexCount(userId, index));
		return new QueryResult<TradeFlow>(list, page);
	}
}
