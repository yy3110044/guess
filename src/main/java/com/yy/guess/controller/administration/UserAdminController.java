package com.yy.guess.controller.administration;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.yy.fast4j.Fast4jUtils;
import com.yy.fast4j.JsonResultMap;
import com.yy.fast4j.Page;
import com.yy.fast4j.QueryCondition;
import com.yy.fast4j.RedisUtil;
import com.yy.fast4j.QueryCondition.SortType;
import com.yy.fast4j.ResponseObject;
import com.yy.guess.po.User;
import com.yy.guess.po.enums.TradeType;
import com.yy.guess.service.TradeFlowService;
import com.yy.guess.service.UserService;
import com.yy.guess.util.CachePre;

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
	
	@Autowired
	private TradeFlowService tfs;
	
	@Autowired
	private RedisTemplate<String, Object> redisTemplate;
	
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
	//返回下级用户数
	@RequestMapping("/getSubordinateCount")
	public ResponseObject getSubordinateCount(@RequestParam int superUserId) {
		QueryCondition qc = new QueryCondition();
		qc.addCondition("superUserId", "=", superUserId);
		int count = us.getCount(qc);
		return new ResponseObject(100, "返回成功", count);
	}
	
	@RequestMapping("/userList")
	public ResponseObject userList(Integer userId,
                                   String userName,
                                   @RequestParam(defaultValue="id") String sortField,
                                   @RequestParam(defaultValue="DESC") SortType sortType,
                                   @RequestParam(defaultValue="20") int pageSize,
                                   @RequestParam(defaultValue="1") int pageNo,
                                   @RequestParam(defaultValue="5") int showCount) {
		QueryCondition qc = new QueryCondition();
		if(userId != null) {
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
	
	//用户详情
	@RequestMapping("/userDetail")
	public ResponseObject userDetail(@RequestParam int userId) {
		return new ResponseObject(100, "返回成功", us.findById(userId));
	}
	
	//删除用户
	@RequestMapping("/userDelete")
	public ResponseObject userDelete(@RequestParam int userId) {
		int subordinateCount = us.getCount(new QueryCondition().addCondition("superUserId", "=", userId));
		if(subordinateCount > 0) {
			return new ResponseObject(101, "此用户还有下级用户不能删除");
		}
		us.delete(userId);
		return new ResponseObject(100, "删除成功");
	}
	
	//修改用户余额
	@RequestMapping("/updateBalance")
	public ResponseObject updateBalance(@RequestParam double amount,
                                        @RequestParam TradeType type,
                                        String description,
                                        @RequestParam int userId) {
		Object[] result = tfs.updateBalance(amount, type, description, userId);
		return new ResponseObject((Integer)result[0], (String)result[1]);
	}
	
	//修改返点
	@RequestMapping("/updateRebateRate")
	public ResponseObject updateRebateRate(@RequestParam double rebateRate,
                                           @RequestParam int userId) {
		double userRebateRateMax = Double.parseDouble(RedisUtil.getString(redisTemplate, CachePre.GUESS_CONFIG, "userRebateRateMax"));
		double userRebateRateMin = Double.parseDouble(RedisUtil.getString(redisTemplate, CachePre.GUESS_CONFIG, "userRebateRateMin"));
		
		User user = us.findById(userId);
		User superUser = us.findById(user.getSuperUserId());
		
		if(superUser != null) {
			userRebateRateMax = superUser.getRebateRate() < userRebateRateMax ? superUser.getRebateRate() : userRebateRateMax;
		}
		
		if(rebateRate > userRebateRateMax || rebateRate < userRebateRateMin) {
			return new ResponseObject(101, "不在范围内");
		}
		us.updateRebateRate(rebateRate, userId);
		return new ResponseObject(100, "修改成功");
	}
	
	//修改用户信息
	@RequestMapping("/updateInfo")
	public ResponseObject updateInfo(@RequestParam int userId,
                                     String nickName,
                                     String qq,
                                     String phone,
                                     String email) {
		us.updateInfo(nickName, qq, phone, email, userId);
		return new ResponseObject(100, "修改成功");
	}
}