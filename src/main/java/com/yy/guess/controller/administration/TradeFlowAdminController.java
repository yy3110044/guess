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
import com.yy.guess.po.TradeFlow;
import com.yy.guess.po.enums.TradeType;
import com.yy.guess.service.TradeFlowService;

/**
 * 流水管理
 * @author 49803
 *
 */
@CrossOrigin
@RestController
@RequestMapping(value="/administration", method=RequestMethod.POST)
public class TradeFlowAdminController {
	@Autowired
	private TradeFlowService tfs;
	
	@RequestMapping("/tradeFlowList")
	public ResponseObject tradeFlowList(Integer userId,
                                        TradeType type,
                                        @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss") Date startTime,
                                        @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss") Date endTime,
                                        @RequestParam(defaultValue="20") int pageSize,
                                        @RequestParam(defaultValue="1") int pageNo,
                                        @RequestParam(defaultValue="5") int showCount) {
		QueryCondition qc = new QueryCondition();
		if(userId != null) {
			qc.addCondition("userId", "=", userId);
		}
		if(type != null) {
			qc.addCondition("type", "=", type);
		}
		if(startTime != null) {
			qc.addCondition("createTime", ">=", startTime);
		}
		if(endTime != null) {
			qc.addCondition("createTime", "<=", endTime);
		}
		qc.addSort("id", SortType.DESC);
		qc.setPage(new Page(pageSize, pageNo, showCount));

		List<TradeFlow> list = tfs.query(qc);
		Page page = qc.getPage(tfs.getCount(qc));
		return new ResponseObject(100, "返回成功", new JsonResultMap().set("list", list).set("page", page));
	}
}