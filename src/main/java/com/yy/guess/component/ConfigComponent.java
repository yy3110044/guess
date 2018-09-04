package com.yy.guess.component;

import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import com.yy.guess.mapper.ConfigMapper;
import com.yy.guess.po.Config;

/**
 * 配置组件
 * @author 49803
 *
 */
@Component
public class ConfigComponent {
	@Autowired
	private ConfigMapper cm;

	private Map<String, String> configMap = new ConcurrentHashMap<String, String>();
	
	public void loadConfigToCache() {
		List<Config> list = this.getAllConfig();
		for(Config config : list) {
			configMap.put(config.getName(), config.getVal());
		}
	}
	
	public List<Config> getAllConfig() {
		return cm.query(null);
	}
	
	@Transactional
	public void update(Config[] configs) {
		for(Config config : configs) {
			cm.updateByName(config.getName(), config.getVal());
			configMap.put(config.getName(), config.getVal());
		}
	}
	
	//返回标题
	public String getWebTitle() {
		return configMap.get("webTitle");
	}
	
	//返回uploadUrl
	public String getUploadUrl() {
		return configMap.get("uploadUrl");
	}
	
	//返回用户返点率上限 userRebateRateMax
	public double getUserRebateRateMax() {
		String str = configMap.get("userRebateRateMax");
		return Double.parseDouble(str);
	}
	
	//返回用户返点率下限 userRebateRateMin
	public double getUserRebateRateMin() {
		String str = configMap.get("userRebateRateMin");
		return Double.parseDouble(str);
	}

	//返回平台抽成
	public double getPlatformRate() {
		String str = configMap.get("platformRate");
		return Double.parseDouble(str);
	}
	
	//返回返还率
	public double getReturnRate() {
		String str = configMap.get("returnRate");
		return Double.parseDouble(str);
	}
	
	//返回下注金额下限
	public double getBetAmountMin() {
		String str = configMap.get("betAmountMin");
		return Double.parseDouble(str);
	}
	
	//返加下注金额上限
	public double getBetAmountMax() {
		String str = configMap.get("betAmountMax");
		return Double.parseDouble(str);
	}
	
	//返回客服链接
	public String getCustomerServiceUrl() {
		return configMap.get("customerServiceUrl");
	}
}