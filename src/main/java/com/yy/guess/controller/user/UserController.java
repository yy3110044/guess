package com.yy.guess.controller.user;

import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
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
		user.setWithdrawPassword(null);
		return new ResponseObject(100, "返回成功", user);
	}
	
	//返回用户余额
	@RequestMapping("/getBalance")
	public ResponseObject getBalance(HttpServletRequest req) {
		int userId = (Integer)req.getAttribute("userId");
		return new ResponseObject(100, "返回成功", us.getBalance(userId));
	}
}