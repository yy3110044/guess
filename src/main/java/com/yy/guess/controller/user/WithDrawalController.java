package com.yy.guess.controller.user;

import java.util.List;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.yy.fast4j.Fast4jUtils;
import com.yy.fast4j.QueryCondition;
import com.yy.fast4j.ResponseObject;
import com.yy.guess.component.ConfigComponent;
import com.yy.guess.po.User;
import com.yy.guess.po.UserBankAccount;
import com.yy.guess.po.UserWithdrawal;
import com.yy.guess.po.enums.UserWithdrawalStatus;
import com.yy.guess.service.UserBankAccountService;
import com.yy.guess.service.UserService;
import com.yy.guess.service.UserWithdrawalService;

/**
 * 提款相关
 * @author 49803
 *
 */
@CrossOrigin
@RestController
@RequestMapping(value="/user", method=RequestMethod.POST)
public class WithDrawalController {
	@Autowired
	private UserBankAccountService ubas;
	
	@Autowired
	private UserWithdrawalService uws;
	
	@Autowired
	private UserService us;
	
	@Autowired
	private ConfigComponent cfgCom;
	
	//返回用户绑定的所有银行帐号
	@RequestMapping("/getAllBankAccount")
	public ResponseObject getAllBankAccount(HttpServletRequest req) {
		int userId = (Integer)req.getAttribute("userId");
		QueryCondition qc = new QueryCondition();
		qc.addCondition("userId", "=", userId);
		List<UserBankAccount> list = ubas.query(qc);
		return new ResponseObject(100, "返回成功", list);
	}
	
	//添加银行卡
	@RequestMapping("/addBankAccount")
	public ResponseObject addBankAccount(@RequestParam String bankCode,
                                         @RequestParam String bankName,
                                         @RequestParam String bankAccount,
                                         HttpServletRequest req) {
		int userId = (Integer)req.getAttribute("userId");
		User user = us.findById(userId);
		if(Fast4jUtils.empty(user.getRealName())) {
			return new ResponseObject(101, "请先设置真实姓名");
		}
		
		int count = ubas.getCount(new QueryCondition().addCondition("userId", "=", userId).addCondition("bankCode", "=", bankCode).addCondition("bankAccount", "=", bankAccount));
		if(count > 0) {
			return new ResponseObject(102, "已绑定了相同的银行卡");
		}

		UserBankAccount account = new UserBankAccount();
		account.setUserId(user.getId());
		account.setUserName(user.getUserName());
		account.setBankCode(bankCode);
		account.setBankName(bankName);
		account.setBankAccount(bankAccount);
		account.setBankAccountName(user.getRealName());
		ubas.add(account);
		return new ResponseObject(100, "添加成功");
	}
	
	//提款
	@RequestMapping("/withdrawal")
	public ResponseObject withdrawal(@RequestParam int userBankAccountId, @RequestParam double amount, @RequestParam String withdrawPassWord, HttpServletRequest req) {
		if(amount <= 0) {
			return new ResponseObject(101, "提款金额必须大于零");
		}
		if(amount < cfgCom.getWithdrawalMin() || amount > cfgCom.getWithdrawalMax()) {
			return new ResponseObject(102, "单笔提款金额范围：" + cfgCom.getWithdrawalMin() + " ~ " + cfgCom.getWithdrawalMax());
		}
		UserBankAccount account = ubas.findById(userBankAccountId);
		if(account == null) {
			return new ResponseObject(103, "收款帐号不存在");
		}
		int userId = (Integer)req.getAttribute("userId");
		User user = us.findById(userId);
		if(!user.getWithdrawPassWord().equals(DigestUtils.md5Hex(withdrawPassWord))) {
			return new ResponseObject(104, "资金密码错误");
		}
		if(amount > user.getBalance()) {
			return new ResponseObject(105, "您的余额不足");
		}
		UserWithdrawal uw = new UserWithdrawal();
		uw.setUserId(user.getId());
		uw.setUserName(user.getUserName());
		uw.setAmount(amount);
		uw.setBankCode(account.getBankCode());
		uw.setBankName(account.getBankName());
		uw.setBankAccount(account.getBankAccount());
		uw.setBankAccountName(account.getBankAccountName());
		uw.setStatus(UserWithdrawalStatus.处理中);
		uws.withdrawal(uw);
		return new ResponseObject(100, "提款申请提交成功");
	}
	
	//删除一个银行帐号
	@RequestMapping("/deleteBankAccount")
	public ResponseObject deleteBankAccount(@RequestParam int userBankAccountId, HttpServletRequest req) {
		int userId = (Integer)req.getAttribute("userId");
		return new ResponseObject(100, "删除成功", ubas.deleteAccount(userBankAccountId, userId));
	}
}