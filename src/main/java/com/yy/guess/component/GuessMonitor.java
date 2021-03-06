package com.yy.guess.component;

import java.util.Date;
import java.util.List;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import com.yy.fast4j.QueryCondition;
import com.yy.guess.po.NewGuessVersus;
import com.yy.guess.po.enums.NewGuessVersusStatus;
import com.yy.guess.service.NewGuessVersusService;

/**
 * 竞猜监听
 * 开启竞猜，开奖，都在这个类处理
 * @author 49803
 *
 */
@Component
public class GuessMonitor implements Runnable {
	private static final Logger logger = LogManager.getLogger(GuessMonitor.class);
	
	private ScheduledExecutorService service;
	
	@Autowired
	private NewGuessVersusService ngvs;
	
	@Value("${web.config.guessMonitorDelay:20000}")
	private long delay; //延迟，单位：毫秒
	
	public GuessMonitor() {
		service = Executors.newSingleThreadScheduledExecutor();
	}
	
	@PostConstruct
	public void start() {
		service.scheduleWithFixedDelay(this, delay, delay, TimeUnit.MILLISECONDS);
	}
	@PreDestroy
	public void stop() {
		service.shutdownNow();
	}
	@Override
	public void run() {
		try {
			QueryCondition qc = new QueryCondition();
			qc.addCondition("status", "=", NewGuessVersusStatus.未开始);
			qc.addCondition("startTime", "<=", new Date());
			List<NewGuessVersus> list = ngvs.query(qc);
			for(NewGuessVersus versus : list) {
				ngvs.checkStart(versus);
			}
		} catch (Exception e) {
			logger.error(e.toString());
			e.printStackTrace();
		}
	}
}