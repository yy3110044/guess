package com.yy.guess.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.yy.fast4j.Fast4jUtils;
import com.yy.fast4j.JsonResultMap;
import com.yy.fast4j.Page;
import com.yy.fast4j.ResponseObject;
import com.yy.guess.po.MatchVersus;
import com.yy.guess.po.Sport;
import com.yy.guess.po.enums.BetDirection;
import com.yy.guess.service.MatchVersusService;
import com.yy.guess.service.PlayTypeService;
import com.yy.guess.service.SportService;
import com.yy.guess.util.QueryResult;

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
	private MatchVersusService mvs;
	
	@Autowired
	private SportService ss;
	
	@Autowired
	private PlayTypeService pts;

	/**
	 * 返回奖金池
	 * @param playTypeId
	 * @param betDirection
	 * @return
	 */
	@RequestMapping("/getBonusPool")
	public ResponseObject getBonusPool(@RequestParam int playTypeId, @RequestParam BetDirection betDirection) {
		return new ResponseObject(100, "返回成功", pts.getBonusPool(betDirection, playTypeId));
	}
	@RequestMapping("/getAllBonusPool")
	public ResponseObject getAllBonusPool(@RequestParam int playTypeId) {
		double[] bonusPool = pts.getBonusPool(playTypeId);
		return new ResponseObject(100, "返回成功", new JsonResultMap().set("leftBonusPool", bonusPool[0]).set("rightBonusPool", bonusPool[1]));
	}
	/**
	 *批量返回奖金池
	 * @param req
	 * @return
	 */
	@RequestMapping("/getBatchBonusPool")
	public ResponseObject getBatchBonusPool(HttpServletRequest req) {
		String[] playTypeId = req.getParameterValues("playTypeId[]");
		if(playTypeId != null && playTypeId.length > 0) {
			JsonResultMap[] maps = new JsonResultMap[playTypeId.length];
			for(int i=0; i<playTypeId.length; i++) {
				double[] bonusPool = pts.getBonusPool(Integer.parseInt(playTypeId[i]));
				maps[i] = new JsonResultMap();
				maps[i].put("leftBonusPool", bonusPool[0]);
				maps[i].put("rightBonusPool", bonusPool[1]);
			}
			return new ResponseObject(100, "返回成功", maps);
		} else {
			return new ResponseObject(101, "参数为空");
		}
	}

	/**
	 * 返回最新赔率
	 * @param playTypeId
	 * @param betDirection
	 * @return
	 */
	@RequestMapping("/getOdds")
	public ResponseObject getOdds(@RequestParam int playTypeId, @RequestParam BetDirection betDirection) {
		return new ResponseObject(100, "返回成功", pts.getOdds(betDirection, playTypeId));
	}
	@RequestMapping("/getAllOdds")
	public ResponseObject getAllOdds(@RequestParam int playTypeId) {
		double[] odds = pts.getOdds(playTypeId);
		return new ResponseObject(100, "返回成功", new JsonResultMap().set("leftOdds", odds[0]).set("rightOdds", odds[1]));
	}
	
	/**
	 * 批量返回最新赔率
	 * @return
	 */
	@RequestMapping("/getBatchOdds")
	public ResponseObject getBatchOdds(HttpServletRequest req) {
		String[] playTypeId = req.getParameterValues("playTypeId[]");
		if(playTypeId != null && playTypeId.length > 0) {
			JsonResultMap[] maps = new JsonResultMap[playTypeId.length];
			for(int i=0; i<playTypeId.length; i++) {
				double[] odds = pts.getOdds(Integer.parseInt(playTypeId[i]));
				maps[i] = new JsonResultMap();
				maps[i].put("leftOdds", odds[0]);
				maps[i].put("rightOdds", odds[1]);
			}
			return new ResponseObject(100, "返回成功", maps);
		} else {
			return new ResponseObject(101, "参数为空");
		}
	}

	/**
	 * 批量返回最新赔率以及玩法状态
	 * @param req
	 * @return status：为true时表示正常下注，为false表示不能投注
	 */
	@RequestMapping("/getBatchOddsAndPlayTypeStatus")
	public ResponseObject getBatchOddsAndPlayTypeStatus(HttpServletRequest req) {
		String[] playTypeId = req.getParameterValues("playTypeId[]");
		if(playTypeId != null && playTypeId.length > 0) {
			JsonResultMap[] maps = new JsonResultMap[playTypeId.length];
			for(int i=0; i<playTypeId.length; i++) {
				int playTypeIdInt = Integer.parseInt(playTypeId[i]);
				maps[i] = new JsonResultMap();
				maps[i].put("status", pts.getPlayTypeGuessStatus(playTypeIdInt));
				double[] odds = pts.getOdds(playTypeIdInt);
				maps[i].put("leftOdds", odds[0]);
				maps[i].put("rightOdds", odds[1]);
			}
			return new ResponseObject(100, "返回成功", maps);
		} else {
			return new ResponseObject(101, "参数为空");
		}
	}
	
	/**
	 * 返回所有的运动项目
	 * @return
	 */
	@RequestMapping("/getAllSport")
	public ResponseObject getAllSport() {
		List<Sport> list = ss.query(null);
		return new ResponseObject(100, "返回成功", list);
	}
	
	/**
	 * 返回MatchVersus
	 * @param type：today、scroll、after、end
	 * @param date
	 * @param pageSize
	 * @param pageNo
	 * @param showCount
	 * @param req
	 * @return
	 */
	@RequestMapping("/getMatchVersus")
	public ResponseObject getMatchVersus(@RequestParam(defaultValue="scroll") String type,
                                         @DateTimeFormat(pattern="yyyy-MM-dd") Date date,
                                         @RequestParam(defaultValue="20") int pageSize,
                                         @RequestParam(defaultValue="1") int pageNo,
                                         @RequestParam(defaultValue="5") int showCount,
                                         HttpServletRequest req) {
		switch(type) {
		case "today":
			return this.getTodayMatchVersus(pageSize, pageNo, showCount, req);
		case "scroll":
			return this.getScrollMatchVersus(pageSize, pageNo, showCount, req);
		case "after":
			return this.getAfterMatchVersus(date, pageSize, pageNo, showCount, req);
		case "end":
			return this.getEndMatchVersus(date, pageSize, pageNo, showCount, req);
		default:
			return new ResponseObject(101, "未知的type：" + type);
		}
	}
	private ResponseObject getTodayMatchVersus(int pageSize, int pageNo, int showCount, HttpServletRequest req) {
		long startTimeMillis = Fast4jUtils.getEveryDayStartTime();
		long endTimeMillis = startTimeMillis + Fast4jUtils._24HoursMillis - 1;
		Date startTime = new Date(startTimeMillis);
		Date endTime = new Date(endTimeMillis);
		QueryResult<MatchVersus> result = mvs.queryInSportId(getSportIdList(req), -1, startTime, endTime, new Page(pageSize, pageNo, showCount));
		JsonResultMap map = new JsonResultMap();
		map.put("list", result.getList());
		map.put("page", result.getPage());
		map.put("playTypeList", pts.getFirstStartedPlayTypeByVersusList(result.getList()));
		return new ResponseObject(100, "返回成功", map);
	}
	private ResponseObject getScrollMatchVersus(int pageSize, int pageNo, int showCount, HttpServletRequest req) {
		QueryResult<MatchVersus> result = mvs.queryInSportId(getSportIdList(req), -1, null, null, new Page(pageSize, pageNo, showCount));
		List<MatchVersus> list = result.getList();
		long current = System.currentTimeMillis();
		List<Long> remainingTimeList = new ArrayList<Long>();
		for(MatchVersus versus : list) {
			remainingTimeList.add(versus.getStartTime().getTime() - current);
		}
		JsonResultMap map = new JsonResultMap();
		map.put("list", list);
		map.put("remainingTimeList", remainingTimeList);
		map.put("page", result.getPage());
		map.put("playTypeList", pts.getFirstStartedPlayTypeByVersusList(result.getList()));
		return new ResponseObject(100, "返回成功", map);
	}
	private ResponseObject getAfterMatchVersus(Date date, int pageSize, int pageNo, int showCount, HttpServletRequest req) {
		if(date == null) {//date为空时就默认设为明天
			date = new Date(System.currentTimeMillis() + Fast4jUtils._24HoursMillis);
		}
		long startTimeMillis = Fast4jUtils.getEveryDayStartTime(date.getTime());
		long endTimeMillis = startTimeMillis + Fast4jUtils._24HoursMillis - 1;
		QueryResult<MatchVersus> result = mvs.queryInSportId(getSportIdList(req), 0, new Date(startTimeMillis), new Date(endTimeMillis), new Page(pageSize, pageNo, showCount));
		JsonResultMap map = new JsonResultMap();
		map.put("list", result.getList());
		map.put("page", result.getPage());
		map.put("playTypeList", pts.getFirstStartedPlayTypeByVersusList(result.getList()));
		return new ResponseObject(100, "返回成功", map);
	}
	private ResponseObject getEndMatchVersus(Date date, int pageSize, int pageNo, int showCount, HttpServletRequest req) {
		if(date == null) {
			date = new Date();
		}
		long startTimeMillis = Fast4jUtils.getEveryDayStartTime(date.getTime());
		long endTimeMillis = startTimeMillis + Fast4jUtils._24HoursMillis - 1;
		QueryResult<MatchVersus> result = mvs.queryInSportId(getSportIdList(req), 1, new Date(startTimeMillis), new Date(endTimeMillis), new Page(pageSize, pageNo, showCount));
		return new ResponseObject(100, "返回成功", result);
	}
	private List<Integer> getSportIdList(HttpServletRequest req) {
		List<Integer> sportIdList = null;
		String[] sportId = req.getParameterValues("sportId[]");
		if(sportId != null && sportId.length > 0) {
			sportIdList = new ArrayList<Integer>();
			for(int i=0; i<sportId.length; i++) {
				sportIdList.add(Integer.valueOf(sportId[i]));
			}
		}
		return sportIdList;
	}
}