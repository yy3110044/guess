package com.yy.guess.component;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;
import com.yy.fast4j.RedisUtil;
import com.yy.guess.po.enums.BetDirection;
import com.yy.guess.util.CachePre;

//赔率组件
@Component
public class OddsComponent {
	private static final Logger logger = LogManager.getLogger(OddsComponent.class);
	
	@Autowired
	private RedisTemplate<String, Object> redisTemplate;
	
	@Autowired
	private ConfigComponent cfgCom;

	//返回最新变动赔率
	public double getNewestOdds(int playTypeId, BetDirection betDirection) {
		String redisKey = String.valueOf(playTypeId);
		Double leftBonusPoolDouble = RedisUtil.getDouble(redisTemplate, CachePre.GUESS_LEFT_BONUS_POOL, redisKey);
		double leftBonusPool = leftBonusPoolDouble == null ? 0 : leftBonusPoolDouble;
		
		Double rightBonusPoolDouble = RedisUtil.getDouble(redisTemplate, CachePre.GUESS_RIGHT_BONUS_POOL, redisKey);
		double rightBonusPool = rightBonusPoolDouble == null ? 0 : rightBonusPoolDouble;
		
		double totalPool = leftBonusPool + rightBonusPool;
		
		double returnRate = cfgCom.getReturnRate();
		
		switch(betDirection) {
		case LEFT:
			if(leftBonusPool == 0) {//还未投注，就直接以返还率为赔率
				return returnRate;
			} else {
				return returnRate / (leftBonusPool / totalPool);
			}
		case RIGHT:
			if(rightBonusPool == 0) {//还未投注，就直接以返还率为赔率
				return returnRate;
			} else {
				return returnRate / (rightBonusPool / totalPool);
			}
		default:
			RuntimeException e = new RuntimeException("未知的betDirection");
			logger.error(e.toString());
			throw e;
		}
	}
}