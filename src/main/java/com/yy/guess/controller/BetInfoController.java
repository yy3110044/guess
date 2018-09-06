package com.yy.guess.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.yy.fast4j.Fast4jUtils;
import com.yy.fast4j.RedisUtil;
import com.yy.fast4j.ResponseObject;
import com.yy.guess.po.enums.BetDirection;
import com.yy.guess.service.BetService;
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

	@Autowired
	private BetService bs;

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
		default:
			RuntimeException e = new RuntimeException("未知的betDirection");
			throw e;
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
		return new ResponseObject(100, "返回成功", bs.getOdds(playTypeId, betDirection));
	}

	/**
	 * 返回对阵列表
	 * @return
	 */
	public ResponseObject getMatchVersusByToday() {
		long startTime = Fast4jUtils.getEveryDayStartTime(System.currentTimeMillis());
	}
	//public ResponseObject getMatchVersus
}