package com.yy.guess.controller.administration;

import java.util.List;
import org.apache.commons.text.StringEscapeUtils;
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
import com.yy.guess.po.SystemNotice;
import com.yy.guess.po.User;
import com.yy.guess.po.UserNotice;
import com.yy.guess.service.SystemNoticeService;
import com.yy.guess.service.UserNoticeService;
import com.yy.guess.service.UserService;

/**
 * 通知管理
 * @author 49803
 *
 */
@CrossOrigin
@RestController
@RequestMapping(value="/administration", method=RequestMethod.POST)
public class NoticeAdminController {
	@Autowired
	private UserNoticeService uns;
	
	@Autowired
	private UserService us;
	
	@Autowired
	private SystemNoticeService sns;
	
	@RequestMapping("/userNoticeList")
	public ResponseObject userNoticeList(String userName,
                                         @RequestParam(defaultValue="20") int pageSize,
                                         @RequestParam(defaultValue="1") int pageNo,
                                         @RequestParam(defaultValue="5") int showCount) {
		QueryCondition qc = new QueryCondition();
		if(!Fast4jUtils.empty(userName)) {
			qc.addCondition("userId", "=", us.getUserIdByUserName(userName));
		}
		qc.setPage(new Page(pageSize, pageNo, showCount));
		qc.addSort("id", SortType.DESC);
		List<UserNotice> list = uns.query(qc);
		Page page = qc.getPage(uns.getCount(qc));
		return new ResponseObject(100, "返回成功", new JsonResultMap().set("list", list).set("page", page));
	}
	
	@RequestMapping("/userNoticeAdd")
	public ResponseObject userNoticeAdd(@RequestParam int userId, @RequestParam String title, @RequestParam String content) {
		User user = us.findById(userId);
		if(user == null) {
			return new ResponseObject(101, "用户不存在");
		}
		UserNotice notice = new UserNotice();
		notice.setUserId(user.getId());
		notice.setUserName(user.getUserName());
		notice.setTitle(StringEscapeUtils.escapeHtml4(title));
		notice.setContent(StringEscapeUtils.escapeHtml4(content));
		uns.add(notice);
		return new ResponseObject(100, "添加成功");
	}
	
	@RequestMapping("/userNoticeDelete")
	public ResponseObject userNoticeDelete(@RequestParam int userNoticeId) {
		uns.delete(userNoticeId);
		return new ResponseObject(100, "删除成功");
	}
	
	@RequestMapping("/systemNoticeList")
	public ResponseObject systemNoticeList(@RequestParam(defaultValue="20") int pageSize,
                                           @RequestParam(defaultValue="1") int pageNo,
                                           @RequestParam(defaultValue="5") int showCount) {
		QueryCondition qc = new QueryCondition();
		qc.setPage(new Page(pageSize, pageNo, showCount));
		qc.addSort("top", SortType.DESC);
		qc.addSort("id", SortType.DESC);
		List<SystemNotice> list = sns.query(qc);
		Page page = qc.getPage(sns.getCount(qc));
		return new ResponseObject(100, "返回成功", new JsonResultMap().set("list", list).set("page", page));
	}
	
	@RequestMapping("/systemNoticeAdd")
	public ResponseObject systemNoticeAdd(@RequestParam String content) {
		SystemNotice notice = new SystemNotice();
		notice.setContent(StringEscapeUtils.escapeHtml4(content));
		sns.add(notice);
		return new ResponseObject(100, "添加成功");
	}
	
	@RequestMapping("/systemNoticeDelete")
	public ResponseObject systemNoticeDelete(@RequestParam int systemNoticeId) {
		sns.delete(systemNoticeId);
		return new ResponseObject(100, "删除成功");
	}
	
	//将某个系统通知置顶
	@RequestMapping("/systemNoticeTop")
	public ResponseObject systemNoticeTop(@RequestParam int systemNoticeId) {
		sns.setTop(systemNoticeId);
		return new ResponseObject(100, "已置顶");
	}
}