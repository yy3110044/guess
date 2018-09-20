package com.yy.guess.controller;

import java.util.Arrays;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.yy.fast4j.Fast4jUtils;
import com.yy.fast4j.LoginManager;
import com.yy.fast4j.QueryCondition;
import com.yy.fast4j.ResponseObject;
import com.yy.guess.po.AdminUser;
import com.yy.guess.po.AdminUserLoginLog;
import com.yy.guess.po.User;
import com.yy.guess.po.UserLoginLog;
import com.yy.guess.po.enums.UserLoginType;
import com.yy.guess.service.AdminUserLoginLogService;
import com.yy.guess.service.AdminUserService;
import com.yy.guess.service.UserLoginLogService;
import com.yy.guess.service.UserService;

/**
 * 登陆相关的controller
 * @author yy
 *
 */
@CrossOrigin
@RestController
@RequestMapping(method=RequestMethod.POST)
public class LoginAboutController {
	@Autowired
	private UserService us;
	
	@Autowired
	private AdminUserService aus;
	
	@Autowired
	private UserLoginLogService ulls;
	
	@Autowired
	private AdminUserLoginLogService aulls;
	
	@Autowired
	private LoginManager loginManager;
	
	@RequestMapping("/userLogin")
	public ResponseObject userLogin(@RequestParam String userName,
                                    @RequestParam String passWord,
                                    @RequestParam UserLoginType loginType,
                                    HttpServletRequest req) {
		User user = us.find(new QueryCondition().addCondition("userName", "=", userName).addCondition("passWord", "=", DigestUtils.md5Hex(passWord)));
		if(user == null) {
			return new ResponseObject(101, "用户名或密码错误");
		}
		
		UserLoginLog log = new UserLoginLog();
		log.setUserId(user.getId());
		log.setUserName(user.getUserName());
		log.setLoginIp(req.getRemoteAddr());
		log.setLoginTime(new Date());
		log.setLoginType(loginType);
		log.setUserAgent(req.getHeader("user-agent"));
		ulls.addLog(log);
		
		switch(loginType) {
		case WEB:
			loginManager.webLogin(user.getId(), req.getSession());
			return new ResponseObject(100, "登陆成功");
		case APP:
			return new ResponseObject(100, "登陆成功", loginManager.appLogin(user.getId()));
		default:
			return new ResponseObject(102, "未知的登陆类型");
		}
	}
	
	@RequestMapping("/userLogout")
	public ResponseObject userLogout(String token, HttpSession session) {
		loginManager.appLogout(token);
		loginManager.webLogout(session);
		return new ResponseObject(100, "退出登陆成功");
	}
	
	@RequestMapping("/isLoginByToken")
	public ResponseObject isLoginByToken(@RequestParam String token) {
		return new ResponseObject(100, "查询成功", loginManager.isLogin(token));
	}
	
	@RequestMapping("/isLoginBySession")
	public ResponseObject isLoginBySession(HttpSession session) {
		return new ResponseObject(100, "查询成功", loginManager.isLogin(session));
	}

	//用户名允许的字符
	private static final char[] userNameChar = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".toCharArray();
	static {
		Arrays.sort(userNameChar);//排下序，用于二分查找
	}
	@RequestMapping("/userRegistry")
	public ResponseObject userRegistry(@RequestParam String userName,
                                       @RequestParam String passWord,
                                       String nickName,
                                       String realName,
                                       String qq,
                                       String phone,
                                       String email,
                                       String superUserName,
                                       HttpSession session) {
		if(Fast4jUtils.empty(userName, passWord)) {
			return new ResponseObject(101, "用户名或密码不能为空");
		}
		
		userName = userName.trim();
		for(char c : userName.toCharArray()) {
			if(Arrays.binarySearch(userNameChar, c) < 0) {
				return new ResponseObject(102, "用户名只能是字母、和数字");
			}
		}
		
		User user = us.find(new QueryCondition().addCondition("userName", "=", userName));
		if(user != null) {
			return new ResponseObject(103, "此用户名已被注册");
		}
		
		user = new User();
		
		if(!Fast4jUtils.empty(superUserName)) {
			User superUser = us.find(new QueryCondition().addCondition("userName", "=", superUserName));
			if(superUser == null) {
				return new ResponseObject(104, "推荐用户不存在");
			} else {
				user.setSuperUserId(superUser.getId());
				user.setRebateRate(superUser.getSubordinateDefaultRebateRate());
			}
		}
		
		user.setUserName(userName);
		user.setPassWord(DigestUtils.md5Hex(passWord));
		user.setNickName(nickName);
		if(!Fast4jUtils.empty(realName)) {
			user.setRealName(realName);
			user.setRealNameLock(true);
		}
		user.setQq(qq);
		user.setPhone(phone);
		user.setEmail(email);
		user.setRegistTime(new Date());
		us.add(user);
		return new ResponseObject(100, "注册成功");
	}
	
	@RequestMapping("/adminUserLogin")
	public ResponseObject adminUserLogin(@RequestParam String userName, @RequestParam String passWord, HttpServletRequest req) {
		AdminUser au = aus.find(new QueryCondition().addCondition("userName", "=", userName.trim()).addCondition("passWord", "=", DigestUtils.md5Hex(passWord)));
		if(au == null) {
			return new ResponseObject(101, "用户名或密码错误");
		}

		AdminUserLoginLog log = new AdminUserLoginLog();
		log.setAdminUserId(au.getId());
		log.setAdminUserName(au.getUserName());
		log.setLoginIp(req.getRemoteAddr());
		log.setLoginTime(new Date());
		log.setUserAgent(req.getHeader("user-agent"));
		aulls.addLog(log);
		req.getSession().setAttribute("adminUserId", au.getId());
		return new ResponseObject(100, "登陆成功");
	}
	
	@RequestMapping("/adminUserLogout")
	public ResponseObject adminUserLogout(HttpSession session) {
		session.removeAttribute("adminUserId");
		return new ResponseObject(100, "退出登陆成功");
	}
}