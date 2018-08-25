package com.yy.guess.component;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import com.yy.fast4j.RedisUtil;
import com.yy.guess.mapper.ConfigMapper;
import com.yy.guess.po.Config;
import com.yy.guess.util.CachePre;

/**
 * 配置组件
 * @author 49803
 *
 */
@Component
public class ConfigComponent {
	@Autowired
	private ConfigMapper cm;
	
	@Autowired
	private RedisTemplate<String, Object> redisTemplate;
	
	public void loadConfigToCache() {
		List<Config> list = this.getAllConfig();
		for(Config config : list) {
			RedisUtil.set(redisTemplate, CachePre.GUESS_CONFIG, config.getName(), config.getVal());
		}
	}
	
	public List<Config> getAllConfig() {
		return cm.query(null);
	}
	
	@Transactional
	public void update(Config[] configs) {
		for(Config config : configs) {
			cm.updateByName(config.getName(), config.getVal());
			RedisUtil.set(redisTemplate, CachePre.GUESS_CONFIG, config.getName(), config.getVal());
		}
	}
	
	//返回标题
	public String getWebTitle() {
		return RedisUtil.getString(redisTemplate, CachePre.GUESS_CONFIG, "webTitle");
	}
	
	//返回uploadUrl
	public String getUploadUrl() {
		return RedisUtil.getString(redisTemplate, CachePre.GUESS_CONFIG, "uploadUrl");
	}
	
	//返回用户返点率上限 userRebateRateMax
	public double getUserRebateRateMax() {
		String str = RedisUtil.getString(redisTemplate, CachePre.GUESS_CONFIG, "userRebateRateMax");
		return Double.parseDouble(str);
	}
	
	//返回用户返点率下限 userRebateRateMin
	public double getUserRebateRateMin() {
		String str = RedisUtil.getString(redisTemplate, CachePre.GUESS_CONFIG, "userRebateRateMin");
		return Double.parseDouble(str);
	}

	//返回平台抽成
	public double getPlatformRate() {
		String str = RedisUtil.getString(redisTemplate, CachePre.GUESS_CONFIG, "platformRate");
		return Double.parseDouble(str);
	}
}