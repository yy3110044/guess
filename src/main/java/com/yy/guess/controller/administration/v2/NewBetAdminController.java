package com.yy.guess.controller.administration.v2;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.yy.fast4j.Fast4jUtils;
import com.yy.fast4j.JsonResultMap;
import com.yy.fast4j.Page;
import com.yy.fast4j.QueryCondition;
import com.yy.fast4j.ResponseObject;
import com.yy.fast4j.QueryCondition.SortType;
import com.yy.guess.po.NewGuessBet;
import com.yy.guess.po.enums.NewGuessBetStatus;
import com.yy.guess.service.NewGuessBetService;

@CrossOrigin
@RestController
@RequestMapping(value="/administration/v2/betAdmin", method=RequestMethod.POST)
public class NewBetAdminController {
	@Resource
	private NewGuessBetService ngbs;

	@RequestMapping("/betList")
	public ResponseObject betList(@RequestParam(defaultValue="20") int pageSize,
                                  @RequestParam(defaultValue="1") int pageNo,
                                  @RequestParam(defaultValue="5") int showCount,
                                  String orderNumber,
                                  Integer versusId,
                                  Integer versusItemId,
                                  Integer userId,
                                  NewGuessBetStatus status) {
		QueryCondition qc = new QueryCondition();
		if(!Fast4jUtils.empty(orderNumber)) {
			qc.addCondition("orderNumber", "=", orderNumber);
		}
		if(versusId != null) {
			qc.addCondition("versusId", "=", versusId);
		}
		if(versusItemId != null) {
			qc.addCondition("versusItemId", "=", versusItemId);
		}
		if(userId != null) {
			qc.addCondition("userId", "=", userId);
		}
		if(status != null) {
			qc.addCondition("status", "=", status);
		}
		qc.addSort("id", SortType.DESC);
		qc.setPage(new Page(pageSize, pageNo, showCount));
		
		List<NewGuessBet> list = ngbs.query(qc);
		Page page = qc.getPage(ngbs.getCount(qc));
		
		return new ResponseObject(100, "返回成功", new JsonResultMap().set("list", list).set("page", page));
	}
	
	@RequestMapping("/betRefund")
	public ResponseObject betRefund(String description, @RequestParam int betId) {
		NewGuessBet bet = ngbs.findById(betId);
		if(bet.getStatus() != NewGuessBetStatus.未结算) {
			return new ResponseObject(101, "只有未结算的订单才能退款");
		}
		ngbs.refund(description, betId);
		return new ResponseObject(100, "退款成功");
	}
}