package com.yy.guess.service.impl;

import java.util.ArrayDeque;
import java.util.List;
import java.util.Map;
import java.util.Queue;
import java.util.concurrent.ConcurrentHashMap;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.yy.guess.component.ConfigComponent;
import com.yy.guess.mapper.BetMapper;
import com.yy.guess.mapper.MatchVersusBoMapper;
import com.yy.guess.mapper.MatchVersusMapper;
import com.yy.guess.mapper.PlayTypeMapper;
import com.yy.guess.mapper.TradeFlowMapper;
import com.yy.guess.mapper.UserMapper;
import com.yy.guess.playTemplate.GuessPlayTemplate;
import com.yy.guess.playTemplate.GuessPlayTemplateFactory;
import com.yy.guess.po.Bet;
import com.yy.guess.po.MatchVersus;
import com.yy.guess.po.MatchVersusBo;
import com.yy.guess.po.PlayType;
import com.yy.guess.po.TradeFlow;
import com.yy.guess.po.User;
import com.yy.guess.po.enums.BetDirection;
import com.yy.guess.po.enums.TradeType;
import com.yy.guess.service.BetService;
import com.yy.guess.util.CachePre;
import com.yy.fast4j.QueryCondition;
import com.yy.fast4j.RedisUtil;
import com.yy.fast4j.QueryCondition.SortType;

@Repository("betService")
@Transactional
public class BetServiceImpl implements BetService {
	private static final Logger logger = LogManager.getLogger(BetServiceImpl.class);
	
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
    
    @Autowired
    private MatchVersusMapper mvm;
    
    @Autowired
    private MatchVersusBoMapper mvbm;
    
    @Autowired
    private ConfigComponent cfgCom;
    
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
    
    //从数据库读取已开启的竞猜
    @Override
    public void loadStartedGuess() {
    	List<PlayType> ptList = ptm.query(new QueryCondition().addCondition("guessStart", "=", true));
    	for(PlayType pt : ptList) {
    		this.lockPlayTypeMap.put(pt.getId(), pt);
    	}
    }
    
    //开启对阵下的所有竞猜
    @Override
	public boolean startGuessByVersusId(int versusId) {
    	List<PlayType> ptList = ptm.query(new QueryCondition().addCondition("versusId", "=", versusId));
    	if(ptList.size() > 0) {
    		for(PlayType pt : ptList) {
    			lockPlayTypeMap.put(pt.getId(), pt);
    		}
    		ptm.updateGuessStartByVersusId(true, versusId);
    		return true;
    	} else {
    		return false;
    	}
	}

    //关闭对阵下的的有竞猜
	@Override
	public boolean stopGuessByVersusId(int versusId) {
		List<PlayType> ptList = ptm.query(new QueryCondition().addCondition("versusId", "=", versusId));
		if(ptList.size() > 0) {
			for(PlayType pt : ptList) {
				lockPlayTypeMap.remove(pt.getId());
				this.cleanGuessCache(pt.getId());
			}
			ptm.updateGuessStartByVersusId(false, versusId);
			return true;
		} else {
			return false;
		}
	}

	//开启某个竞猜
	@Override
	public boolean startGuessByPlayTypeId(int playTypeId) {
		PlayType pt = ptm.findById(playTypeId);
		if(pt != null) {
			lockPlayTypeMap.put(pt.getId(), pt);
			ptm.updateGuessStartByPlayTypeId(true, playTypeId);
			return true;
		} else {
			return false;
		}
	}
	
	//关闭某个竞猜
	@Override
	public boolean stopGuessByPlayTypeId(int playTypeId) {
		PlayType pt = ptm.findById(playTypeId);
		if(pt != null) {
			lockPlayTypeMap.remove(pt.getId());
			this.cleanGuessCache(playTypeId);
			ptm.updateGuessStartByPlayTypeId(false, playTypeId);
			return true;
		} else {
			return false;
		}
	}
	
	//查看某个玩法是否已开启竞猜
	@Override
	public boolean checkGuessStarted(int pleyTypeId) {
		return this.lockPlayTypeMap.get(pleyTypeId) != null;
	}
	//清除guess相关的cache，在关闭某个竞猜时调用
	private void cleanGuessCache(int playTypeId) {
		String key = String.valueOf(playTypeId);
		RedisUtil.delete(redisTemplate, CachePre.GUESS_LEFT_BONUS_POOL, key);
		RedisUtil.delete(redisTemplate, CachePre.GUESS_RIGHT_BONUS_POOL, key);
		RedisUtil.delete(redisTemplate, CachePre.GUESS_LEFT_UNSOLD_BET_QUEUE, key);
		RedisUtil.delete(redisTemplate, CachePre.GUESS_RIGHT_UNSOLD_BET_QUEUE, key);
		RedisUtil.delete(redisTemplate, CachePre.GUESS_LEFT_NEWEST_ODDS, key);
		RedisUtil.delete(redisTemplate, CachePre.GUESS_RIGHT_NEWEST_ODDS, key);
	}
    
    /**
     *   下注方法
     */
	@Override
	public boolean bet(int playTypeId,
                       int userId,
                       String userName,
                       BetDirection betDirection,
                       double odds,
                       double betAmount) {
		if(odds <= 0 || betAmount <= 0) {
			RuntimeException e = new RuntimeException("odds、betAmount必须大于零");
			logger.error(e.toString());
			throw e;
		}
		
		PlayType lockPlayType = this.lockPlayTypeMap.get(playTypeId);
		if(lockPlayType == null) {
			return false;
		}
		
		synchronized (lockPlayType) { //线程同步
			//奖池计算
			this.calculateBonusPool(lockPlayType.getVersusId(), lockPlayType.getBo(), playTypeId, userId, userName, betDirection, odds, betAmount);
			
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
			return true;
		}
	}
	
	//奖池计算
	private void calculateBonusPool(int versusId,
									int bo,
                                    int playTypeId,
                                    int userId,
                                    String userName,
                                    BetDirection betDirection,
                                    double odds,
                                    double betAmount) {
		String redisKey = String.valueOf(playTypeId); //redis缓存key
		
		String ownSideBonusPoolPre = null; //已方奖金池Pre
		String ownSideUnSoldBetQueuePre = null; //已方未售完Bet队列Pre
		
		String newestOddsPre = null; //最新赔率pre
		switch(betDirection) {
		case LEFT:
			ownSideBonusPoolPre = CachePre.GUESS_LEFT_BONUS_POOL;
			ownSideUnSoldBetQueuePre = CachePre.GUESS_LEFT_UNSOLD_BET_QUEUE;
			newestOddsPre = CachePre.GUESS_LEFT_NEWEST_ODDS;
			break;
		case RIGHT:
			ownSideBonusPoolPre = CachePre.GUESS_RIGHT_BONUS_POOL;
			ownSideUnSoldBetQueuePre = CachePre.GUESS_RIGHT_UNSOLD_BET_QUEUE;
			newestOddsPre = CachePre.GUESS_RIGHT_NEWEST_ODDS;
			break;
		default:
			RuntimeException e = new RuntimeException("未知的投注方向");
			logger.error(e);
			throw e;
		}
		
		//把金额添加进已方奖金池
		this.minusOrPlusBonusPool(ownSideBonusPoolPre, redisKey, betAmount);
		
		//更新最新赔率
		RedisUtil.set(redisTemplate, newestOddsPre, redisKey, odds);
		
		//生成Bet对象并保存到redis缓存中
		this.addBetToRedis(ownSideUnSoldBetQueuePre, redisKey, this.generateAndSaveBet(versusId, bo, playTypeId, userId, userName, betDirection, odds, betAmount, 0, false));

		//计算双方奖池
		this.calculateBothSideBonusPool(CachePre.GUESS_LEFT_BONUS_POOL, CachePre.GUESS_RIGHT_UNSOLD_BET_QUEUE, redisKey);
		this.calculateBothSideBonusPool(CachePre.GUESS_RIGHT_BONUS_POOL, CachePre.GUESS_LEFT_UNSOLD_BET_QUEUE, redisKey);
	}

	//生成并保存下注对象，并返回
	private Bet generateAndSaveBet(int versusId,
							int bo,
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
		bet.setBo(bo);
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
	//增加或减少奖金池
	private void minusOrPlusBonusPool(String pre, String key, double plusBonus) {
		if(plusBonus == 0) {
			return;
		}
		Double bonusPoolDouble = RedisUtil.getDouble(redisTemplate, pre, key);
		double bonusPool = bonusPoolDouble == null ? plusBonus : bonusPoolDouble + plusBonus;
		if(bonusPool < 0) {
			RuntimeException e = new RuntimeException("bonusPool不能被减到小于零，bonusPoolDouble=" + bonusPoolDouble + "，bonusPool=" + bonusPool);
			logger.error(e.toString());
			throw e;
		} else {
			RedisUtil.set(redisTemplate, pre, key, bonusPool);;
		}
	}
	//返回奖金池
	private double getBonusPool(String pre, String key) {
		Double bonusPool = RedisUtil.getDouble(redisTemplate, pre, key);
		if(bonusPool == null) {
			RedisUtil.set(redisTemplate, pre, key, 0);
			return 0;
		} else {
			return bonusPool;
		}
	}
	//返回未售完Bet队列
	private Queue<Bet> getUnSoldBetQueue(String pre, String key) {
		@SuppressWarnings("unchecked")
		Queue<Bet> betQueue = (Queue<Bet>)RedisUtil.getObject(redisTemplate, pre, key);
		if(betQueue == null) {
			betQueue = new ArrayDeque<Bet>();
			RedisUtil.set(redisTemplate, pre, key, betQueue);
		}
		return betQueue;
	}
	//添加一个未售完bet到缓存
	private void addBetToRedis(String pre, String key, Bet bet) {
		if(bet.getSoldAmount() >= bet.getBetAmount() || bet.isSoldOut()) {
			RuntimeException e = new RuntimeException("已被售完的，不能添加：betAmount：" + bet.getBetAmount() + "，soldAmount：" + bet.getSoldAmount() + "，soldOut：" + bet.isSoldOut());
			logger.error(e);
			throw e;
		}
		@SuppressWarnings("unchecked")
		Queue<Bet> betQueue = (Queue<Bet>)RedisUtil.getObject(redisTemplate, pre, key);
		if(betQueue == null) {
			betQueue = new ArrayDeque<Bet>();
		}
		betQueue.offer(bet);
		RedisUtil.set(redisTemplate, pre, key, betQueue);
	}
	
	//计算双方奖池
	private void calculateBothSideBonusPool(String bonusPoolPre, String unSoldBetQueuePre, String key) {
		double bonus = this.getBonusPool(bonusPoolPre, key);
		Queue<Bet> unSoldBetQueue = this.getUnSoldBetQueue(unSoldBetQueuePre, key);
		
		//递归计算奖池，并返回剩余奖池
		double lastBonusPool = this.recursiveCalculateBothSideBonusPool(bonus, unSoldBetQueue);
		
		RedisUtil.set(redisTemplate, bonusPoolPre, key, lastBonusPool);
		RedisUtil.set(redisTemplate, unSoldBetQueuePre, key, unSoldBetQueue);
	}
	//递归计算双方奖池
	private double recursiveCalculateBothSideBonusPool(double bonus, Queue<Bet> unSoldBetQueue) {
		if(bonus < 0) {
			RuntimeException e = new RuntimeException("bonus不能小于零");
			logger.error(e);
			throw e;
		} else if(bonus == 0) {
			return bonus;
		} else {
			Bet bet = unSoldBetQueue.peek();
			if(bet != null) {
				double otherSideLastAmount = (bet.getBetAmount() - bet.getSoldAmount()) * bet.getOdds(); //另一方对赌需要出的金额
				if(otherSideLastAmount < 0) {
					RuntimeException e = new RuntimeException("otherSideLastAmount不能小于零：" + otherSideLastAmount);
					logger.error(e);
					throw e;
				}
				if(otherSideLastAmount < bonus) { //未售完的，小于要消耗的金额，说明还要再取
					unSoldBetQueue.poll();//从queue中移除
					mapper.updateSoldAmount(bet.getBetAmount(), true, bet.getId());//更新数据库
					return this.recursiveCalculateBothSideBonusPool(bonus - otherSideLastAmount, unSoldBetQueue);
				} else if(otherSideLastAmount > bonus) { //未售完的，大于要消耗的金额，说明够了，还有剩
					bet.setSoldAmount(bet.getSoldAmount() + bonus / bet.getOdds());
					mapper.updateSoldAmount(bet.getSoldAmount(), false, bet.getId());//更新数据库
					return 0;
				} else { //未售完的，等于要消耗的金额，说明刚好售完
					unSoldBetQueue.poll();//从queue中移除
					mapper.updateSoldAmount(bet.getBetAmount(), true, bet.getId());//更新数据库
					return 0;
				}
			} else {
				return bonus;
			}
		}
	}

	@Override
	public void settlement(Bet bet) {
		MatchVersus versus = mvm.findById(bet.getVersusId());
		List<MatchVersusBo> boList = mvbm.query(new QueryCondition().addCondition("versusId", "=", bet.getVersusId()).addSort("bo", SortType.ASC));
		PlayType pt = ptm.findById(bet.getPlayTypeId());
		
		GuessPlayTemplate temp = GuessPlayTemplateFactory.getGuessPlayTemplate(pt.getTemplateClass());
		int result = temp.getResult(versus, boList, pt);
		if(result < 0) { //左方胜
			if(bet.getBetDirection() == BetDirection.LEFT) {
				double bonus = bet.getSoldAmount() * bet.getOdds(); //奖金
				double unSoldRefund = bet.getBetAmount() - bet.getSoldAmount(); //未售完的退款
			}
		} else if(result > 0) { //右方胜
			if(bet.getBetDirection() == BetDirection.RIGHT) {
				
			}
		} else { //平，不处理
			return
		}
	}
}