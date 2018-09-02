package com.yy.guess.service.impl;

import java.text.DecimalFormat;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.yy.guess.component.ConfigComponent;
import com.yy.guess.component.OddsComponent;
import com.yy.guess.mapper.BetMapper;
import com.yy.guess.mapper.MatchVersusBoMapper;
import com.yy.guess.mapper.MatchVersusMapper;
import com.yy.guess.mapper.PlayTypeMapper;
import com.yy.guess.mapper.RateRecordMapper;
import com.yy.guess.mapper.TradeFlowMapper;
import com.yy.guess.mapper.UserMapper;
import com.yy.guess.playTemplate.GuessPlayTemplate;
import com.yy.guess.playTemplate.GuessPlayTemplateFactory;
import com.yy.guess.po.Bet;
import com.yy.guess.po.MatchVersus;
import com.yy.guess.po.MatchVersusBo;
import com.yy.guess.po.PlayType;
import com.yy.guess.po.RateRecord;
import com.yy.guess.po.TradeFlow;
import com.yy.guess.po.User;
import com.yy.guess.po.enums.BetDirection;
import com.yy.guess.po.enums.BetStatus;
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
    private OddsComponent oddsCom;
    
    @Autowired
    private ConfigComponent cfgCom;
    
    @Autowired
    private RateRecordMapper rrm;
    
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
    private final Map<Integer, PlayType> lockPlayTypeMap = new ConcurrentHashMap<Integer, PlayType>();
    
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
    			pt.setGuessStart(true);
    			lockPlayTypeMap.put(pt.getId(), pt);
    		}
    		ptm.updateGuessStartByVersusId(true, versusId);
    		return true;
    	} else {
    		return false;
    	}
	}
    
    //返回奖金池
    private double[] getBonusPool(int playTypeId) {
    	String redisKey = String.valueOf(playTypeId);
    	Double leftBonusPoolDouble = RedisUtil.getDouble(redisTemplate, CachePre.GUESS_LEFT_BONUS_POOL, redisKey);
    	double leftBonusPool = leftBonusPoolDouble == null ? 0 : leftBonusPoolDouble;
    	
    	Double rightBonusPoolDouble = RedisUtil.getDouble(redisTemplate, CachePre.GUESS_RIGHT_BONUS_POOL, redisKey);
    	double rightBonusPool = rightBonusPoolDouble == null ? 0 : rightBonusPoolDouble;
    	
    	return new double[] {leftBonusPool, rightBonusPool};
    }

    //关闭对阵下的的所有竞猜
	@Override
	public boolean stopGuessByVersusId(int versusId) {
		List<PlayType> ptList = ptm.query(new QueryCondition().addCondition("versusId", "=", versusId));
		if(ptList.size() > 0) {
			for(PlayType pt : ptList) {
				lockPlayTypeMap.remove(pt.getId());
				double[] bonusPool = this.getBonusPool(pt.getId());
				if(pt.isFixedOdds()) {
					ptm.updateBonusPool(bonusPool[0], bonusPool[1], pt.getId());
				} else {
					double leftOdds = oddsCom.getNewestOdds(pt.getId(), BetDirection.LEFT);
					double rightOdds = oddsCom.getNewestOdds(pt.getId(), BetDirection.RIGHT);
					ptm.updateOddsAndBonusPool(leftOdds, rightOdds, bonusPool[0], bonusPool[1], pt.getId());
				}
				this.cleanGuessCache(pt.getId());
			}
			ptm.updateGuessStartByVersusId(false, versusId);
			return true;
		} else {
			return false;
		}
	}
	
	@Override
	public boolean stopGuessByVerssuIdAndBo(int versusId, int bo) {
		List<PlayType> ptList = ptm.query(new QueryCondition().addCondition("versusId", "=", versusId).addCondition("bo", "=", bo));
		if(ptList.size() > 0) {
			for(PlayType pt : ptList) {
				lockPlayTypeMap.remove(pt.getId());
				double[] bonusPool = this.getBonusPool(pt.getId());
				if(pt.isFixedOdds()) {
					ptm.updateBonusPool(bonusPool[0], bonusPool[1], pt.getId());
				} else {
					double leftOdds = oddsCom.getNewestOdds(pt.getId(), BetDirection.LEFT);
					double rightOdds = oddsCom.getNewestOdds(pt.getId(), BetDirection.RIGHT);
					ptm.updateOddsAndBonusPool(leftOdds, rightOdds, bonusPool[0], bonusPool[1], pt.getId());
				}
				this.cleanGuessCache(pt.getId());
			}
			ptm.updateGuessStartByVersusIdAndBo(false, versusId, bo);
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
			ptm.updateGuessStartByPlayTypeId(true, playTypeId);
			lockPlayTypeMap.put(playTypeId, ptm.findById(playTypeId));
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
			double[] bonusPool = this.getBonusPool(pt.getId());
			if(pt.isFixedOdds()) {
				ptm.updateBonusPool(bonusPool[0], bonusPool[1], pt.getId());
			} else {
				double leftOdds = oddsCom.getNewestOdds(pt.getId(), BetDirection.LEFT);
				double rightOdds = oddsCom.getNewestOdds(pt.getId(), BetDirection.RIGHT);
				ptm.updateOddsAndBonusPool(leftOdds, rightOdds, bonusPool[0], bonusPool[1], pt.getId());
			}
			this.cleanGuessCache(playTypeId);
			ptm.updateGuessStartByPlayTypeId(false, playTypeId);
			return true;
		} else {
			return false;
		}
	}
	
	//查看某个玩法是否已开启竞猜
	@Override
	public boolean checkGuessStarted(int playTypeId) {
		return this.lockPlayTypeMap.get(playTypeId) != null;
	}
	//清除guess相关的cache，在关闭某个竞猜时调用
	@Override
	public void cleanGuessCache(int playTypeId) {
		String key = String.valueOf(playTypeId);
		RedisUtil.delete(redisTemplate, CachePre.GUESS_LEFT_BONUS_POOL, key);
		RedisUtil.delete(redisTemplate, CachePre.GUESS_RIGHT_BONUS_POOL, key);
	}

	//返回赔率
	public double getOdds(int playTypeId, BetDirection betDirection) {
		PlayType pt = this.lockPlayTypeMap.get(playTypeId);
		if(pt.isFixedOdds()) {
			switch(betDirection) {
			case LEFT: return pt.getLeftOdds();
			case RIGHT: return pt.getRightOdds();
			default:
				RuntimeException e = new RuntimeException("未知的betDirection");
				logger.error(e.toString());
				throw e;
			}
		} else {
			return oddsCom.getNewestOdds(playTypeId, betDirection);
		}
	}
	
	/**
	 *  下注
	 * @param playTypeId
	 * @param userId
	 * @param userName
	 * @param betDirection
	 * @param betAmount
	 * @return
	 */
	@Override
	public boolean bet(int playTypeId, int userId, String userName, BetDirection betDirection, double betAmount) {
		if(betAmount <= 0) {
			logger.warn("下注额必须大于零，betAmount=" + betAmount);
			return false;
		}
		
		PlayType lockPlayType = this.lockPlayTypeMap.get(playTypeId);
		if(lockPlayType == null) {
			logger.warn("lockPlayType为null");
			return false;
		}
		
		synchronized(lockPlayType) { //线程同步
			//保存下注对象
			Bet bet = new Bet();
			bet.setVersusId(lockPlayType.getVersusId());
			bet.setBo(lockPlayType.getBo());
			bet.setPlayTypeId(lockPlayType.getId());
			bet.setUserId(userId);
			bet.setUserName(userName);
			bet.setBetDirection(betDirection);
			bet.setBetAmount(betAmount);
			bet.setStatus(BetStatus.已下注);
			mapper.add(bet);
			
			//修改缓存奖金池
			String redisKey = String.valueOf(playTypeId);
			switch(betDirection) {
			case LEFT:
				Double leftBonusPool = RedisUtil.getDouble(redisTemplate, CachePre.GUESS_LEFT_BONUS_POOL, redisKey);
				RedisUtil.set(redisTemplate, CachePre.GUESS_LEFT_BONUS_POOL, redisKey, leftBonusPool == null ? betAmount : betAmount + leftBonusPool);
				break;
			case RIGHT:
				Double rightBonusPool = RedisUtil.getDouble(redisTemplate, CachePre.GUESS_RIGHT_BONUS_POOL, redisKey);
				RedisUtil.set(redisTemplate, CachePre.GUESS_RIGHT_BONUS_POOL, redisKey, rightBonusPool == null ? betAmount : betAmount + rightBonusPool);
				break;
			default:
				RuntimeException e = new RuntimeException("未知的betDirection");
				logger.error(e.toString());
				throw e;
			}
			
			//修改用户余额
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

	@Override
	public void settlement(Bet bet) {
		MatchVersus versus = mvm.findById(bet.getVersusId());
		PlayType pt = ptm.findById(bet.getPlayTypeId());
		List<MatchVersusBo> boList = mvbm.query(new QueryCondition().addCondition("versusId", "=", bet.getVersusId()).addSort("bo", SortType.ASC));
		GuessPlayTemplate template = GuessPlayTemplateFactory.getGuessPlayTemplate(pt.getTemplateClass());

		int result = template.getResult(versus, boList, pt);
		if(result < 0) { //左方胜
			if(bet.getBetDirection() == BetDirection.LEFT) {
				double platformRate = cfgCom.getPlatformRate();
				double odds = 0;
				if(pt.isFixedOdds()) { //使用固定赔率
					odds = pt.getLeftOdds();
				} else { //使用变动赔率
					odds = oddsCom.getNewestOdds(pt.getId(), BetDirection.LEFT);
				}
				this.settlement(bet.getId(), bet.getUserId(), odds * bet.getBetAmount(), platformRate);
			}
		} else if(result > 0) { //右方胜
			if(bet.getBetDirection() == BetDirection.RIGHT) {
				double platformRate = cfgCom.getPlatformRate();
				double odds = 0;
				if(pt.isFixedOdds()) { //使用固定赔率
					odds = pt.getRightOdds();
				} else { //使用变动赔率
					odds = oddsCom.getNewestOdds(pt.getId(), BetDirection.RIGHT);
				}
				this.settlement(bet.getId(), bet.getUserId(), odds * bet.getBetAmount(), platformRate);
			}
		} else {
			//为平时不处理
		}
	}
	private void settlement(int betId, int userId, double amount, double platformRate) {
		User user = um.findById(userId); //取出未更改前用户

		double choucheng = amount * platformRate; //平台抽成
		double shide = amount - choucheng;//实际返奖
		
		um.plusBalance(shide, userId);//更改余额
		
		mapper.setStatus(BetStatus.已结算, betId);//更改bet状态
		
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
}