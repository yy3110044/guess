package com.yy.guess.controller;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
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
import com.yy.guess.po.SystemNotice;
import com.yy.guess.po.UserNotice;
import com.yy.guess.service.SystemNoticeService;
import com.yy.guess.service.UserNoticeService;

/**
 * 通知notice
 * @author 49803
 *
 */
@CrossOrigin
@RestController
@RequestMapping(method=RequestMethod.POST)
public class NoticeController {
	@Autowired
	private SystemNoticeService sns;
	
	@Autowired
	private UserNoticeService uns;
	
	@RequestMapping("/systemNoticeList")
	public ResponseObject systemNoticeList(@RequestParam(defaultValue="20") int pageSize,
                                           @RequestParam(defaultValue="1") int pageNo,
                                           @RequestParam(defaultValue="5") int showCount) {
		QueryCondition qc = new QueryCondition();
		qc.addSort("top", SortType.DESC);
		qc.addSort("id", SortType.DESC);
		qc.setPage(new Page(pageSize, pageNo, showCount));
		List<SystemNotice> list = sns.query(qc);
		Page page = qc.getPage(sns.getCount(qc));
		return new ResponseObject(100, "返回成功", new JsonResultMap().set("list", list).set("page", page));
	}
	
	@RequestMapping("/user/userNoticeList")
	public ResponseObject userNoticeList(@RequestParam(defaultValue="20") int pageSize,
                                         @RequestParam(defaultValue="1") int pageNo,
                                         @RequestParam(defaultValue="5") int showCount,
                                         HttpServletRequest req) {
		Integer userId = (Integer)req.getAttribute("userId");
		QueryCondition qc = new QueryCondition();
		qc.addCondition("userId", "=", userId);
		qc.addSort("hadRead", SortType.ASC);
		qc.addSort("id", SortType.DESC);
		qc.setPage(new Page(pageSize, pageNo, showCount));
		List<UserNotice> list = uns.query(qc);
		Page page = qc.getPage(uns.getCount(qc));
		return new ResponseObject(100, "返回成功", new JsonResultMap().set("list", list).set("page", page));
	}
	
	//设置通知的状态
	@RequestMapping("/user/setHadRead")
	public ResponseObject setHadRead(@RequestParam int noticeId, @RequestParam boolean hadRead, HttpServletRequest req) {
		Integer userId = (Integer)req.getAttribute("userId");
		uns.setHadRead(hadRead, userId, noticeId);
		return new ResponseObject(100, "更新成功");
	}
	
	//返回通知详情
	@RequestMapping("/user/userNoticeDetail")
	public ResponseObject userNoticeDetail(@RequestParam int noticeId, HttpServletRequest req) {
		Integer userId = (Integer)req.getAttribute("userId");
		QueryCondition qc = new QueryCondition();
		qc.addCondition("id", "=", noticeId);
		qc.addCondition("userId", "=", userId);
		UserNotice notice = uns.find(qc);
		return new ResponseObject(100, "返回成功", notice);
	}
	
	//返回某用户的未读通知数量，未登陆返回零
	@RequestMapping("/user/getUnreadUserNoticeCount")
	public ResponseObject getUnreadUserNoticeCount(HttpServletRequest req) {
		Integer userId = (Integer)req.getAttribute("userId");
		QueryCondition qc = new QueryCondition();
		qc.addCondition("userId", "=", userId);
		qc.addCondition("hadRead", "=", false);
		int count = uns.getCount(qc);
		return new ResponseObject(100, "返回成功", count);
	}
}