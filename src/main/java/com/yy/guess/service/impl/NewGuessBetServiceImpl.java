package com.yy.guess.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.yy.guess.mapper.NewGuessBetMapper;
import com.yy.guess.mapper.NewGuessVersusItemMapper;
import com.yy.guess.mapper.NewGuessVersusMapper;
import com.yy.guess.mapper.TradeFlowMapper;
import com.yy.guess.mapper.UserMapper;
import com.yy.guess.mapper.UserNoticeMapper;
import com.yy.guess.po.NewGuessBet;
import com.yy.guess.po.NewGuessVersus;
import com.yy.guess.po.NewGuessVersusItem;
import com.yy.guess.po.TradeFlow;
import com.yy.guess.po.User;
import com.yy.guess.po.UserNotice;
import com.yy.guess.po.enums.NewGuessBetStatus;
import com.yy.guess.po.enums.NewGuessVersusStatus;
import com.yy.guess.po.enums.TradeType;
import com.yy.guess.service.NewGuessBetService;
import com.yy.guess.service.NewGuessVersusService;
import com.yy.guess.util.CachePre;
import com.yy.guess.util.Util;
import com.yy.fast4j.QueryCondition;

@Repository("newGuessBetService")
@Transactional
public class NewGuessBetServiceImpl implements NewGuessBetService {
	@Resource
    private NewGuessBetMapper mapper;
    
    @Resource
    private NewGuessVersusMapper ngvm;
    
    @Resource
    private NewGuessVersusItemMapper ngvim;
    
    @Resource
    private UserMapper um;
    
    @Resource
    private TradeFlowMapper tfm;
    
    @Resource
    private UserNoticeMapper unm;
    
    @Resource
    private NewGuessVersusService ngvs;

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
				
				ngvm.plusAllPayBonus(amount, bet.getVersusId()); //更新总金额
				ngvim.plusAllPayBonus(amount, bet.getVersusItemId());//更新总金额
				
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

	@Override
	public NewGuessBet bet(int versusId, int versusItemId, double betAmount, int userId) {
		User user = um.findById(userId);
		NewGuessBet bet = new NewGuessBet();
		bet.setOrderNumber(Util.generateOrderNumber());
		bet.setVersusId(versusId);
		bet.setVersusItemId(versusItemId);
		bet.setUserId(userId);
		bet.setUserName(user.getUserName());
		bet.setOdds(ngvs.getOdds(versusItemId));
		bet.setBetAmount(betAmount);
		bet.setStatus(NewGuessBetStatus.未结算);
		mapper.add(bet);
		
		//修改用户余额
		um.plusBalance(0 - betAmount, userId);
		
		//添加流水记录
		TradeFlow flow = new TradeFlow();
		flow.setUserId(userId);
		flow.setUserName(user.getUserName());
		flow.setPreBalance(user.getBalance());
		flow.setAmount(0 - betAmount);
		flow.setType(TradeType.下注);
		tfm.add(flow);
		
		//更新下注总额以及变动赔率
		updateBetAmountAndChangeOdds(versusId, versusItemId, betAmount);
		
		return bet;
	}
	
	//更新下注总额以及变动赔率
	private void updateBetAmountAndChangeOdds(int versusId, int versusItemId, double betAmount) {
		ngvm.plusBetAllAmount(betAmount, versusId);//更新下注总额
		ngvim.plusBetAmount(betAmount, versusItemId);//更新下注总额
		
		NewGuessVersus versus = ngvm.findById(versusId);
		List<NewGuessVersusItem> versusItemList = ngvim.query(new QueryCondition().addCondition("versusId", "=", versusId));
		for(NewGuessVersusItem versusItem : versusItemList) {
			updateChangeOdds(versus, versusItem);
		}

		
		//更新缓存
		NewGuessVersus cacheVersus = CachePre.versusMap.get(versusId);
		if(cacheVersus != null) {
			cacheVersus.setBetAllAmount(cacheVersus.getBetAllAmount() + betAmount);
		}
		NewGuessVersusItem cacheVersusItem = CachePre.versusItemMap.get(versusItemId);
		if(cacheVersusItem != null) {
			cacheVersusItem.setBetAmount(cacheVersusItem.getBetAmount() + betAmount);
		}
	}
	//更新变动赔率
	private void updateChangeOdds(NewGuessVersus versus, NewGuessVersusItem versusItem) {
		if(versus.getBetAllAmount() > 0 && versusItem.getBetAmount() > 0) {//当竞猜与竞猜项的下注额大于零时赔率才变动
			double current_changeOdds = versusItem.getChangeOdds();
			double changed_changeOdds = 1d / (versusItem.getBetAmount() / versus.getBetAllAmount());
			
			double finalChangeOdds = 0;
			if(changed_changeOdds > current_changeOdds) {//赔率增加了
				double temp = 0;
				if(versusItem.getChangeOddsPlusStrategy() > 0) {//按固定值限制增加
					temp = current_changeOdds + versusItem.getChangeOddsPlusValue();
					finalChangeOdds = temp < changed_changeOdds ? temp : changed_changeOdds;
				} else if(versusItem.getChangeOddsPlusStrategy() < 0) {//按百分比限制增加
					temp = current_changeOdds + current_changeOdds * versusItem.getChangeOddsPlusRatio();
					finalChangeOdds = temp < changed_changeOdds ? temp : changed_changeOdds;
				} else { //不限制
					finalChangeOdds = changed_changeOdds;
				}
			} else if(changed_changeOdds < current_changeOdds) {//赔率减少了
				double temp = 0;
				if(versusItem.getChangeOddsMinusStrategy() > 0) {//按固定值限制减少
					temp = current_changeOdds - versusItem.getChangeOddsMinusValue();
					finalChangeOdds = temp > changed_changeOdds ? temp : changed_changeOdds;
				} else if(versusItem.getChangeOddsMinusStrategy() < 0) {//按百分比限制减少
					temp = current_changeOdds - current_changeOdds * versusItem.getChangeOddsMinusRatio();
					finalChangeOdds = temp > changed_changeOdds ? temp : changed_changeOdds;
				} else { //不限制
					finalChangeOdds = changed_changeOdds;
				}
			} else {//赔率没变时不处理
				
			}
			if(finalChangeOdds < versusItem.getChangeOddsMin()) {
				finalChangeOdds = versusItem.getChangeOddsMin();
			}
			if(finalChangeOdds > versusItem.getChangeOddsMax()) {
				finalChangeOdds = versusItem.getChangeOddsMax();
			}
			if(finalChangeOdds != current_changeOdds) {//赔率发生了变动才更改
				ngvim.updateChangeOdds(finalChangeOdds, versusItem.getId());
				NewGuessVersusItem cacheVersusItem = CachePre.versusItemMap.get(versusItem.getId());//更改缓存
				if(cacheVersusItem != null) {
					cacheVersusItem.setChangeOdds(finalChangeOdds);
				}
			}
		}
	}
}
