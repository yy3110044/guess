package com.yy.guess.controller.user;

import javax.servlet.http.HttpServletRequest;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.yy.fast4j.Fast4jUtils;
import com.yy.fast4j.ResponseObject;
import com.yy.guess.po.User;
import com.yy.guess.service.UserService;

/**
 * 用户相关
 * @author 49803
 *
 */
@CrossOrigin
@RestController
@RequestMapping(value="/user", method=RequestMethod.POST)
public class UserController {
	@Autowired
	private UserService us;
	
	//返回用户信息
	@RequestMapping("/getUserInfo")
	public ResponseObject getUserInfo(HttpServletRequest req) {
		int userId = (Integer)req.getAttribute("userId");
		User user = us.findById(userId);
		user.setPassWord(null);
		user.setWithdrawPassWord(null);
		return new ResponseObject(100, "返回成功", user);
	}
	
	//返回用户余额
	@RequestMapping("/getBalance")
	public ResponseObject getBalance(HttpServletRequest req) {
		int userId = (Integer)req.getAttribute("userId");
		return new ResponseObject(100, "返回成功", us.getBalance(userId));
	}
	
	//更改真实姓名
	@RequestMapping("/updateRealName")
	public ResponseObject updateRealName(@RequestParam String realName, HttpServletRequest req) {
		int userId = (Integer)req.getAttribute("userId");
		us.updateRealName(realName, userId);
		return new ResponseObject(100, "更改成功");
	}
	
	//修改资料：nickName、qq、email
	@RequestMapping("/updateInfo")
	public ResponseObject updateInfo(@RequestParam String nickName, @RequestParam String qq, @RequestParam String email, HttpServletRequest req) {
		int userId = (Integer)req.getAttribute("userId");
		us.updateInfo(nickName, qq, email, userId);
		return new ResponseObject(100, "更改成功");
	}
	
	//修改登陆密码
	@RequestMapping("/updatePassWord")
	public ResponseObject updatePassWord(@RequestParam String oldPassWord, @RequestParam String newPassWord, HttpServletRequest req) {
		if(Fast4jUtils.empty(newPassWord)) {
			return new ResponseObject(101, "新密码不能为空");
		}
		int userId = (Integer)req.getAttribute("userId");
		User user = us.findById(userId);
		if(!user.getPassWord().equals(DigestUtils.md5Hex(oldPassWord))) {
			return new ResponseObject(102, "原密码错误");
		}
		us.updatePassWord(DigestUtils.md5Hex(newPassWord), userId);
		return new ResponseObject(100, "更改成功");
	}
	
	//修改资金密码
	@RequestMapping("/updateWithdrawPassWord")
	public ResponseObject updateWithdrawPassWord(@RequestParam String oldWithdrawPassWord, @RequestParam String newWithdrawPassWord, HttpServletRequest req) {
		if(Fast4jUtils.empty(newWithdrawPassWord)) {
			return new ResponseObject(101, "新密码不能为空");
		}
		int userId = (Integer)req.getAttribute("userId");
		User user = us.findById(userId);
		if(Fast4jUtils.empty(user.getWithdrawPassWord())) { //未设置资金密码直接修改
			us.updateWithdrawPassword(DigestUtils.md5Hex(newWithdrawPassWord), userId);
			return new ResponseObject(100, "更改成功");
		} else { //有资金密码，先比对旧密码
			if(!user.getWithdrawPassWord().equals(DigestUtils.md5Hex(oldWithdrawPassWord))) {
				return new ResponseObject(102, "原密码错误");
			} else {
				us.updateWithdrawPassword(DigestUtils.md5Hex(newWithdrawPassWord), userId);
				return new ResponseObject(100, "更改成功");
			}
		}
	}
	
	//返回是否设置了资金密码
	@RequestMapping("/haveWithdrawPassWord")
	public ResponseObject haveWithdrawPassWord(HttpServletRequest req) {
		int userId = (Integer)req.getAttribute("userId");
		User user = us.findById(userId);
		return new ResponseObject(100, "返回成功", !Fast4jUtils.empty(user.getWithdrawPassWord()));
	}
}