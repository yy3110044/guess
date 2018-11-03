package com.yy.guess.controller.user;

import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.yy.fast4j.Page;
import com.yy.fast4j.ResponseObject;
import com.yy.guess.po.TradeFlow;
import com.yy.guess.service.TradeFlowService;
import com.yy.guess.util.QueryResult;

@Deprecated
@CrossOrigin
@RestController
@RequestMapping(value="/user", method=RequestMethod.POST)
public class TradeFlowController {
	@Autowired
	private TradeFlowService tfs;
	
	/**
	 * 交易记录列表
	 * @param index，0：全部、1：下注、返点、返奖、退款、2：充值、提现、3：其它
	 * @param pageSize
	 * @param pageNo
	 * @param showCount
	 * @return
	 */
	@RequestMapping("/getTradeFlowList")
	public ResponseObject getTradeFlowList(@RequestParam(defaultValue="0") int index,
										   @RequestParam(defaultValue="15") int pageSize,
										   @RequestParam(defaultValue="1") int pageNo,
										   @RequestParam(defaultValue="5") int showCount,
										   HttpServletRequest req) {
		int userId = (Integer)req.getAttribute("userId");
		QueryResult<TradeFlow> result = tfs.queryByIndex(userId, index, new Page(pageSize, pageNo, showCount));
		return new ResponseObject(100, "返回成功", result);
	}
}