package com.yy.guess.controller.administration;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
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
import com.yy.guess.component.ConfigComponent;
import com.yy.guess.po.AdminUser;
import com.yy.guess.po.AdminUserLoginLog;
import com.yy.guess.po.Config;
import com.yy.guess.po.User;
import com.yy.guess.po.UserLoginLog;
import com.yy.guess.service.AdminUserLoginLogService;
import com.yy.guess.service.AdminUserService;
import com.yy.guess.service.UserLoginLogService;
import com.yy.guess.service.UserService;

/**
 * 网站信息controller
 * @author yy
 *
 */
@CrossOrigin
@RestController
@RequestMapping(value="/administration", method=RequestMethod.POST)
public class WebSiteAdminController {
	@Autowired
	private UserService us;
	
	@Autowired
	private AdminUserService aus;
	
	@Autowired
	private ConfigComponent cfgCom;
	
	@Autowired
	private AdminUserLoginLogService aulls;
	
	@Autowired
	private UserLoginLogService ulls;

	@RequestMapping("/getWebsiteInfo")
	public ResponseObject getWebsiteInfo(HttpServletRequest req) {
		int adminUserId = (Integer)req.getAttribute("adminUserId");
		AdminUser au = aus.findById(adminUserId);
		Map<String, Object> result = new HashMap<>();
		result.put("adminUserName", au.getUserName());
		result.put("adminUserLastLoginTime", au.getLastLoginTime());
		result.put("adminUserLastLoginIp", au.getLastLoginIp());
		result.put("os", System.getProperty("os.name", "") + " " + System.getProperty("os.arch", "") + " " + System.getProperty("os.version", ""));
		result.put("serverName", req.getServerName());
		result.put("container", req.getServletContext().getServerInfo());
		result.put("userAgent", req.getHeader("user-agent"));
		return new ResponseObject(100, "返回成功", result);
	}
	
	@RequestMapping("/getAllConfigs")
	public ResponseObject getAllConfigs() {
		return new ResponseObject(100, "返回成功", cfgCom.getAllConfig());
	}
	
	//修改配置(同时修改数据库与缓存)
	@RequestMapping("/modifyConfig")
	public ResponseObject modifyConfig(HttpServletRequest req) {
		String[] name_val = req.getParameterValues("name_val[]");
		if(name_val != null && name_val.length > 0) {
			int length = name_val.length;
			Config[] configs = new Config[length];
			for(int i=0; i<length; i++) {
				String[] strs = name_val[i].split("=>");
				configs[i] = new Config();
				configs[i].setName(strs[0]);
				configs[i].setVal(strs[1]);
			}
			cfgCom.update(configs);
			return new ResponseObject(100, "修改成功");
		} else {
			return new ResponseObject(101, "参数不能为空");
		}
	}
	
	//用户日志list
	@RequestMapping("/loginLogList")
	public ResponseObject loginLogList(@RequestParam String type,
                                       String userName,
                                       @RequestParam(defaultValue="20") int pageSize,
                                       @RequestParam(defaultValue="1") int pageNo,
                                       @RequestParam(defaultValue="5") int showCount) {
		if("user".equals(type)) {
			QueryCondition qc = new QueryCondition();
			if(!Fast4jUtils.empty(userName)) {
				User user = us.find(new QueryCondition().addCondition("userName", "=", userName));
				if(user == null) {
					qc.addCondition("userId", "=", 0);
				} else {
					qc.addCondition("userId", "=", user.getId());
				}
			}
			qc.addSort("id", SortType.DESC);
			qc.setPage(new Page(pageSize, pageNo, showCount));
			List<UserLoginLog> list = ulls.query(qc);
			Page page = qc.getPage(ulls.getCount(qc));
			return new ResponseObject(100, "返回成功", new JsonResultMap().set("list", list).set("page", page));
		} else if("adminUser".equals(type)) {
			QueryCondition qc = new QueryCondition();
			if(!Fast4jUtils.empty(userName)) {
				AdminUser au = aus.find(new QueryCondition().addCondition("userName", "=", userName));
				if(au == null) {
					qc.addCondition("adminUserId", "=", 0);
				} else {
					qc.addCondition("adminUserId", "=", au.getId());
				}
			}
			qc.addSort("id", SortType.DESC);
			qc.setPage(new Page(pageSize, pageNo, showCount));
			List<AdminUserLoginLog> list = aulls.query(qc);
			Page page = qc.getPage(aulls.getCount(qc));
			return new ResponseObject(100, "返回成功", new JsonResultMap().set("list", list).set("page", page));
		} else {
			return new ResponseObject(101, "未知的type类型");
		}
	}
}