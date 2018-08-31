package com.yy.guess.controller.user;

import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.yy.fast4j.ResponseObject;
import com.yy.guess.component.ConfigComponent;
import com.yy.guess.po.PlayType;
import com.yy.guess.po.User;
import com.yy.guess.po.enums.BetDirection;
import com.yy.guess.service.BetService;
import com.yy.guess.service.PlayTypeService;
import com.yy.guess.service.UserService;

/**
 * 下注相关
 * @author 49803
 *
 */
@CrossOrigin
@RestController
@RequestMapping(value="/user", method=RequestMethod.POST)
public class BetController {
	@Autowired
	private UserService us;
	
	@Autowired
	private BetService bs;
	
	@Autowired
	private PlayTypeService pts;
	
	@Autowired
	private ConfigComponent cfgCom;
	
	@RequestMapping("/bet")
	public ResponseObject bet(@RequestParam int playTypeId,
                              @RequestParam BetDirection betDirection,
                              @RequestParam double betAmount,
                              HttpServletRequest req) {
		if(betAmount <= 0) {
			return new ResponseObject(101, "投注金额必须大于零");
		}
		
		if(betAmount < cfgCom.getBetAmountMin() || betAmount > cfgCom.getBetAmountMax()) {
			return new ResponseObject(102, "下注金额范围：" + cfgCom.getBetAmountMin() + " ~ " + cfgCom.getBetAmountMax());
		}
		
		PlayType pt = pts.findById(playTypeId);
		if(pt == null) {
			return new ResponseObject(103, "玩法不存在");
		}
		
		if(!pt.isGuessStart()) {
			return new ResponseObject(104, "玩法未开启竞猜");
		}
		
		int userId = (Integer)req.getAttribute("userId");

		User user = us.findById(userId);
		if(user.getBalance() < betAmount) {
			return new ResponseObject(105, "用户余额不足");
		}

		boolean result = bs.bet(playTypeId, userId, user.getUserName(), betDirection, betAmount);

		if(result) {
			return new ResponseObject(100, "下注成功");
		} else {
			return new ResponseObject(106, "下注失败");
		}
	}
}