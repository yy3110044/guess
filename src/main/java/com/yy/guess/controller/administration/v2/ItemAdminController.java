package com.yy.guess.controller.administration.v2;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
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
import com.yy.guess.po.NewGuessItem;
import com.yy.guess.service.NewGuessItemService;

@CrossOrigin
@RestController
@RequestMapping(value="/administration/v2/itemAdmin", method=RequestMethod.POST)
public class ItemAdminController {
	@Autowired
	private NewGuessItemService ngis;

	@RequestMapping("/list")
	public ResponseObject list(@RequestParam(defaultValue="20") int pageSize,
            				   @RequestParam(defaultValue="1") int pageNo,
            				   @RequestParam(defaultValue="5") int showCount) {
		QueryCondition qc = new QueryCondition();
		qc.setPage(new Page(pageSize, pageNo, showCount));
		List<NewGuessItem> list = ngis.query(qc);
		return new ResponseObject(100, "返回成功", new JsonResultMap().set("list", list).set("page", qc.getPage(ngis.getCount(qc))));
	}
	
	@RequestMapping("/getAll")
	public ResponseObject getAll() {
		QueryCondition qc = new QueryCondition();
		qc.addSort("name", SortType.ASC);
		List<NewGuessItem> list = ngis.query(qc);
		return new ResponseObject(100, "返回成功", list);
	}
	
	@RequestMapping("/add")
	public ResponseObject add(@RequestParam String name, @RequestParam String logoUrl, @RequestParam String description) {
		if(Fast4jUtils.empty(name, logoUrl)) {
			return new ResponseObject(101, "名称和logo图不能为空");
		}
		NewGuessItem item = ngis.find(new QueryCondition().addCondition("name", "=", name));
		if(item != null) {
			return new ResponseObject(102, "此名称已存在");
		}
		item = new NewGuessItem();
		item.setName(name);
		item.setLogoUrl(logoUrl);
		item.setDescription(description);
		ngis.add(item);
		return new ResponseObject(100, "添加成功");
	}
	
	@RequestMapping("/delete")
	public ResponseObject delete(@RequestParam int itemId) {
		ngis.delete(itemId);
		return new ResponseObject(100, "删除项目");
	}
}