package com.yy.guess.controller;

import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.yy.fast4j.Fast4jUtils;
import com.yy.fast4j.JsonResultMap;
import com.yy.fast4j.Page;
import com.yy.fast4j.QueryCondition;
import com.yy.fast4j.RedisUtil;
import com.yy.fast4j.ResponseObject;
import com.yy.fast4j.QueryCondition.SortType;
import com.yy.guess.po.MatchVersus;
import com.yy.guess.po.enums.BetDirection;
import com.yy.guess.service.BetService;
import com.yy.guess.service.MatchVersusService;
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
	
	@Autowired
	private MatchVersusService mvs;

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
		default:
			RuntimeException e = new RuntimeException("未知的betDirection");
			throw e;
		}
		return new ResponseObject(100, "返回成功", bonusPool == null ? 0 : bonusPool);
	}

	/**
	 * 返回最新赔率
	 * @param playTypeId
	 * @param betDirection
	 * @return
	 */
	@RequestMapping("/getNewestOdds")
	public ResponseObject getNewestOdds(@RequestParam int playTypeId, @RequestParam BetDirection betDirection) {
		return new ResponseObject(100, "返回成功", bs.getOdds(playTypeId, betDirection));
	}
	//返回最新赔率，左右双方一起返回
	@RequestMapping("/getAllNewestOdds")
	public ResponseObject getAllNewestOdds(@RequestParam int playTypeId) {
		String key = String.valueOf(playTypeId);
		Double leftBonusPool = RedisUtil.getDouble(redisTemplate, CachePre.GUESS_LEFT_BONUS_POOL, key);
		Double rightBonusPool = RedisUtil.getDouble(redisTemplate, CachePre.GUESS_RIGHT_BONUS_POOL, key);
		return new ResponseObject(100, "返回成功", new JsonResultMap().set("leftBonusPool", leftBonusPool == null ? 0 : leftBonusPool).set("rightBonusPool", rightBonusPool == null ? 0 : rightBonusPool));
	}
	
	/**
	 * 批量返回最新赔率
	 * @return
	 */
	@RequestMapping("/getBatchNewestOdds")
	public ResponseObject getBatchNewestOdds(HttpServletRequest req) {
		String[] playTypeId = req.getParameterValues("playTypeId[]");
		if(playTypeId != null && playTypeId.length > 0) {
			JsonResultMap[] maps = new JsonResultMap[playTypeId.length];
			for(int i=0; i<playTypeId.length; i++) {
				Double leftBonusPool = RedisUtil.getDouble(redisTemplate, CachePre.GUESS_LEFT_BONUS_POOL, playTypeId[i]);
				Double rightBonusPool = RedisUtil.getDouble(redisTemplate, CachePre.GUESS_RIGHT_BONUS_POOL, playTypeId[i]);
				maps[i] = new JsonResultMap();
				maps[i].put("leftBonusPool", leftBonusPool == null ? 0 : leftBonusPool);
				maps[i].put("rightBonusPool", rightBonusPool == null ? 0 : rightBonusPool);
			}
			return new ResponseObject(100, "返回成功", maps);
		} else {
			return new ResponseObject(101, "参数为空");
		}
	}

	/**
	 * 返回一天的对阵列表
	 * @return
	 */
	@RequestMapping("/getMatchVersusByToday")
	public ResponseObject getMatchVersusByToday(Integer sportId) {
		long current = System.currentTimeMillis();
		long endTime = Fast4jUtils.getEveryDayStartTime(current) + Fast4jUtils._24HoursMillis - 1;
		QueryCondition qc = new QueryCondition();
		if(sportId != null) {
			qc.addCondition("sportId", "=", sportId);
		}
		qc.addCondition("endTime", ">=", new Date(current));
		qc.addCondition("startTime", "<=", new Date(endTime));
		qc.addCondition("playTypeCount", ">", 0);
		qc.addSort("startTime", SortType.ASC);
		List<MatchVersus> list = mvs.query(qc);
		return new ResponseObject(100, "返回成功", list);
	}
	
	public ResponseObject getMatchVersus(Integer sportId,
                                         @RequestParam(defaultValue="20") int pageSize,
                                         @RequestParam(defaultValue="1") int pageNo,
                                         @RequestParam(defaultValue="5") int showCount) {
		QueryCondition qc = new QueryCondition();
		if(sportId != null) {
			qc.addCondition("sportId", "=", sportId);
		}
		qc.addCondition("endTime", ">=", new Date());
		qc.addCondition("playTypeCount", ">", 0);
		qc.addSort("startTime", SortType.ASC);
		qc.setPage(new Page(pageSize, pageNo, showCount));
		List<MatchVersus> list = mvs.query(qc);
		Page page = qc.getPage(mvs.getCount(qc));
		return new ResponseObject(100, "返回成功", new JsonResultMap().set("list", list).set("page", page));
	}
}