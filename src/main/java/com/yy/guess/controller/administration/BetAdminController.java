package com.yy.guess.controller.administration;

import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.yy.fast4j.JsonResultMap;
import com.yy.fast4j.Page;
import com.yy.fast4j.QueryCondition;
import com.yy.fast4j.ResponseObject;
import com.yy.fast4j.QueryCondition.SortType;
import com.yy.guess.po.Bet;
import com.yy.guess.po.enums.BetStatus;
import com.yy.guess.service.BetService;

@CrossOrigin
@RestController
@RequestMapping(value="/administration", method=RequestMethod.POST)
public class BetAdminController {
	@Autowired
	private BetService bs;
	
	@RequestMapping("/betList")
	public ResponseObject betList(Integer userId,
								  BetStatus status,
								  @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss") Date startTime,
								  @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss") Date endTime,
								  @RequestParam(defaultValue="20") int pageSize,
								  @RequestParam(defaultValue="1") int pageNo,
								  @RequestParam(defaultValue="5") int showCount) {
		QueryCondition qc = new QueryCondition();
		if(userId != null) {
			qc.addCondition("userId", "=", userId);
		}
		if(status != null) {
			qc.addCondition("status", "=", status);
		}
		if(startTime != null) {
			qc.addCondition("createTime", ">=", startTime);
		}
		if(endTime != null) {
			qc.addCondition("createTime", "<=", endTime);
		}
		qc.addSort("id", SortType.DESC);
		qc.setPage(new Page(pageSize, pageNo, showCount));
		List<Bet> list = bs.query(qc);
		Page page = qc.getPage(bs.getCount(qc));
		return new ResponseObject(100, "返回成功", new JsonResultMap().set("list", list).set("page", page));
	}
	
	//退款
	@RequestMapping("/betRefund")
	public ResponseObject betRefund(@RequestParam int betId, String description) {
		bs.refund(betId, description);
		return new ResponseObject(100, "操作成功");
	}
}