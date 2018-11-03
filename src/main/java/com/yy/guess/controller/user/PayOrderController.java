package com.yy.guess.controller.user;

import java.util.UUID;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.yy.fast4j.ResponseObject;
import com.yy.guess.component.ConfigComponent;
import com.yy.guess.po.PayOrder;
import com.yy.guess.po.User;
import com.yy.guess.po.enums.PayOrderStatus;
import com.yy.guess.service.PayOrderService;
import com.yy.guess.service.UserService;
import com.yy.guess.util.Util;

@Deprecated
@CrossOrigin
@RestController
@RequestMapping(value="/user", method=RequestMethod.POST)
public class PayOrderController {
	@Autowired
	private PayOrderService pos;
	
	@Autowired
	private UserService us;
	
	@Autowired
	private ConfigComponent cfgCom;
	
	/**
	 * 生成支付订单
	 * @param amount
	 * @param subject
	 * @param payType
	 * @param req
	 * @return
	 */
	@RequestMapping("/generatePayOrder")
	public ResponseObject generatePayOrder(@RequestParam double amount, @RequestParam String subject, @RequestParam String payType, HttpServletRequest req) {
		amount = Double.parseDouble(Util.formatNumber(amount));//格式化金额只取两位小数，多余的截除
		if(amount <= 0) {
			return new ResponseObject(101, "充值金额必须大于零");
		}
		
		double payMin = cfgCom.getPayMin();
		double payMax = cfgCom.getPayMax();
		if(amount < payMin || amount > payMax) {
			return new ResponseObject(102, "充值限额¥" + payMin + " ~ " + payMax);
		}
		int userId = (Integer)req.getAttribute("userId");
		User user = us.findById(userId);
		PayOrder order = new PayOrder();
		order.setId(UUID.randomUUID().toString().replace("-", "").toUpperCase());
		order.setUserId(user.getId());
		order.setUserName(user.getUserName());
		order.setAmount(amount);
		order.setSubject(subject);
		order.setPayType(payType);
		order.setStatus(PayOrderStatus.未支付);
		pos.add(order);
		return new ResponseObject(100, "订单生成成功", order);
	}
}