package com.yy.guess.controller;

import java.util.Collection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.yy.fast4j.RedisUtil;
import com.yy.fast4j.ResponseObject;
import com.yy.guess.po.Bet;
import com.yy.guess.po.enums.BetDirection;
import com.yy.guess.util.CachePre;

/**
 * 下注相关信息
 * @author 49803
 *
 */
@CrossOrigin
@RestController
@RequestMapping(method=RequestMethod.POST)
public class BetInfoController {
	@Autowired
	private RedisTemplate<String, Object> redisTemplate;
	
	/**
	 *    返回奖金池
	 * @param playTypeId
	 * @param betDirection
	 * @return
	 */
	@RequestMapping("/getBonusPool")
	public ResponseObject getBonusPool(@RequestParam int playTypeId, @RequestParam BetDirection betDirection) {
		Double bonusPool = null;
		switch(betDirection) {
		case LEFT:
			bonusPool = RedisUtil.getDouble(redisTemplate, CachePre.GUESS_LEFT_BONUS_POOL, String.valueOf(playTypeId));
			break;
		case RIGHT:
			bonusPool = RedisUtil.getDouble(redisTemplate, CachePre.GUESS_RIGHT_BONUS_POOL, String.valueOf(playTypeId));
			break;
		}
		return new ResponseObject(100, "返回成功", bonusPool == null ? 0 : bonusPool);
	}
	
	/**
	 *    返回最新赔率
	 * @param playTypeId
	 * @param betDirection
	 * @return
	 */
	@RequestMapping("/getNewestOdds")
	public ResponseObject getNewestOdds(@RequestParam int playTypeId, @RequestParam BetDirection betDirection) {
		Double newestOdds = null;
		switch(betDirection) {
		case LEFT:
			newestOdds = RedisUtil.getDouble(redisTemplate, CachePre.GUESS_LEFT_NEWEST_ODDS, String.valueOf(playTypeId));
			break;
		case RIGHT:
			newestOdds = RedisUtil.getDouble(redisTemplate, CachePre.GUESS_RIGHT_NEWEST_ODDS, String.valueOf(playTypeId));
			break;
		}
		return new ResponseObject(100, "返回成功", newestOdds == null ? 0 : newestOdds);
	}
	
	/**
	 *   返回未售出 bet列表
	 * @param playTypeId
	 * @param betDirection
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/getUnSoldBetList")
	public ResponseObject getUnSoldBetList(@RequestParam int playTypeId, @RequestParam BetDirection betDirection) {
		Collection<Bet> betCollection = null;
		switch(betDirection) {
		case LEFT:
			betCollection = (Collection<Bet>)RedisUtil.getObject(redisTemplate, CachePre.GUESS_LEFT_UNSOLD_BET_QUEUE, String.valueOf(playTypeId));
			break;
		case RIGHT:
			betCollection = (Collection<Bet>)RedisUtil.getObject(redisTemplate, CachePre.GUESS_RIGHT_UNSOLD_BET_QUEUE, String.valueOf(playTypeId));
			break;
		}
		return new ResponseObject(100, "返回成功", betCollection);
	}
}