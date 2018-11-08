package com.yy.guess.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.yy.guess.mapper.NewGuessBetMapper;
import com.yy.guess.mapper.NewGuessVersusMapper;
import com.yy.guess.mapper.TradeFlowMapper;
import com.yy.guess.mapper.UserMapper;
import com.yy.guess.mapper.UserNoticeMapper;
import com.yy.guess.po.NewGuessBet;
import com.yy.guess.po.NewGuessVersus;
import com.yy.guess.po.TradeFlow;
import com.yy.guess.po.UserNotice;
import com.yy.guess.po.enums.NewGuessBetStatus;
import com.yy.guess.po.enums.NewGuessVersusStatus;
import com.yy.guess.po.enums.TradeType;
import com.yy.guess.service.NewGuessBetService;
import com.yy.guess.util.Util;
import com.yy.fast4j.QueryCondition;

@Repository("newGuessBetService")
@Transactional
public class NewGuessBetServiceImpl implements NewGuessBetService {
    @Autowired
    private NewGuessBetMapper mapper;
    
    @Resource
    private NewGuessVersusMapper ngvm;
    
    @Resource
    private UserMapper um;
    
    @Resource
    private TradeFlowMapper tfm;
    
    @Resource
    private UserNoticeMapper unm;

    @Override
    public void add(NewGuessBet obj) {
        mapper.add(obj);
    }

    @Override
    public void delete(int id) {
        mapper.delete(id);
    }

    @Override
    public void update(NewGuessBet obj) {
        mapper.update(obj);
    }

    @Override
    public NewGuessBet find(QueryCondition qc) {
        return mapper.find(qc);
    }

    @Override
    public NewGuessBet findById(int id) {
        return mapper.findById(id);
    }

    @Override
    public List<NewGuessBet> query(QueryCondition qc) {
        return mapper.query(qc);
    }

    @Override
    public int getCount(QueryCondition qc) {
        return mapper.getCount(qc);
    }
    /*****************************************************************分隔线************************************************************************/

	@Override
	public List<Integer> getBetIdList(int versusId, NewGuessBetStatus status) {
		return mapper.getBetIdList(versusId, status);
	}

	@Override
	public void settlement(int betId) {
		NewGuessBet bet = mapper.findById(betId);
		if(bet == null) {
			return;
		}
		if(bet.getStatus() != NewGuessBetStatus.未结算) {
			return;
		}
		NewGuessVersus versus = ngvm.findById(bet.getVersusId());
		if(versus == null) {
			return;
		}
		if(versus.getStatus() == NewGuessVersusStatus.未开始 || versus.getStatus() == NewGuessVersusStatus.进行中) {
			return;
		}
		
		if(versus.getStatus() == NewGuessVersusStatus.已结束) { //结算
			if(versus.getResultItemId() == bet.getVersusItemId()) { //猜中
				double amount = bet.getBetAmount() * bet.getOdds(); //中奖奖金
				double preBalance = um.getBalance(bet.getUserId());//用户原余额
				um.plusBalance(amount, bet.getUserId());//更改用户余额
				mapper.updateStatusAndPayBonus(NewGuessBetStatus.已猜中, amount, betId);//更改bet状态
				
				//添加流水记录
				TradeFlow flow = new TradeFlow();
				flow.setUserId(bet.getUserId());
				flow.setUserName(bet.getUserName());
				flow.setPreBalance(preBalance);
				flow.setAmount(amount);
				flow.setType(TradeType.返奖);
				flow.setDescription("返奖¥：" + Util.formatNumber(amount));
				tfm.add(flow);
				
				//发送通知
				UserNotice un = new UserNotice();
				un.setUserId(bet.getUserId());
				un.setUserName(bet.getUserName());
				un.setTitle("恭喜中奖");
				StringBuilder content = new StringBuilder();
				content.append("<div data-v-7c5a7d97=\"\" class=\"card-body\" style=\"font-size:1.4rem;\">下注金额：¥" + Util.formatNumber(bet.getBetAmount()) + "</div>");
				content.append("<div data-v-7c5a7d97=\"\" class=\"card-body\" style=\"font-size:1.4rem;\">赔率：" + Util.formatNumber(bet.getOdds()) + "</div>");
				content.append("<div data-v-7c5a7d97=\"\" class=\"card-body\" style=\"font-size:1.4rem;\">中奖金额：¥" + Util.formatNumber(amount) + "</div>");
				content.append("<div data-v-7c5a7d97=\"\" class=\"card-body\" style=\"font-size:1.4rem;\">订单号：" + bet.getOrderNumber() + "</div>");
				un.setContent(content.toString());
				un.setSystemNotice(true);
				unm.add(un);
			} else { //未猜中
				mapper.updateStatus(NewGuessBetStatus.未猜中, betId);//设置订单为未猜中
			}
		} else if(versus.getStatus() == NewGuessVersusStatus.流局) { //退款
			this.refund("竞猜流局，下注金额退回", betId);
		}
	}

	@Override
	public void refund(String description, int betId) {
		NewGuessBet bet = mapper.findById(betId);
		if(bet.getStatus() != NewGuessBetStatus.未结算) {
			return;
		}
		double preBalance = um.getBalance(bet.getUserId());//原余额
		um.plusBalance(bet.getBetAmount(), bet.getUserId());//更改用户余额
		mapper.updateStatus(NewGuessBetStatus.已退回, betId);//更改bet状态
		//添加流水记录
		TradeFlow flow = new TradeFlow();
		flow.setUserId(bet.getUserId());
		flow.setUserName(bet.getUserName());
		flow.setPreBalance(preBalance);
		flow.setAmount(bet.getBetAmount());
		flow.setType(TradeType.退款);
		flow.setDescription(description);
		tfm.add(flow);
	}
}
