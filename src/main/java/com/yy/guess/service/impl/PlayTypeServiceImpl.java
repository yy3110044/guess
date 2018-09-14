package com.yy.guess.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import javax.annotation.PostConstruct;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.yy.guess.component.ConfigComponent;
import com.yy.guess.mapper.MatchVersusMapper;
import com.yy.guess.mapper.PlayTypeMapper;
import com.yy.guess.po.MatchVersus;
import com.yy.guess.po.PlayType;
import com.yy.guess.po.enums.BetDirection;
import com.yy.guess.service.PlayTypeService;
import com.yy.guess.util.CachePre;
import com.yy.fast4j.QueryCondition;
import com.yy.fast4j.RedisUtil;
import com.yy.fast4j.QueryCondition.SortType;

@Repository("playTypeService")
@Transactional
public class PlayTypeServiceImpl implements PlayTypeService {
	private static final Logger logger = LogManager.getLogger(PlayTypeServiceImpl.class);
	
	@Autowired
	private RedisTemplate<String, Object> redisTemplate;
	
	@Autowired
	private ConfigComponent cfgCom;
	
    @Autowired
    private PlayTypeMapper mapper;
    
    @Autowired
    private MatchVersusMapper mvm;

    @Override
    public void add(PlayType obj) {
        mapper.add(obj);
        if(obj.isGuessStart()) {
        	startedPlayTypeMap.put(obj.getId(), obj);
        }
    }

    @Override
    public void delete(int id) {
    	PlayType pt = mapper.findById(id);
        mapper.delete(id);
        if(pt != null) {
        	mvm.plusPlayTypeCount(-1, pt.getVersusId());//更新versus中的玩法数
        }
        startedPlayTypeMap.remove(id);
    }

    @Override
    public void update(PlayType obj) {
        mapper.update(obj);
        if(obj.isGuessStart()) {
        	startedPlayTypeMap.put(obj.getId(), obj);
        }
    }

    @Override
    public PlayType find(QueryCondition qc) {
        return mapper.find(qc);
    }

    @Override
    public PlayType findById(int id) {
        return mapper.findById(id);
    }

    @Override
    public List<PlayType> query(QueryCondition qc) {
        return mapper.query(qc);
    }

    @Override
    public int getCount(QueryCondition qc) {
        return mapper.getCount(qc);
    }
    /*****************************************************************分隔线************************************************************************/

    @Override
	public void addList(List<PlayType> ptList, int versusId) {
		mapper.addList(ptList);
		mvm.plusPlayTypeCount(ptList.size(), versusId);//更新versus中的玩法数
		loadStartedPlayTypeToMap(); //重新加载PlayType
	}
    
    private final Map<Integer, PlayType> startedPlayTypeMap = new ConcurrentHashMap<Integer, PlayType>();
    @Override
    @PostConstruct//系统启动时加载
    public void loadStartedPlayTypeToMap() {
    	List<PlayType> list = mapper.query(new QueryCondition().addCondition("guessStart", "=", true));
    	for(PlayType pt : list) {
    		startedPlayTypeMap.put(pt.getId(), pt);
    	}
    }

    @Override
	public PlayType getStartPlayTypeByMap(int id) {
		return startedPlayTypeMap.get(id);
	}

	@Override
	public void deleteByVersusId(int versusId) {
		List<Integer> playTypeIdList = mapper.getPlayTypeIdListByVersusId(versusId);
		mapper.deleteByVersusId(versusId);
		for(Integer id : playTypeIdList) {
			startedPlayTypeMap.remove(id);
		}
	}

	@Override
	public void deleteByVersusIdAndBo(int versusId, int bo) {
		List<Integer> playTypeIdList = mapper.getPlayTypeIdListByVersusIdAndBo(versusId, bo);
		mapper.deleteByVersusIdAndBo(versusId, bo);
		for(Integer id : playTypeIdList) {
			startedPlayTypeMap.remove(id);
		}
	}

	@Override
	public void updateGuessStartByPlayTypeId(boolean guessStart, int playTypeId) {
		mapper.updateGuessStartByPlayTypeId(guessStart, playTypeId);
		if(guessStart) { //开
			PlayType playType = mapper.findById(playTypeId);
			if(playType != null) {
				this.startedPlayTypeMap.put(playType.getId(), playType);
			}
		} else { //关
			this.startedPlayTypeMap.remove(playTypeId);
		}
	}

	@Override
	public void updateGuessStartByVersusId(boolean guessStart, int versusId) {
		mapper.updateGuessStartByVersusId(guessStart, versusId);
		if(guessStart) {
			List<PlayType> list = mapper.query(new QueryCondition().addCondition("versusId", "=", versusId));
			for(PlayType playType : list) {
				this.startedPlayTypeMap.put(playType.getId(), playType);
			}
		} else {
			List<Integer> idList = mapper.getPlayTypeIdListByVersusId(versusId);
			for(Integer id : idList) {
				this.startedPlayTypeMap.remove(id);
			}
		}
	}

	@Override
	public void updateGuessStartByVersusIdAndBo(boolean guessStart, int versusId, int bo) {
		mapper.updateGuessStartByVersusIdAndBo(guessStart, versusId, bo);
		if(guessStart) {
			List<PlayType> list = mapper.query(new QueryCondition().addCondition("versusId", "=", versusId).addCondition("bo", "=", bo));
			for(PlayType playType : list) {
				this.startedPlayTypeMap.put(playType.getId(), playType);
			}
		} else {
			List<Integer> idList = mapper.getPlayTypeIdListByVersusIdAndBo(versusId, bo);
			for(Integer id : idList) {
				this.startedPlayTypeMap.remove(id);
			}
		}
	}
	
	@Override
	public void updateWinRate(double leftWinRate, double rightWinRate, int playTypeId) {
		mapper.updateWinRate(leftWinRate, rightWinRate, playTypeId);
		PlayType playType = this.startedPlayTypeMap.get(playTypeId);
		if(playType != null) {
			playType.setLeftWinRate(leftWinRate);
			playType.setRightWinRate(rightWinRate);
		}
	}
	
	@Override
	public void updateFixedOdds(boolean fixedOdds, int playTypeId) {
		mapper.updateFixedOdds(fixedOdds, playTypeId);
		PlayType playType = this.startedPlayTypeMap.get(playTypeId);
		if(playType != null) {
			playType.setFixedOdds(fixedOdds);
		}
	}
	
	@Override
	public void updateWinRateAndFixedOdds(double leftWinRate, double rightWinRate, boolean fixedOdds, int playTypeId) {
		mapper.updateWinRateAndFixedOdds(leftWinRate, rightWinRate, fixedOdds, playTypeId);
		PlayType playType = this.startedPlayTypeMap.get(playTypeId);
		if(playType != null) {
			playType.setLeftWinRate(leftWinRate);
			playType.setRightWinRate(rightWinRate);
			playType.setFixedOdds(fixedOdds);
		}
	}

	@Override
	public void updateWinRateByVersusId(double leftWinRate, double rightWinRate, int versusId) {
		mapper.updateWinRateByVersusId(leftWinRate, rightWinRate, versusId);
		List<Integer> ids = mapper.getPlayTypeIdListByVersusId(versusId);
		for(Integer id : ids) {
			PlayType playType = this.startedPlayTypeMap.get(id);
			if(playType != null) {
				playType.setLeftWinRate(leftWinRate);
				playType.setRightWinRate(rightWinRate);
			}
		}
	}

	@Override
	public void updateFixedOddsByVersusId(boolean fixedOdds, int versusId) {
		mapper.updateFixedOddsByVersusId(fixedOdds, versusId);
		List<Integer> ids = mapper.getPlayTypeIdListByVersusId(versusId);
		for(Integer id : ids) {
			PlayType playType = this.startedPlayTypeMap.get(id);
			if(playType != null) {
				playType.setFixedOdds(fixedOdds);
			}
		}
	}
	
	@Override
	public void updateWinRateAndFixedOddsByVersusId(double leftWinRate, double rightWinRate, boolean fixedOdds, int versusId) {
		mapper.updateWinRateAndFixedOddsByVersusId(leftWinRate, rightWinRate, fixedOdds, versusId);
		List<Integer> ids = mapper.getPlayTypeIdListByVersusId(versusId);
		for(Integer id : ids) {
			PlayType playType = this.startedPlayTypeMap.get(id);
			if(playType != null) {
				playType.setLeftWinRate(leftWinRate);
				playType.setRightWinRate(rightWinRate);
				playType.setFixedOdds(fixedOdds);
			}
		}
	}

	@Override
	public void updateWinRateByVersusIdAndBo(double leftWinRate, double rightWinRate, int versusId, int bo) {
		mapper.updateWinRateByVersusIdAndBo(leftWinRate, rightWinRate, versusId, bo);
		List<Integer> ids = mapper.getPlayTypeIdListByVersusIdAndBo(versusId, bo);
		for(Integer id : ids) {
			PlayType playType = this.startedPlayTypeMap.get(id);
			if(playType != null) {
				playType.setLeftWinRate(leftWinRate);
				playType.setRightWinRate(rightWinRate);
			}
		}
	}

	@Override
	public void updateFixedOddsByVersusIdAndBo(boolean fixedOdds, int versusId, int bo) {
		mapper.updateFixedOddsByVersusIdAndBo(fixedOdds, versusId, bo);
		List<Integer> ids = mapper.getPlayTypeIdListByVersusIdAndBo(versusId, bo);
		for(Integer id : ids) {
			PlayType playType = this.startedPlayTypeMap.get(id);
			if(playType != null) {
				playType.setFixedOdds(fixedOdds);
			}
		}
	}

	@Override
	public void updateWinRateAndFixedOddsByVersusIdAndBo(double leftWinRate, double rightWinRate, boolean fixedOdds, int versusId, int bo) {
		mapper.updateWinRateAndFixedOddsByVersusIdAndBo(leftWinRate, rightWinRate, fixedOdds, versusId, bo);
		List<Integer> ids = mapper.getPlayTypeIdListByVersusIdAndBo(versusId, bo);
		for(Integer id : ids) {
			PlayType playType = this.startedPlayTypeMap.get(id);
			if(playType != null) {
				playType.setLeftWinRate(leftWinRate);
				playType.setRightWinRate(rightWinRate);
				playType.setFixedOdds(fixedOdds);
			}
		}
	}
	
	@Override
	public double getOdds(BetDirection direction, int playTypeId) {
		PlayType playType = startedPlayTypeMap.get(playTypeId);
		if(playType == null) {
			return -1; //返回一个负数，表示玩法关闭，赔率不存在
		}
		if(playType.isFixedOdds()) { //固定赔率
			return getFixedOdds(direction, playType);
		} else { //变动赔率
			double[] bonusPool = this.getBonusPool(playTypeId);
			if(bonusPool[0] == 0 || bonusPool[1] == 0) { //投注额为零，返回固定赔率
				return this.getFixedOdds(direction, playType);
			} else {
				switch(direction) {
				case LEFT:
					return this.cfgCom.getReturnRate() / (bonusPool[0] / (bonusPool[0] + bonusPool[1]));
				case RIGHT:
					return this.cfgCom.getReturnRate() / (bonusPool[1] / (bonusPool[0] + bonusPool[1]));
				default:
					RuntimeException e = new RuntimeException("未知的下注方：" + direction);
					logger.error(e.toString());
					throw e;
				}
			}
		}
	}
	//返回固定赔率
	private double getFixedOdds(BetDirection direction, PlayType playType) {
		switch(direction) {
		case LEFT:
			return cfgCom.getReturnRate() / playType.getLeftWinRate();
		case RIGHT:
			return cfgCom.getReturnRate() / playType.getRightWinRate();
		default:
			RuntimeException e = new RuntimeException("未知的下注方：" + direction);
			logger.error(e.toString());
			throw e;
		}
	}
	private double[] getFixedOdds(PlayType playType) {
		return new double[] {cfgCom.getReturnRate() / playType.getLeftWinRate(), cfgCom.getReturnRate() / playType.getRightWinRate()};
	}
	
	@Override
	public double[] getOdds(int playTypeId) {
		PlayType playType = this.startedPlayTypeMap.get(playTypeId);
		if(playType == null) {
			return new double[]{-1, -1}; //返回一个负数，表示玩法关闭，赔率不存在
		}
		if(playType.isFixedOdds()) { //固定赔率
			return this.getFixedOdds(playType);
		} else { //变动赔率
			double[] bonusPool = this.getBonusPool(playTypeId);
			if(bonusPool[0] == 0 || bonusPool[1] == 0) { //投注额为零，返回固定赔率
				return this.getFixedOdds(playType);
			} else {
				double totalBonusPool = bonusPool[0] + bonusPool[1];
				double returnRate = cfgCom.getReturnRate();
				return new double[] {returnRate / (bonusPool[0] / totalBonusPool), returnRate / (bonusPool[1] / totalBonusPool)};
			}
		}
	}
	
	@Override
	public void cleanPlayTypeCache(int playTypeId) {
		String key = String.valueOf(playTypeId);
		RedisUtil.delete(redisTemplate, CachePre.GUESS_LEFT_BONUS_POOL, key);
		RedisUtil.delete(redisTemplate, CachePre.GUESS_RIGHT_BONUS_POOL, key);
	}

	@Override
	public void stopGuessByPlayTypeId(int playTypeId) {
		this.updateGuessStartByPlayTypeId(false, playTypeId); //关闭状态
		this.cleanPlayTypeCache(playTypeId);//清除缓存
		double[] bonusPool = this.getBonusPool(playTypeId); //奖金池
		mapper.updateBonusPool(bonusPool[0], bonusPool[1], playTypeId);
	}

	@Override
	public void stopGuessByVersusId(int versusId) {
		this.updateGuessStartByVersusId(false, versusId);
		List<Integer> idList = mapper.getPlayTypeIdListByVersusId(versusId);
		for(Integer id : idList) {
			this.cleanPlayTypeCache(id); //清除缓存
			double[] bonusPool = this.getBonusPool(id);
			mapper.updateBonusPool(bonusPool[0], bonusPool[1], id);
		}
	}

	@Override
	public void stopGuessByVersusIdAndBo(int versusId, int bo) {
		this.updateGuessStartByVersusIdAndBo(false, versusId, bo);
		List<Integer> idList = mapper.getPlayTypeIdListByVersusIdAndBo(versusId, bo);
		for(Integer id : idList) {
			this.cleanPlayTypeCache(id); //清除缓存
			double[] bonusPool = this.getBonusPool(id);
			mapper.updateBonusPool(bonusPool[0], bonusPool[1], id);
		}
	}

	@Override
	public double getBonusPool(BetDirection betDirection, int playTypeId) {
		String key = String.valueOf(playTypeId);
		switch(betDirection) {
		case LEFT:
			Double leftBonusPoolDouble = RedisUtil.getDouble(redisTemplate, CachePre.GUESS_LEFT_BONUS_POOL, key);
			return leftBonusPoolDouble == null ? 0 : leftBonusPoolDouble;
		case RIGHT:
			Double rightBonusPoolDouble = RedisUtil.getDouble(redisTemplate, CachePre.GUESS_RIGHT_BONUS_POOL, key);
			return rightBonusPoolDouble == null ? 0 : rightBonusPoolDouble;
		default:
			RuntimeException e = new RuntimeException("未知的下注方：" + betDirection);
			logger.error(e.toString());
			throw e;
		}
	}

	@Override
	public double[] getBonusPool(int playTypeId) {
		String key = String.valueOf(playTypeId);
		Double leftBonusPoolDouble = RedisUtil.getDouble(redisTemplate, CachePre.GUESS_LEFT_BONUS_POOL, key);
		Double rightBonusPoolDouble = RedisUtil.getDouble(redisTemplate, CachePre.GUESS_RIGHT_BONUS_POOL, key);
		double leftBonusPool = leftBonusPoolDouble == null ? 0 : leftBonusPoolDouble;
		double rightBonusPool = rightBonusPoolDouble == null ? 0 : rightBonusPoolDouble;
		return new double[] {leftBonusPool, rightBonusPool};
	}

	@Override
	public void plusBonusPool(double amount, BetDirection betDirection, int playTypeId) {
		String key = String.valueOf(playTypeId);
		switch(betDirection) {
		case LEFT:
			Double leftBonusPool = RedisUtil.getDouble(redisTemplate, CachePre.GUESS_LEFT_BONUS_POOL, key);
			RedisUtil.set(redisTemplate, CachePre.GUESS_LEFT_BONUS_POOL, key, leftBonusPool == null ? amount : leftBonusPool + amount);
			break;
		case RIGHT:
			Double rightBonusPool = RedisUtil.getDouble(redisTemplate, CachePre.GUESS_RIGHT_BONUS_POOL, key);
			RedisUtil.set(redisTemplate, CachePre.GUESS_RIGHT_BONUS_POOL, key, rightBonusPool == null ? amount : rightBonusPool + amount);
			break;
		default:
			RuntimeException e = new RuntimeException("未知的betDirection：" + betDirection);
			logger.error(e.toString());
			throw e;
		}
	}

	@Override
	public void updatePause(boolean pause, int playTypeId) {
		mapper.updatePause(pause, playTypeId);
		PlayType playType = this.startedPlayTypeMap.get(playTypeId);
		if(playType != null) {
			playType.setPause(pause);
		}
	}
	
	@Override
	public List<PlayType> getFirstStartedPlayTypeByVersusList(List<MatchVersus> versusList) {
		List<PlayType> list = new ArrayList<PlayType>();
		for(MatchVersus versus : versusList) {
			list.add(this.getFirstPlayTypeByVersusId(versus.getId()));
		}
		return list;
	}

	@Override
	public List<PlayType> getFirstStartedPlayTypeByVersusIdList(List<Integer> versusIdList) {
		List<PlayType> list = new ArrayList<PlayType>();
		for(Integer versusId : versusIdList) {
			list.add(this.getFirstPlayTypeByVersusId(versusId));
		}
		return list;
	}
	private PlayType getFirstPlayTypeByVersusId(int versusId) {
		QueryCondition qc = new QueryCondition();
		qc.addCondition("versusId", "=", versusId);
		qc.addCondition("guessStart", "=", true);
		qc.addSort("bo", SortType.ASC);
		return mapper.find(qc);
	}

	@Override
	public void updateName(String name, int playTypeId) {
		mapper.updateName(name, playTypeId);
		PlayType pt = this.startedPlayTypeMap.get(playTypeId);
		if(pt != null) {
			pt.setName(name);
		}
	}

	@Override
	public void updateGuessName(String leftGuessName, String rightGuessName, int playTypeId) {
		mapper.updateGuessName(leftGuessName, rightGuessName, playTypeId);
		PlayType pt = this.startedPlayTypeMap.get(playTypeId);
		if(pt != null) {
			pt.setLeftGuessName(leftGuessName);
			pt.setRightGuessName(rightGuessName);
		}
	}

	@Override
	public boolean getPlayTypeGuessStatus(int playTypeId) {
		PlayType pt = this.startedPlayTypeMap.get(playTypeId);
		if(pt != null) {
			return !pt.isPause() && pt.isGuessStart();
		} else {
			return false;
		}
	}
}