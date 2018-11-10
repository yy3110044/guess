package com.yy.guess.controller.user.v2;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.yy.fast4j.QueryCondition;
import com.yy.fast4j.ResponseObject;
import com.yy.guess.po.NewGuessBet;
import com.yy.guess.po.NewGuessVersus;
import com.yy.guess.po.NewGuessVersusItem;
import com.yy.guess.po.enums.NewGuessVersusStatus;
import com.yy.guess.service.NewGuessBetService;
import com.yy.guess.service.NewGuessVersusItemService;
import com.yy.guess.service.NewGuessVersusService;
import com.yy.guess.service.UserService;
import com.yy.guess.util.CachePre;
import com.yy.guess.util.Util;

@CrossOrigin
@RestController
@RequestMapping(value="/user/v2", method=RequestMethod.POST)
public class NewBetController {
	private static final Logger logger = LogManager.getLogger(NewBetController.class);

	@Resource
	private NewGuessBetService ngbs;
	
	@Resource
	private NewGuessVersusService ngvs;
	
	@Resource
	private NewGuessVersusItemService ngvis;
	
	@Resource
	private UserService us;
	
	@RequestMapping("/bet")
	public ResponseObject bet(@RequestParam int versusId,
                              @RequestParam int versusItemId,
                              @RequestParam double betAmount,
                              HttpServletRequest req) {
		if(betAmount <= 0) {
			return new ResponseObject(107, "投注金额必须大于零");
		}
		NewGuessVersus versus = ngvs.findById(versusId);
		if(versus == null) {
			return new ResponseObject(101, "竞猜不存在");
		}
		NewGuessVersusItem versusItem = ngvis.find(new QueryCondition().addCondition("id", "=", versusItemId).addCondition("versusId", "=", versusId));
		if(versusItem == null) {
			return new ResponseObject(102, "竞猜项不存在");
		}
		if(versus.getStatus() == NewGuessVersusStatus.已结束 || versus.getStatus() == NewGuessVersusStatus.流局) {
			return new ResponseObject(103, "竞猜已结束");
		}
		if(versus.isBetPause()) {
			return new ResponseObject(104, "竞猜已暂停下注");
		}
		if(betAmount < versus.getBetAmountMin() || betAmount > versus.getBetAmountMax()) {
			return new ResponseObject(105, "单笔下注范围:" + Util.formatNumber(versus.getBetAmountMin()) + " ~ " + Util.formatNumber(versus.getBetAmountMax()));
		}
		
		int userId = (Integer)req.getAttribute("userId");
		double balance = us.getBalance(userId);
		if(balance < betAmount) {
			return new ResponseObject(106, "用户余额不足");
		}
		
		NewGuessVersus cacheVersus = CachePre.versusMap.get(versusId);
		if(cacheVersus == null) {
			RuntimeException e = new RuntimeException("缓存对象为空：versusId=" + versusId);
			logger.error(e.toString());
			throw e;
		}
		synchronized(cacheVersus) {//下注的操作同步化
			NewGuessBet bet = ngbs.bet(versusId, versusItemId, betAmount, userId);
			return new ResponseObject(100, "下注成功", bet);
		}
	}
}