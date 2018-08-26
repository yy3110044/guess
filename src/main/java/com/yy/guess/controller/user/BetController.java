package com.yy.guess.controller.user;

import java.util.List;
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
import com.yy.guess.po.User;
import com.yy.guess.po.enums.BetDirection;
import com.yy.guess.service.BetService;
import com.yy.guess.service.UserService;
import com.yy.guess.util.CachePre;

/**
 * 下注相关
 * @author 49803
 *
 */
@CrossOrigin
@RestController
//@RequestMapping(value="/user", method=RequestMethod.POST)
@RequestMapping(method={RequestMethod.POST, RequestMethod.GET})
public class BetController {
	@Autowired
	private RedisTemplate<String, Object> redisTemplate;
	
	@Autowired
	private UserService us;
	
	@Autowired
	private BetService bs;
	
	@RequestMapping("/testBet")
	public ResponseObject testBet(@RequestParam int versusId,
                                  @RequestParam int playTypeId,
                                  @RequestParam int userId,
                                  @RequestParam BetDirection betDirection,
                                  @RequestParam double odds,
                                  @RequestParam double betAmount) {
		User user = us.findById(userId);
		if(user.getBalance() < betAmount) {
			return new ResponseObject(101, "用户余额不足");
		}
		boolean result = bs.bet(versusId, playTypeId, userId, user.getUserName(), betDirection, odds, betAmount);
		return new ResponseObject(100, "下注成功", result);
	}
	
	/**
	 * 返回奖金池
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
	 *  返回未售出 bet列表
	 * @param playTypeId
	 * @param betDirection
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/getUnSoldBetList")
	public ResponseObject getUnSoldBetList(@RequestParam int playTypeId, @RequestParam BetDirection betDirection) {
		List<Bet> betList = null;
		switch(betDirection) {
		case LEFT:
			betList = (List<Bet>)RedisUtil.getObject(redisTemplate, CachePre.GUESS_LEFT_UNSOLD_BET_QUEUE, String.valueOf(playTypeId));
			break;
		case RIGHT:
			betList = (List<Bet>)RedisUtil.getObject(redisTemplate, CachePre.GUESS_RIGHT_UNSOLD_BET_QUEUE, String.valueOf(playTypeId));
			break;
		}
		return new ResponseObject(100, "返回成功", betList);
	}
}