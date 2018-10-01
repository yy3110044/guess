package com.yy.guess.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.yy.guess.mapper.TradeFlowMapper;
import com.yy.guess.mapper.UserMapper;
import com.yy.guess.mapper.UserNoticeMapper;
import com.yy.guess.mapper.UserWithdrawalMapper;
import com.yy.guess.po.TradeFlow;
import com.yy.guess.po.UserNotice;
import com.yy.guess.po.UserWithdrawal;
import com.yy.guess.po.enums.TradeType;
import com.yy.guess.po.enums.UserWithdrawalStatus;
import com.yy.guess.service.UserWithdrawalService;
import com.yy.fast4j.Fast4jUtils;
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
    
    @Autowired
    private UserNoticeMapper unm;

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

	@Override
	public void updateWithdrawal(int withdrawalId, UserWithdrawalStatus status, String remark) {
		UserWithdrawal withdrawal = mapper.findById(withdrawalId);
		if(UserWithdrawalStatus.处理中 != withdrawal.getStatus()) { //只有状太为处理中的才处理
			return;
		}
		switch(status) {
		case 已同意:
			this.agreeWithdrawal(withdrawalId, remark, withdrawal.getUserId(), withdrawal.getUserName(), withdrawal.getAmount());
			break;
		case 已拒绝:
			this.refuseWithdrawal(withdrawalId, remark, withdrawal.getUserId(), withdrawal.getUserName(), withdrawal.getAmount());
			break;
		case 处理中:
			break;
		default:
			break;
		}
	}
	private void agreeWithdrawal(int withdrawalId, String remark, int userId, String userName, double amount) {//同意提款
		mapper.updateStatus(UserWithdrawalStatus.已同意, remark, withdrawalId);
		//发送通知
		UserNotice un = new UserNotice();
		un.setUserId(userId);
		un.setUserName(userName);
		un.setTitle("您的提款已到帐");
		un.setContent("您的提款：" + amount + "元，已到帐，请注意查收。");
		un.setSystemNotice(true);
		unm.add(un);
	}
	private void refuseWithdrawal(int withdrawalId, String remark, int userId, String userName, double amount) {//拒绝提款
		mapper.updateStatus(UserWithdrawalStatus.已拒绝, remark, withdrawalId);
		//发送通知
		UserNotice un = new UserNotice();
		un.setUserId(userId);
		un.setUserName(userName);
		un.setTitle("您的提款已拒绝");
		un.setContent("您的提款：" + amount + "元，已拒绝，金额已退回您的帐户。" + (Fast4jUtils.empty(remark) ? "" : ("拒绝原因：" + remark)));
		un.setSystemNotice(true);
		unm.add(un);
		
		double preBalance = um.getBalance(userId);
		
		um.plusBalance(amount, userId);//加回帐户余额
		
		//添加帐户流水
		TradeFlow tf = new TradeFlow();
		tf.setUserId(userId);
		tf.setUserName(userName);
		tf.setPreBalance(preBalance);
		tf.setAmount(amount);
		tf.setType(TradeType.退款);
		tf.setDescription(remark);
		tfm.add(tf);
	}
}
