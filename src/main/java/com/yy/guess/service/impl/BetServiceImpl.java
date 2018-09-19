package com.yy.guess.service.impl;

import java.text.DecimalFormat;
import java.util.List;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.yy.guess.component.ConfigComponent;
import com.yy.guess.mapper.BetMapper;
import com.yy.guess.mapper.RateRecordMapper;
import com.yy.guess.mapper.TradeFlowMapper;
import com.yy.guess.mapper.UserMapper;
import com.yy.guess.po.Bet;
import com.yy.guess.po.PlayType;
import com.yy.guess.po.RateRecord;
import com.yy.guess.po.TradeFlow;
import com.yy.guess.po.User;
import com.yy.guess.po.enums.BetDirection;
import com.yy.guess.po.enums.BetStatus;
import com.yy.guess.po.enums.TradeType;
import com.yy.guess.service.BetService;
import com.yy.guess.service.PlayTypeService;
import com.yy.guess.util.Util;
import com.yy.fast4j.QueryCondition;

@Repository("betService")
@Transactional
public class BetServiceImpl implements BetService {
	private static final Logger logger = LogManager.getLogger(BetServiceImpl.class);
	
    @Autowired
    private BetMapper mapper;
    
    @Autowired
    private TradeFlowMapper tfm;
    
    @Autowired
    private UserMapper um;
    
    @Autowired
    private ConfigComponent cfgCom;
    
    @Autowired
    private RateRecordMapper rrm;
    
    @Autowired
    private PlayTypeService pts;
    
    @Override
    public void add(Bet obj) {
        mapper.add(obj);
    }

    @Override
    public void delete(int id) {
        mapper.delete(id);
    }

    @Override
    public void update(Bet obj) {
        mapper.update(obj);
    }

    @Override
    public Bet find(QueryCondition qc) {
        return mapper.find(qc);
    }

    @Override
    public Bet findById(int id) {
        return mapper.findById(id);
    }

    @Override
    public List<Bet> query(QueryCondition qc) {
        return mapper.query(qc);
    }

    @Override
    public int getCount(QueryCondition qc) {
        return mapper.getCount(qc);
    }
    /*****************************************************************分隔线************************************************************************/

    //下注
    @Override
    public Bet bet(int playTypeId, int userId, String userName, BetDirection betDirection, double betAmount) {
    	if(betAmount <= 0) {
    		logger.warn("下注额必须大于零，betAmount=" + betAmount);
    		return null;
    	}

    	PlayType playType = this.pts.getStartPlayTypeByMap(playTypeId);
    	if(playType == null) {
    		logger.warn("playType为null");
    		return null;
    	}
    	
    	synchronized(playType) {
	    	//保存存bet到数据库
	    	double[] odds = pts.getOdds(playTypeId);
	    	Bet bet = new Bet();
	    	bet.setOrderNumber(Util.generateOrderNumber());
	    	bet.setVersusId(playType.getVersusId());
	    	bet.setBo(playType.getBo());
	    	bet.setPlayTypeId(playType.getId());
	    	bet.setUserId(userId);
	    	bet.setUserName(userName);
	    	bet.setBetDirection(betDirection);
	    	bet.setLeftOdds(odds[0]);
	    	bet.setRightOdds(odds[1]);
	    	bet.setBetAmount(betAmount);
	    	bet.setStatus(BetStatus.已下注);
	    	mapper.add(bet);
	    	
	    	//修改缓存奖金池
	    	pts.plusBonusPool(betAmount, betDirection, playTypeId);
	    	
	    	
	    	//查询用户原余额
			double preBalance = um.getBalance(userId);
			//修改用户余额
			um.plusBalance(0 - betAmount, userId);
			
			//添加流水记录
			TradeFlow flow = new TradeFlow();
			flow.setUserId(userId);
			flow.setUserName(userName);
			flow.setPreBalance(preBalance);
			flow.setAmount(0 - betAmount);
			flow.setType(TradeType.下注);
			tfm.add(flow);
			return bet;
    	}
    }

    @Override
	public void settlementOrRefund(int betId) {
    	Bet bet = mapper.findById(betId);
    	PlayType pt = pts.findById(bet.getPlayTypeId());
    	switch(pt.getStatus()) {
    	case 已结束:
    		this.settlement(betId, pt);
    		break;
    	case 未比赛:
    		this.refund(betId, null);
    		break;
    	default:
    		break;
    	}
    }
    
    @Override
    public void settlement(int betId, PlayType playType) {
    	Bet bet = mapper.findById(betId);
    	if(bet.getStatus() != BetStatus.已下注) {
    		return;
    	}
    	int result = playType.getResult();
		if(result < 0) { //左方胜
			if(bet.getBetDirection() == BetDirection.LEFT) {
				this.settlement(bet.getId(), bet.getUserId(), bet.getLeftOdds() * bet.getBetAmount(), cfgCom.getPlatformRate());
				return;
			}
		} else if(result > 0) { //右方胜
			if(bet.getBetDirection() == BetDirection.RIGHT) {
				this.settlement(bet.getId(), bet.getUserId(), bet.getRightOdds() * bet.getBetAmount(), cfgCom.getPlatformRate());
				return;
			}
		} else {
			//为平时不处理
			return;
		}
		mapper.updateStatus(BetStatus.未猜中, bet.getId());
    }
	private void settlement(int betId, int userId, double amount, double platformRate) {
		User user = um.findById(userId); //取出未更改前用户

		double choucheng = amount * platformRate; //平台抽成
		double shide = amount - choucheng;//实际返奖
		
		um.plusBalance(shide, userId);//更改余额
		
		mapper.updateStatusAndRealPayBonus(BetStatus.已结算, shide, betId);//更改bet状态
		
		//添加流水记录
		TradeFlow flow = new TradeFlow();
		flow.setUserId(userId);
		flow.setUserName(user.getUserName());
		flow.setPreBalance(user.getBalance());
		flow.setAmount(shide);
		flow.setType(TradeType.返奖);
		DecimalFormat df = new DecimalFormat("0.00");
		flow.setDescription("返奖：" + df.format(amount) + "，实得：" + df.format(shide) + "，平台抽成：" + df.format(choucheng));
		tfm.add(flow);
		
		//父用户返点
		choucheng = this.recursiveUserRate(user, um.findById(user.getSuperUserId()), choucheng);
		
		//添加平台抽成记录
		RateRecord record = new RateRecord();
		record.setUserId(userId);
		record.setBetId(betId);
		record.setAmount(choucheng);
		record.setPlatformRate(platformRate);
		rrm.add(record);
	}
	//递归用户上级返点，返回剩余的平台抽成
	private double recursiveUserRate(User childUser, User superUser, double choucheng) {
		if(childUser == null || superUser == null) {
			return choucheng;
		} else {
			double rate = superUser.getRebateRate() - childUser.getRebateRate();//返点率
			double amount = choucheng * rate; //返点金额
			if(amount > 0) { //大于零时才处理
				//更改用户余额
				um.plusBalance(amount, superUser.getId());
				
				//添加流水记录
				TradeFlow flow = new TradeFlow();
				flow.setUserId(superUser.getId());
				flow.setUserName(superUser.getUserName());
				flow.setPreBalance(superUser.getBalance());
				flow.setAmount(amount);
				flow.setType(TradeType.返点);
				flow.setDescription("下级返点");
				tfm.add(flow);
				
				return this.recursiveUserRate(superUser, um.findById(superUser.getSuperUserId()), choucheng - amount);
			} else {
				return choucheng;
			}
		}
	}

	//退款
	@Override
	public void refund(int betId, String description) {
		Bet bet = mapper.findById(betId);
    	if(bet.getStatus() != BetStatus.已下注) {
    		return;
    	}
		//原余额
		double preBalance = um.getBalance(bet.getUserId());
		
		//更改用户余额
		um.plusBalance(bet.getBetAmount(), bet.getUserId());
		
		//更改bet状态
		mapper.updateStatus(BetStatus.已退回, bet.getId());
		
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
	public List<Integer> getBetIdList(BetStatus status) {
		return mapper.getBetIdList(status);
	}
}