package com.yy.guess.component;

import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import javax.annotation.PreDestroy;
import org.springframework.stereotype.Component;

/**
 * 竞猜结算component
 * @author yy
 *
 */
@Component
public class GuessSettleComponent {
	private ScheduledExecutorService service;
	private long delay = 30L; //延迟，单位：秒
	
	public GuessSettleComponent() {
		service = Executors.newSingleThreadScheduledExecutor();
	}
	
	public void start() {
		service.scheduleWithFixedDelay(new GuessSettleRunable(), delay, delay, TimeUnit.SECONDS);
	}
	
	@PreDestroy
	public void stop() {
		service.shutdownNow();
	}
	
	private class GuessSettleRunable implements Runnable {
		@Override
		public void run() {
			
		}
	}
}