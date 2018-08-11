package com.yy.guess.controller.administration;

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
import com.yy.fast4j.QueryCondition.SortType;
import com.yy.fast4j.ResponseObject;
import com.yy.guess.po.User;
import com.yy.guess.service.UserService;

/**
 * 会员管理
 * @author yy
 *
 */
@CrossOrigin
@RestController
@RequestMapping(value="/administration", method=RequestMethod.POST)
public class UserAdminController {
	@Autowired
	private UserService us;
	
	@RequestMapping("/userTreeList")
	public ResponseObject userTreeList(@RequestParam(defaultValue="0") int superUserId,
                                       @RequestParam String sortField,
                                       @RequestParam SortType sortType,
                                       @RequestParam(defaultValue="20") int pageSize,
                                       @RequestParam(defaultValue="1") int pageNo,
                                       @RequestParam(defaultValue="5") int showCount) {
		QueryCondition qc = new QueryCondition();
		qc.addCondition("superUserId", "=", superUserId);
		qc.addSort(sortField, sortType);
		qc.setPage(new Page(pageSize, pageNo, showCount));
		
		List<User> list = us.query(qc);
		Page page = qc.getPage(us.getCount(qc));
		return new ResponseObject(100, "返回成功", new JsonResultMap().set("list", list).set("page", page));
	}
	
	@RequestMapping("/userList")
	public ResponseObject userList(int userId,
                                   String userName,
                                   @RequestParam(defaultValue="id") String sortField,
                                   @RequestParam(defaultValue="DESC") SortType sortType,
                                   @RequestParam(defaultValue="20") int pageSize,
                                   @RequestParam(defaultValue="1") int pageNo,
                                   @RequestParam(defaultValue="5") int showCount) {
		QueryCondition qc = new QueryCondition();
		if(userId > 0) {
			qc.addCondition("id", "=", userId);
		}
		if(!Fast4jUtils.empty(userName)) {
			qc.addCondition("userName", "=", userName.trim());
		}
		qc.addSort(sortField, sortType);
		qc.setPage(new Page(pageSize, pageNo, showCount));
		
		List<User> list = us.query(qc);
		Page page = qc.getPage(us.getCount(qc));
		return new ResponseObject(100, "返回成功", new JsonResultMap().set("list", list).set("page", page));
	}
}