package com.yy.guess.controller.administration;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.yy.fast4j.Fast4jUtils;
import com.yy.fast4j.JsonResultMap;
import com.yy.fast4j.Page;
import com.yy.fast4j.QueryCondition;
import com.yy.fast4j.ResponseObject;
import com.yy.guess.po.Sport;
import com.yy.guess.service.SportService;

/**
 * 竞猜管理
 * @author yy
 *
 */
@RestController
@RequestMapping(value="/administration", method=RequestMethod.POST)
public class GuessAdminController {
	
	@Autowired
	private SportService ss;
	
	@RequestMapping("/sportAdd")
	public ResponseObject sportAdd(@RequestParam String name, @RequestParam String logoUrl, @RequestParam String description) {
		if(Fast4jUtils.empty(name, logoUrl)) {
			return new ResponseObject(101, "名称和logo图不能为空");
		}
		Sport sport = ss.find(new QueryCondition().addCondition("name", "=", name));
		if(sport != null) {
			return new ResponseObject(102, "此名称已存在");
		}
		sport = new Sport();
		sport.setName(name);
		sport.setLogoUrl(logoUrl);
		sport.setDescription(description);
		ss.add(sport);
		return new ResponseObject(100, "添加成功");
	}
	
	@RequestMapping("/sportList")
	public ResponseObject sportList(@RequestParam(defaultValue="20") int pageSize,
                                     @RequestParam(defaultValue="1") int pageNo,
                                     @RequestParam(defaultValue="5") int showCount) {
		QueryCondition qc = new QueryCondition();
		qc.setPage(new Page(pageSize, pageNo, showCount));
		List<Sport> list = ss.query(qc);
		return new ResponseObject(100, "返回成功", new JsonResultMap().set("list", list).set("page", qc.getPage().setRowCount(ss.getCount(qc))));
	}
}