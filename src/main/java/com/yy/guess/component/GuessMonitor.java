package com.yy.guess.component;

import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import javax.annotation.PreDestroy;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

/**
 * 竞猜监听
 * 开启竞猜，开奖，都在这个类处理
 * @author 49803
 *
 */
@Component
public class GuessMonitor {
	private static final Logger logger = LogManager.getLogger(GuessMonitor.class);
	
	private ScheduledExecutorService service;
	
	@Value("${web.config.guessMonitorDelay}")
	private long delay; //延迟，单位：毫秒
	
	public GuessMonitor() {
		service = Executors.newSingleThreadScheduledExecutor();
	}
	
	public void start() {
		service.scheduleWithFixedDelay(new GuessMonitorRunable(), delay, delay, TimeUnit.MILLISECONDS);
	}
	
	@PreDestroy
	public void stop() {
		service.shutdownNow();
	}
	
	private class GuessMonitorRunable implements Runnable {
		@Override
		public void run() {
			try {
				
			} catch (Exception e) {
				logger.error(e);
			}
		}
	}
}