package com.yy.guess.service.impl;

import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Queue;
import java.util.concurrent.ConcurrentHashMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.yy.guess.mapper.BetMapper;
import com.yy.guess.mapper.MatchVersusMapper;
import com.yy.guess.mapper.PlayTypeMapper;
import com.yy.guess.mapper.TradeFlowMapper;
import com.yy.guess.mapper.UserMapper;
import com.yy.guess.po.Bet;
import com.yy.guess.po.PlayType;
import com.yy.guess.po.TradeFlow;
import com.yy.guess.po.enums.BetDirection;
import com.yy.guess.po.enums.TradeType;
import com.yy.guess.service.BetService;
import com.yy.guess.service.MatchVersusService;
import com.yy.guess.util.CachePre;
import com.yy.fast4j.QueryCondition;
import com.yy.fast4j.RedisUtil;

@Repository("betService")
@Transactional
public class BetServiceImpl implements BetService {
    @Autowired
    private BetMapper mapper;
    
    @Autowired
    private RedisTemplate<String, Object> redisTemplate;
    
    @Autowired
    private TradeFlowMapper tfm;
    
    @Autowired
    private UserMapper um;
    
    @Autowired
    private PlayTypeMapper ptm;
    
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

    //用作同步锁对象的Map
    private Map<Integer, PlayType> lockPlayTypeMap = new ConcurrentHashMap<Integer, PlayType>();
    
    @Override
	public boolean startGuessByVersusId(int versusId) {
    	List<PlayType> ptList = ptm.query(new QueryCondition().addCondition("versusId", "=", versusId));
    	if(ptList.size() > 0) {
    		for(PlayType pt : ptList) {
    			lockPlayTypeMap.put(pt.getId(), pt);
    		}
    		return true;
    	} else {
    		return false;
    	}
	}

	@Override
	public boolean stopGuessByVersusId(int versusId) {
		List<PlayType> ptList = ptm.query(new QueryCondition().addCondition("versusId", "=", versusId));
		if(ptList.size() > 0) {
			for(PlayType pt : ptList) {
				lockPlayTypeMap.remove(pt.getId());
			}
			return true;
		} else {
			return false;
		}
	}

	@Override
	public boolean startGuessByPlayTypeId(int playTypeId) {
		PlayType pt = ptm.findById(playTypeId);
		if(pt != null) {
			lockPlayTypeMap.put(pt.getId(), pt);
			return true;
		} else {
			return false;
		}
	}

	@Override
	public boolean stopGuessByPlayTypeId(int playTypeId) {
		PlayType pt = ptm.findById(playTypeId);
		if(pt != null) {
			lockPlayTypeMap.remove(pt.getId());
			return true;
		} else {
			return false;
		}
	}
    
    /**
     * 下注方法
     */
	@Override
	public boolean bet(int versusId,
                       int playTypeId,
                       int userId,
                       String userName,
                       BetDirection betDirection,
                       double odds,
                       double betAmount) {
		PlayType lockPlayType = this.lockPlayTypeMap.get(playTypeId);
		if(lockPlayType == null) return false;
		
		synchronized (lockPlayType) { //线程同步
			String redisKey = String.valueOf(playTypeId);

			//奖池计算，并返回已售完金额
			this.calculateBonusPool(versusId, playTypeId, userId, userName, betDirection, odds, betAmount, redisKey);
			
			double preBalance = um.getBalance(userId);//查询用户原余额
			um.plusBalance(0 - betAmount, userId); //减去用户余额
			
			//添加流水记录
			TradeFlow flow = new TradeFlow();
			flow.setUserId(userId);
			flow.setUserName(userName);
			flow.setPreBalance(preBalance);
			flow.setAmount(0 - betAmount);
			flow.setType(TradeType.下注);
			tfm.add(flow);
		}
	}
	//奖池计算
	private void calculateBonusPool(int versusId,
                                    int playTypeId,
                                    int userId,
                                    String userName,
                                    BetDirection betDirection,
                                    double odds,
                                    double betAmount,
                                    String key) {
		Queue<Bet> leftBetQueue = this.getUnSoldBetQueue(CachePre.GUESS_LEFT_UNSOLD_BET_QUEUE, key);//左方未售完下注队列
		Queue<Bet> rightBetQueue = this.getUnSoldBetQueue(CachePre.GUESS_RIGHT_UNSOLD_BET_QUEUE, key);//右方未售完下注队列
		
		double leftBonusPool = this.getBonusPool(CachePre.GUESS_LEFT_BONUS_POOL, key);//左方奖金池
		double rightBonusPool = this.getBonusPool(CachePre.GUESS_RIGHT_BONUS_POOL, key);//右方奖金池

		double guessAmount = odds * betAmount;//对赌金额
		switch(betDirection) {
		case LEFT:
			if(guessAmount > rightBonusPool) { //对赌金额大于对方奖金池
				this.minusOrPlusBonusPool(CachePre.GUESS_RIGHT_BONUS_POOL, key, 0 - rightBonusPool); //减去对方奖金池
				//对赌金额未售完，还要把Bet存入到缓存中
				Bet bet = this.generateAndSaveBet(versusId, playTypeId, userId, userName, betDirection, odds, betAmount, guessAmount - rightBonusPool, false);
				this.addBetToRedis(CachePre.GUESS_LEFT_UNSOLD_BET_QUEUE, key, bet);//把未售完的bet添加到缓存中去
				
				//把未售完的添加到已方奖金池中
				this.minusOrPlusBonusPool(CachePre.GUESS_LEFT_BONUS_POOL, key, guessAmount - rightBonusPool);//把未售完的添加到己方奖金池中
				//接下来，还要从对方未售完的bet缓存中修改
				
			} else { //对赌金额小于等于对方奖金池
				this.minusOrPlusBonusPool(CachePre.GUESS_RIGHT_BONUS_POOL, key, 0 - guessAmount); //减去对方奖金池
				Bet bet = this.generateAndSaveBet(versusId, playTypeId, userId, userName, betDirection, odds, betAmount, betAmount, true);
			}
			break;
		case RIGHT:

			break;
		default:
			throw new RuntimeException("未知的投注方向");
		}
	}
	//生成并保存下注对象，并返回
	private Bet generateAndSaveBet(int versusId,
                            int playTypeId,
                            int userId,
                            String userName,
                            BetDirection betDirection,
                            double odds,
                            double betAmount,
                            double soldAmount,
                            boolean soldOut) {
		Bet bet = new Bet();
		bet.setVersusId(versusId);
		bet.setPlayTypeId(playTypeId);
		bet.setUserId(userId);
		bet.setUserName(userName);
		bet.setBetDirection(betDirection);
		bet.setOdds(odds);
		bet.setBetAmount(betAmount);
		bet.setSoldAmount(soldAmount);
		bet.setSoldOut(soldOut);
		this.mapper.add(bet);
		return bet;
	}
	//返回奖金池
	private double getBonusPool(String pre, String key) {
		Double bonusPool = RedisUtil.getDouble(redisTemplate, pre, key);
		return bonusPool == null ? 0 : bonusPool;
	}
	//增加或减少奖金池
	private void minusOrPlusBonusPool(String pre, String key, double plusBonus) {
		Double bonusPool = RedisUtil.getDouble(redisTemplate, pre, key);
		RedisUtil.set(redisTemplate, pre, key, bonusPool == null ? plusBonus : bonusPool + plusBonus);
	}
	//添加一个未售完bet到缓存
	private void addBetToRedis(String pre, String key, Bet bet) {
		@SuppressWarnings("unchecked")
		Queue<Bet> betQueue = (Queue<Bet>)RedisUtil.getObject(redisTemplate, pre, key);
		betQueue.offer(bet);
		RedisUtil.set(redisTemplate, pre, key, betQueue);
	}
	//从缓存bet中国消耗一定下载
	private void minusBet(String pre, String key, double minusMonus) {
		
	}
	/*
	//返回未售完的投注队列
	private Queue<Bet> getUnSoldBetQueue(String pre, String key) {
		@SuppressWarnings("unchecked")
		Queue<Bet> betQueue = (Queue<Bet>)RedisUtil.getObject(redisTemplate, pre, key);
		return betQueue == null ? new LinkedList<Bet>() : betQueue;
	}
	*/
}
