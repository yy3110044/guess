package com.yy.guess.component;

import java.util.List;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import javax.annotation.PreDestroy;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import com.yy.fast4j.QueryCondition;
import com.yy.guess.po.Bet;
import com.yy.guess.po.enums.BetStatus;
import com.yy.guess.service.BetService;

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
	
	@Autowired
	private BetService bs;
	
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
				List<Bet> betList = bs.query(new QueryCondition().addCondition("status", "=", BetStatus.已下注));
				for(Bet bet : betList) {
					bs.settlementOrRefund(bet);
				}
			} catch (Exception e) {
				logger.error(e);
			}
		}
	}
}