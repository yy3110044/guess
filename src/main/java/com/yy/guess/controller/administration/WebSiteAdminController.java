package com.yy.guess.controller.administration;

import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import com.yy.fast4j.RedisUtil;
import com.yy.fast4j.ResponseObject;
import com.yy.guess.po.AdminUser;
import com.yy.guess.po.Config;
import com.yy.guess.service.AdminUserService;
import com.yy.guess.service.ConfigService;
import com.yy.guess.util.CachePre;

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
	private AdminUserService aus;
	
	@Autowired
	private ConfigService cs;
	
	@Autowired
	private RedisTemplate<String, Object> redisTemplate;

	
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
		return new ResponseObject(100, "返回成功", cs.query(null));
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
				
				RedisUtil.set(redisTemplate, CachePre.GUESS_CONFIG, configs[i].getName(), configs[i].getVal());
			}
			cs.update(configs);
			return new ResponseObject(100, "修改成功");
		} else {
			return new ResponseObject(101, "参数不能为空");
		}
	}
}