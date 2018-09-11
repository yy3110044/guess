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
	 * 返回对阵列表
	 * @param scroll 是否返回滚动
	 * @param today scroll为true时要用到的参数
	 * @param queryDate scroll为false时要用到的参数
	 * @param pageSize
	 * @param pageNo
	 * @param showCount
	 * @param req
	 * @return
	 */
	@RequestMapping("/getMatchVersus")
	public ResponseObject getMatchVersus(@RequestParam(defaultValue="true") boolean scroll,

										 @RequestParam(defaultValue="false") boolean today,
			 							 /************************************************/
			 							 @DateTimeFormat(pattern="yyyy-MM-dd") Date queryDate,

			 							 @RequestParam(defaultValue="20") int pageSize,
			 							 @RequestParam(defaultValue="1") int pageNo,
			 							 @RequestParam(defaultValue="5") int showCount,
			 							 HttpServletRequest req) {
		if(scroll) {
			return this.getMatchVersus(today, req, pageSize, pageNo, showCount);
		} else {
			return this.getMatchVersus(queryDate, req, pageSize, pageNo, showCount);
		}
	}
	//滚动
	private ResponseObject getMatchVersus(boolean today, HttpServletRequest req, int pageSize, int pageNo, int showCount) {
		List<Integer> sportIdList = null;
		Date endTime = null;
		Date startTime = null;
		Page page = null;
		/*---------------------------------------------------------------------------------------*/
		String[] sportId = req.getParameterValues("sportId[]");
		if(sportId != null && sportId.length > 0) {
			sportIdList = new ArrayList<>();
			for(int i=0; i<sportId.length; i++) {
				sportIdList.add(Integer.valueOf(sportId[i]));
			}
		}
		if(today) {
			long currentMillis = System.currentTimeMillis();
			long endTimeMillis = Fast4jUtils.getEveryDayStartTime(currentMillis) + Fast4jUtils._24HoursMillis - 1;
			endTime = new Date(currentMillis);
			startTime = new Date(endTimeMillis);
		} else {
			endTime = new Date();
		}
		page = new Page(pageSize, pageNo, showCount);
		
		List<MatchVersus> list = mvs.queryInSportIdScroll(sportIdList, endTime, startTime, page);
		page.setRowCount(mvs.queryInSportIdScrollCount(sportIdList, endTime, startTime));
		return new ResponseObject(100, "返回成功", new JsonResultMap().set("list", list).set("page", page));
	}
	//按开始日期查询
	private ResponseObject getMatchVersus(Date queryDate, HttpServletRequest req, int pageSize, int pageNo, int showCount) {
		List<Integer> sportIdList = null;
		Date startTime = null;
		Date endTime = null;
		Page page = null;
		/**********************************************************************************/
		String[] sportId = req.getParameterValues("sportId[]");
		if(sportId != null && sportId.length > 0) {
			sportIdList = new ArrayList<>();
			for(int i=0; i<sportId.length; i++) {
				sportIdList.add(Integer.valueOf(sportId[i]));
			}
		}
		if(queryDate == null) {
			return new ResponseObject(101, "查询日期不能为空");
		}
		long startTimeMillis = Fast4jUtils.getEveryDayStartTime(queryDate.getTime());
		long endTimeMillis = startTimeMillis + Fast4jUtils._24HoursMillis - 1;
		startTime = new Date(startTimeMillis);
		endTime = new Date(endTimeMillis);
		
		page = new Page(pageSize, pageNo, showCount);
		
		List<MatchVersus> list = mvs.queryInSportIdStartTime(sportIdList, startTime, endTime, page);
		page.setRowCount(mvs.queryInSportIdStartTimeCount(sportIdList, startTime, endTime));
		return new ResponseObject(100, "返回成功", new JsonResultMap().set("list", list).set("page", page));
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
}