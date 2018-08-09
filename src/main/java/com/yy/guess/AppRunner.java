package com.yy.guess;

import java.util.List;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.boot.CommandLineRunner;
import org.springframework.core.Ordered;
import org.springframework.stereotype.Component;
import com.yy.fast4j.Cache;
import com.yy.guess.component.GuessSettleComponent;
import com.yy.guess.po.Config;
import com.yy.guess.service.ConfigService;
import com.yy.guess.util.CachePre;

@Component
public class AppRunner implements CommandLineRunner, ApplicationRunner, Ordered {
	private static final Logger logger = LogManager.getLogger(AppRunner.class);
	
	@Autowired
	private ConfigService cs;
	
	@Autowired
	private Cache cache;
	
	@Autowired
	private GuessSettleComponent guessSettleComponent;

	/**
	 * 实现Ordered接口，可以实现，不同的操作按顺序启动
	 */
	@Override
	public int getOrder() {
		return 0;
	}

	/**
	 * 实现ApplicationRunner接口，也可以实现开机启动，ApplicationArguments对参数作了进一步封装
	 */
	@Override
	public void run(ApplicationArguments args) throws Exception {
		
	}

	//实现CommandLineRunner接口，并重写run方法，就可以在spring boot启动后执行一些操作，
	//同时在要在实现类上加上@Component注解，这里直接用
	@Override
	public void run(String... args) throws Exception {
		loadConfigToCache();
		guessSettleComponent.start();
	}
	//加载Config到Cache
	private void loadConfigToCache() {
		logger.info("加载Config到缓存");
		List<Config> list = cs.query(null);
		for(Config config : list) {
			cache.set(CachePre.GUESS_CONFIG, config.getName(), config.getVal());
			logger.debug(config.getName() + "=>" + config.getVal());
		}
	}
}